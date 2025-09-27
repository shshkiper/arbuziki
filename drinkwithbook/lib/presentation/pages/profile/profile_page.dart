import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:go_router/go_router.dart';
import 'settings_dialog.dart';
import 'dart:ui';
import '../../widgets/orders_modal.dart';

class ProfilePage extends ConsumerStatefulWidget {
  final VoidCallback? onNavigateToClubs;

  const ProfilePage({super.key, this.onNavigateToClubs});

  @override
  ConsumerState<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  final _user = Supabase.instance.client.auth.currentUser;
  String get adm => _user?.userMetadata?['name'] ?? '';

  @override
  Widget build(BuildContext context) {
    print(adm);
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        flexibleSpace: Container(
          height: 120, // Высота размытой области
          child: ClipRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 0.0, sigmaY: 25.0),
              child: Container(color: Colors.white.withOpacity(0.00001)),
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
            child: 
            adm != 'Admin'
            ?Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.card_giftcard_outlined),
                  iconSize: 27,
                  onPressed: () => context.go('/loyalty'),
                ),
                 IconButton(
                  icon: const Icon(Icons.settings),
                  iconSize: 27,
                  onPressed: () => _showSettingsDialog(context),
                ),
              ],
            )
            :
            Row( 
              children: [
              ],
            )
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            adm != 'Admin'
            ?Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Первая строка: аватар, имя и почта
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Аватар с градиентом
                          Container(
                            width: 56,
                            height: 56,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Theme.of(context).colorScheme.primary,
                                  Theme.of(
                                    context,
                                  ).colorScheme.primary.withOpacity(0.8),
                                ],
                              ),
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.primary.withOpacity(0.3),
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Center(
                              child: Text(
                                _getUserInitials(),
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontFamily: 'G',
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(width: 16),

                          // Имя и почта
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _user?.userMetadata?['name'] ??
                                      'Пользователь',
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w800,
                                    color:
                                        Theme.of(context).colorScheme.onSurface,
                                    fontFamily: 'G',
                                    height: 1.1,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  _user?.email ?? '',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.onSurface.withOpacity(0.7),
                                    fontFamily: 'G',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 15),

                      // Разделитель
                      Container(height: 1, color: Colors.grey.withOpacity(0.1)),

                      const SizedBox(height: 10),

                      // Вторая строка: статистика
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _PremiumProfileStat(
                            title: 'Визитов',
                            value: '47',
                            status: 'none',
                          ),
                          Container(
                            width: 1,
                            height: 40,
                            color: Colors.grey.withOpacity(0.1),
                          ),
                          _PremiumProfileStat(
                            title: 'Баллов',
                            value: '2,450',
                            status: 'none',
                          ),
                          Container(
                            width: 1,
                            height: 40,
                            color: Colors.grey.withOpacity(0.1),
                          ),
                          _PremiumProfileStat(
                            title: 'Уровень',
                            value: 'Золото',
                            status: 'Золото',
                          ),
                        ],
                      ),
                    ],
                  ),
                )
                .animate(delay: const Duration(milliseconds: 200))
                .fadeIn(duration: const Duration(milliseconds: 150))
                .slideX(
                  begin: -0.2,
                  duration: const Duration(milliseconds: 150),
                )
                :
                Container(
                  
                )
                .animate(delay: const Duration(milliseconds: 200))
                .fadeIn(duration: const Duration(milliseconds: 150))
                .slideX(
                  begin: -0.2,
                  duration: const Duration(milliseconds: 150),
                ),
            adm != 'Admin'?
            const SizedBox(height: 15):const SizedBox(height: 0),

            adm != 'Admin'?
            _MenuSection(
                  title: 'Заказы',
                  items: 
                  [
                    _MenuItem(
                      icon: Icons.shopping_bag_outlined,
                      title: 'История заказов',
                      subtitle: 'Ваши предыдущие заказы',
                      onTap: () => _showOrdersModal(context),
                    ),
                  ],
                )
                .animate(delay: const Duration(milliseconds: 200))
                .fadeIn(duration: const Duration(milliseconds: 150))
                .slideX(
                  begin: -0.2,
                  duration: const Duration(milliseconds: 150),
                ):SizedBox(),

            adm != 'Admin'?
            const SizedBox(height: 15):const SizedBox(height: 0),
            adm != 'Admin'?
            _MenuSection(
                  title: 'Настройки',
                  items: [
                    _MenuItem(
                      icon: Icons.notifications,
                      title: 'Уведомления',
                      subtitle: 'Управление уведомлениями',
                      onTap: () => _showNotificationSettings(context),
                    ),
                    _MenuItem(
                      icon: Icons.privacy_tip,
                      title: 'Приватность',
                      subtitle: 'Настройки конфиденциальности',
                      onTap: () => _showPrivacySettings(context),
                    ),
                    _MenuItem(
                      icon: Icons.help,
                      title: 'Помощь',
                      subtitle: 'Часто задаваемые вопросы',
                      onTap: () => _showHelp(context),
                    ),
                  ],
                )
                .animate(delay: const Duration(milliseconds: 200))
                .fadeIn(duration: const Duration(milliseconds: 150))
                .slideX(
                  begin: 0.2,
                  duration: const Duration(milliseconds: 150),
                ):SizedBox(),
            adm != 'Admin'?
            const SizedBox(height: 15):const SizedBox(height: 0),

            adm != 'Admin'?
            _MenuSection(
                  title: 'О приложении',
                  items: [
                    _MenuItem(
                      icon: Icons.info,
                      title: 'О нас',
                      subtitle: 'Информация о кафе',
                      onTap: () => _showAbout(context),
                    ),
                    _MenuItem(
                      icon: Icons.fmd_good,
                      title: 'Мы на карте',
                      subtitle: 'Наше местонахождение',
                      onTap: () => context.push('/map'),
                    ),
                    _MenuItem(
                      icon: Icons.rate_review,
                      title: 'Оценить приложение',
                      subtitle: 'Поделиться отзывом',
                      onTap: () => _showRating(context),
                    ),
                    _MenuItem(
                      icon: Icons.share,
                      title: 'Поделиться',
                      subtitle: 'Расскажи друзьям',
                      onTap: () => _shareApp(context),
                    ),
                  ],
                )
                .animate(delay: const Duration(milliseconds: 200))
                .fadeIn(duration: const Duration(milliseconds: 150))
                .slideY(
                  begin: 0.2,
                  duration: const Duration(milliseconds: 150),
                ):
                _MenuSection(
                  title: 'Панель администратора',
                  items: [
                    _MenuItem(
                      icon: Icons.person,
                      title: 'Пользователи',
                      subtitle: 'Список пользователей',
                      onTap: () => const SizedBox(),
                    ),
                    _MenuItem(
                      icon: Icons.article,
                      title: 'Логи',
                      subtitle: 'Список логов',
                      onTap: () => const SizedBox(),
                    ),
                    _MenuItem(
                      icon: Icons.groups_outlined,
                      title: 'Клубы',
                      subtitle: 'Список клубов',
                      onTap: () => const SizedBox(),
                    ),
                    _MenuItem(
                      icon: Icons.event,
                      title: 'События',
                      subtitle: 'Список событий',
                      onTap: () => const SizedBox(),
                    ),
                     _MenuItem(
                      icon: Icons.shopping_basket,
                      title: 'Все заказы',
                      subtitle: 'Список заказов',
                      onTap: () => const SizedBox(),
                    ),
                  ],
                )
                .animate(delay: const Duration(milliseconds: 200))
                .fadeIn(duration: const Duration(milliseconds: 150))
                .slideY(
                  begin: 0.2,
                  duration: const Duration(milliseconds: 150),
                ),

            const SizedBox(height: 24),

            // Кнопка выхода
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: theme.colorScheme.error.withOpacity(0.3),
                    blurRadius: 10,
                    spreadRadius: 1,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: OutlinedButton.icon(
                onPressed: () => _showLogoutDialog(context),
                icon: const Icon(Icons.logout),
                label: const Text('Выйти из аккаунта'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: theme.colorScheme.error.withOpacity(0.8),
                  side: BorderSide(color: theme.colorScheme.error),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: Color.fromARGB(200, 231, 239, 255),
                ),
              ),
            ),
            const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }

  String _getUserInitials() {
    final name = _user?.userMetadata?['name'] as String?;
    if (name != null && name.isNotEmpty) {
      final parts = name.split(' ');
      if (parts.length >= 2) {
        return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
      } else {
        return parts[0][0].toUpperCase();
      }
    }
    return _user?.email?[0].toUpperCase() ?? 'U';
  }

  void _showSettingsDialog(BuildContext context) {
    showDialog(context: context, builder: (context) => const SettingsDialog());
  }

  void _showOrdersModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const OrdersModal(),
    );
  }

  Widget _PremiumProfileStat({
    required String title,
    required String value,
    required String status,
  }) {
    Color? valueColor;
    if (status == 'Золото') {
      valueColor = const Color(0xFFFFD700);
    } else if (status == 'Серебро') {
      valueColor = const Color(0xFFC0C0C0);
    } else if (status == 'Бронза') {
      valueColor = const Color(0xFFCD7F32);
    }

    return Expanded(
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: valueColor ?? Theme.of(context).colorScheme.onSurface,
              fontFamily: 'G',
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
              fontFamily: 'G',
            ),
          ),
        ],
      ),
    );
  }

  void _showNotificationSettings(BuildContext context) {
    // TODO: Implement notification settings
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Настройки уведомлений - в разработке')),
    );
  }

  void _showPrivacySettings(BuildContext context) {
    // TODO: Implement privacy settings
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Настройки приватности - в разработке')),
    );
  }

  void _showHelp(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Помощь'),
            content: const SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Как заказать кофе?'),
                  SizedBox(height: 8),
                  Text(
                    '1. Перейдите во вкладку "Меню"\n2. Выберите напиток\n3. Добавьте в корзину\n4. Оформите заказ',
                  ),
                  SizedBox(height: 16),
                  Text('Как накопить баллы?'),
                  SizedBox(height: 8),
                  Text(
                    'Баллы начисляются за каждую покупку и участие в мероприятиях клубов.',
                  ),
                  SizedBox(height: 16),
                  Text('Как присоединиться к клубу?'),
                  SizedBox(height: 8),
                  Text(
                    'Перейдите во вкладку "Клубы" и выберите интересующий вас клуб.',
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Понятно'),
              ),
            ],
          ),
    );
  }

  void _showAbout(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('О нас'),
            content: const SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Drink with Book - это уютное пространство для любителей кофе, чая и хорошей литературы.',
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Мы создали это место для тех, кто ценит качественные напитки, интересные книги и душевные беседы.',
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Присоединяйтесь к нашему сообществу и открывайте новые вкусы и истории каждый день!',
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Закрыть'),
              ),
            ],
          ),
    );
  }

  void _showRating(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Спасибо за желание оценить приложение!')),
    );
  }

  void _shareApp(BuildContext context) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Поделиться - в разработке')));
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (context) => Dialog(
            backgroundColor: Colors.transparent,
            elevation: 0,
            insetPadding: const EdgeInsets.all(20),
            child: Container(
              constraints: const BoxConstraints(maxWidth: 500),
              decoration: BoxDecoration(
                color: Colors.white,
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Заголовок
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 44,
                              height: 44,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.red,
                                    Colors.red.withOpacity(0.8),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(14),
                              ),
                              child: Icon(
                                Icons.logout_rounded,
                                color: Colors.white,
                                size: 24,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Text(
                              'Выход',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w800,
                                color: Theme.of(context).colorScheme.onSurface,
                                fontFamily: 'G',
                              ),
                            ),
                          ],
                        ),
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
                              color: Theme.of(
                                context,
                              ).colorScheme.onSurface.withOpacity(0.7),
                              size: 20,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    // Текст подтверждения
                    Text(
                      'Вы уверены, что хотите выйти из аккаунта?',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Theme.of(
                          context,
                        ).colorScheme.onSurface.withOpacity(0.8),
                        fontFamily: 'G',
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Кнопки
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(
                              color: Colors.grey.withOpacity(0.3),
                              width: 1.5,
                            ),
                          ),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () => Navigator.of(context).pop(),
                              borderRadius: BorderRadius.circular(14),
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 24,
                                  vertical: 14,
                                ),
                                child: Text(
                                  'Отмена',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.onSurface.withOpacity(0.8),
                                    fontFamily: 'G',
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Colors.red, Colors.red.withOpacity(0.9)],
                              stops: const [0.0, 0.8],
                            ),
                            borderRadius: BorderRadius.circular(14),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.red.withOpacity(0.4),
                                blurRadius: 15,
                                offset: const Offset(0, 5),
                              ),
                            ],
                          ),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () async {
                                await Supabase.instance.client.auth.signOut();
                                if (context.mounted) {
                                  Navigator.of(context).pop(); // Закрыть диалог
                                  context.go('/auth');
                                }
                              },
                              borderRadius: BorderRadius.circular(14),
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 32,
                                  vertical: 14,
                                ),
                                child: Text(
                                  'Выйти',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                    fontFamily: 'G',
                                    letterSpacing: -0.2,
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

class _MenuSection extends StatelessWidget {
  final String title;
  final List<_MenuItem> items;

  const _MenuSection({required this.title, required this.items});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 10),
          child: Text(
            title,
            style: theme.textTheme.titleMedium?.copyWith(
              fontFamily: "G",
              fontSize: 22,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Card(
          margin: EdgeInsets.zero,
          child: Column(
            children:
                items
                    .asMap()
                    .entries
                    .map(
                      (entry) => Column(
                        children: [
                          entry.value,
                          if (entry.key < items.length - 1)
                            Divider(
                              height: 1,
                              indent: 56,
                              color: theme.colorScheme.outline.withOpacity(0.2),
                            ),
                        ],
                      ),
                    )
                    .toList(),
          ),
        ),
      ],
    );
  }
}

class _MenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _MenuItem({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListTile(
      leading: Container(
        width: 45,
        height: 45,
        decoration: BoxDecoration(
          color: theme.colorScheme.primary.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon, color: theme.colorScheme.primary, size: 22),
      ),
      title: Text(
        title,
        style: theme.textTheme.titleSmall?.copyWith(
          fontFamily: "G",
          fontSize: 20,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: theme.textTheme.bodySmall?.copyWith(
          color: theme.colorScheme.onSurface.withOpacity(0.5),
          fontFamily: "G",
          fontSize: 14,
        ),
      ),
      trailing: Icon(
        Icons.chevron_right,
        color: theme.colorScheme.onSurface.withOpacity(0.4),
        size: 25,
      ),
      onTap: onTap,
    );
  }
}
