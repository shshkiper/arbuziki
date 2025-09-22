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
        title: Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  'assets/images/logo.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 12),
            const Text('Drink with Book'),
          ],
        ),
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
                      price: drink['price'] as String,
                      image: drink['image'] as String,
                      rating: drink['rating'] as double,
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
  final double rating;

  const _DrinkCard({
    required this.name,
    required this.price,
    required this.image,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/$image'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: theme.textTheme.titleSmall,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      price,
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: theme.colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          size: 16,
                          color: Colors.amber,
                        ),
                        const SizedBox(width: 2),
                        Text(
                          rating.toString(),
                          style: theme.textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
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


// Данные для примера
final _popularDrinks = [
  {
    'name': 'Капучино',
    'price': '₽250',
    'image': 'capuchino.jpg',
    'rating': 4.8,
  },
  {
    'name': 'Латте',
    'price': '₽280',
    'image': 'latte.jpg',
    'rating': 4.7,
  },
  {
    'name': 'Flat White',
    'price': '₽320',
    'image': 'Flat White.jpg',
    'rating': 4.9,
  },
  {
    'name': 'Айс Латте',
    'price': '₽300',
    'image': 'ice latte.jpg',
    'rating': 4.6,
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
