import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';

class LoyaltyPage extends ConsumerStatefulWidget {
  const LoyaltyPage({super.key});

  @override
  ConsumerState<LoyaltyPage> createState() => _LoyaltyPageState();
}

class _LoyaltyPageState extends ConsumerState<LoyaltyPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Моя карта'),
            Tab(text: 'Подписки'),
            Tab(text: 'Награды'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          _LoyaltyCardTab(),
          _SubscriptionsTab(),
          _RewardsTab(),
        ],
      ),
    );
  }
}

class _LoyaltyCardTab extends StatelessWidget {
  const _LoyaltyCardTab();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Карта лояльности
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  theme.colorScheme.primary,
                  theme.colorScheme.primary.withOpacity(0.8),
                ],
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: theme.colorScheme.primary.withOpacity(0.3),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Drink with Book',
                      style: theme.textTheme.titleLarge?.copyWith(
                        color: theme.colorScheme.onPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.tertiary,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        'ЗОЛОТО',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Text(
                  'Анна Смирнова',
                  style: theme.textTheme.headlineSmall?.copyWith(
                    color: theme.colorScheme.onPrimary,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Участник с октября 2023',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onPrimary.withOpacity(0.8),
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '2,450',
                          style: theme.textTheme.headlineLarge?.copyWith(
                            color: theme.colorScheme.onPrimary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Баллов',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.onPrimary.withOpacity(0.8),
                          ),
                        ),
                      ],
                    ),
                    Icon(
                      Icons.qr_code,
                      size: 48,
                      color: theme.colorScheme.onPrimary.withOpacity(0.8),
                    ),
                  ],
                ),
              ],
            ),
          )
              .animate()
              .fadeIn(duration: const Duration(milliseconds: 600))
              .slideY(begin: -0.2, duration: const Duration(milliseconds: 600)),

          const SizedBox(height: 24),

          // Прогресс до следующего уровня
          Text(
            'Прогресс до следующего уровня',
            style: theme.textTheme.titleLarge,
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: theme.colorScheme.outline.withOpacity(0.2),
              ),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Золото',
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: theme.colorScheme.tertiary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Платина',
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: theme.colorScheme.onSurface.withOpacity(0.6),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                LinearProgressIndicator(
                  value: 0.73,
                  backgroundColor: theme.colorScheme.outline.withOpacity(0.2),
                  valueColor: AlwaysStoppedAnimation<Color>(
                    theme.colorScheme.tertiary,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Осталось 550 баллов до уровня Платина',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurface.withOpacity(0.7),
                  ),
                ),
              ],
            ),
          )
              .animate(delay: const Duration(milliseconds: 200))
              .fadeIn(duration: const Duration(milliseconds: 600))
              .slideX(begin: -0.2, duration: const Duration(milliseconds: 600)),

          const SizedBox(height: 24),

          // Статистика
          Text(
            'Моя статистика',
            style: theme.textTheme.titleLarge,
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _StatCard(
                  title: 'Визитов',
                  value: '47',
                  icon: Icons.store,
                  color: theme.colorScheme.primary,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _StatCard(
                  title: 'Потрачено',
                  value: '₽12,340',
                  icon: Icons.payments,
                  color: theme.colorScheme.secondary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _StatCard(
                  title: 'Сэкономлено',
                  value: '₽1,890',
                  icon: Icons.savings,
                  color: Colors.green,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _StatCard(
                  title: 'Любимый напиток',
                  value: 'Капучино',
                  icon: Icons.local_cafe,
                  color: Colors.brown,
                ),
              ),
            ],
          )
              .animate(delay: const Duration(milliseconds: 400))
              .fadeIn(duration: const Duration(milliseconds: 600))
              .slideY(begin: 0.2, duration: const Duration(milliseconds: 600)),

          const SizedBox(height: 24),

          // История транзакций
          Text(
            'Последние начисления',
            style: theme.textTheme.titleLarge,
          ),
          const SizedBox(height: 16),
          ..._loyaltyTransactions.map((transaction) => _TransactionCard(
            transaction: transaction,
          ))
              .toList()
              .animate(interval: const Duration(milliseconds: 100))
              .fadeIn(duration: const Duration(milliseconds: 400))
              .slideX(begin: 0.2, duration: const Duration(milliseconds: 400)),
        ],
      ),
    );
  }
}

class _SubscriptionsTab extends StatelessWidget {
  const _SubscriptionsTab();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Активные подписки',
            style: theme.textTheme.titleLarge,
          ),
          const SizedBox(height: 16),
          
          if (_activeSubscriptions.isEmpty)
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Icon(
                      Icons.subscriptions_outlined,
                      size: 48,
                      color: theme.colorScheme.onSurface.withOpacity(0.5),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'У вас пока нет активных подписок',
                      style: theme.textTheme.titleMedium,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Оформите подписку и получайте свои любимые напитки с выгодой',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurface.withOpacity(0.7),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          
          ..._activeSubscriptions.map((subscription) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: _SubscriptionCard(
              subscription: subscription,
              isActive: true,
            ),
          )),

          const SizedBox(height: 24),

          Text(
            'Доступные подписки',
            style: theme.textTheme.titleLarge,
          ),
          const SizedBox(height: 16),
          
          ..._availableSubscriptions.map((subscription) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: _SubscriptionCard(
              subscription: subscription,
              isActive: false,
            ),
          ))
              .toList()
              .animate(interval: const Duration(milliseconds: 100))
              .fadeIn(duration: const Duration(milliseconds: 400))
              .slideY(begin: 0.2, duration: const Duration(milliseconds: 400)),
        ],
      ),
    );
  }
}

class _RewardsTab extends StatelessWidget {
  const _RewardsTab();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Доступные награды',
            style: theme.textTheme.titleLarge,
          ),
          const SizedBox(height: 16),
          
          ..._availableRewards.map((reward) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: _RewardCard(reward: reward),
          ))
              .toList()
              .animate(interval: const Duration(milliseconds: 100))
              .fadeIn(duration: const Duration(milliseconds: 400))
              .slideX(begin: 0.2, duration: const Duration(milliseconds: 400)),

          const SizedBox(height: 24),

          Text(
            'Использованные награды',
            style: theme.textTheme.titleLarge,
          ),
          const SizedBox(height: 16),
          
          ..._usedRewards.map((reward) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: _RewardCard(reward: reward, isUsed: true),
          )),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const _StatCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Icon(
              icon,
              size: 32,
              color: color,
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              title,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurface.withOpacity(0.7),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TransactionCard extends StatelessWidget {
  final Map<String, dynamic> transaction;

  const _TransactionCard({required this.transaction});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isEarned = transaction['type'] == 'earned';
    
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: (isEarned ? Colors.green : Colors.red).withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Icon(
                isEarned ? Icons.add : Icons.remove,
                color: isEarned ? Colors.green : Colors.red,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    transaction['description'],
                    style: theme.textTheme.titleSmall,
                  ),
                  Text(
                    transaction['date'],
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurface.withOpacity(0.6),
                    ),
                  ),
                ],
              ),
            ),
            Text(
              '${isEarned ? '+' : '-'}${transaction['points']} баллов',
              style: theme.textTheme.titleSmall?.copyWith(
                color: isEarned ? Colors.green : Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SubscriptionCard extends StatelessWidget {
  final Map<String, dynamic> subscription;
  final bool isActive;

  const _SubscriptionCard({
    required this.subscription,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    subscription['name'],
                    style: theme.textTheme.titleMedium,
                  ),
                ),
                if (isActive)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.green.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      'Активна',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: Colors.green,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              subscription['description'],
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurface.withOpacity(0.7),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '₽${subscription['price']}/${subscription['period']}',
                      style: theme.textTheme.titleLarge?.copyWith(
                        color: theme.colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (subscription['discount'] != null)
                      Text(
                        'Скидка ${subscription['discount']}%',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: Colors.green,
                        ),
                      ),
                  ],
                ),
                ElevatedButton(
                  onPressed: () {
                    if (isActive) {
                      _showManageSubscriptionDialog(context);
                    } else {
                      _showSubscribeDialog(context, subscription);
                    }
                  },
                  child: Text(isActive ? 'Управлять' : 'Подписаться'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showSubscribeDialog(BuildContext context, Map<String, dynamic> subscription) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Оформить подписку'),
        content: Text('Вы хотите оформить подписку "${subscription['name']}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Отмена'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Подписка оформлена!'),
                ),
              );
            },
            child: const Text('Подписаться'),
          ),
        ],
      ),
    );
  }

  void _showManageSubscriptionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Управление подпиской'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.pause),
              title: const Text('Приостановить'),
              onTap: () {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Подписка приостановлена'),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.cancel),
              title: const Text('Отменить'),
              onTap: () {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Подписка отменена'),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _RewardCard extends StatelessWidget {
  final Map<String, dynamic> reward;
  final bool isUsed;

  const _RewardCard({
    required this.reward,
    this.isUsed = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Card(
      child: Opacity(
        opacity: isUsed ? 0.6 : 1.0,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Icon(
                  reward['icon'],
                  size: 32,
                  color: theme.colorScheme.primary,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      reward['title'],
                      style: theme.textTheme.titleMedium,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      reward['description'],
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurface.withOpacity(0.7),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${reward['points']} баллов',
                      style: theme.textTheme.titleSmall?.copyWith(
                        color: theme.colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              if (!isUsed)
                ElevatedButton(
                  onPressed: reward['points'] <= 2450 ? () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Награда "${reward['title']}" получена!'),
                      ),
                    );
                  } : null,
                  child: const Text('Получить'),
                )
              else
                Text(
                  'Использована',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurface.withOpacity(0.5),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

// Данные для примера
final _loyaltyTransactions = [
  {
    'type': 'earned',
    'points': 25,
    'description': 'Покупка капучино',
    'date': 'Сегодня, 14:30',
  },
  {
    'type': 'earned',
    'points': 50,
    'description': 'Участие в мероприятии',
    'date': 'Вчера, 18:00',
  },
  {
    'type': 'spent',
    'points': 100,
    'description': 'Бесплатный латте',
    'date': '2 дня назад',
  },
  {
    'type': 'earned',
    'points': 30,
    'description': 'Покупка книги',
    'date': '3 дня назад',
  },
];

final _activeSubscriptions = <Map<String, dynamic>>[];

final _availableSubscriptions = [
  {
    'name': 'Кофейная подписка',
    'description': 'Один бесплатный кофе каждый день',
    'price': 1500,
    'period': 'месяц',
    'discount': 20,
  },
  {
    'name': 'Чайная подписка',
    'description': 'Два чая в неделю на выбор',
    'price': 800,
    'period': 'месяц',
    'discount': 15,
  },
  {
    'name': 'Книжная подписка',
    'description': 'Скидка 30% на все книги',
    'price': 500,
    'period': 'месяц',
    'discount': null,
  },
];

final _availableRewards = [
  {
    'title': 'Бесплатный капучино',
    'description': 'Любой капучино на выбор',
    'points': 100,
    'icon': Icons.local_cafe,
  },
  {
    'title': 'Скидка 20% на книги',
    'description': 'На любую книгу в магазине',
    'points': 200,
    'icon': Icons.menu_book,
  },
  {
    'title': 'Десерт в подарок',
    'description': 'Любой десерт из меню',
    'points': 150,
    'icon': Icons.cake,
  },
  {
    'title': 'VIP столик на час',
    'description': 'Бронь лучшего столика',
    'points': 300,
    'icon': Icons.star,
  },
  {
    'title': 'Мастер-класс бесплатно',
    'description': 'Участие в любом мастер-классе',
    'points': 500,
    'icon': Icons.school,
  },
  {
    'title': 'Кофе на месяц',
    'description': 'Бесплатный кофе каждый день',
    'points': 3000,
    'icon': Icons.card_giftcard,
  },
];

final _usedRewards = [
  {
    'title': 'Бесплатный латте',
    'description': 'Использована 3 дня назад',
    'points': 120,
    'icon': Icons.local_cafe,
  },
  {
    'title': 'Скидка на книгу',
    'description': 'Использована неделю назад',
    'points': 200,
    'icon': Icons.menu_book,
  },
];
