import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../data/providers/order_providers.dart';
import '../../data/models/order_model.dart';

class OrdersModal extends ConsumerStatefulWidget {
  const OrdersModal({super.key});

  @override
  ConsumerState<OrdersModal> createState() => _OrdersModalState();
}

class _OrdersModalState extends ConsumerState<OrdersModal> {
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
              color: theme.colorScheme.outline.withOpacity(0.3),
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
                  'История заказов',
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontFamily: 'G',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.close),
                  style: IconButton.styleFrom(
                    backgroundColor: theme.colorScheme.outline.withOpacity(
                      0.05,
                    ),
                  ),
                ),
              ],
            ),
          ),

          Container(
            height: 8,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  theme.colorScheme.shadow.withOpacity(0.1),
                  theme.colorScheme.shadow.withOpacity(0.05),
                  Colors.transparent,
                ],
                stops: const [0.0, 0.5, 1.0],
              ),
            ),
          ),

          // Содержимое
          Expanded(
            child: Consumer(
              builder: (context, ref, child) {
                final ordersAsync = ref.watch(userOrdersStreamProvider);

                return ordersAsync.when(
                  data: (orders) {
                    if (orders.isEmpty) {
                      return _buildEmptyState(theme);
                    }

                    return ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: orders.length,
                      itemBuilder: (context, index) {
                        final order = orders[index];
                        return _buildOrderCard(order, theme, index);
                      },
                    );
                  },
                  loading:
                      () => const Center(child: CircularProgressIndicator()),
                  error:
                      (error, stack) =>
                          _buildErrorState(theme, error.toString()),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(ThemeData theme) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: theme.colorScheme.primary.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.shopping_bag_outlined,
                size: 64,
                color: theme.colorScheme.primary,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'У вас пока нет заказов',
              style: theme.textTheme.headlineSmall?.copyWith(
                fontFamily: 'G',
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              'Сделайте первый заказ, чтобы увидеть его здесь',
              style: theme.textTheme.bodyLarge?.copyWith(
                color: theme.colorScheme.outline,
                fontFamily: 'G',
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceVariant.withOpacity(0.3),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.tips_and_updates,
                    color: theme.colorScheme.primary,
                    size: 18,
                  ),
                  const SizedBox(width: 8),
                  Flexible(
                    child: Text(
                      'Добавьте товары в корзину и оформите заказ',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontFamily: 'G',
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
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

  Widget _buildErrorState(ThemeData theme, String error) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: theme.colorScheme.error.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.error_outline,
                size: 64,
                color: theme.colorScheme.error,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Ошибка загрузки заказов',
              style: theme.textTheme.headlineSmall?.copyWith(
                fontFamily: 'G',
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: theme.colorScheme.error.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: theme.colorScheme.error.withOpacity(0.2),
                ),
              ),
              child: Text(
                error,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.error,
                  fontFamily: 'G',
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () {
                // Здесь можно добавить логику повторной загрузки
              },
              icon: const Icon(Icons.refresh),
              label: const Text('Попробовать снова'),
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.colorScheme.primary,
                foregroundColor: theme.colorScheme.onPrimary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderCard(OrderModel order, ThemeData theme, int index) {
    return Container(
          margin: const EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: theme.colorScheme.shadow.withOpacity(0.08),
                blurRadius: 20,
                offset: const Offset(0, 4),
              ),
              BoxShadow(
                color: theme.colorScheme.shadow.withOpacity(0.04),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Заголовок заказа
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      theme.colorScheme.primary.withOpacity(0.05),
                      theme.colorScheme.primary.withOpacity(0.02),
                    ],
                  ),
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(20),
                  ),
                ),
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
                            color: theme.colorScheme.primary,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            Icon(
                              Icons.access_time,
                              size: 14,
                              color: theme.colorScheme.outline,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              _formatDateTime(order.createdAt),
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: theme.colorScheme.outline,
                                fontFamily: 'G',
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    _buildStatusChip(order.status, theme),
                  ],
                ),
              ),

              // Детали заказа
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Сумма и способ получения
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Сумма',
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: theme.colorScheme.outline,
                                  fontFamily: 'G',
                                ),
                              ),
                              const SizedBox(height: 4),
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
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Получение',
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: theme.colorScheme.outline,
                                  fontFamily: 'G',
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                order.orderType == 'pickup'
                                    ? 'Самовывоз'
                                    : 'Доставка',
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  fontFamily: 'G',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    if (order.notes != null) ...[
                      const SizedBox(height: 16),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.surfaceVariant.withOpacity(
                            0.3,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Комментарий',
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: theme.colorScheme.outline,
                                fontFamily: 'G',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              order.notes!,
                              style: theme.textTheme.bodyMedium?.copyWith(
                                fontFamily: 'G',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],

                    if (order.loyaltyPointsEarned > 0) ...[
                      const SizedBox(height: 12),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.amber.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Colors.amber.withOpacity(0.3),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.stars,
                              size: 16,
                              color: Colors.amber[700],
                            ),
                            const SizedBox(width: 6),
                            Text(
                              '+${order.loyaltyPointsEarned} баллов',
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: Colors.amber[700],
                                fontWeight: FontWeight.w600,
                                fontFamily: 'G',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              ),

              // Кнопки действий
              Container(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    if (order.status == 'pending' ||
                        order.status == 'preparing') ...[
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () => _cancelOrder(order.id),
                          icon: const Icon(Icons.cancel_outlined, size: 18),
                          label: const Text('Отменить'),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: theme.colorScheme.error,
                            side: BorderSide(
                              color: theme.colorScheme.error.withOpacity(0.3),
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                    ],
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () => _showOrderDetails(order),
                        icon: const Icon(Icons.visibility, size: 18),
                        label: const Text('Подробнее'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: theme.colorScheme.primary,
                          foregroundColor: theme.colorScheme.onPrimary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          elevation: 3,
                          shadowColor: theme.colorScheme.primary.withOpacity(
                            0.2,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
        .animate(delay: (index * 100).ms)
        .slideX(duration: 400.ms, curve: Curves.easeOut);
  }

  Widget _buildStatusChip(String status, ThemeData theme) {
    Color color;
    String text;

    switch (status) {
      case 'pending':
        color = Colors.orange;
        text = 'Ожидает';
        break;
      case 'preparing':
        color = Colors.blue;
        text = 'Готовится';
        break;
      case 'ready':
        color = Colors.green;
        text = 'Готов';
        break;
      case 'completed':
        color = Colors.grey;
        text = 'Завершен';
        break;
      case 'cancelled':
        color = Colors.red;
        text = 'Отменен';
        break;
      default:
        color = Colors.grey;
        text = 'Неизвестно';
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
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 6),
          Text(
            text,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
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
                onPressed: () async {
                  Navigator.pop(context);
                  try {
                    // Здесь должна быть логика отмены заказа через OrderService
                    // Пока что просто показываем уведомление
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text('Заказ отменен'),
                        backgroundColor: Theme.of(context).colorScheme.primary,
                      ),
                    );
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Ошибка при отмене заказа: ${e.toString()}',
                        ),
                        backgroundColor: Theme.of(context).colorScheme.error,
                      ),
                    );
                  }
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
      builder: (context) => OrderDetailsModal(order: order),
    );
  }

  String _formatDateTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inMinutes < 1) {
      return 'Только что';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes} мин назад';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} ч назад';
    } else if (difference.inDays == 1) {
      return 'Вчера';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} дн назад';
    } else {
      return '${dateTime.day}.${dateTime.month}.${dateTime.year}';
    }
  }
}

class OrderDetailsModal extends StatelessWidget {
  final OrderModel order;

  const OrderDetailsModal({required this.order});

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
              color: theme.colorScheme.outline.withOpacity(0.3),
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
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.close),
                  style: IconButton.styleFrom(
                    backgroundColor: theme.colorScheme.outline.withOpacity(
                      0.05,
                    ),
                  ),
                ),
              ],
            ),
          ),

          Container(
            height: 8,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  theme.colorScheme.shadow.withOpacity(0.1),
                  theme.colorScheme.shadow.withOpacity(0.05),
                  Colors.transparent,
                ],
                stops: const [0.0, 0.5, 1.0],
              ),
            ),
          ),

          // Содержимое
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Статус заказа
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          theme.colorScheme.primary.withOpacity(0.1),
                          theme.colorScheme.primary.withOpacity(0.05),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: theme.colorScheme.primary.withOpacity(0.2),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Статус заказа',
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontFamily: 'G',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 8),
                        _buildStatusChipForDetails(order.status, theme),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Основная информация
                  Text(
                    'Информация о заказе',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontFamily: 'G',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),

                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surfaceVariant.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: theme.colorScheme.outline.withOpacity(0.05),
                      ),
                    ),
                    child: Column(
                      children: [
                        _buildDetailRow(
                          'Номер заказа',
                          '#${order.id.substring(0, 8)}',
                          theme: theme,
                        ),
                        _buildDetailRow(
                          'Дата создания',
                          _formatDateTime(order.createdAt),
                          theme: theme,
                        ),
                        _buildDetailRow(
                          'Способ получения',
                          order.orderType == 'pickup'
                              ? 'Самовывоз'
                              : 'Доставка',
                          theme: theme,
                        ),
                        _buildDetailRow(
                          'Сумма',
                          '₽${order.totalAmount.toInt()}',
                          theme: theme,
                          isTotal: true,
                        ),
                      ],
                    ),
                  ),

                  if (order.notes != null) ...[
                    const SizedBox(height: 24),
                    Text(
                      'Комментарий к заказу',
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontFamily: 'G',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.surfaceVariant.withOpacity(
                          0.3,
                        ),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        order.notes!,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontFamily: 'G',
                        ),
                      ),
                    ),
                  ],

                  if (order.items.isNotEmpty) ...[
                    const SizedBox(height: 24),
                    Text(
                      'Состав заказа',
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontFamily: 'G',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    ...order.items
                        .map(
                          (item) => Container(
                            margin: const EdgeInsets.only(bottom: 12),
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: theme.colorScheme.surfaceVariant
                                  .withOpacity(0.3),
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: theme.colorScheme.outline.withOpacity(
                                  0.1,
                                ),
                              ),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: theme.colorScheme.primary
                                        .withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Icon(
                                    Icons.local_cafe,
                                    color: theme.colorScheme.primary,
                                    size: 24,
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item.productName,
                                        style: theme.textTheme.titleMedium
                                            ?.copyWith(
                                              fontFamily: 'G',
                                              fontWeight: FontWeight.w600,
                                            ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        '${item.quantity} шт.',
                                        style: theme.textTheme.bodyMedium
                                            ?.copyWith(
                                              color: theme.colorScheme.outline,
                                              fontFamily: 'G',
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  '₽${(item.price * item.quantity).toInt()}',
                                  style: theme.textTheme.titleMedium?.copyWith(
                                    fontFamily: 'G',
                                    fontWeight: FontWeight.bold,
                                    color: theme.colorScheme.primary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                        .toList(),
                  ],

                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusChipForDetails(String status, ThemeData theme) {
    Color color;
    String text;
    IconData icon;

    switch (status) {
      case 'pending':
        color = Colors.orange;
        text = 'Ожидает подтверждения';
        icon = Icons.access_time;
        break;
      case 'preparing':
        color = Colors.blue;
        text = 'Готовится';
        icon = Icons.local_cafe;
        break;
      case 'ready':
        color = Colors.green;
        text = 'Готов к выдаче';
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
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 20, color: color),
          const SizedBox(width: 8),
          Text(
            text,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.w600,
              fontSize: 16,
              fontFamily: 'G',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(
    String label,
    String value, {
    required ThemeData theme,
    bool isTotal = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontFamily: 'G',
              fontSize: isTotal ? 16 : 14,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              fontFamily: 'G',
              fontSize: isTotal ? 16 : 14,
              color: isTotal ? theme.colorScheme.primary : null,
            ),
          ),
        ],
      ),
    );
  }

  String _formatDateTime(DateTime dateTime) {
    return '${dateTime.day}.${dateTime.month}.${dateTime.year} в ${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}';
  }
}
