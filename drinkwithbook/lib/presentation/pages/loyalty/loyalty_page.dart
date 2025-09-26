import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'dart:ui';

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
        toolbarHeight: 100,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Container(),
        centerTitle: false,
        flexibleSpace: ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 0.0, sigmaY: 25.0),
            child: Container(
              color: Colors.white.withOpacity(0.00001),
              child: Column(
                children: [
                  // Верхняя часть с логотипом и корзиной
                  Container(
                    height: 80,
                    child: Row(
                      children: [
                        // Логотип
                        Padding(
                          padding: const EdgeInsets.only(left: 17.0, top: 24.0),
                          child: Image.asset(
                            height: 45,
                            'assets/images/logo.png',
                            fit: BoxFit.contain,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // TabBar
                  Expanded(
                    child: TabBar(
                      dividerHeight: 0,
                      controller: _tabController,
                      labelStyle: TextStyle(
                        fontSize: 16.4,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'G',
                      ),
                      unselectedLabelStyle: TextStyle(
                        fontSize: 16.4,
                        fontWeight: FontWeight.normal,
                        fontFamily: 'G',
                      ),
                      tabs: const [
                        Tab(text: 'Моя карта'),
                        Tab(text: 'Подписки'),
                        Tab(text: 'Награды'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
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
      final alreadyActive = _activeSubscriptions.any(
        (s) => s['name'] == subscription['name'],
      );
      if (alreadyActive) return;
      // убрать из доступных
      _availableSubscriptions.removeWhere(
        (s) => s['name'] == subscription['name'],
      );
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
      _activeSubscriptions.removeWhere(
        (s) => s['name'] == subscription['name'],
      );
      // вернуть обратно в доступные, если её там нет
      final exists = _availableSubscriptions.any(
        (s) => s['name'] == subscription['name'],
      );
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
      SnackBar(content: Text('Награда "${reward['title']}" успешно обменена!')),
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
      builder:
          (context) => Dialog(
            backgroundColor: Colors.transparent,
            elevation: 0,
            insetPadding: const EdgeInsets.all(20),
            child: Container(
              constraints: const BoxConstraints(maxWidth: 400),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(28),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.25),
                    blurRadius: 40,
                    offset: const Offset(0, 15),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Заголовок с иконкой
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Заголовок с иконкой слева
                        Row(
                          children: [
                            Container(
                              width: 44,
                              height: 44,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Theme.of(context).colorScheme.primary,
                                    Theme.of(
                                      context,
                                    ).colorScheme.primary.withOpacity(0.8),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(14),
                              ),
                              child: Icon(
                                Icons.qr_code_2_rounded,
                                color: Theme.of(context).colorScheme.surface,
                                size: 24,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Text(
                              'QR-код',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w800,
                                color: Theme.of(context).colorScheme.onSurface,
                                fontFamily: 'G',
                              ),
                            ),
                          ],
                        ),

                        // Крестик для выхода справа
                        IconButton(
                          onPressed: () => Navigator.of(context).pop(),
                          icon: Container(
                            width: 36,
                            height: 36,
                            decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.1),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.close_rounded,
                              color: Colors.grey[600],
                              size: 20,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 28),

                    // QR-код с оформлением
                    Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Colors.grey.withOpacity(0.03),
                            Colors.grey.withOpacity(0.08),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Colors.grey.withOpacity(0.2),
                          width: 1.5,
                        ),
                      ),
                      child: Column(
                        children: [
                          QrImageView(
                            data: qrData,
                            version: QrVersions.auto,
                            size: 180.0,
                            backgroundColor: Colors.transparent,
                            eyeStyle: QrEyeStyle(
                              eyeShape: QrEyeShape.square,
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                            dataModuleStyle: QrDataModuleStyle(
                              dataModuleShape: QrDataModuleShape.square,
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                          ),

                          const SizedBox(height: 16),

                          // Информация под QR-кодом
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                            decoration: BoxDecoration(
                              color: Theme.of(
                                context,
                              ).colorScheme.primary.withOpacity(0.05),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: Theme.of(
                                  context,
                                ).colorScheme.primary.withOpacity(0.1),
                                width: 1,
                              ),
                            ),
                            child: Column(
                              children: [
                                Text(
                                  userEmail,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.grey[700],
                                    fontFamily: 'G',
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '2,450 баллов • Статус: ЗОЛОТО',
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w700,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    fontFamily: 'G',
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 28),

                    // Кнопка закрытия
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Theme.of(context).colorScheme.primary,
                            Theme.of(
                              context,
                            ).colorScheme.primary.withOpacity(0.9),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Theme.of(
                              context,
                            ).colorScheme.primary.withOpacity(0.4),
                            blurRadius: 15,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () => Navigator.of(context).pop(),
                          borderRadius: BorderRadius.circular(16),
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.check_circle_rounded,
                                  size: 20,
                                  color: Theme.of(context).colorScheme.surface,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  'Готово',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color:
                                        Theme.of(context).colorScheme.surface,
                                    fontFamily: 'G',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
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

class _LoyaltyCardTab extends StatelessWidget {
  final VoidCallback? onShowQRCode;

  const _LoyaltyCardTab({this.onShowQRCode});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Карта лояльности
          Container(
                width: double.infinity,
                padding: const EdgeInsets.all(32),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      theme.colorScheme.primary,
                      theme.colorScheme.primaryContainer,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(28),
                  boxShadow: [
                    BoxShadow(
                      color: theme.colorScheme.primary.withOpacity(0.4),
                      blurRadius: 30,
                      offset: const Offset(0, 15),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Верхняя строка с названием и статусом
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Drink with Book',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: Theme.of(context).colorScheme.surface,
                            fontFamily: 'G',
                            letterSpacing: -0.3,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Colors.amber, Colors.orange],
                            ),
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.amber.withOpacity(0.3),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Text(
                            'ЗОЛОТО',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w800,
                              color: Colors.black,
                              fontFamily: 'G',
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),

                    // Информация о пользователе
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Анна Смирнова',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w800,
                            color: Theme.of(context).colorScheme.surface,
                            fontFamily: 'G',
                            height: 1.2,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Участник с октября 2023',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.white.withOpacity(0.9),
                            fontFamily: 'G',
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 32),

                    // Баллы и QR код
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '2,450',
                              style: TextStyle(
                                fontSize: 36,
                                fontWeight: FontWeight.w900,
                                color: Theme.of(context).colorScheme.surface,
                                fontFamily: 'G',
                                letterSpacing: -1,
                              ),
                            ),
                            Text(
                              'Баллов',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.white.withOpacity(0.8),
                                fontFamily: 'G',
                              ),
                            ),
                          ],
                        ),

                        // QR код
                        GestureDetector(
                          onTap: onShowQRCode,
                          child: Container(
                            width: 70,
                            height: 70,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.15),
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: Colors.white.withOpacity(0.3),
                                width: 2,
                              ),
                            ),
                            child: Icon(
                              Icons.qr_code_2_rounded,
                              size: 32,
                              color: Colors.white.withOpacity(0.9),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
              .animate()
              .fadeIn(duration: const Duration(milliseconds: 200))
              .slideY(begin: -0.2, duration: const Duration(milliseconds: 200)),

          const SizedBox(height: 28),

          // Прогресс до следующего уровня
          Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 25,
                      offset: const Offset(0, 8),
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
                          'Прогресс до следующего\nуровня',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: Theme.of(context).colorScheme.onSurface,
                            fontFamily: 'G',
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            '73%',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w800,
                              color: Colors.grey[700],
                              fontFamily: 'G',
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    // Уровни
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.star_rounded,
                                  size: 16,
                                  color: Colors.amber,
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  'Золото',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.amber,
                                    fontFamily: 'G',
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              '2,450 / 3,000',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Colors.grey[600],
                                fontFamily: 'G',
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.star_rounded,
                                  size: 16,
                                  color: Colors.grey[400],
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  'Платина',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.grey[500],
                                    fontFamily: 'G',
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              'Следующий уровень',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey[500],
                                fontFamily: 'G',
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    // Прогресс бар
                    Container(
                      height: 12,
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Stack(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.73,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Colors.amber, Colors.orange],
                              ),
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 8),
                    Center(
                      child: Text(
                        'Осталось 550 баллов до уровня Платина',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey[600],
                          fontFamily: 'G',
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              )
              .animate(delay: const Duration(milliseconds: 200))
              .fadeIn(duration: const Duration(milliseconds: 200))
              .slideX(begin: -0.2, duration: const Duration(milliseconds: 200)),

          const SizedBox(height: 28),

          // Статистика
          Text(
                'Моя статистика',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: Theme.of(context).colorScheme.onSurface,
                  fontFamily: 'G',
                ),
              )
              .animate(delay: const Duration(milliseconds: 200))
              .fadeIn(duration: const Duration(milliseconds: 200))
              .slideX(begin: -0.2, duration: const Duration(milliseconds: 200)),
          const SizedBox(height: 16),

          GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1.2,
                children: [
                  _ModernStatCard(
                    title: 'Визитов',
                    value: '47',
                    icon: Icons.store_rounded,
                    color: theme.colorScheme.primary,
                  ),
                  _ModernStatCard(
                    title: 'Потрачено',
                    value: '₽12,340',
                    icon: Icons.credit_card_rounded,
                    color: theme.colorScheme.secondary,
                  ),
                  _ModernStatCard(
                    title: 'Сэкономлено',
                    value: '₽1,890',
                    icon: Icons.savings_rounded,
                    color: Colors.green,
                  ),
                  _ModernStatCard(
                    title: 'Любимый напиток',
                    value: 'Капучино',
                    icon: Icons.coffee_rounded,
                    color: Colors.brown,
                  ),
                ],
              )
              .animate(delay: const Duration(milliseconds: 200))
              .fadeIn(duration: const Duration(milliseconds: 200))
              .slideY(begin: 0.2, duration: const Duration(milliseconds: 200)),

          const SizedBox(height: 28),

          // История транзакций
          Row(
            children: [
              Container(
                width: 4,
                height: 24,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      theme.colorScheme.primary,
                      theme.colorScheme.secondary,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 12),
              Text(
                'Последние начисления',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: Theme.of(context).colorScheme.onSurface,
                  fontFamily: 'G',
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          ..._loyaltyTransactions
              .map(
                (transaction) =>
                    _ModernTransactionCard(transaction: transaction),
              )
              .toList()
              .animate(interval: const Duration(milliseconds: 100))
              .fadeIn(duration: const Duration(milliseconds: 400))
              .slideX(begin: 0.2, duration: const Duration(milliseconds: 400)),
        ],
      ),
    );

    // Современная карточка статистики
  }
}

class _ModernStatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const _ModernStatCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, size: 22, color: color),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: Theme.of(context).colorScheme.onSurface,
                    fontFamily: 'G',
                  ),
                ),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[600],
                    fontFamily: 'G',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Современная карточка
class _ModernTransactionCard extends StatelessWidget {
  final Map<String, dynamic> transaction;

  const _ModernTransactionCard({required this.transaction});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 12,
        ),
        leading: Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color:
                transaction['points'] > 0
                    ? Colors.green.withOpacity(0.1)
                    : Colors.red.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            transaction['points'] > 0
                ? Icons.add_rounded
                : Icons.remove_rounded,
            color: transaction['points'] > 0 ? Colors.green : Colors.red,
            size: 20,
          ),
        ),
        title: Text(
          transaction['description'],
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Theme.of(context).colorScheme.onSurface,
            fontFamily: 'G',
          ),
        ),
        subtitle: Text(
          transaction['date'],
          style: TextStyle(
            fontSize: 13,
            color: Colors.grey[600],
            fontFamily: 'G',
          ),
        ),
        trailing: Text(
          '${transaction['points'] > 0 ? '+' : ''}${transaction['points']}',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: transaction['points'] > 0 ? Colors.green : Colors.red,
            fontFamily: 'G',
          ),
        ),
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
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Заголовок активных подписок
          Row(
            children: [
              Container(
                width: 4,
                height: 24,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      theme.colorScheme.primary,
                      theme.colorScheme.secondary,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 12),
              Text(
                'Активные подписки',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: Theme.of(context).colorScheme.onSurface,
                  fontFamily: 'G',
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),

          if (activeSubscriptions.isEmpty)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(40),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.06),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          theme.colorScheme.primary.withOpacity(0.1),
                          theme.colorScheme.secondary.withOpacity(0.1),
                        ],
                      ),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.subscriptions_rounded,
                      size: 40,
                      color: theme.colorScheme.primary.withOpacity(0.6),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'У вас пока нет активных подписок',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Theme.of(context).colorScheme.onSurface,
                      fontFamily: 'G',
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Оформите подписку и получайте свои любимые напитки с выгодой',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[600],
                      fontFamily: 'G',
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),

          ...activeSubscriptions.map(
            (subscription) => Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: _ModernSubscriptionCard(
                subscription: subscription,
                isActive: true,
                onCancel: onCancel,
              ),
            ),
          ),

          const SizedBox(height: 15),

          // Заголовок доступных подписок
          Row(
            children: [
              Container(
                width: 4,
                height: 24,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.green, Colors.greenAccent],
                  ),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 12),
              Text(
                'Доступные подписки',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: Theme.of(context).colorScheme.onSurface,
                  fontFamily: 'G',
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),

          ...availableSubscriptions
              .map(
                (subscription) => Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: _ModernSubscriptionCard(
                    subscription: subscription,
                    isActive: false,
                    onSubscribe: onSubscribe,
                  ),
                ),
              )
              .toList()
              .animate(interval: const Duration(milliseconds: 100))
              .fadeIn(duration: const Duration(milliseconds: 400))
              .slideY(begin: 0.2, duration: const Duration(milliseconds: 400)),
        ],
      ),
    );
  }
}

class _ModernSubscriptionCard extends StatelessWidget {
  final Map<String, dynamic> subscription;
  final bool isActive;
  final ValueChanged<Map<String, dynamic>>? onSubscribe;
  final ValueChanged<Map<String, dynamic>>? onCancel;

  const _ModernSubscriptionCard({
    required this.subscription,
    required this.isActive,
    this.onSubscribe,
    this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 25,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Верхняя часть с названием и статусом
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    subscription['name'],
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: Theme.of(context).colorScheme.onSurface,
                      fontFamily: 'G',
                      height: 1.2,
                    ),
                  ),
                ),
                if (isActive)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.green, Colors.greenAccent],
                      ),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.green.withOpacity(0.3),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.check_circle_rounded,
                          size: 14,
                          color: Theme.of(context).colorScheme.surface,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          'Активна',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: Theme.of(context).colorScheme.surface,
                            fontFamily: 'G',
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),

            const SizedBox(height: 12),

            // Описание
            Text(
              subscription['description'],
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: Colors.grey[700],
                fontFamily: 'G',
                height: 1.4,
              ),
            ),

            const SizedBox(height: 20),

            // Цена и кнопка
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Цена и скидка
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          '₽${subscription['price']}',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w900,
                            color: theme.colorScheme.primary,
                            fontFamily: 'G',
                            letterSpacing: -1,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '/${subscription['period']}',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey[600],
                            fontFamily: 'G',
                          ),
                        ),
                      ],
                    ),
                    if (subscription['discount'] != null)
                      Container(
                        margin: const EdgeInsets.only(top: 4),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.green.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          'Скидка ${subscription['discount']}%',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: Colors.green,
                            fontFamily: 'G',
                          ),
                        ),
                      ),
                  ],
                ),

                // Кнопка
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors:
                          isActive
                              ? [Colors.grey, Colors.grey[600]!]
                              : [
                                theme.colorScheme.primary,
                                theme.colorScheme.secondary,
                              ],
                    ),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: (isActive
                                ? Colors.grey
                                : theme.colorScheme.primary)
                            .withOpacity(0.3),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        if (isActive) {
                          _showModernManageSubscriptionDialog(context);
                        } else {
                          _showModernSubscribeDialog(context, subscription);
                        }
                      },
                      borderRadius: BorderRadius.circular(16),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 14,
                        ),
                        child: Text(
                          isActive ? 'Управлять' : 'Подписаться',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: Theme.of(context).colorScheme.surface,
                            fontFamily: 'G',
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showModernSubscribeDialog(
    BuildContext context,
    Map<String, dynamic> subscription,
  ) {
    showDialog(
      context: context,
      builder:
          (context) => Dialog(
            backgroundColor: Colors.transparent,
            elevation: 0,
            child: Container(
              constraints: const BoxConstraints(maxWidth: 500),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(28),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.25),
                    blurRadius: 40,
                    offset: const Offset(0, 15),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Theme.of(context).colorScheme.primary,
                            Theme.of(context).colorScheme.secondary,
                          ],
                        ),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.subscriptions_rounded,
                        size: 40,
                        color: Theme.of(context).colorScheme.surface,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Оформить подписку',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                        color: Theme.of(context).colorScheme.onSurface,
                        fontFamily: 'G',
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Вы хотите оформить подписку "${subscription['name']}" за ₽${subscription['price']}/${subscription['period']}?',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[700],
                        fontFamily: 'G',
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 28),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: Colors.grey.withOpacity(0.3),
                                width: 1.5,
                              ),
                            ),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () => Navigator.of(context).pop(),
                                borderRadius: BorderRadius.circular(16),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 16,
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Отмена',
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.grey[700],
                                        fontFamily: 'G',
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Theme.of(context).colorScheme.primary,
                                  Theme.of(context).colorScheme.secondary,
                                ],
                              ),
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.primary.withOpacity(0.4),
                                  blurRadius: 15,
                                  offset: const Offset(0, 5),
                                ),
                              ],
                            ),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () {
                                  Navigator.of(context).pop();
                                  onSubscribe?.call(subscription);
                                },
                                borderRadius: BorderRadius.circular(16),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 16,
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Подписаться',
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w700,
                                        color:
                                            Theme.of(
                                              context,
                                            ).colorScheme.surface,
                                        fontFamily: 'G',
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
    );
  }

  void _showModernManageSubscriptionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (context) => Dialog(
            backgroundColor: Colors.transparent,
            elevation: 0,
            child: Container(
              constraints: const BoxConstraints(maxWidth: 500),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(28),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.25),
                    blurRadius: 40,
                    offset: const Offset(0, 15),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.green, Colors.greenAccent],
                        ),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.settings_rounded,
                        size: 40,
                        color: Theme.of(context).colorScheme.surface,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Управление подпиской',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                        color: Theme.of(context).colorScheme.onSurface,
                        fontFamily: 'G',
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Опции управления
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        children: [
                          _buildModernDialogOption(
                            context,
                            icon: Icons.pause_rounded,
                            title: 'Приостановить подписку',
                            subtitle: 'Временно остановить списания',
                            color: Colors.orange,
                            onTap: () {
                              Navigator.of(context).pop();
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Подписка приостановлена',
                                    style: TextStyle(fontFamily: 'G'),
                                  ),
                                  backgroundColor: Colors.green,
                                ),
                              );
                            },
                          ),
                          Divider(
                            height: 1,
                            color: Colors.grey.withOpacity(0.2),
                          ),
                          _buildModernDialogOption(
                            context,
                            icon: Icons.cancel_rounded,
                            title: 'Отменить подписку',
                            subtitle: 'Полностью прекратить подписку',
                            color: Colors.red,
                            onTap: () {
                              Navigator.of(context).pop();
                              onCancel?.call(subscription);
                            },
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: Colors.grey.withOpacity(0.3),
                          width: 1.5,
                        ),
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () => Navigator.of(context).pop(),
                          borderRadius: BorderRadius.circular(16),
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            child: Center(
                              child: Text(
                                'Закрыть',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey[700],
                                  fontFamily: 'G',
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
    );
  }

  Widget _buildModernDialogOption(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: color, size: 22),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).colorScheme.onSurface,
                        fontFamily: 'G',
                      ),
                    ),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey[600],
                        fontFamily: 'G',
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
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
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Заголовок
          Row(
            children: [
              Container(
                width: 4,
                height: 32,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      theme.colorScheme.primary,
                      theme.colorScheme.secondary,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Бонусы',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color: Theme.of(context).colorScheme.onSurface,
                      fontFamily: 'G',
                      height: 1.1,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Обменивайте баллы на приятные бонусы',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[600],
                      fontFamily: 'G',
                    ),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 10),

          // Доступные награды
          ...availableRewards
              .map(
                (reward) => Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: _ModernRewardCard(reward: reward, onRedeem: onRedeem),
                ),
              )
              .toList()
              .animate(interval: const Duration(milliseconds: 150))
              .fadeIn(duration: const Duration(milliseconds: 200))
              .slideY(begin: 0.3, duration: const Duration(milliseconds: 200)),

          // Использованные награды
          if (usedRewards.isNotEmpty) ...[
            Row(
              children: [
                Container(
                  width: 4,
                  height: 24,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.grey, Colors.grey[600]!],
                    ),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  'История наград',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    color: Theme.of(context).colorScheme.onSurface,
                    fontFamily: 'G',
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),

            ...usedRewards.map(
              (reward) => Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: _ModernUsedRewardCard(reward: reward),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _ModernRewardCard extends StatelessWidget {
  final Map<String, dynamic> reward;
  final Function(Map<String, dynamic>) onRedeem;

  const _ModernRewardCard({required this.reward, required this.onRedeem});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final canAfford = (reward['points'] as int) <= 2450; //ТУТ ТЕКУЩИ БАЛЛЫ

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 25,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Первая строка: иконка, название и описание
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Иконка награды
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors:
                          canAfford
                              ? [
                                theme.colorScheme.primary,
                                theme.colorScheme.primary,
                              ]
                              : [Colors.grey, Colors.grey[600]!],
                    ),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: (canAfford
                                ? theme.colorScheme.primary
                                : Colors.grey)
                            .withOpacity(0.3),
                        blurRadius: 15,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Icon(
                    reward['icon'] ?? Icons.card_giftcard_rounded,
                    size: 27,
                    color: Theme.of(context).colorScheme.surface,
                  ),
                ),

                const SizedBox(width: 20),

                // Название и описание
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        reward['title'],
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          color: Theme.of(context).colorScheme.onSurface,
                          fontFamily: 'G',
                        ),
                      ),

                      const SizedBox(height: 6),

                      Text(
                        reward['description'],
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey[600],
                          fontFamily: 'G',
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Вторая строка: стоимость и кнопка
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color:
                        canAfford
                            ? theme.colorScheme.primary.withOpacity(0.1)
                            : Colors.grey.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.bolt_rounded,
                        size: 16,
                        color:
                            canAfford ? theme.colorScheme.primary : Colors.grey,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        '${reward['points']} баллов',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color:
                              canAfford
                                  ? theme.colorScheme.primary
                                  : Colors.grey,
                          fontFamily: 'G',
                        ),
                      ),
                    ],
                  ),
                ),

                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors:
                          canAfford
                              ? [
                                theme.colorScheme.primary,
                                theme.colorScheme.secondary,
                              ]
                              : [Colors.grey, Colors.grey[600]!],
                    ),
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: [
                      BoxShadow(
                        color: (canAfford
                                ? theme.colorScheme.primary
                                : Colors.grey)
                            .withOpacity(0.3),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap:
                          canAfford
                              ? () => _showRedeemDialog(context, reward)
                              : null,
                      borderRadius: BorderRadius.circular(14),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 12,
                        ),
                        child: Text(
                          'Обменять',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: Theme.of(context).colorScheme.surface,
                            fontFamily: 'G',
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showRedeemDialog(BuildContext context, Map<String, dynamic> reward) {
    showDialog(
      context: context,
      builder:
          (context) => Dialog(
            backgroundColor: Colors.transparent,
            elevation: 0,
            child: Container(
              constraints: const BoxConstraints(maxWidth: 500),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(28),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.25),
                    blurRadius: 40,
                    offset: const Offset(0, 15),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Theme.of(context).colorScheme.primary,
                            Theme.of(context).colorScheme.secondary,
                          ],
                        ),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.card_giftcard_rounded,
                        size: 48,
                        color: Theme.of(context).colorScheme.surface,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Обменять баллы?',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                        color: Theme.of(context).colorScheme.onSurface,
                        fontFamily: 'G',
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Вы хотите обменять ${reward['points']} баллов на "${reward['title']}"?',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[700],
                        fontFamily: 'G',
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 28),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: Colors.grey.withOpacity(0.3),
                                width: 1.5,
                              ),
                            ),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () => Navigator.of(context).pop(),
                                borderRadius: BorderRadius.circular(16),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 16,
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Отмена',
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.grey[700],
                                        fontFamily: 'G',
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Theme.of(context).colorScheme.primary,
                                  Theme.of(context).colorScheme.secondary,
                                ],
                              ),
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.primary.withOpacity(0.4),
                                  blurRadius: 15,
                                  offset: const Offset(0, 5),
                                ),
                              ],
                            ),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () {
                                  Navigator.of(context).pop();
                                  onRedeem(reward);
                                },
                                borderRadius: BorderRadius.circular(16),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 16,
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Обменять',
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w700,
                                        color:
                                            Theme.of(
                                              context,
                                            ).colorScheme.surface,
                                        fontFamily: 'G',
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
    );
  }
}

class _ModernUsedRewardCard extends StatelessWidget {
  final Map<String, dynamic> reward;

  const _ModernUsedRewardCard({required this.reward});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            // Иконка
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.grey, Colors.grey[600]!],
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(
                reward['icon'] ?? Icons.check_circle_rounded,
                size: 28,
                color: Theme.of(context).colorScheme.surface,
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
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Theme.of(context).colorScheme.onSurface,
                      fontFamily: 'G',
                    ),
                  ),

                  const SizedBox(height: 8),

                  // Статус под названием
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Colors.grey.withOpacity(0.2),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.check_circle_rounded,
                          size: 14,
                          color: Colors.grey,
                        ),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            reward['description'],
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: Colors.grey,
                              fontFamily: 'G',
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
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
    'points': -100,
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
