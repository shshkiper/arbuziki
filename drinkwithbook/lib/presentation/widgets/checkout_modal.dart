import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../pages/home/home_page.dart';
import '../../data/providers/order_providers.dart';
import '../../data/models/order_model.dart';

class CheckoutModal extends ConsumerWidget {
  const CheckoutModal({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final cartItems = ref.watch(cartItemsProvider);

    if (cartItems.isEmpty) {
      return Container(
        height: MediaQuery.of(context).size.height * 0.7,
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
                    'Оформление заказа',
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
                        0.1,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Пустая корзина
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.shopping_cart_outlined,
                      size: 80,
                      color: theme.colorScheme.outline,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Корзина пуста',
                      style: theme.textTheme.headlineSmall?.copyWith(
                        fontFamily: 'G',
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Добавьте товары в корзину',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.outline,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
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
                  'Оформление заказа',
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

          // Содержимое
          Expanded(child: _CheckoutContent()),
        ],
      ),
    );
  }
}

class _CheckoutContent extends ConsumerStatefulWidget {
  @override
  ConsumerState<_CheckoutContent> createState() => _CheckoutContentState();
}

class _CheckoutContentState extends ConsumerState<_CheckoutContent> {
  String _orderType = 'pickup';
  String? _notes;
  final TextEditingController _notesController = TextEditingController();

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cartItems = ref.watch(cartItemsProvider);
    final checkoutState = ref.watch(checkoutStateProvider);

    if (cartItems.isEmpty) {
      return const SizedBox.shrink();
    }

    // Вычисляем общую сумму
    final total = cartItems.fold<double>(
      0.0,
      (sum, item) => sum + (item.price.toDouble() * item.quantity),
    );

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Ваш заказ
          Text(
            'Ваш заказ',
            style: theme.textTheme.titleLarge?.copyWith(
              fontFamily: 'G',
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),

          // Список товаров
          ...cartItems
              .map(
                (item) => Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surfaceVariant.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(
                          'assets/images/${item.image}',
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.name,
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontFamily: 'G',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '${item.quantity} шт.',
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: theme.colorScheme.outline,
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

          const SizedBox(height: 16),

          // Итого
          Container(
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Итого:',
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontFamily: 'G',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '₽${total.toInt()}',
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontFamily: 'G',
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.primary,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Способ получения
          Text(
            'Способ получения',
            style: theme.textTheme.titleLarge?.copyWith(
              fontFamily: 'G',
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),

          // Варианты получения
          Container(
            decoration: BoxDecoration(
              color: theme.colorScheme.surfaceVariant.withOpacity(0.3),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                RadioListTile<String>(
                  value: 'pickup',
                  groupValue: _orderType,
                  onChanged: (value) {
                    setState(() {
                      _orderType = value!;
                    });
                  },
                  title: const Text(
                    'Самовывоз',
                    style: TextStyle(fontFamily: 'G'),
                  ),
                  subtitle: const Text(
                    'Забрать в кафе',
                    style: TextStyle(fontFamily: 'G'),
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
                RadioListTile<String>(
                  value: 'delivery',
                  groupValue: _orderType,
                  onChanged: (value) {
                    setState(() {
                      _orderType = value!;
                    });
                  },
                  title: const Text(
                    'Доставка',
                    style: TextStyle(fontFamily: 'G'),
                  ),
                  subtitle: const Text(
                    'Доставим к вашему столику',
                    style: TextStyle(fontFamily: 'G'),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Комментарии к заказу
          Text(
            'Комментарии к заказу',
            style: theme.textTheme.titleLarge?.copyWith(
              fontFamily: 'G',
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),

          TextField(
            controller: _notesController,
            maxLines: 3,
            decoration: InputDecoration(
              hintText: 'Особые пожелания, аллергии, etc...',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(
                  color: theme.colorScheme.outline.withOpacity(0.3),
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(
                  color: theme.colorScheme.outline.withOpacity(0.3),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(
                  color: theme.colorScheme.primary,
                  width: 2,
                ),
              ),
              filled: true,
              fillColor: theme.colorScheme.surfaceVariant.withOpacity(0.3),
            ),
            onChanged: (value) {
              _notes = value.isEmpty ? null : value;
            },
          ),

          const SizedBox(height: 24),

          // Кнопка подтверждения
          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              onPressed: checkoutState.isLoading ? null : () => _placeOrder(),
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.colorScheme.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 6,
                shadowColor: theme.colorScheme.primary.withOpacity(0.2),
              ),
              child:
                  checkoutState.isLoading
                      ? const SizedBox(
                        height: 24,
                        width: 24,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.white,
                          ),
                        ),
                      )
                      : Text(
                        'Подтвердить заказ ₽${total.toInt()}',
                        style: theme.textTheme.titleLarge?.copyWith(
                          color: theme.colorScheme.onPrimary,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'G',
                        ),
                      ),
            ),
          ).animate().slideY(duration: 700.ms),

          if (checkoutState.error != null) ...[
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: theme.colorScheme.error.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: theme.colorScheme.error.withOpacity(0.2),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.error_outline,
                    color: theme.colorScheme.error,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      checkoutState.error!,
                      style: TextStyle(
                        color: theme.colorScheme.error,
                        fontFamily: 'G',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Future<void> _placeOrder() async {
    try {
      print('🛒 Начинаем оформление заказа...');

      final cartItems = ref.read(cartItemsProvider);
      final total = cartItems.fold<double>(
        0.0,
        (sum, item) => sum + (item.price.toDouble() * item.quantity),
      );

      // Создаем элементы заказа
      final orderItems =
          cartItems
              .map(
                (item) => OrderItem(
                  productId: item.id,
                  productName: item.name,
                  quantity: item.quantity,
                  price: item.price.toDouble(),
                ),
              )
              .toList();

      print('📦 Количество позиций: ${orderItems.length}');

      final checkoutNotifier = ref.read(checkoutStateProvider.notifier);
      final order = await checkoutNotifier.createOrder(
        items: orderItems,
        totalAmount: total,
        notes: _notes,
        orderType: _orderType,
      );

      if (order != null) {
        print('✅ Заказ создан успешно: ${order.id}');

        // Очищаем корзину
        ref.read(cartItemsProvider.notifier).state = [];
        print('🛒 Корзина очищена');

        // Закрываем окно оформления заказа
        if (mounted) {
          print('🔄 Заказ создан успешно');
          Navigator.of(context).pop();
        }
      } else {
        print('❌ Заказ не был создан');
      }
    } catch (e, stackTrace) {
      print('❌ Ошибка при оформлении заказа: $e');
      print('📚 Stack trace: $stackTrace');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Ошибка при создании заказа: ${e.toString()}'),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    }
  }
}
