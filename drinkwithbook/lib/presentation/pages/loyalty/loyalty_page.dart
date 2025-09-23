import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoyaltyPage extends ConsumerStatefulWidget {
  const LoyaltyPage({super.key});

  @override
  ConsumerState<LoyaltyPage> createState() => _LoyaltyPageState();
}

class _LoyaltyPageState extends ConsumerState<LoyaltyPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<Map<String, dynamic>> _activeSubscriptions = [];
  List<Map<String, dynamic>> _availableSubscriptions = [
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

  List<Map<String, dynamic>> _availableRewards = [
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

  List<Map<String, dynamic>> _usedRewards = [
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
        children: [
          _LoyaltyCardTab(onShowQRCode: () => _showQRCode(context)),
          _SubscriptionsTab(
            activeSubscriptions: _activeSubscriptions,
            availableSubscriptions: _availableSubscriptions,
            onSubscribe: _subscribeTo,
            onCancel: _cancelSubscription,
          ),
          _RewardsTab(
            availableRewards: _availableRewards,
            usedRewards: _usedRewards,
            onRedeem: _redeemReward,
          ),
        ],
      ),
    );
  }

  void _subscribeTo(Map<String, dynamic> subscription) {
    setState(() {
      // если уже активна — ничего не делаем
      final alreadyActive = _activeSubscriptions.any((s) => s['name'] == subscription['name']);
      if (alreadyActive) return;
      // убрать из доступных
      _availableSubscriptions.removeWhere((s) => s['name'] == subscription['name']);
      // добавить в активные
      _activeSubscriptions.add({
        ...subscription,
        'startDate': DateTime.now(),
        'endDate': DateTime.now().add(const Duration(days: 30)),
      });
    });
  }

  void _cancelSubscription(Map<String, dynamic> subscription) {
    setState(() {
      _activeSubscriptions.removeWhere((s) => s['name'] == subscription['name']);
      // вернуть обратно в доступные, если её там нет
      final exists = _availableSubscriptions.any((s) => s['name'] == subscription['name']);
      if (!exists) {
        _availableSubscriptions.add({
          'name': subscription['name'],
          'description': subscription['description'],
          'price': subscription['price'],
          'period': subscription['period'],
          'discount': subscription['discount'],
        });
      }
    });
  }

  void _redeemReward(Map<String, dynamic> reward) {
    setState(() {
      _availableRewards.removeWhere((r) => r['title'] == reward['title']);
      _usedRewards.insert(0, {
        ...reward,
        'description': 'Использована только что',
      });
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Награда "${reward['title']}" успешно обменена!'),
      ),
    );
  }

  void _showQRCode(BuildContext context) {
    final user = Supabase.instance.client.auth.currentUser;
    final userId = user?.id ?? 'guest';
    final userEmail = user?.email ?? 'guest@example.com';
    
    // Данные для QR-кода - ID пользователя и баллы
    final qrData = 'LOYALTY_CARD:$userId:2450:GOLD';
    
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'QR-код карты лояльности',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
              
              const SizedBox(height: 24),
              
              // QR-код
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: QrImageView(
                  data: qrData,
                  version: QrVersions.auto,
                  size: 200.0,
                  backgroundColor: Colors.white,
                ),
              ),
              
              const SizedBox(height: 16),
              
              Text(
                userEmail,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                ),
                textAlign: TextAlign.center,
              ),
              
              const SizedBox(height: 8),
              
              Text(
                '2,450 баллов • Статус: ЗОЛОТО',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
              
              const SizedBox(height: 24),
              
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Закрыть'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LoyaltyCardTab extends StatelessWidget {
  final VoidCallback? onShowQRCode;
  
  const _LoyaltyCardTab({this.onShowQRCode});

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
                    GestureDetector(
                      onTap: onShowQRCode,
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          Icons.qr_code,
                          size: 48,
                          color: theme.colorScheme.onPrimary,
                        ),
                      ),
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
  final List<Map<String, dynamic>> activeSubscriptions;
  final List<Map<String, dynamic>> availableSubscriptions;
  final ValueChanged<Map<String, dynamic>> onSubscribe;
  final ValueChanged<Map<String, dynamic>> onCancel;

  const _SubscriptionsTab({
    required this.activeSubscriptions,
    required this.availableSubscriptions,
    required this.onSubscribe,
    required this.onCancel,
  });

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
          
          if (activeSubscriptions.isEmpty)
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
          
          ...activeSubscriptions.map((subscription) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: _SubscriptionCard(
              subscription: subscription,
              isActive: true,
              onCancel: onCancel,
            ),
          )),

          const SizedBox(height: 24),

          Text(
            'Доступные подписки',
            style: theme.textTheme.titleLarge,
          ),
          const SizedBox(height: 16),
          
          ...availableSubscriptions.map((subscription) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: _SubscriptionCard(
              subscription: subscription,
              isActive: false,
              onSubscribe: onSubscribe,
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
  final List<Map<String, dynamic>> availableRewards;
  final List<Map<String, dynamic>> usedRewards;
  final ValueChanged<Map<String, dynamic>> onRedeem;

  const _RewardsTab({
    required this.availableRewards,
    required this.usedRewards,
    required this.onRedeem,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Заголовок
          Text(
            'Бонусы',
            style: theme.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: theme.colorScheme.onSurface,
            ),
          ),
          
          const SizedBox(height: 8),
          
          Text(
            'Обменивайте баллы на приятные бонусы',
            style: theme.textTheme.bodyLarge?.copyWith(
              color: theme.colorScheme.onSurface.withOpacity(0.7),
            ),
          ),
          
          const SizedBox(height: 32),

          // Доступные награды - минималистичный дизайн
          ...availableRewards.map((reward) => Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: _MinimalRewardCard(reward: reward, onRedeem: onRedeem),
          ))
              .toList()
              .animate(interval: const Duration(milliseconds: 150))
              .fadeIn(duration: const Duration(milliseconds: 600))
              .slideY(begin: 0.3, duration: const Duration(milliseconds: 600)),

          const SizedBox(height: 40),

          // Использованные награды
          if (usedRewards.isNotEmpty) ...[
            Text(
              'История',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w500,
                color: theme.colorScheme.onSurface.withOpacity(0.8),
              ),
            ),
            
            const SizedBox(height: 16),
            
            ...usedRewards.map((reward) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: _MinimalUsedRewardCard(reward: reward),
            )),
          ],
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
  final ValueChanged<Map<String, dynamic>>? onSubscribe;
  final ValueChanged<Map<String, dynamic>>? onCancel;

  const _SubscriptionCard({
    required this.subscription,
    required this.isActive,
    this.onSubscribe,
    this.onCancel,
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
              onSubscribe?.call(subscription);
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
                onCancel?.call(subscription);
              },
            ),
          ],
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


// removed duplicate demo datasets; stateful copies now live in _LoyaltyPageState

// Минималистичная карточка награды
class _MinimalRewardCard extends StatelessWidget {
  final Map<String, dynamic> reward;
  final ValueChanged<Map<String, dynamic>> onRedeem;

  const _MinimalRewardCard({required this.reward, required this.onRedeem});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: theme.colorScheme.outline.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: InkWell(
        onTap: () => _showRedeemDialog(context, reward),
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Row(
            children: [
              // Иконка
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(
                  reward['icon'],
                  size: 28,
                  color: theme.colorScheme.primary,
                ),
              ),
              
              const SizedBox(width: 20),
              
              // Контент
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      reward['title'],
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                    
                    const SizedBox(height: 4),
                    
                    Text(
                      reward['description'],
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurface.withOpacity(0.7),
                      ),
                    ),
                  ],
                ),
              ),
              
              // Баллы и кнопка
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '${reward['points']} баллов',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 8),
                  
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      'Обменять',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showRedeemDialog(BuildContext context, Map<String, dynamic> reward) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(
          'Обменять награду',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              reward['icon'],
              size: 48,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(height: 16),
            Text(
              reward['title'],
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'Стоимость: ${reward['points']} баллов',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Отмена'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              onRedeem(reward);
            },
            child: const Text('Обменять'),
          ),
        ],
      ),
    );
  }
}

// Минималистичная карточка использованной награды
class _MinimalUsedRewardCard extends StatelessWidget {
  final Map<String, dynamic> reward;

  const _MinimalUsedRewardCard({required this.reward});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface.withOpacity(0.5),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: theme.colorScheme.outline.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            // Иконка
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: theme.colorScheme.onSurface.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                reward['icon'],
                size: 24,
                color: theme.colorScheme.onSurface.withOpacity(0.6),
              ),
            ),
            
            const SizedBox(width: 16),
            
            // Контент
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    reward['title'],
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w500,
                      color: theme.colorScheme.onSurface.withOpacity(0.8),
                    ),
                  ),
                  
                  const SizedBox(height: 2),
                  
                  Text(
                    reward['description'],
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurface.withOpacity(0.6),
                    ),
                  ),
                ],
              ),
            ),
            
            // Статус
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 4,
              ),
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                'Использовано',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: Colors.green,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
