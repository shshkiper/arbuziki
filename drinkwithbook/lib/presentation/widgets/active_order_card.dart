import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../data/providers/order_providers.dart';
import '../../data/models/order_model.dart';
import 'orders_modal.dart';

class ActiveOrderCard extends ConsumerWidget {
  const ActiveOrderCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    return Consumer(
      builder: (context, ref, child) {
        final ordersAsync = ref.watch(userOrdersStreamProvider);

        return ordersAsync.when(
          data: (orders) {
            // Находим активный заказ (pending, preparing, ready)
            final activeOrder =
                orders
                    .where(
                      (order) =>
                          order.status == 'pending' ||
                          order.status == 'preparing' ||
                          order.status == 'ready',
                    )
                    .firstOrNull;

            if (activeOrder == null) return const SizedBox.shrink();

            return _buildActiveOrderCard(context, activeOrder, theme);
          },
          loading: () => const SizedBox.shrink(),
          error: (error, stack) => const SizedBox.shrink(),
        );
      },
    );
  }

  Widget _buildActiveOrderCard(
    BuildContext context,
    OrderModel order,
    ThemeData theme,
  ) {
    return InkWell(
          onTap: () => _showOrderDetails(context, order),
          borderRadius: BorderRadius.circular(16),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
              boxShadow: [
                BoxShadow(
                  color: theme.colorScheme.primary.withOpacity(0.08),
                  blurRadius: 15,
                  offset: const Offset(0, 3),
                ),
                BoxShadow(
                  color: theme.colorScheme.primary.withOpacity(0.04),
                  blurRadius: 6,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      Icons.shopping_bag,
                      color: theme.colorScheme.onPrimary,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Активный заказ #${order.id.substring(0, 8)}',
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontFamily: 'G',
                            fontWeight: FontWeight.bold,
                            color: theme.colorScheme.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  _buildStatusChip(order.status, theme),
                  const SizedBox(width: 8),
                  Icon(
                    Icons.chevron_right,
                    color: theme.colorScheme.outline,
                    size: 20,
                  ),
                ],
              ),
            ),
          ),
        )
        .animate()
        .slideY(duration: 400.ms, curve: Curves.easeOut)
        .fadeIn(duration: 300.ms);
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
        icon = Icons.local_cafe;
        break;
      case 'ready':
        color = Colors.green;
        text = 'Готов';
        icon = Icons.check_circle;
        break;
      default:
        color = Colors.grey;
        text = 'Неизвестно';
        icon = Icons.help;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 4),
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

  void _showOrderDetails(BuildContext context, OrderModel order) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      isDismissible: true,
      enableDrag: true,
      builder: (context) => OrderDetailsModal(order: order),
    );
  }
}
