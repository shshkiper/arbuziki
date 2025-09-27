# Drink with Book 📚☕

**Приложение для книжно-кофейного сообщества** - мобильное приложение Flutter для заведения, объединяющего кафе и книжный магазин.

> ⚠️ **Статус проекта**: В разработке (MVP версия)
> 
> Приложение находится в стадии активной разработки. Некоторые функции реализованы частично или находятся в процессе разработки.

## 📋 Содержание

- [Описание проекта](#описание-проекта)
- [Установка и настройка](#установка-и-настройка)
- [Архитектура](#архитектура)
- [Реализованные функции](#реализованные-функции)
- [Пользовательские истории](#пользовательские-истории)
- [Схема базы данных](#схема-базы-данных)
- [API и алгоритмы](#api-и-алгоритмы)
- [Разработка](#разработка)

## 🎯 Описание проекта

**Drink with Book** - это MVP приложение для книжно-кофейного заведения, которое включает:

### ✅ Реализованные функции
- 🍵 Просмотр меню (кофе, чай, десерты, книги)
- 🛒 Добавление товаров в корзину
- 👤 Базовая аутентификация через Supabase
- 👥 Система клубов по интересам
- 🎁 Программа лояльности с QR-кодами
- 📍 Статичная карта заведения
- ⚙️ Настройки профиля

### 🚧 В разработке
- 💳 Система заказов и оплаты
- 💬 Чат сообщества
- 📊 Интеграция с базой данных
- 🔄 Real-time обновления

## 🚀 Установка и настройка

### Требования
- Flutter 3.35.0+
- Dart 3.7.2+
- Android Studio / VS Code
- Аккаунт Supabase

### Шаги установки

1. **Клонирование репозитория**
   ```bash
   git clone <repository-url>
   cd drinkwithbook
   ```

2. **Установка зависимостей**
   ```bash
   flutter pub get
   ```

3. **Настройка Supabase**
   - Создайте проект в [Supabase](https://supabase.com)
   - Создайте файл `.env` в корне проекта:
     ```env
     SUPABASE_URL=your_supabase_url
     SUPABASE_ANON_KEY=your_supabase_anon_key
     ```
   - Выполните SQL скрипты из файлов:
     - `supabase_schema.sql` - создание схемы БД
     - `supabase_seed_data.sql` - начальные данные

4. **Генерация кода**
   ```bash
   flutter packages pub run build_runner build
   ```

5. **Запуск приложения**
   ```bash
   flutter run
   ```

## 🏗️ Архитектура

### Технологический стек
- **Frontend**: Flutter 3.35.0
- **Backend**: Supabase (PostgreSQL + Auth + Real-time)
- **State Management**: Riverpod 2.5.1
- **Routing**: GoRouter 13.0.0
- **UI Animations**: Flutter Animate 4.3.0
- **Code Generation**: Freezed + JSON Serializable

### Структура проекта
```
lib/
├── main.dart                 # Точка входа приложения
├── data/
│   └── models/              # Модели данных (Freezed)
├── presentation/
│   ├── pages/               # Экраны приложения
│   ├── widgets/             # Переиспользуемые виджеты
│   └── theme/               # Тема приложения
```

### Паттерны архитектуры
- **Clean Architecture** - разделение на слои
- **MVVM** - Model-View-ViewModel с Riverpod
- **Repository Pattern** - для работы с данными
- **Freezed** - для неизменяемых моделей

## 📱 Основные функции

### 1. Аутентификация
- Регистрация через email
- Авторизация пользователей
- Автоматическое создание профиля

### 2. Главная страница
- Обзор актуальных событий
- Быстрый доступ к меню
- Уведомления и реклама книг

### 3. Меню и корзина
- **Кофе**: Капучино, Латте, Эспрессо, Flat White, холодные напитки
- **Чай**: Матча, Earl Grey, фруктовые чаи, освежающие напитки
- **Десерты**: Пончики, круассаны, чизкейк, тирамису
- **Книги**: Философия, искусство чаепития, литература
- ✅ Добавление товаров в корзину
- ✅ Просмотр корзины в модальном окне
- ❌ **НЕ РАБОТАЕТ**: Оформление заказа (кнопка просто закрывает корзину)
- ❌ **НЕ РАБОТАЕТ**: Отслеживание статуса заказов

### 4. Клубы и сообщества
- **Кофейные гурманы** - обсуждение сортов кофе
- **Книжный клуб** - чтение и обсуждение литературы
- **Чайная церемония** - изучение чайных традиций
- **Философский кофе** - философские дискуссии
- **Молодые писатели** - творческое сообщество

### 5. Программа лояльности
- ✅ QR-код для идентификации пользователя
- ✅ 4 уровня: Bronze, Silver, Gold, Platinum
- ✅ Просмотр доступных наград
- ✅ История использованных наград
- ✅ Система подписок (UI готов)
- ❌ **НЕ РАБОТАЕТ**: Реальная интеграция с БД для начисления/списания баллов

### 6. Чат
- ✅ UI для общих чатов и чатов клубов готов
- ❌ **НЕ РАБОТАЕТ**: Отправка и получение сообщений

### 7. Карта заведения
- ✅ Статичная карта с изображением планировки
- ✅ Маркеры столиков и зон
- ✅ Поиск местоположения
- ✅ Информационные панели

### 8. Профиль пользователя
- ✅ Отображение информации о пользователе
- ✅ Настройки темы приложения
- ❌ **НЕ РАБОТАЕТ**: История заказов (данные не загружаются)
- ❌ **НЕ РАБОТАЕТ**: Участие в клубах (интеграция отсутствует)

## 📖 Пользовательские истории

### История 1: Первый визит и регистрация
1. **Как новый пользователь**, я хочу зарегистрироваться в приложении
2. Открываю приложение → вижу splash screen с логотипом
3. Перехожу на страницу регистрации
4. Ввожу email и пароль → подтверждаю email
5. Автоматически создается профиль с уровнем Bronze
6. Получаю приветственное сообщение и 50 бонусных баллов

### История 2: Просмотр меню и добавление в корзину
1. **Как посетитель кафе**, я хочу посмотреть меню и добавить товары в корзину
2. Перехожу в раздел "Меню" → выбираю категорию "Кофе"
3. Просматриваю ассортимент (капучино, латте, эспрессо)
4. Выбираю "Капучино" → вижу описание, цену, ингредиенты
5. Нажимаю "Добавить в корзину" → товар добавляется
6. Перехожу в корзину → вижу добавленные товары
7. Могу изменить количество или удалить товары
8. ❌ **ПРОБЛЕМА**: Кнопка "Оформить заказ" просто закрывает корзину
9. ❌ **НЕ РАБОТАЕТ**: Нет возможности реально оформить заказ

### История 3: Участие в клубе
1. **Как любитель кофе**, я хочу присоединиться к клубу кофейных гурманов
2. Перехожу в раздел "Клубы" → выбираю "Кофейные гурманы"
3. Читаю описание клуба и предстоящие события
4. Нажимаю "Присоединиться" → становлюсь участником
5. Вижу посты других участников о новых сортах кофе
6. Участвую в обсуждении → оставляю комментарий
7. Регистрируюсь на мероприятие "Дегустация эфиопского кофе"
8. Получаю уведомление о предстоящем событии

### История 4: Просмотр программы лояльности
1. **Как постоянный клиент**, я хочу посмотреть свою программу лояльности
2. Перехожу в раздел "Бонусы" → вижу QR-код
3. Просматриваю доступные награды (UI готов)
4. Вижу историю использованных наград
5. Просматриваю систему подписок
6. ❌ **НЕ РАБОТАЕТ**: Реальное начисление/списание баллов
7. ❌ **НЕ РАБОТАЕТ**: Интеграция с заказами

### История 5: Просмотр карты заведения
1. **Как посетитель**, я хочу посмотреть планировку заведения
2. Перехожу в раздел "Карта" → вижу статичную карту
3. Просматриваю расположение столиков и зон
4. Могу найти нужное место на карте
5. Вижу информационные панели с описанием зон
6. ✅ **РАБОТАЕТ**: Статичная карта с маркерами

### История 6: Попытка общения в чате
1. **Как участник сообщества**, я хочу пообщаться с другими посетителями
2. Перехожу в раздел "Чат" → выбираю "Общий чат"
3. Вижу UI чата с полем для ввода сообщения
4. Пытаюсь написать сообщение о новом сорте кофе
5. ❌ **НЕ РАБОТАЕТ**: Сообщения не отправляются
6. ❌ **НЕ РАБОТАЕТ**: Нет получения сообщений от других пользователей

## ⚠️ Критические проблемы для исправления

### 🔴 Система заказов (КРИТИЧНО)
1. **Кнопка "Оформить заказ" не работает** - просто закрывает корзину
2. **Отсутствует экран оформления заказа** - нужно создать `checkout_page.dart`
3. **Нет сохранения заказов в БД** - интеграция с Supabase отсутствует
4. **Нет отслеживания статуса заказов** - нужен экран `orders_page.dart`
5. **Нет экрана истории заказов** - данные не загружаются в профиле

### 🟡 Интеграция с БД (ВАЖНО)
1. **Продукты захардкожены** - нужно загружать из Supabase
2. **Лояльность не работает** - нет начисления/списания баллов
3. **Чат не работает** - нет отправки/получения сообщений
4. **Клубы не интегрированы** - данные не сохраняются

### 🟢 UI готов, нужна интеграция
1. **Программа лояльности** - UI готов, нужна БД интеграция
2. **Профиль пользователя** - UI готов, данные не загружаются
3. **Клубы** - UI готов, функционал частично работает

## 🗄️ Схема базы данных

### Основные таблицы

#### Пользователи
```sql
profiles (
  id UUID PRIMARY KEY,
  email TEXT NOT NULL,
  name TEXT,
  avatar_url TEXT,
  loyalty_points INTEGER DEFAULT 0,
  loyalty_level TEXT DEFAULT 'bronze',
  total_spent DECIMAL(10,2) DEFAULT 0,
  visits_count INTEGER DEFAULT 0,
  is_owner BOOLEAN DEFAULT FALSE,
  created_at TIMESTAMP,
  last_visit TIMESTAMP
)
```

#### Продукты
```sql
products (
  id UUID PRIMARY KEY,
  name TEXT NOT NULL,
  description TEXT NOT NULL,
  price DECIMAL(10,2) NOT NULL,
  category_id UUID REFERENCES categories(id),
  image_url TEXT,
  ingredients TEXT[],
  is_available BOOLEAN DEFAULT TRUE,
  preparation_time INTEGER DEFAULT 0,
  rating DECIMAL(3,2) DEFAULT 0,
  reviews_count INTEGER DEFAULT 0,
  customizations JSONB
)
```

#### Заказы
```sql
orders (
  id UUID PRIMARY KEY,
  user_id UUID REFERENCES profiles(id),
  total_amount DECIMAL(10,2) NOT NULL,
  status TEXT DEFAULT 'pending',
  order_type TEXT DEFAULT 'pickup',
  notes TEXT,
  estimated_time INTEGER,
  loyalty_points_earned INTEGER DEFAULT 0,
  loyalty_points_used INTEGER DEFAULT 0,
  created_at TIMESTAMP
)
```

#### Клубы
```sql
clubs (
  id UUID PRIMARY KEY,
  name TEXT NOT NULL,
  description TEXT NOT NULL,
  type TEXT NOT NULL, -- 'coffee', 'tea', 'book'
  image_url TEXT,
  is_private BOOLEAN DEFAULT FALSE,
  created_by UUID REFERENCES profiles(id),
  created_at TIMESTAMP
)
```

#### Лояльность
```sql
loyalty_transactions (
  id UUID PRIMARY KEY,
  user_id UUID REFERENCES profiles(id),
  type TEXT NOT NULL, -- 'earned', 'spent'
  points INTEGER NOT NULL,
  description TEXT NOT NULL,
  order_id UUID REFERENCES orders(id),
  created_at TIMESTAMP
)

rewards (
  id UUID PRIMARY KEY,
  title TEXT NOT NULL,
  description TEXT NOT NULL,
  points_required INTEGER NOT NULL,
  reward_type TEXT NOT NULL, -- 'discount', 'free_item', 'special_access'
  reward_value JSONB,
  is_active BOOLEAN DEFAULT TRUE
)
```

### Связи между таблицами
- **Один ко многим**: User → Orders, Club → Events, Club → Posts
- **Многие ко многим**: Users ↔ Clubs (через club_members), Users ↔ Products (через favorites)
- **Иерархические**: Categories → Products, Orders → Order Items

### Индексы для оптимизации
- `idx_profiles_loyalty_level` - поиск по уровню лояльности
- `idx_products_category` - фильтрация продуктов по категории
- `idx_orders_user` - заказы пользователя
- `idx_club_members_club` - участники клуба

## 🔧 API и алгоритмы

### Supabase Integration
```dart
// Инициализация
await Supabase.initialize(
  url: dotenv.env['SUPABASE_URL']!,
  anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
);

// Аутентификация
final response = await Supabase.instance.client.auth.signUp(
  email: email,
  password: password,
);

// Запросы к БД
final products = await Supabase.instance.client
    .from('products')
    .select('*')
    .eq('category_id', categoryId);
```

### Алгоритмы лояльности
```sql
-- Начисление баллов
CREATE FUNCTION add_loyalty_points(
  user_uuid UUID, 
  points_to_add INTEGER, 
  description_text TEXT
) RETURNS VOID AS $$
BEGIN
  UPDATE profiles 
  SET loyalty_points = loyalty_points + points_to_add
  WHERE id = user_uuid;
  
  -- Автоматическое обновление уровня
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
```

### Real-time обновления
```dart
// Подписка на изменения заказов
Supabase.instance.client
    .from('orders')
    .stream(primaryKey: ['id'])
    .eq('user_id', userId)
    .listen((data) {
      // Обновление UI при изменении статуса заказа
    });

// Подписка на сообщения чата
Supabase.instance.client
    .from('chat_messages')
    .stream(primaryKey: ['id'])
    .eq('chat_type', 'general')
    .listen((data) {
      // Обновление чата в реальном времени
    });
```

### Алгоритм рекомендаций
```dart
class RecommendationEngine {
  // Рекомендации на основе истории заказов
  static List<ProductModel> getRecommendations(String userId) {
    // 1. Анализ предыдущих заказов
    // 2. Поиск похожих продуктов
    // 3. Учет сезонности и популярности
    // 4. Фильтрация по доступности
  }
  
  // Рекомендации клубов по интересам
  static List<ClubModel> getClubRecommendations(String userId) {
    // 1. Анализ активности в клубах
    // 2. Поиск похожих пользователей
    // 3. Рекомендация новых клубов
  }
}
```

## 🛠️ Разработка

### Команды разработки
```bash
# Запуск в режиме разработки
flutter run

# Генерация кода после изменений в моделях
flutter packages pub run build_runner build --delete-conflicting-outputs

# Анализ кода
flutter analyze

# Тестирование
flutter test

# Сборка APK
flutter build apk --release
```

### Структура моделей данных
Все модели используют **Freezed** для генерации:
- Неизменяемые классы
- Автоматическая генерация `copyWith`, `==`, `hashCode`
- JSON сериализация/десериализация
- Паттерн Matching

### State Management с Riverpod
```dart
// Провайдер для продуктов
final productsProvider = FutureProvider<List<ProductModel>>((ref) async {
  return await ProductRepository().getProducts();
});

// Провайдер для корзины
final cartProvider = StateNotifierProvider<CartNotifier, List<OrderItem>>((ref) {
  return CartNotifier();
});

// Использование в виджете
class ProductList extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final products = ref.watch(productsProvider);
    
    return products.when(
      data: (products) => ListView.builder(...),
      loading: () => CircularProgressIndicator(),
      error: (error, stack) => Text('Error: $error'),
    );
  }
}
```

### Тестирование
```dart
// Unit тесты для моделей
void main() {
  group('UserModel', () {
    test('should create user from JSON', () {
      final json = {'id': '1', 'email': 'test@test.com'};
      final user = UserModel.fromJson(json);
      expect(user.email, 'test@test.com');
    });
  });
}

// Widget тесты
void main() {
  testWidgets('ProductList should display products', (tester) async {
    await tester.pumpWidget(ProviderScope(
      child: MaterialApp(home: ProductList()),
    ));
    
    expect(find.byType(ListTile), findsWidgets);
  });
}
```
