import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'dart:async';
import 'dart:ui';
import '../../../data/models/order_model.dart';
import '../../../data/providers/order_providers.dart';

class OrdersPage extends ConsumerStatefulWidget {
  const OrdersPage({super.key});

  @override
  ConsumerState<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends ConsumerState<OrdersPage> {
  Timer? _statusTimer;

  @override
  void initState() {
    super.initState();
    _startStatusTimer();
  }

  @override
  void dispose() {
    _statusTimer?.cancel();
    super.dispose();
  }

  void _startStatusTimer() {
    // Симуляция изменения статуса заказа каждые 30 секунд
    _statusTimer = Timer.periodic(const Duration(seconds: 30), (timer) {
      if (mounted) {
        _simulateStatusUpdate();
      }
    });
  }

  void _simulateStatusUpdate() {
    // Здесь можно добавить логику для симуляции обновления статуса
    // В реальном приложении это будет происходить через Supabase realtime
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final ordersAsync = ref.watch(userOrdersStreamProvider);

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
        title: Padding(
          padding: const EdgeInsets.only(left: 1.0),
          child: Image.asset(
            height: 45,
            'assets/images/logo.png',
            fit: BoxFit.contain,
          ),
        ),
        centerTitle: false,
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => context.pop(),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 13.0),
            child: IconButton(
              icon: const Icon(Icons.refresh),
              iconSize: 27,
              onPressed: () {
                // Обновляем список заказов
                ref.invalidate(userOrdersStreamProvider);
              },
            ),
          ),
        ],
      ),
      body: ordersAsync.when(
        data: (orders) {
          if (orders.isEmpty) {
            return _buildEmptyState(theme);
          }

          return RefreshIndicator(
            onRefresh: () async {
              ref.invalidate(userOrdersStreamProvider);
            },
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: orders.length,
              itemBuilder: (context, index) {
                final order = orders[index];
                return _buildOrderCard(order, theme, index);
              },
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => _buildErrorState(theme, error.toString()),
      ),
    );
  }

  Widget _buildEmptyState(ThemeData theme) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.shopping_bag_outlined,
            size: 64,
            color: theme.colorScheme.outline,
          ),
          const SizedBox(height: 16),
          Text(
            'У вас пока нет заказов',
            style: theme.textTheme.headlineSmall?.copyWith(fontFamily: 'G'),
          ),
          const SizedBox(height: 8),
          Text(
            'Сделайте первый заказ и отслеживайте его здесь',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.outline,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () => context.go('/home'),
            child: const Text('Перейти к меню'),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(ThemeData theme, String error) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, size: 64, color: theme.colorScheme.error),
          const SizedBox(height: 16),
          Text(
            'Ошибка загрузки заказов',
            style: theme.textTheme.headlineSmall?.copyWith(fontFamily: 'G'),
          ),
          const SizedBox(height: 8),
          Text(
            error,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.outline,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              ref.invalidate(userOrdersStreamProvider);
            },
            child: const Text('Попробовать снова'),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderCard(OrderModel order, ThemeData theme, int index) {
    return Container(
          margin: const EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Заголовок заказа
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Заказ #${order.id.substring(0, 8)}',
                          style: theme.textTheme.titleLarge?.copyWith(
                            fontFamily: 'G',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          _formatDateTime(order.createdAt),
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.outline,
                          ),
                        ),
                      ],
                    ),
                    _buildStatusChip(order.status, theme),
                  ],
                ),
              ),

              // Прогресс заказа
              _buildOrderProgress(order, theme),

              // Детали заказа
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Сумма заказа',
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontFamily: 'G',
                          ),
                        ),
                        Text(
                          '₽${order.totalAmount.toInt()}',
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontFamily: 'G',
                            fontWeight: FontWeight.bold,
                            color: theme.colorScheme.primary,
                          ),
                        ),
                      ],
                    ),
                    if (order.notes != null) ...[
                      const SizedBox(height: 8),
                      Text(
                        'Комментарий: ${order.notes}',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.outline,
                        ),
                      ),
                    ],
                    if (order.loyaltyPointsEarned > 0) ...[
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(Icons.stars, size: 16, color: Colors.amber),
                          const SizedBox(width: 4),
                          Text(
                            '+${order.loyaltyPointsEarned} баллов',
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: Colors.amber[700],
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),

              // Кнопки действий
              if (order.status == 'pending' || order.status == 'preparing') ...[
                const Divider(height: 1),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () => _cancelOrder(order.id),
                          icon: const Icon(Icons.cancel_outlined),
                          label: const Text('Отменить'),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: theme.colorScheme.error,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () => _showOrderDetails(order),
                          icon: const Icon(Icons.info_outline),
                          label: const Text('Подробнее'),
                        ),
                      ),
                    ],
                  ),
                ),
              ] else ...[
                const Divider(height: 1),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () => _showOrderDetails(order),
                      icon: const Icon(Icons.info_outline),
                      label: const Text('Подробности заказа'),
                    ),
                  ),
                ),
              ],
            ],
          ),
        )
        .animate(delay: (index * 100).ms)
        .slideX(duration: 400.ms, curve: Curves.easeOut);
  }

  Widget _buildStatusChip(String status, ThemeData theme) {
    Color color;
    String text;
    IconData icon;

    switch (status) {
      case 'pending':
        color = Colors.orange;
        text = 'Ожидает';
        icon = Icons.access_time;
        break;
      case 'preparing':
        color = Colors.blue;
        text = 'Готовится';
        icon = Icons.restaurant;
        break;
      case 'ready':
        color = Colors.green;
        text = 'Готов';
        icon = Icons.check_circle;
        break;
      case 'completed':
        color = Colors.grey;
        text = 'Завершен';
        icon = Icons.done_all;
        break;
      case 'cancelled':
        color = Colors.red;
        text = 'Отменен';
        icon = Icons.cancel;
        break;
      default:
        color = Colors.grey;
        text = 'Неизвестно';
        icon = Icons.help;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: color),
          const SizedBox(width: 4),
          Text(
            text,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.w500,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderProgress(OrderModel order, ThemeData theme) {
    final statuses = ['pending', 'preparing', 'ready', 'completed'];
    final currentIndex = statuses.indexOf(order.status);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children:
            statuses.asMap().entries.map((entry) {
              final index = entry.key;
              final isActive = index <= currentIndex;
              final isLast = index == statuses.length - 1;

              return Expanded(
                child: Row(
                  children: [
                    Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color:
                            isActive
                                ? theme.colorScheme.primary
                                : theme.colorScheme.outline.withOpacity(0.3),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child:
                            isActive
                                ? Icon(
                                  Icons.check,
                                  color: Colors.white,
                                  size: 16,
                                )
                                : Text(
                                  '${index + 1}',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                      ),
                    ),
                    if (!isLast)
                      Expanded(
                        child: Container(
                          height: 2,
                          color:
                              isActive
                                  ? theme.colorScheme.primary
                                  : theme.colorScheme.outline.withOpacity(0.3),
                        ),
                      ),
                  ],
                ),
              );
            }).toList(),
      ),
    );
  }

  String _formatDateTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inMinutes < 1) {
      return 'Только что';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes} мин. назад';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} ч. назад';
    } else {
      return '${dateTime.day}.${dateTime.month}.${dateTime.year}';
    }
  }

  void _cancelOrder(String orderId) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Отменить заказ?'),
            content: const Text('Вы уверены, что хотите отменить этот заказ?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Нет'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  // Здесь добавить логику отмены заказа
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Заказ отменен')),
                  );
                },
                child: const Text('Да, отменить'),
              ),
            ],
          ),
    );
  }

  void _showOrderDetails(OrderModel order) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      isDismissible: true,
      enableDrag: true,
      builder: (context) => _OrderDetailsModal(order: order),
    );
  }
}

class _OrderDetailsModal extends StatelessWidget {
  final OrderModel order;

  const _OrderDetailsModal({required this.order});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          // Индикатор перетаскивания
          Container(
            margin: const EdgeInsets.only(top: 8),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.3),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          // Заголовок
          Container(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Детали заказа',
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontFamily: 'G',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close),
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.grey.withOpacity(0.1),
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1),

          // Содержимое
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Информация о заказе',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontFamily: 'G',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _buildDetailRow(
                    'Номер заказа',
                    '#${order.id.substring(0, 8)}',
                  ),
                  _buildDetailRow(
                    'Дата создания',
                    _formatDateTime(order.createdAt),
                  ),
                  _buildDetailRow('Статус', _getStatusText(order.status)),
                  _buildDetailRow(
                    'Способ получения',
                    order.orderType == 'pickup' ? 'Самовывоз' : 'Доставка',
                  ),
                  _buildDetailRow('Сумма', '₽${order.totalAmount.toInt()}'),

                  if (order.notes != null) ...[
                    const SizedBox(height: 16),
                    Text(
                      'Комментарий',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontFamily: 'G',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.surfaceVariant,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(order.notes!),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
          Text(value),
        ],
      ),
    );
  }

  String _getStatusText(String status) {
    switch (status) {
      case 'pending':
        return 'Ожидает подтверждения';
      case 'preparing':
        return 'Готовится';
      case 'ready':
        return 'Готов к выдаче';
      case 'completed':
        return 'Завершен';
      case 'cancelled':
        return 'Отменен';
      default:
        return 'Неизвестно';
    }
  }

  String _formatDateTime(DateTime dateTime) {
    return '${dateTime.day}.${dateTime.month}.${dateTime.year} ${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}';
  }
}
