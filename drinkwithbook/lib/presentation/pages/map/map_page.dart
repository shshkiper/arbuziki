import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'dart:ui';
import 'package:go_router/go_router.dart';
import '../profile/profile_page.dart';

class MapPage extends ConsumerStatefulWidget {
  const MapPage({super.key});

  @override
  ConsumerState<MapPage> createState() => _MapPageState();
}

class _MapPageState extends ConsumerState<MapPage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
  backgroundColor: Colors.transparent,
  flexibleSpace: Container(
    height: 120,
    child: ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 0.0, sigmaY: 25.0),
        child: Container(color: Colors.white.withOpacity(0.00001)),
      ),
    ),
  ),
  leading: Padding(
    padding: const EdgeInsets.only(left: 8.0),
    child: IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        context.go('/home');
      },
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
  centerTitle: true, // Изменено на true для центрирования
  actions: [
    Padding(
      padding: const EdgeInsets.only(right: 13.0),
      child: Row(
        children: [
          IconButton(
            iconSize: 27,
            icon: const Icon(Icons.my_location),
            onPressed: () => _showLocationDialog(context),
          ),
          IconButton(
            iconSize: 27,
            icon: const Icon(Icons.search),
            onPressed: () => _showSearchDialog(context),
          ),
        ],
      ),
    ),
  ],
),
      body: Stack(
        children: [
          // Карта как фон
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/map.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Градиентный оверлей для лучшей читаемости
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.1),
                  Colors.transparent,
                  Colors.black.withOpacity(0.3),
                ],
                stops: const [0.0, 0.5, 1.0],
              ),
            ),
          ),

          // Маркеры на карте
          ..._buildMapMarkers(theme),

          // Панель снизу с информацией
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: _buildBottomPanel(theme),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildMapMarkers(ThemeData theme) {
    return [
      // Маркер кафе
      Positioned(
        left: MediaQuery.of(context).size.width * 0.3,
        top: MediaQuery.of(context).size.height * 0.4,
        child: _MapMarker(
          title: 'Drink with Book',
          subtitle: 'Главное кафе',
          isOpen: true,
          onTap: () => _showCafeDetails(context),
        ),
      ),

      // Маркер филиала
      Positioned(
        left: MediaQuery.of(context).size.width * 0.7,
        top: MediaQuery.of(context).size.height * 0.6,
        child: _MapMarker(
          title: 'Drink with Book',
          subtitle: 'Филиал на Арбате',
          isOpen: false,
          onTap: () => _showCafeDetails(context),
        ),
      ),
    ];
  }

  Widget _buildBottomPanel(ThemeData theme) {
    return Container(
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      Icons.location_on,
                      color: theme.colorScheme.primary,
                      size: 28,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Drink with Book',
                          style: theme.textTheme.titleLarge?.copyWith(
                            fontFamily: 'G',
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'ул. Тверская, 15 • Открыто до 23:00',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            fontFamily: 'G',
                            fontSize: 15,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.green.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      'Открыто',
                      style: TextStyle(
                        fontFamily: 'G',
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.green[700],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: _ActionButton(
                      icon: Icons.directions,
                      label: 'Маршрут',
                      onTap: () => _showDirections(context),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _ActionButton(
                      icon: Icons.phone,
                      label: 'Позвонить',
                      onTap: () => _makeCall(context),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _ActionButton(
                      icon: Icons.info_outline,
                      label: 'Подробнее',
                      onTap: () => _showCafeDetails(context),
                    ),
                  ),
                ],
              ),
            ],
          ),
        )
        .animate()
        .fadeIn(duration: const Duration(milliseconds: 300))
        .slideY(begin: 0.3, duration: const Duration(milliseconds: 300));
  }

  void _showLocationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Определение местоположения'),
            content: const Text(
              'Функция определения местоположения будет доступна в следующих версиях приложения.',
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

  void _showSearchDialog(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Поиск на карте'),
            content: const Text(
              'Функция поиска будет доступна в следующих версиях приложения.',
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

  void _showCafeDetails(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _CafeDetailsSheet(),
    );
  }

  void _showDirections(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Функция построения маршрута будет доступна в следующих версиях',
        ),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _makeCall(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Функция звонков будет доступна в следующих версиях'),
        duration: Duration(seconds: 2),
      ),
    );
  }
}

class _MapMarker extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool isOpen;
  final VoidCallback onTap;

  const _MapMarker({
    required this.title,
    required this.subtitle,
    required this.isOpen,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.location_on,
              color: isOpen ? Colors.green : Colors.red,
              size: 24,
            ),
            const SizedBox(height: 4),
            Text(
              title,
              style: TextStyle(
                fontFamily: 'G',
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            Text(
              subtitle,
              style: TextStyle(
                fontFamily: 'G',
                fontSize: 10,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _ActionButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: theme.colorScheme.primary.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Icon(icon, color: theme.colorScheme.primary, size: 24),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontFamily: 'G',
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: theme.colorScheme.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CafeDetailsSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      height: MediaQuery.of(context).size.height * 0.6,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Заголовок
            Row(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Icon(
                    Icons.coffee,
                    color: theme.colorScheme.primary,
                    size: 32,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Drink with Book',
                        style: theme.textTheme.headlineSmall?.copyWith(
                          fontFamily: 'G',
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Кафе и книжный магазин',
                        style: theme.textTheme.bodyLarge?.copyWith(
                          fontFamily: 'G',
                          fontSize: 16,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'Открыто',
                    style: TextStyle(
                      fontFamily: 'G',
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.green[700],
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Информация
            _InfoRow(
              icon: Icons.location_on,
              title: 'Адрес',
              value: 'ул. Тверская, 15, Москва',
            ),
            _InfoRow(
              icon: Icons.access_time,
              title: 'Часы работы',
              value: 'Пн-Вс: 08:00 - 23:00',
            ),
            _InfoRow(
              icon: Icons.phone,
              title: 'Телефон',
              value: '+7 (495) 123-45-67',
            ),
            _InfoRow(icon: Icons.wifi, title: 'Wi-Fi', value: 'Бесплатный'),

            const SizedBox(height: 24),

            // Описание
            Text(
              'О нас',
              style: theme.textTheme.titleLarge?.copyWith(
                fontFamily: 'G',
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Drink with Book - это уютное пространство для любителей кофе, чая и хорошей литературы. Мы создали это место для тех, кто ценит качественные напитки, интересные книги и душевные беседы.',
              style: theme.textTheme.bodyLarge?.copyWith(
                fontFamily: 'G',
                fontSize: 16,
                color: Colors.grey[700],
                height: 1.5,
              ),
            ),

            const SizedBox(height: 24),

            // Кнопки действий
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.directions),
                    label: const Text('Маршрут'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: theme.colorScheme.primary,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.phone),
                    label: const Text('Позвонить'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: theme.colorScheme.primary,
                      side: BorderSide(color: theme.colorScheme.primary),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
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
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const _InfoRow({
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Icon(icon, color: theme.colorScheme.primary, size: 20),
          const SizedBox(width: 12),
          Text(
            '$title: ',
            style: theme.textTheme.bodyLarge?.copyWith(
              fontFamily: 'G',
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.grey[700],
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: theme.textTheme.bodyLarge?.copyWith(
                fontFamily: 'G',
                fontSize: 16,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
