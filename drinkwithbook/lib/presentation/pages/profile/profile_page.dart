import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfilePage extends ConsumerStatefulWidget {
  final VoidCallback? onNavigateToClubs;
  
  const ProfilePage({super.key, this.onNavigateToClubs});

  @override
  ConsumerState<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  final _user = Supabase.instance.client.auth.currentUser;

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
            icon: const Icon(Icons.settings),
            onPressed: () => _showSettingsDialog(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Профиль пользователя
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    theme.colorScheme.primary.withOpacity(0.1),
                    theme.colorScheme.secondary.withOpacity(0.1),
                  ],
                ),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: theme.colorScheme.outline.withOpacity(0.2),
                ),
              ),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: theme.colorScheme.primary,
                    child: Text(
                      _getUserInitials(),
                      style: theme.textTheme.headlineMedium?.copyWith(
                        color: theme.colorScheme.onPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    _user?.userMetadata?['name'] ?? 'Пользователь',
                    style: theme.textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _user?.email ?? '',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurface.withOpacity(0.7),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _ProfileStat(
                        title: 'Визитов',
                        value: '47',
                      ),
                      _ProfileStat(
                        title: 'Баллов',
                        value: '2,450',
                      ),
                      _ProfileStat(
                        title: 'Уровень',
                        value: 'Золото',
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

            // Меню действий
            _MenuSection(
              title: 'Мои активности',
              items: [
                _MenuItem(
                  icon: Icons.history,
                  title: 'История заказов',
                  subtitle: 'Посмотреть все заказы',
                  onTap: () => _showOrderHistory(context),
                ),
                _MenuItem(
                  icon: Icons.favorite,
                  title: 'Избранное',
                  subtitle: 'Любимые напитки и книги',
                  onTap: () => _showFavorites(context),
                ),
                _MenuItem(
                  icon: Icons.group,
                  title: 'Мои клубы',
                  subtitle: 'Участие в сообществах',
                  onTap: () {
                    if (widget.onNavigateToClubs != null) {
                      widget.onNavigateToClubs!();
                    } else {
                      context.go('/clubs');
                    }
                  },
                ),
              ],
            )
                .animate(delay: const Duration(milliseconds: 200))
                .fadeIn(duration: const Duration(milliseconds: 600))
                .slideX(begin: -0.2, duration: const Duration(milliseconds: 600)),

            const SizedBox(height: 16),

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
                .animate(delay: const Duration(milliseconds: 400))
                .fadeIn(duration: const Duration(milliseconds: 600))
                .slideX(begin: 0.2, duration: const Duration(milliseconds: 600)),

            const SizedBox(height: 16),

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
                .animate(delay: const Duration(milliseconds: 600))
                .fadeIn(duration: const Duration(milliseconds: 600))
                .slideY(begin: 0.2, duration: const Duration(milliseconds: 600)),

            const SizedBox(height: 24),

            // Кнопка выхода
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () => _showLogoutDialog(context),
                icon: const Icon(Icons.logout),
                label: const Text('Выйти из аккаунта'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: theme.colorScheme.error,
                  side: BorderSide(color: theme.colorScheme.error),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
              ),
            )
                .animate(delay: const Duration(milliseconds: 800))
                .fadeIn(duration: const Duration(milliseconds: 400))
                .scale(begin: const Offset(0.8, 0.8)),
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
    // TODO: Implement settings
  }

  void _showOrderHistory(BuildContext context) {
    // TODO: Implement order history
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('История заказов - в разработке')),
    );
  }

  void _showFavorites(BuildContext context) {
    // TODO: Implement favorites
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Избранное - в разработке')),
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
      builder: (context) => AlertDialog(
        title: const Text('Помощь'),
        content: const SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Как заказать кофе?'),
              SizedBox(height: 8),
              Text('1. Перейдите во вкладку "Меню"\n2. Выберите напиток\n3. Добавьте в корзину\n4. Оформите заказ'),
              SizedBox(height: 16),
              Text('Как накопить баллы?'),
              SizedBox(height: 8),
              Text('Баллы начисляются за каждую покупку и участие в мероприятиях клубов.'),
              SizedBox(height: 16),
              Text('Как присоединиться к клубу?'),
              SizedBox(height: 8),
              Text('Перейдите во вкладку "Клубы" и выберите интересующий вас клуб.'),
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
      builder: (context) => AlertDialog(
        title: const Text('О нас'),
        content: const SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Drink with Book - это уютное пространство для любителей кофе, чая и хорошей литературы.'),
              SizedBox(height: 16),
              Text('Мы создали это место для тех, кто ценит качественные напитки, интересные книги и душевные беседы.'),
              SizedBox(height: 16),
              Text('Присоединяйтесь к нашему сообществу и открывайте новые вкусы и истории каждый день!'),
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
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Поделиться - в разработке')),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Выход'),
        content: const Text('Вы уверены, что хотите выйти из аккаунта?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Отмена'),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.of(context).pop();
              await Supabase.instance.client.auth.signOut();
              if (context.mounted) {
                context.go('/auth');
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.error,
              foregroundColor: Theme.of(context).colorScheme.onError,
            ),
            child: const Text('Выйти'),
          ),
        ],
      ),
    );
  }
}

class _ProfileStat extends StatelessWidget {
  final String title;
  final String value;

  const _ProfileStat({
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Column(
      children: [
        Text(
          value,
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.primary,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          title,
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurface.withOpacity(0.7),
          ),
        ),
      ],
    );
  }
}

class _MenuSection extends StatelessWidget {
  final String title;
  final List<_MenuItem> items;

  const _MenuSection({
    required this.title,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 12),
          child: Text(
            title,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Card(
          margin: EdgeInsets.zero,
          child: Column(
            children: items
                .asMap()
                .entries
                .map((entry) => Column(
                      children: [
                        entry.value,
                        if (entry.key < items.length - 1)
                          Divider(
                            height: 1,
                            indent: 56,
                            color: theme.colorScheme.outline.withOpacity(0.2),
                          ),
                      ],
                    ))
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
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: theme.colorScheme.primary.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(
          icon,
          color: theme.colorScheme.primary,
          size: 20,
        ),
      ),
      title: Text(
        title,
        style: theme.textTheme.titleSmall,
      ),
      subtitle: Text(
        subtitle,
        style: theme.textTheme.bodySmall?.copyWith(
          color: theme.colorScheme.onSurface.withOpacity(0.7),
        ),
      ),
      trailing: Icon(
        Icons.chevron_right,
        color: theme.colorScheme.onSurface.withOpacity(0.4),
      ),
      onTap: onTap,
    );
  }
}
