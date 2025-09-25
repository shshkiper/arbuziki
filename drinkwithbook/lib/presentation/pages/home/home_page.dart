import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../menu/menu_page.dart';
import '../clubs/clubs_page.dart';
import '../loyalty/loyalty_page.dart';
import '../profile/profile_page.dart';
import 'dart:ui';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  int _currentIndex = 0;
  final PageController _pageController = PageController();
  int? _menuInitialTabIndex;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onTabTapped(int index, {int? initialTabIndex}) {
    setState(() {
      _currentIndex = index;
      _menuInitialTabIndex = initialTabIndex;
    });
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
        onPageChanged: (index) => setState(() {
          _currentIndex = index;
          if (index != 1) {
            _menuInitialTabIndex = null; // Сбрасываем при переходе с меню
          }
        }),
        children: [
          _HomeTab(
            onNavigateToMenu: () => _onTabTapped(1),
            onNavigateToBooks: () => _onTabTapped(1, initialTabIndex: 3),
          ),
          MenuPage(initialTabIndex: _menuInitialTabIndex),
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
          selectedLabelStyle: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            fontFamily: 'G', // Ваш шрифт
          ),
          unselectedLabelStyle: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.normal,
            fontFamily: 'G', // Ваш шрифт
          ),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home_outlined),
              label: 'Главная',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.menu_book_rounded),
              activeIcon: Icon(Icons.menu_book_rounded),
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
  final VoidCallback onNavigateToBooks;

  const _HomeTab({
    required this.onNavigateToMenu,
    required this.onNavigateToBooks,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        flexibleSpace: Container(
          height: 120, // Высота размытой области
          child: ClipRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 0.0, sigmaY: 25.0),
              child: Container(
                color: Colors.white.withOpacity(0.00001),
              ),
            ),
          ),
        ),
        title: Padding(
          padding: const EdgeInsets.only(left: 1.0),
          child: Image.asset(
            height: 45,
            'assets/images/logo.png',
            fit: BoxFit.contain,
          ),
        ),
        centerTitle: false,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 13.0),
            child: Row(
              children: [
                IconButton(
                  iconSize: 27,
                  icon: const Icon(Icons.notifications_outlined),
                  onPressed: () {},
                ),
                IconButton(
                  iconSize: 27,
                  icon: const Icon(Icons.message_outlined),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 16, bottom: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Приветствие
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16), // ← отступы слева и справа
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
                      fontFamily: "G",
                      color: theme.colorScheme.onPrimary,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Сегодня прекрасный день для кофе и хорошей книги',
                    style: theme.textTheme.bodyLarge?.copyWith(
                      fontFamily: "G",
                      fontSize: 17,
                      color: theme.colorScheme.onPrimary.withOpacity(0.9),
                    ),
                  ),
                ],
              ),
            )
                .animate()
                .fadeIn(duration: const Duration(milliseconds: 200))
                .slideY(begin: -0.2, duration: const Duration(milliseconds: 400)),

            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16), // ← отступы слева и справа
              child: Row(
                children: [
                  Expanded(
                    child: _QuickActionCard(
                      icon: Icons.coffee_maker,
                      title: 'Заказать кофе',
                      onTap: onNavigateToMenu,
                    ),
                  )
                  .animate(delay: const Duration(milliseconds: 120))
                  .fadeIn(duration: const Duration(milliseconds: 120))
                  .slideX(begin: -0.2, duration: const Duration(milliseconds: 150)),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _QuickActionCard(
                      icon: Icons.auto_stories,
                      title: 'Список книг',
                      onTap: onNavigateToBooks,
                    ),
                  )
                  .animate(delay: const Duration(milliseconds: 120))
                  .fadeIn(duration: const Duration(milliseconds: 120))
                  .slideX(begin: 0.2, duration: const Duration(milliseconds: 150)),
                ],
              ),
            ),

            const SizedBox(height: 15),

            // Популярные напитки
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Популярные напитки',
                style: theme.textTheme.bodyLarge?.copyWith(
                  fontFamily: "G",
                  fontSize: 22,
                ),
              ),
            )
                  .animate(delay: const Duration(milliseconds: 120))
                  .fadeIn(duration: const Duration(milliseconds: 120))
                  .slideX(begin: 0.2, duration: const Duration(milliseconds: 150)),
            const SizedBox(height: 7),
            SizedBox(
              height: 200,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _popularDrinks.length + 2, // +2 для пустых элементов
                itemBuilder: (context, index) {
                  // Первый элемент - отступ слева
                  if (index == 0) {
                    return const SizedBox(width: 18);
                  }
                  
                  // Последний элемент - отступ справа
                  if (index == _popularDrinks.length + 1) {
                    return const SizedBox(width: 10);
                  }
                  
                  // Основные элементы (индекс сдвинут на -1)
                  final drink = _popularDrinks[index - 1];
                  return Container(
                    width: 160,
                    margin: const EdgeInsets.only(right: 12), // обычный отступ между карточками
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
                .animate(delay: const Duration(milliseconds: 120))
                .fadeIn(duration: const Duration(milliseconds: 120))
                .slideX(begin: 0.2, duration: const Duration(milliseconds: 200)),

            const SizedBox(height: 15),

            // Активности клубов
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Активности клубов',
                style: theme.textTheme.bodyLarge?.copyWith(
                        fontFamily: "G",
                        fontSize: 22,
                ),
              ),
            )
                  .animate(delay: const Duration(milliseconds: 120))
                  .fadeIn(duration: const Duration(milliseconds: 120))
                  .slideX(begin: 0.2, duration: const Duration(milliseconds: 150)),
            const SizedBox(height: 7),
            ..._clubActivities.map((activity) => Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, bottom: 12), // ← добавил horizontal
              child: _ActivityCard(
                clubName: activity['clubName'] as String,
                activity: activity['activity'] as String,
                time: activity['time'] as String,
                participants: activity['participants'] as int,
              ),
            ))
                .toList()
                .animate(interval: const Duration(milliseconds: 120))
                .fadeIn(duration: const Duration(milliseconds: 400))
                .slideY(begin: 0.2, duration: const Duration(milliseconds: 400)),
          ],
        ),
      ),
    );
  }
}

class _QuickActionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _QuickActionCard({
    required this.icon,
    required this.title,
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
                size: 42,
                color: theme.colorScheme.primary,
              ),
              const SizedBox(height: 8),
              Text(
                title,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontFamily: "G",
                  fontSize: 16,
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
                    fontFamily: 'G',
                    fontSize: 22,
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
                    fontFamily: 'G',
                    fontSize: 18,
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
                      fontFamily: 'G',
                      fontSize: 17,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    activity,
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontFamily: 'G',
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[900], 
                    ),
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
                          color: theme.colorScheme.onSurface.withOpacity(0.5),
                          fontFamily: 'G',
                          fontSize: 12,
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
                          color: theme.colorScheme.onSurface.withOpacity(0.5),
                          fontFamily: 'G',
                          fontSize: 12,
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
                            color: isFavorite ? Colors.red.withValues(alpha: 0.85) : theme.colorScheme.onSurface,
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
                const SizedBox(height: 5),
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
                              fontFamily: 'G',
                              fontSize: 28,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            widget.item['description'],
                            style: theme.textTheme.titleLarge?.copyWith(
                              color: Colors.white.withOpacity(0.8),
                              fontFamily: 'G',
                              fontSize:19,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                        const SizedBox(height: 15),
                        _buildCustomizationOptions(theme),
                        const SizedBox(height: 10),
                        _buildNutritionInfo(theme),
                        const SizedBox(height: 13),
                        ]
                      ),
                    ),
                // Контент в белой области
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Размеры
                      _buildSizeSelection(theme),
                      
                      const SizedBox(height: 0),
                    
                      
                      if (widget.item['ingredients'] != null) ...[
                        const SizedBox(height: 13),
                        Container( 
                          width: double.infinity,
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: theme.colorScheme.outline.withOpacity(0.1),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Состав',
                                style: theme.textTheme.titleLarge?.copyWith(
                                  fontFamily: 'G',
                                    fontSize: 20,
                                    color: theme.colorScheme.onSurface.withOpacity(1),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                (widget.item['ingredients'] as List<String>).join(', '),
                                style: theme.textTheme.bodyLarge?.copyWith(
                                  fontFamily: 'G',
                                  fontSize: 17,
                                  color: theme.colorScheme.onSurface.withOpacity(0.9),
                                  height: 1.4,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 12),
                      ],
                      Container( 
                          width: double.infinity,
                          padding: const EdgeInsets.only(top: 0, bottom: 16, left: 16,right: 16),
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Предложения',
                                style: theme.textTheme.titleLarge?.copyWith(
                                  fontFamily: 'G',
                                    fontSize: 20,
                                    color: theme.colorScheme.onSurface.withOpacity(1),
                                ),
                              ),
                              const SizedBox(height: 10),
                      // Предложения
                              _buildSuggestions(theme),
                            ],
                          ),
                        ),
                      const SizedBox(height: 100), // Отступ для кнопки корзины
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
                borderRadius: BorderRadius.circular(20),
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
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.add_circle_outline,
                          color: Colors.white,
                          size: 28,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '${_getCurrentPrice()} ₽',
                          style: theme.textTheme.titleLarge?.copyWith(
                            fontFamily: 'G',
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
              ),
              child: Column(
                children: [
                  Text(
                    'M',
                    style: theme.textTheme.headlineMedium?.copyWith(
                      fontFamily: 'G',
                      fontSize: 22,
                      color: selectedSize == 'M' 
                          ? Colors.white 
                          : theme.colorScheme.onSurface,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '350 мл',
                    style: theme.textTheme.bodySmall?.copyWith(
                      fontFamily: 'G',
                      fontSize: 16,
                      color: selectedSize == 'M' 
                          ? Colors.white.withOpacity(1) 
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
              ),
              child: Column(
                children: [
                  Text(
                    'L',
                    style: theme.textTheme.headlineMedium?.copyWith(
                      fontFamily: 'G',
                      fontSize: 22,
                      color: selectedSize == 'L' 
                          ? Colors.white 
                          : theme.colorScheme.onSurface,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '450 мл',
                    style: theme.textTheme.bodySmall?.copyWith(
                      fontFamily: 'G',
                      fontSize: 16,
                      color: selectedSize == 'L' 
                          ? Colors.white.withOpacity(1) 
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

Widget _buildCustomizationOptions(ThemeData theme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildCustomizationItem(
          theme,
          Icons.add_circle_outline,
          'Полезные\nдобавки',
        ),
        _buildCustomizationItem(
          theme,
          Icons.add_circle_outline,
          'Сырная\nпенка и мусс',
        ),
        _buildCustomizationItem(
          theme,
          Icons.local_drink_outlined,
          'Молоко\nкоровье',
        ),
        _buildCustomizationItem(
          theme,
          Icons.coffee_outlined,
          'Эспрессо\nДринкит',
        ),
      ],
    );
  }

Widget _buildCustomizationItem(ThemeData theme, IconData icon, String label) {
    return Column(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: theme.colorScheme.outline.withOpacity(0.2),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Icon(
            icon,
            color: theme.colorScheme.onSurface,
            size:30,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurface.withOpacity(0.7),
            fontFamily: "G",
            fontSize: 13.5,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }


Widget _buildNutritionInfo(ThemeData theme) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildNutritionItem('156 ккал', 'Энергия', theme),
          _buildNutritionItem('7,7 г', 'Белки', theme),
          _buildNutritionItem('8,0 г', 'Жиры', theme),
          _buildNutritionItem('11,9 г', 'Углеводы', theme),
        ],
      ),
    );
  }

  Widget _buildNutritionItem(String value, String label, ThemeData theme) {
    return Column(
      children: [
        Text(
          value,
          style: theme.textTheme.titleLarge?.copyWith(
            fontFamily: 'G',
            fontSize: 20,
            color: theme.colorScheme.onSurface.withOpacity(1),
          ),
        ),
        Text(
          label,
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurface.withOpacity(0.9),
            fontFamily: 'G',
            fontSize: 14,
          ),
        ),
      ],
    );
  }

   Widget _buildSuggestions(ThemeData theme) {
  List<Map<String, dynamic>> suggestions = [
    {'name': 'Круассан', 'price': 180, 'image': 'donat1.jpg'},
    {'name': 'Чизкейк', 'price': 320, 'image': 'donat2.jpg'},
  ];
  
  return SizedBox(
    height: 200,
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final suggestion = suggestions[index];
        return Container(
          width: 150,
          margin: EdgeInsets.only(
            right: index < suggestions.length - 1 ? 15 : 0,
            left: index == 0 ? 0 : 0,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
          ),
          child: Stack(
            children: [
              Column(
                children: [
                  // Изображение
                  Container(
                    height: 110,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(18),
                        topRight: Radius.circular(18),
                      ),
                      image: DecorationImage(
                        image: AssetImage('assets/images/${suggestion['image']}'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  // Текст
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          suggestion['name'],
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                            color: Colors.black87,
                            height: 1.3,
                          ),
                          maxLines: 2,
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Text(
                              '${suggestion['price']} ₽',
                              style: TextStyle(
                                color: theme.colorScheme.primary,
                                fontWeight: FontWeight.w800,
                                fontSize: 18,
                                fontFamily: 'G',
                              ),
                            ),
                            const Spacer(),
                            Container(
                              padding: const EdgeInsets.all(0),
                              decoration: BoxDecoration(
                                color: theme.colorScheme.primary,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.add_circle,
                                color: Colors.white,
                                size: 28,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    ),
  );
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
