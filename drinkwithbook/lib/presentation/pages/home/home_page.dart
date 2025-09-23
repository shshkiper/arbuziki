import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../menu/menu_page.dart';
import '../clubs/clubs_page.dart';
import '../loyalty/loyalty_page.dart';
import '../profile/profile_page.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  int _currentIndex = 0;
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onTabTapped(int index) {
    setState(() => _currentIndex = index);
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) => setState(() => _currentIndex = index),
        children: [
          _HomeTab(onNavigateToMenu: () => _onTabTapped(1)),
          const MenuPage(),
          const ClubsPage(),
          const LoyaltyPage(),
          ProfilePage(
            onNavigateToClubs: () => _onTabTapped(2),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: _onTabTapped,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: theme.colorScheme.primary,
          unselectedItemColor: theme.colorScheme.onSurface.withOpacity(0.6),
          backgroundColor: theme.colorScheme.surface,
          elevation: 0,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home),
              label: 'Главная',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.local_cafe_outlined),
              activeIcon: Icon(Icons.local_cafe),
              label: 'Меню',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.groups_outlined),
              activeIcon: Icon(Icons.groups),
              label: 'Клубы',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.card_giftcard_outlined),
              activeIcon: Icon(Icons.card_giftcard),
              label: 'Бонусы',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              activeIcon: Icon(Icons.person),
              label: 'Профиль',
            ),
          ],
        ),
      ),
    );
  }
}

class _HomeTab extends StatelessWidget {
  final VoidCallback onNavigateToMenu;
  
  const _HomeTab({required this.onNavigateToMenu});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      appBar: AppBar(
        title: SizedBox(
          height: 40,
          child: Image.asset(
            'assets/images/logo.png',
            fit: BoxFit.contain,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.chat_outlined),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Приветствие
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    theme.colorScheme.primary,
                    theme.colorScheme.primary.withOpacity(0.8),
                  ],
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Добро пожаловать!',
                    style: theme.textTheme.headlineMedium?.copyWith(
                      color: theme.colorScheme.onPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Сегодня прекрасный день для кофе и хорошей книги',
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: theme.colorScheme.onPrimary.withOpacity(0.9),
                    ),
                  ),
                ],
              ),
            )
                .animate()
                .fadeIn(duration: const Duration(milliseconds: 600))
                .slideY(begin: -0.2, duration: const Duration(milliseconds: 600)),

            const SizedBox(height: 24),

            // Быстрые действия
            Text(
              'Быстрые действия',
              style: theme.textTheme.headlineSmall,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _QuickActionCard(
                    icon: Icons.local_cafe,
                    title: 'Заказать кофе',
                    subtitle: 'Быстрый заказ',
                    onTap: onNavigateToMenu,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _QuickActionCard(
                    icon: Icons.menu_book,
                    title: 'Книги недели',
                    subtitle: 'Рекомендации',
                    onTap: onNavigateToMenu,
                  ),
                ),
              ],
            )
                .animate(delay: const Duration(milliseconds: 200))
                .fadeIn(duration: const Duration(milliseconds: 600))
                .slideX(begin: -0.2, duration: const Duration(milliseconds: 600)),

            const SizedBox(height: 24),

            // Популярные напитки
            Text(
              'Популярные напитки',
              style: theme.textTheme.headlineSmall,
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 200,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _popularDrinks.length,
                itemBuilder: (context, index) {
                  final drink = _popularDrinks[index];
                  return Container(
                    width: 160,
                    margin: EdgeInsets.only(
                      right: index < _popularDrinks.length - 1 ? 12 : 0,
                    ),
                    child: _DrinkCard(
                      name: drink['name'] as String,
                      price: '₽${drink['price']}',
                      image: drink['image'] as String,
                      onTap: () => _showDrinkDetails(context, drink),
                    ),
                  );
                },
              ),
            )
                .animate(delay: const Duration(milliseconds: 400))
                .fadeIn(duration: const Duration(milliseconds: 600))
                .slideY(begin: 0.2, duration: const Duration(milliseconds: 600)),

            const SizedBox(height: 24),

            // Активности клубов
            Text(
              'Активности клубов',
              style: theme.textTheme.headlineSmall,
            ),
            const SizedBox(height: 16),
            ..._clubActivities.map((activity) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: _ActivityCard(
                clubName: activity['clubName'] as String,
                activity: activity['activity'] as String,
                time: activity['time'] as String,
                participants: activity['participants'] as int,
              ),
            ))
                .toList()
                .animate(interval: const Duration(milliseconds: 100))
                .fadeIn(duration: const Duration(milliseconds: 400))
                .slideX(begin: 0.2, duration: const Duration(milliseconds: 400)),
          ],
        ),
      ),
    );
  }
}

class _QuickActionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _QuickActionCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Icon(
                icon,
                size: 32,
                color: theme.colorScheme.primary,
              ),
              const SizedBox(height: 8),
              Text(
                title,
                style: theme.textTheme.titleMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurface.withOpacity(0.7),
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DrinkCard extends StatelessWidget {
  final String name;
  final String price;
  final String image;
  final VoidCallback onTap;

  const _DrinkCard({
    required this.name,
    required this.price,
    required this.image,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          image: DecorationImage(
            image: AssetImage('assets/images/$image'),
            fit: BoxFit.cover,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.transparent,
                Colors.transparent,
                Colors.black.withOpacity(0.7),
              ],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  name,
                  style: theme.textTheme.titleSmall?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    shadows: [
                      Shadow(
                        color: Colors.black.withOpacity(0.5),
                        blurRadius: 2,
                      ),
                    ],
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  price,
                  style: theme.textTheme.titleSmall?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    shadows: [
                      Shadow(
                        color: Colors.black.withOpacity(0.5),
                        blurRadius: 2,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ActivityCard extends StatelessWidget {
  final String clubName;
  final String activity;
  final String time;
  final int participants;

  const _ActivityCard({
    required this.clubName,
    required this.activity,
    required this.time,
    required this.participants,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: theme.colorScheme.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                Icons.groups,
                color: theme.colorScheme.primary,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    clubName,
                    style: theme.textTheme.titleSmall?.copyWith(
                      color: theme.colorScheme.primary,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    activity,
                    style: theme.textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(
                        Icons.access_time,
                        size: 14,
                        color: theme.colorScheme.onSurface.withOpacity(0.6),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        time,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurface.withOpacity(0.6),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Icon(
                        Icons.people,
                        size: 14,
                        color: theme.colorScheme.onSurface.withOpacity(0.6),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '$participants участников',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurface.withOpacity(0.6),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void _showDrinkDetails(BuildContext context, Map<String, dynamic> drink) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) => _ItemDetailsBottomSheet(
      item: drink,
      onAddToCart: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${drink['name']} добавлен в корзину'),
            duration: const Duration(seconds: 2),
          ),
        );
      },
    ),
  );
}

class _ItemDetailsBottomSheet extends StatefulWidget {
  final Map<String, dynamic> item;
  final VoidCallback onAddToCart;

  const _ItemDetailsBottomSheet({
    required this.item,
    required this.onAddToCart,
  });

  @override
  State<_ItemDetailsBottomSheet> createState() => _ItemDetailsBottomSheetState();
}

class _ItemDetailsBottomSheetState extends State<_ItemDetailsBottomSheet> {
  bool isFavorite = false;
  String selectedSize = 'M';
  int basePrice = 0;

  @override
  void initState() {
    super.initState();
    basePrice = widget.item['price'] as int;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenHeight = MediaQuery.of(context).size.height;
    
    return Container(
      height: screenHeight * 0.93, // 93% экрана
      decoration: BoxDecoration(
        color: theme.colorScheme.background,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Stack(
        children: [
          // Прокручиваемый контент
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Drag handle
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.outline.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                
                // Header с кнопками
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Кнопка избранного
                      Container(
                        decoration: BoxDecoration(
                          color: theme.colorScheme.outline.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: IconButton(
                          onPressed: () {
                            setState(() {
                              isFavorite = !isFavorite;
                            });
                          },
                          icon: Icon(
                            isFavorite ? Icons.favorite : Icons.favorite_border,
                            color: isFavorite ? Colors.red : theme.colorScheme.onSurface,
                            size: 24,
                          ),
                        ),
                      ),
                      
                      // Кнопка закрытия
                      Container(
                        decoration: BoxDecoration(
                          color: theme.colorScheme.outline.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: IconButton(
                          onPressed: () => Navigator.of(context).pop(),
                          icon: Icon(
                            Icons.close,
                            color: theme.colorScheme.onSurface,
                            size: 24,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                
                // Изображение (теперь прокручивается)
                Container(
                  width: double.infinity,
                  height: screenHeight * 0.4,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                      image: AssetImage('assets/images/${widget.item['image']}'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.transparent,
                          Colors.black.withOpacity(0.7),
                        ],
                        stops: const [0.0, 0.6, 1.0],
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.item['name'],
                            style: theme.textTheme.displaySmall?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'настрой как любишь',
                            style: theme.textTheme.titleLarge?.copyWith(
                              color: Colors.white.withOpacity(0.8),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                
                const SizedBox(height: 24),
                
                // Контент в белой области
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Размеры
                      _buildSizeSelection(theme),
                      
                      const SizedBox(height: 24),
                      
                      // Описание
                      Text(
                        widget.item['description'],
                        style: theme.textTheme.bodyLarge?.copyWith(
                          height: 1.5,
                        ),
                      ),
                      
                      if (widget.item['ingredients'] != null) ...[
                        const SizedBox(height: 16),
                        Text(
                          'Состав: ${(widget.item['ingredients'] as List<String>).join(', ')}',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.onSurface.withOpacity(0.8),
                          ),
                        ),
                      ],
                      
                      const SizedBox(height: 120), // Отступ для кнопки корзины
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          // Закрепленная кнопка добавления в корзину
          Positioned(
            left: 20,
            right: 20,
            bottom: 20,
            child: Container(
              decoration: BoxDecoration(
                color: theme.colorScheme.primary,
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                    color: theme.colorScheme.primary.withOpacity(0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                    widget.onAddToCart();
                  },
                  borderRadius: BorderRadius.circular(25),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 24,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '${_getCurrentPrice()} ₽',
                          style: theme.textTheme.titleLarge?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  int _getCurrentPrice() {
    int price = basePrice;
    if (selectedSize == 'L') {
      price += 50;
    }
    return price;
  }

  Widget _buildSizeSelection(ThemeData theme) {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () => setState(() => selectedSize = 'M'),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(
                color: selectedSize == 'M' 
                    ? theme.colorScheme.primary 
                    : theme.colorScheme.surface,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: selectedSize == 'M' 
                      ? theme.colorScheme.primary 
                      : theme.colorScheme.outline.withOpacity(0.3),
                ),
              ),
              child: Column(
                children: [
                  Text(
                    'M',
                    style: theme.textTheme.headlineMedium?.copyWith(
                      color: selectedSize == 'M' 
                          ? Colors.white 
                          : theme.colorScheme.onSurface,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '350 мл',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: selectedSize == 'M' 
                          ? Colors.white.withOpacity(0.8) 
                          : theme.colorScheme.onSurface.withOpacity(0.8),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: GestureDetector(
            onTap: () => setState(() => selectedSize = 'L'),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(
                color: selectedSize == 'L' 
                    ? theme.colorScheme.primary 
                    : theme.colorScheme.surface,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: selectedSize == 'L' 
                      ? theme.colorScheme.primary 
                      : theme.colorScheme.outline.withOpacity(0.3),
                ),
              ),
              child: Column(
                children: [
                  Text(
                    'L',
                    style: theme.textTheme.headlineMedium?.copyWith(
                      color: selectedSize == 'L' 
                          ? Colors.white 
                          : theme.colorScheme.onSurface,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '450 мл',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: selectedSize == 'L' 
                          ? Colors.white.withOpacity(0.8) 
                          : theme.colorScheme.onSurface.withOpacity(0.8),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}


// Данные для примера
final _popularDrinks = [
  {
    'id': 'coffee_1',
    'name': 'Капучино',
    'description': 'Классический итальянский кофе с молочной пенкой',
    'price': 250,
    'image': 'capuchino.jpg',
    'ingredients': ['Эспрессо', 'Молоко', 'Молочная пенка'],
  },
  {
    'id': 'coffee_2',
    'name': 'Латте',
    'description': 'Нежный кофе с большим количеством молока',
    'price': 280,
    'image': 'latte.jpg',
    'ingredients': ['Эспрессо', 'Молоко', 'Молочная пенка'],
  },
  {
    'id': 'coffee_3',
    'name': 'Flat White',
    'description': 'Крепкий кофе с микропенкой',
    'price': 320,
    'image': 'Flat White.jpg',
    'ingredients': ['Двойной эспрессо', 'Молоко'],
  },
  {
    'id': 'coffee_4',
    'name': 'Айс Латте',
    'description': 'Освежающий холодный латте',
    'price': 300,
    'image': 'ice latte.jpg',
    'ingredients': ['Эспрессо', 'Молоко', 'Лед'],
  },
];

final _clubActivities = [
  {
    'clubName': 'Кофейный клуб',
    'activity': 'Дегустация новых сортов',
    'time': '2 часа назад',
    'participants': 12,
  },
  {
    'clubName': 'Книжный клуб',
    'activity': 'Обсуждение "1984" Оруэлла',
    'time': '4 часа назад',
    'participants': 8,
  },
  {
    'clubName': 'Чайный клуб',
    'activity': 'Церемония японского чая',
    'time': '1 день назад',
    'participants': 15,
  },
];
