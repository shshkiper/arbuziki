-- Создание схемы базы данных для приложения Drink with Book

-- Включаем расширения
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Таблица пользователей (расширяет auth.users)
CREATE TABLE public.profiles (
    id UUID REFERENCES auth.users(id) PRIMARY KEY,
    email TEXT NOT NULL,
    name TEXT,
    avatar_url TEXT,
    loyalty_points INTEGER DEFAULT 0,
    loyalty_level TEXT DEFAULT 'bronze' CHECK (loyalty_level IN ('bronze', 'silver', 'gold', 'platinum')),
    total_spent DECIMAL(10,2) DEFAULT 0,
    visits_count INTEGER DEFAULT 0,
    is_owner BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    last_visit TIMESTAMP WITH TIME ZONE
);

-- Таблица категорий товаров
CREATE TABLE public.categories (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
    name TEXT NOT NULL,
    description TEXT,
    type TEXT NOT NULL CHECK (type IN ('coffee', 'tea', 'food', 'book')),
    icon_url TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Таблица товаров
CREATE TABLE public.products (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
    name TEXT NOT NULL,
    description TEXT NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    category_id UUID REFERENCES categories(id),
    image_url TEXT,
    ingredients TEXT[], -- массив ингредиентов
    is_available BOOLEAN DEFAULT TRUE,
    preparation_time INTEGER DEFAULT 0, -- в минутах
    rating DECIMAL(3,2) DEFAULT 0,
    reviews_count INTEGER DEFAULT 0,
    customizations JSONB, -- размеры, добавки и т.д.
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Таблица заказов
CREATE TABLE public.orders (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
    user_id UUID REFERENCES profiles(id) NOT NULL,
    total_amount DECIMAL(10,2) NOT NULL,
    status TEXT DEFAULT 'pending' CHECK (status IN ('pending', 'preparing', 'ready', 'completed', 'cancelled')),
    order_type TEXT DEFAULT 'pickup' CHECK (order_type IN ('pickup', 'delivery')),
    notes TEXT,
    estimated_time INTEGER, -- в минутах
    loyalty_points_earned INTEGER DEFAULT 0,
    loyalty_points_used INTEGER DEFAULT 0,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    ready_at TIMESTAMP WITH TIME ZONE,
    completed_at TIMESTAMP WITH TIME ZONE
);

-- Таблица позиций заказа
CREATE TABLE public.order_items (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
    order_id UUID REFERENCES orders(id) ON DELETE CASCADE,
    product_id UUID REFERENCES products(id),
    product_name TEXT NOT NULL, -- сохраняем название на случай удаления товара
    quantity INTEGER NOT NULL DEFAULT 1,
    price DECIMAL(10,2) NOT NULL, -- цена на момент заказа
    customizations JSONB,
    notes TEXT
);

-- Таблица клубов
CREATE TABLE public.clubs (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
    name TEXT NOT NULL,
    description TEXT NOT NULL,
    type TEXT NOT NULL CHECK (type IN ('coffee', 'tea', 'book')),
    image_url TEXT,
    is_private BOOLEAN DEFAULT FALSE,
    created_by UUID REFERENCES profiles(id),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Таблица участников клубов
CREATE TABLE public.club_members (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
    club_id UUID REFERENCES clubs(id) ON DELETE CASCADE,
    user_id UUID REFERENCES profiles(id) ON DELETE CASCADE,
    role TEXT DEFAULT 'member' CHECK (role IN ('member', 'moderator', 'admin')),
    joined_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    UNIQUE(club_id, user_id)
);

-- Таблица событий клубов
CREATE TABLE public.club_events (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
    club_id UUID REFERENCES clubs(id) ON DELETE CASCADE,
    title TEXT NOT NULL,
    description TEXT NOT NULL,
    scheduled_at TIMESTAMP WITH TIME ZONE NOT NULL,
    location TEXT,
    max_attendees INTEGER,
    status TEXT DEFAULT 'upcoming' CHECK (status IN ('upcoming', 'ongoing', 'completed', 'cancelled')),
    created_by UUID REFERENCES profiles(id),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Таблица участников событий
CREATE TABLE public.event_attendees (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
    event_id UUID REFERENCES club_events(id) ON DELETE CASCADE,
    user_id UUID REFERENCES profiles(id) ON DELETE CASCADE,
    status TEXT DEFAULT 'attending' CHECK (status IN ('attending', 'maybe', 'not_attending')),
    registered_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    UNIQUE(event_id, user_id)
);

-- Таблица постов в клубах
CREATE TABLE public.club_posts (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
    club_id UUID REFERENCES clubs(id) ON DELETE CASCADE,
    author_id UUID REFERENCES profiles(id) ON DELETE CASCADE,
    content TEXT NOT NULL,
    image_urls TEXT[],
    likes_count INTEGER DEFAULT 0,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Таблица лайков постов
CREATE TABLE public.post_likes (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
    post_id UUID REFERENCES club_posts(id) ON DELETE CASCADE,
    user_id UUID REFERENCES profiles(id) ON DELETE CASCADE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    UNIQUE(post_id, user_id)
);

-- Таблица комментариев к постам
CREATE TABLE public.post_comments (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
    post_id UUID REFERENCES club_posts(id) ON DELETE CASCADE,
    author_id UUID REFERENCES profiles(id) ON DELETE CASCADE,
    content TEXT NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Таблица подписок
CREATE TABLE public.subscriptions (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
    user_id UUID REFERENCES profiles(id) ON DELETE CASCADE,
    type TEXT NOT NULL,
    name TEXT NOT NULL,
    description TEXT,
    price DECIMAL(10,2) NOT NULL,
    frequency TEXT NOT NULL CHECK (frequency IN ('weekly', 'monthly')),
    status TEXT DEFAULT 'active' CHECK (status IN ('active', 'paused', 'cancelled')),
    start_date DATE NOT NULL,
    end_date DATE,
    next_delivery DATE,
    preferences JSONB,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Таблица продуктов в подписках
CREATE TABLE public.subscription_products (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
    subscription_id UUID REFERENCES subscriptions(id) ON DELETE CASCADE,
    product_id UUID REFERENCES products(id),
    quantity INTEGER DEFAULT 1
);

-- Таблица транзакций лояльности
CREATE TABLE public.loyalty_transactions (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
    user_id UUID REFERENCES profiles(id) ON DELETE CASCADE,
    type TEXT NOT NULL CHECK (type IN ('earned', 'spent')),
    points INTEGER NOT NULL,
    description TEXT NOT NULL,
    order_id UUID REFERENCES orders(id),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Таблица наград/призов
CREATE TABLE public.rewards (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
    title TEXT NOT NULL,
    description TEXT NOT NULL,
    points_required INTEGER NOT NULL,
    reward_type TEXT NOT NULL CHECK (reward_type IN ('discount', 'free_item', 'special_access')),
    reward_value JSONB, -- детали награды
    is_active BOOLEAN DEFAULT TRUE,
    usage_limit INTEGER, -- максимальное количество использований
    usage_count INTEGER DEFAULT 0,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Таблица использованных наград
CREATE TABLE public.user_rewards (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
    user_id UUID REFERENCES profiles(id) ON DELETE CASCADE,
    reward_id UUID REFERENCES rewards(id),
    used_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    order_id UUID REFERENCES orders(id) -- если награда использована в заказе
);

-- Таблица сообщений чата
CREATE TABLE public.chat_messages (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
    sender_id UUID REFERENCES profiles(id) ON DELETE CASCADE,
    chat_type TEXT NOT NULL CHECK (chat_type IN ('general', 'club', 'owner')),
    club_id UUID REFERENCES clubs(id) ON DELETE CASCADE, -- только для клубных чатов
    content TEXT NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Таблица избранного
CREATE TABLE public.favorites (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
    user_id UUID REFERENCES profiles(id) ON DELETE CASCADE,
    product_id UUID REFERENCES products(id) ON DELETE CASCADE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    UNIQUE(user_id, product_id)
);

-- Создание индексов для оптимизации
CREATE INDEX idx_profiles_loyalty_level ON profiles(loyalty_level);
CREATE INDEX idx_products_category ON products(category_id);
CREATE INDEX idx_products_available ON products(is_available);
CREATE INDEX idx_orders_user ON orders(user_id);
CREATE INDEX idx_orders_status ON orders(status);
CREATE INDEX idx_orders_created_at ON orders(created_at);
CREATE INDEX idx_club_members_club ON club_members(club_id);
CREATE INDEX idx_club_members_user ON club_members(user_id);
CREATE INDEX idx_club_posts_club ON club_posts(club_id);
CREATE INDEX idx_club_posts_created_at ON club_posts(created_at);
CREATE INDEX idx_loyalty_transactions_user ON loyalty_transactions(user_id);
CREATE INDEX idx_chat_messages_chat_type ON chat_messages(chat_type);
CREATE INDEX idx_chat_messages_club ON chat_messages(club_id);
CREATE INDEX idx_chat_messages_created_at ON chat_messages(created_at);

-- Создание функций для автоматического обновления updated_at
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ language 'plpgsql';

-- Применение триггеров для автоматического обновления updated_at
CREATE TRIGGER update_profiles_updated_at BEFORE UPDATE ON profiles FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_products_updated_at BEFORE UPDATE ON products FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_clubs_updated_at BEFORE UPDATE ON clubs FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_club_posts_updated_at BEFORE UPDATE ON club_posts FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_subscriptions_updated_at BEFORE UPDATE ON subscriptions FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_chat_messages_updated_at BEFORE UPDATE ON chat_messages FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

-- Функция для автоматического создания профиля при регистрации
CREATE OR REPLACE FUNCTION public.handle_new_user()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO public.profiles (id, email, name)
    VALUES (NEW.id, NEW.email, NEW.raw_user_meta_data->>'name');
    RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Триггер для создания профиля
CREATE TRIGGER on_auth_user_created
    AFTER INSERT ON auth.users
    FOR EACH ROW EXECUTE FUNCTION public.handle_new_user();

-- Функция для начисления баллов лояльности
CREATE OR REPLACE FUNCTION add_loyalty_points(user_uuid UUID, points_to_add INTEGER, description_text TEXT, order_uuid UUID DEFAULT NULL)
RETURNS VOID AS $$
BEGIN
    -- Добавляем баллы к профилю
    UPDATE profiles 
    SET loyalty_points = loyalty_points + points_to_add,
        updated_at = NOW()
    WHERE id = user_uuid;
    
    -- Записываем транзакцию
    INSERT INTO loyalty_transactions (user_id, type, points, description, order_id)
    VALUES (user_uuid, 'earned', points_to_add, description_text, order_uuid);
    
    -- Обновляем уровень лояльности
    UPDATE profiles 
    SET loyalty_level = CASE 
        WHEN loyalty_points >= 5000 THEN 'platinum'
        WHEN loyalty_points >= 3000 THEN 'gold'
        WHEN loyalty_points >= 1000 THEN 'silver'
        ELSE 'bronze'
    END
    WHERE id = user_uuid;
END;
$$ LANGUAGE plpgsql;

-- Функция для списания баллов лояльности
CREATE OR REPLACE FUNCTION spend_loyalty_points(user_uuid UUID, points_to_spend INTEGER, description_text TEXT, order_uuid UUID DEFAULT NULL)
RETURNS BOOLEAN AS $$
DECLARE
    current_points INTEGER;
BEGIN
    -- Проверяем достаточность баллов
    SELECT loyalty_points INTO current_points FROM profiles WHERE id = user_uuid;
    
    IF current_points >= points_to_spend THEN
        -- Списываем баллы
        UPDATE profiles 
        SET loyalty_points = loyalty_points - points_to_spend,
            updated_at = NOW()
        WHERE id = user_uuid;
        
        -- Записываем транзакцию
        INSERT INTO loyalty_transactions (user_id, type, points, description, order_id)
        VALUES (user_uuid, 'spent', points_to_spend, description_text, order_uuid);
        
        RETURN TRUE;
    ELSE
        RETURN FALSE;
    END IF;
END;
$$ LANGUAGE plpgsql;

-- Настройка Row Level Security (RLS)
ALTER TABLE profiles ENABLE ROW LEVEL SECURITY;
ALTER TABLE orders ENABLE ROW LEVEL SECURITY;
ALTER TABLE order_items ENABLE ROW LEVEL SECURITY;
ALTER TABLE club_members ENABLE ROW LEVEL SECURITY;
ALTER TABLE club_posts ENABLE ROW LEVEL SECURITY;
ALTER TABLE post_likes ENABLE ROW LEVEL SECURITY;
ALTER TABLE post_comments ENABLE ROW LEVEL SECURITY;
ALTER TABLE subscriptions ENABLE ROW LEVEL SECURITY;
ALTER TABLE loyalty_transactions ENABLE ROW LEVEL SECURITY;
ALTER TABLE user_rewards ENABLE ROW LEVEL SECURITY;
ALTER TABLE chat_messages ENABLE ROW LEVEL SECURITY;
ALTER TABLE favorites ENABLE ROW LEVEL SECURITY;

-- Политики безопасности для profiles
CREATE POLICY "Users can view own profile" ON profiles FOR SELECT USING (auth.uid() = id);
CREATE POLICY "Users can update own profile" ON profiles FOR UPDATE USING (auth.uid() = id);

-- Политики для orders
CREATE POLICY "Users can view own orders" ON orders FOR SELECT USING (auth.uid() = user_id);
CREATE POLICY "Users can create own orders" ON orders FOR INSERT WITH CHECK (auth.uid() = user_id);

-- Политики для order_items
CREATE POLICY "Users can view own order items" ON order_items FOR SELECT USING (
    EXISTS (SELECT 1 FROM orders WHERE orders.id = order_items.order_id AND orders.user_id = auth.uid())
);

-- Политики для club_members
CREATE POLICY "Users can view club memberships" ON club_members FOR SELECT USING (
    user_id = auth.uid() OR 
    EXISTS (SELECT 1 FROM club_members cm WHERE cm.club_id = club_members.club_id AND cm.user_id = auth.uid())
);

-- Политики для loyalty_transactions
CREATE POLICY "Users can view own loyalty transactions" ON loyalty_transactions FOR SELECT USING (auth.uid() = user_id);

-- Политики для chat_messages
CREATE POLICY "Users can view general chat messages" ON chat_messages FOR SELECT USING (
    chat_type = 'general' OR 
    (chat_type = 'club' AND EXISTS (SELECT 1 FROM club_members WHERE club_id = chat_messages.club_id AND user_id = auth.uid())) OR
    chat_type = 'owner'
);

CREATE POLICY "Users can send chat messages" ON chat_messages FOR INSERT WITH CHECK (auth.uid() = sender_id);

-- Даем права на чтение публичных таблиц
CREATE POLICY "Anyone can view categories" ON categories FOR SELECT USING (true);
CREATE POLICY "Anyone can view products" ON products FOR SELECT USING (true);
CREATE POLICY "Anyone can view clubs" ON clubs FOR SELECT USING (true);
CREATE POLICY "Anyone can view club events" ON club_events FOR SELECT USING (true);
CREATE POLICY "Anyone can view rewards" ON rewards FOR SELECT USING (true);
