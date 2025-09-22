-- Заполнение базы данных начальными данными для приложения Drink with Book

-- Категории товаров
INSERT INTO categories (id, name, description, type) VALUES
    ('550e8400-e29b-41d4-a716-446655440001', 'Кофе', 'Ароматный кофе различных сортов', 'coffee'),
    ('550e8400-e29b-41d4-a716-446655440002', 'Чай', 'Изысканные чаи со всего мира', 'tea'),
    ('550e8400-e29b-41d4-a716-446655440003', 'Десерты', 'Вкусные десерты и выпечка', 'food'),
    ('550e8400-e29b-41d4-a716-446655440004', 'Книги', 'Интересные книги для души', 'book');

-- Кофейные напитки
INSERT INTO products (id, name, description, price, category_id, image_url, ingredients, preparation_time, rating, reviews_count) VALUES
    ('550e8400-e29b-41d4-a716-446655440101', 'Капучино', 'Классический итальянский кофе с молочной пенкой', 250.00, '550e8400-e29b-41d4-a716-446655440001', 'capuchino.jpg', ARRAY['Эспрессо', 'Молоко', 'Молочная пенка'], 5, 4.8, 156),
    ('550e8400-e29b-41d4-a716-446655440102', 'Латте', 'Нежный кофе с большим количеством молока', 280.00, '550e8400-e29b-41d4-a716-446655440001', 'latte.jpg', ARRAY['Эспрессо', 'Молоко', 'Молочная пенка'], 4, 4.7, 203),
    ('550e8400-e29b-41d4-a716-446655440103', 'Flat White', 'Крепкий кофе с микропенкой', 320.00, '550e8400-e29b-41d4-a716-446655440001', 'Flat White.jpg', ARRAY['Двойной эспрессо', 'Молоко'], 6, 4.9, 89),
    ('550e8400-e29b-41d4-a716-446655440104', 'Айс Латте', 'Освежающий холодный латте', 300.00, '550e8400-e29b-41d4-a716-446655440001', 'ice latte.jpg', ARRAY['Эспрессо', 'Молоко', 'Лед'], 3, 4.6, 124),
    ('550e8400-e29b-41d4-a716-446655440105', 'Двойной Эспрессо', 'Крепкий двойной эспрессо для истинных ценителей', 200.00, '550e8400-e29b-41d4-a716-446655440001', 'double espresso.jpg', ARRAY['Двойной эспрессо'], 2, 4.5, 67),
    ('550e8400-e29b-41d4-a716-446655440106', 'Айс Латте с карамелью', 'Холодный латте с карамельным сиропом и шоколадными шариками', 350.00, '550e8400-e29b-41d4-a716-446655440001', 'ice latte with caramel and choco balls.jpg', ARRAY['Эспрессо', 'Молоко', 'Карамельный сироп', 'Шоколадные шарики', 'Лед'], 4, 4.7, 91),
    ('550e8400-e29b-41d4-a716-446655440107', 'Латте с сырной пенкой', 'Необычный латте с нежной сырной пенкой', 380.00, '550e8400-e29b-41d4-a716-446655440001', 'latte with cheese foam.jpg', ARRAY['Эспрессо', 'Молоко', 'Сырная пенка'], 7, 4.4, 43),
    ('550e8400-e29b-41d4-a716-446655440108', 'Дальгона кофе', 'Трендовый взбитый кофе', 320.00, '550e8400-e29b-41d4-a716-446655440001', 'dalgona-сofe.jpg', ARRAY['Растворимый кофе', 'Сахар', 'Молоко'], 8, 4.3, 78);

-- Чайные напитки
INSERT INTO products (id, name, description, price, category_id, image_url, ingredients, preparation_time, rating, reviews_count) VALUES
    ('550e8400-e29b-41d4-a716-446655440201', 'Айс Матча Латте', 'Освежающий японский зеленый чай матча с молоком', 350.00, '550e8400-e29b-41d4-a716-446655440002', 'ice matcha latte.jpg', ARRAY['Матча', 'Молоко', 'Лед', 'Сироп'], 5, 4.7, 112),
    ('550e8400-e29b-41d4-a716-446655440202', 'Черный чай Earl Grey', 'Классический английский чай с бергамотом', 180.00, '550e8400-e29b-41d4-a716-446655440002', '1.jpg', ARRAY['Черный чай', 'Бергамот'], 3, 4.4, 89),
    ('550e8400-e29b-41d4-a716-446655440203', 'Зеленый чай Сенча', 'Традиционный японский зеленый чай', 200.00, '550e8400-e29b-41d4-a716-446655440002', '2.jpg', ARRAY['Зеленый чай сенча'], 3, 4.6, 67),
    ('550e8400-e29b-41d4-a716-446655440204', 'Фруктовый чай', 'Ароматный чай с кусочками фруктов', 220.00, '550e8400-e29b-41d4-a716-446655440002', '3.jpg', ARRAY['Фруктовый чай', 'Сушеные фрукты'], 4, 4.5, 94),
    ('550e8400-e29b-41d4-a716-446655440205', 'Освежающий напиток', 'Прохладительный напиток с мятой и лимоном', 250.00, '550e8400-e29b-41d4-a716-446655440002', 'refresher.jpg', ARRAY['Зеленый чай', 'Мята', 'Лимон', 'Лед'], 3, 4.3, 56);

-- Десерты
INSERT INTO products (id, name, description, price, category_id, image_url, preparation_time, rating, reviews_count) VALUES
    ('550e8400-e29b-41d4-a716-446655440301', 'Французский круассан', 'Свежий слоеный круассан', 180.00, '550e8400-e29b-41d4-a716-446655440003', '4.jpg', 0, 4.6, 78),
    ('550e8400-e29b-41d4-a716-446655440302', 'Чизкейк Нью-Йорк', 'Классический американский чизкейк', 320.00, '550e8400-e29b-41d4-a716-446655440003', '5.jpg', 0, 4.8, 145),
    ('550e8400-e29b-41d4-a716-446655440303', 'Тирамису', 'Итальянский десерт с кофе и маскарпоне', 380.00, '550e8400-e29b-41d4-a716-446655440003', '6.jpg', 0, 4.9, 167),
    ('550e8400-e29b-41d4-a716-446655440304', 'Маффин с черникой', 'Домашний маффин с сочной черникой', 150.00, '550e8400-e29b-41d4-a716-446655440003', '7.jpg', 2, 4.4, 89),
    ('550e8400-e29b-41d4-a716-446655440305', 'Латте парфе с персиком', 'Слоеный десерт с кофейным кремом и персиком', 420.00, '550e8400-e29b-41d4-a716-446655440003', 'latte parfait peach.jpg', 5, 4.7, 92),
    ('550e8400-e29b-41d4-a716-446655440306', 'Айс латте с персиком', 'Холодный кофейный напиток с персиковым сиропом', 330.00, '550e8400-e29b-41d4-a716-446655440003', 'ice latte peach.jpg', 3, 4.5, 76);

-- Книги
INSERT INTO products (id, name, description, price, category_id, image_url, rating, reviews_count) VALUES
    ('550e8400-e29b-41d4-a716-446655440401', 'Кофе и философия жизни', 'Размышления о жизни за чашкой ароматного кофе', 450.00, '550e8400-e29b-41d4-a716-446655440004', '8.jpg', 4.3, 34),
    ('550e8400-e29b-41d4-a716-446655440402', 'Искусство чаепития', 'История и традиции чайной культуры разных стран', 520.00, '550e8400-e29b-41d4-a716-446655440004', '9.jpg', 4.5, 28),
    ('550e8400-e29b-41d4-a716-446655440403', 'Уютные вечера с книгой', 'Сборник рассказов для душевного чтения', 380.00, '550e8400-e29b-41d4-a716-446655440004', '10.jpg', 4.6, 52),
    ('550e8400-e29b-41d4-a716-446655440404', 'Секреты бариста', 'Профессиональные техники приготовления кофе', 650.00, '550e8400-e29b-41d4-a716-446655440004', '11.jpg', 4.8, 41),
    ('550e8400-e29b-41d4-a716-446655440405', 'Медитация с чашкой чая', 'Практики осознанности и релаксации', 420.00, '550e8400-e29b-41d4-a716-446655440004', '12.jpg', 4.4, 37);

-- Клубы
INSERT INTO clubs (id, name, description, type, created_at) VALUES
    ('550e8400-e29b-41d4-a716-446655440501', 'Кофейные гурманы', 'Обсуждаем лучшие сорта кофе, способы приготовления и делимся рецептами. Еженедельные дегустации и мастер-классы от профессиональных бариста.', 'coffee', NOW()),
    ('550e8400-e29b-41d4-a716-446655440502', 'Книжный клуб "Страница за страницей"', 'Читаем и обсуждаем современную и классическую литературу. Встречи каждые две недели, уютная атмосфера и интересные дискуссии гарантированы.', 'book', NOW()),
    ('550e8400-e29b-41d4-a716-446655440503', 'Чайная церемония', 'Изучаем традиции чаепития разных стран мира. Проводим настоящие чайные церемонии и узнаем историю чайной культуры.', 'tea', NOW()),
    ('550e8400-e29b-41d4-a716-446655440504', 'Философский кофе', 'Размышляем о жизни, искусстве и философии за чашкой ароматного кофе. Глубокие беседы в непринужденной атмосфере.', 'coffee', NOW()),
    ('550e8400-e29b-41d4-a716-446655440505', 'Молодые писатели', 'Сообщество начинающих авторов. Делимся своими произведениями, получаем обратную связь и вдохновляемся творчеством друг друга.', 'book', NOW());

-- События клубов
INSERT INTO club_events (id, club_id, title, description, scheduled_at, location, max_attendees, created_at) VALUES
    ('550e8400-e29b-41d4-a716-446655440601', '550e8400-e29b-41d4-a716-446655440501', 'Дегустация эфиопского кофе', 'Попробуем редкие сорта кофе из различных регионов Эфиопии. Узнаем об особенностях терруара и способах обработки зерен.', NOW() + INTERVAL '1 day' + INTERVAL '18 hours', 'Основной зал', 15, NOW()),
    ('550e8400-e29b-41d4-a716-446655440602', '550e8400-e29b-41d4-a716-446655440502', 'Обсуждение "Мастер и Маргарита"', 'Разбираем один из величайших романов русской литературы. Философские темы, символизм и актуальность произведения.', NOW() + INTERVAL '3 days' + INTERVAL '19 hours', 'Тихий уголок', 12, NOW()),
    ('550e8400-e29b-41d4-a716-446655440603', '550e8400-e29b-41d4-a716-446655440503', 'Японская чайная церемония', 'Изучаем искусство приготовления матча. Традиционные движения, философия чайной церемонии и медитативные практики.', NOW() + INTERVAL '5 days' + INTERVAL '16 hours', 'Зал для мероприятий', 10, NOW()),
    ('550e8400-e29b-41d4-a716-446655440604', '550e8400-e29b-41d4-a716-446655440504', 'Дискуссия "Смысл жизни в современном мире"', 'Философские размышления о поиске смысла в эпоху технологий. Обмен мнениями и жизненным опытом.', NOW() + INTERVAL '7 days' + INTERVAL '18 hours', 'Философский уголок', 8, NOW()),
    ('550e8400-e29b-41d4-a716-446655440605', '550e8400-e29b-41d4-a716-446655440505', 'Вечер поэзии', 'Читаем свои стихи и прозу, получаем конструктивную критику. Открытый микрофон для всех желающих поделиться творчеством.', NOW() + INTERVAL '4 days' + INTERVAL '20 hours', 'Творческая зона', 20, NOW());

-- Награды программы лояльности
INSERT INTO rewards (id, title, description, points_required, reward_type, reward_value, usage_limit) VALUES
    ('550e8400-e29b-41d4-a716-446655440701', 'Бесплатный капучино', 'Любой капучино из меню совершенно бесплатно', 100, 'free_item', '{"product_category": "coffee", "max_price": 300}', NULL),
    ('550e8400-e29b-41d4-a716-446655440702', 'Скидка 20% на книги', 'Скидка на любую книгу в нашем магазине', 200, 'discount', '{"discount_percent": 20, "category": "book"}', NULL),
    ('550e8400-e29b-41d4-a716-446655440703', 'Десерт в подарок', 'Любой десерт из меню бесплатно к вашему заказу', 150, 'free_item', '{"product_category": "food", "max_price": 400}', NULL),
    ('550e8400-e29b-41d4-a716-446655440704', 'VIP столик на час', 'Бронь лучшего столика в кафе на час', 300, 'special_access', '{"service": "vip_table", "duration_hours": 1}', 50),
    ('550e8400-e29b-41d4-a716-446655440705', 'Мастер-класс бесплатно', 'Бесплатное участие в любом мастер-классе', 500, 'special_access', '{"service": "masterclass", "type": "any"}', 30),
    ('550e8400-e29b-41d4-a716-446655440706', 'Месячная кофейная подписка', 'Бесплатный кофе каждый день в течение месяца', 3000, 'special_access', '{"service": "coffee_subscription", "duration_days": 30}', 10),
    ('550e8400-e29b-41d4-a716-446655440707', 'Скидка 15% на всё', 'Скидка на весь ассортимент кафе', 400, 'discount', '{"discount_percent": 15, "category": "all"}', NULL),
    ('550e8400-e29b-41d4-a716-446655440708', 'Персональная консультация бариста', 'Индивидуальный урок приготовления кофе', 800, 'special_access', '{"service": "barista_consultation", "duration_minutes": 60}', 20);

-- Примеры сообщений в общем чате
INSERT INTO chat_messages (sender_id, chat_type, content, created_at) VALUES
    -- Эти записи будут добавлены после создания пользователей
    (NULL, 'general', 'Добро пожаловать в наше уютное кафе! Здесь вы можете общаться с другими посетителями, делиться впечатлениями о кофе и книгах.', NOW() - INTERVAL '2 hours'),
    (NULL, 'general', 'Не забывайте участвовать в мероприятиях наших клубов - это отличный способ найти единомышленников!', NOW() - INTERVAL '1 hour'),
    (NULL, 'general', 'Новый сорт эфиопского кофе уже в меню! Обязательно попробуйте - невероятные фруктовые ноты.', NOW() - INTERVAL '30 minutes');

-- Примеры постов в клубах (будут добавлены после создания пользователей)
-- Эти посты можно добавить позже, когда появятся реальные пользователи

-- Доступные подписки
INSERT INTO subscriptions (id, user_id, type, name, description, price, frequency, status, start_date, next_delivery) VALUES
    -- Примеры подписок - шаблоны, которые пользователи могут активировать
    ('550e8400-e29b-41d4-a716-446655440801', NULL, 'coffee_daily', 'Ежедневный кофе', 'Один бесплатный кофе каждый день', 1500.00, 'monthly', 'active', CURRENT_DATE, CURRENT_DATE + INTERVAL '1 day'),
    ('550e8400-e29b-41d4-a716-446655440802', NULL, 'tea_weekly', 'Чайная подписка', 'Два чая в неделю на ваш выбор', 800.00, 'monthly', 'active', CURRENT_DATE, CURRENT_DATE + INTERVAL '3 days'),
    ('550e8400-e29b-41d4-a716-446655440803', NULL, 'book_discount', 'Книжная подписка', 'Скидка 30% на все книги в течение месяца', 500.00, 'monthly', 'active', CURRENT_DATE, CURRENT_DATE + INTERVAL '1 month');

-- Обновляем счетчики отзывов и рейтинги (имитируем активность)
UPDATE products SET 
    rating = 4.0 + (RANDOM() * 1.0),
    reviews_count = (10 + (RANDOM() * 200)::INT)
WHERE rating = 0;

-- Функция для создания тестового пользователя (можно использовать для демонстрации)
CREATE OR REPLACE FUNCTION create_demo_user(user_email TEXT, user_name TEXT)
RETURNS UUID AS $$
DECLARE
    new_user_id UUID;
BEGIN
    -- В реальном приложении пользователи создаются через Supabase Auth
    -- Эта функция только для демонстрации структуры данных
    
    new_user_id := uuid_generate_v4();
    
    INSERT INTO profiles (id, email, name, loyalty_points, loyalty_level, total_spent, visits_count, created_at)
    VALUES (new_user_id, user_email, user_name, 2450, 'gold', 12340.00, 47, NOW() - INTERVAL '6 months');
    
    -- Добавляем пользователя в несколько клубов
    INSERT INTO club_members (club_id, user_id, joined_at) VALUES
        ('550e8400-e29b-41d4-a716-446655440501', new_user_id, NOW() - INTERVAL '3 months'),
        ('550e8400-e29b-41d4-a716-446655440502', new_user_id, NOW() - INTERVAL '2 months');
    
    -- Добавляем несколько транзакций лояльности
    INSERT INTO loyalty_transactions (user_id, type, points, description, created_at) VALUES
        (new_user_id, 'earned', 25, 'Покупка капучино', NOW()),
        (new_user_id, 'earned', 50, 'Участие в мероприятии клуба', NOW() - INTERVAL '1 day'),
        (new_user_id, 'spent', 100, 'Бесплатный латте', NOW() - INTERVAL '2 days'),
        (new_user_id, 'earned', 30, 'Покупка книги', NOW() - INTERVAL '3 days');
    
    -- Добавляем в избранное
    INSERT INTO favorites (user_id, product_id) VALUES
        (new_user_id, '550e8400-e29b-41d4-a716-446655440101'), -- Капучино
        (new_user_id, '550e8400-e29b-41d4-a716-446655440201'), -- Матча латте
        (new_user_id, '550e8400-e29b-41d4-a716-446655440302'); -- Чизкейк
    
    RETURN new_user_id;
END;
$$ LANGUAGE plpgsql;

-- Создаем представления для удобства работы с данными
CREATE VIEW club_stats AS
SELECT 
    c.id,
    c.name,
    c.type,
    COUNT(DISTINCT cm.user_id) as members_count,
    COUNT(DISTINCT ce.id) as events_count,
    COUNT(DISTINCT cp.id) as posts_count
FROM clubs c
LEFT JOIN club_members cm ON c.id = cm.club_id
LEFT JOIN club_events ce ON c.id = ce.club_id
LEFT JOIN club_posts cp ON c.id = cp.club_id
GROUP BY c.id, c.name, c.type;

CREATE VIEW user_loyalty_stats AS
SELECT 
    p.id,
    p.name,
    p.email,
    p.loyalty_points,
    p.loyalty_level,
    p.total_spent,
    p.visits_count,
    COUNT(DISTINCT o.id) as orders_count,
    COUNT(DISTINCT cm.club_id) as clubs_count,
    COALESCE(SUM(CASE WHEN lt.type = 'earned' THEN lt.points ELSE 0 END), 0) as total_earned_points,
    COALESCE(SUM(CASE WHEN lt.type = 'spent' THEN lt.points ELSE 0 END), 0) as total_spent_points
FROM profiles p
LEFT JOIN orders o ON p.id = o.user_id
LEFT JOIN club_members cm ON p.id = cm.user_id
LEFT JOIN loyalty_transactions lt ON p.id = lt.user_id
GROUP BY p.id, p.name, p.email, p.loyalty_points, p.loyalty_level, p.total_spent, p.visits_count;

CREATE VIEW popular_products AS
SELECT 
    p.*,
    c.name as category_name,
    COALESCE(oi_stats.order_count, 0) as times_ordered,
    COALESCE(f_stats.favorites_count, 0) as favorites_count
FROM products p
JOIN categories c ON p.category_id = c.id
LEFT JOIN (
    SELECT 
        product_id, 
        COUNT(*) as order_count,
        SUM(quantity) as total_quantity
    FROM order_items 
    GROUP BY product_id
) oi_stats ON p.id = oi_stats.product_id
LEFT JOIN (
    SELECT 
        product_id,
        COUNT(*) as favorites_count
    FROM favorites
    GROUP BY product_id
) f_stats ON p.id = f_stats.product_id
ORDER BY oi_stats.order_count DESC NULLS LAST, p.rating DESC;
