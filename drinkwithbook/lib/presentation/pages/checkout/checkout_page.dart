import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../../../data/models/order_model.dart';
import '../../../data/providers/order_providers.dart';
import '../home/home_page.dart'; // Для CartItem
import 'dart:ui';

class CheckoutPage extends ConsumerStatefulWidget {
  const CheckoutPage({super.key});

  @override
  ConsumerState<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends ConsumerState<CheckoutPage> {
  final _notesController = TextEditingController();
  String _orderType = 'pickup';

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
      return Scaffold(
        appBar: AppBar(
          title: const Text('Оформление заказа'),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.shopping_cart_outlined,
                size: 64,
                color: theme.colorScheme.outline,
              ),
              const SizedBox(height: 16),
              Text('Корзина пуста', style: theme.textTheme.headlineSmall),
              const SizedBox(height: 8),
              Text(
                'Добавьте товары в корзину для оформления заказа',
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
        ),
      );
    }

    final total = cartItems.fold<double>(
      0.0,
      (sum, item) => sum + (item.price.toDouble() * item.quantity),
    );

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
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Заголовок
            Text(
              'Оформление заказа',
              style: theme.textTheme.headlineMedium?.copyWith(
                fontFamily: 'G',
                fontWeight: FontWeight.bold,
              ),
            ).animate().fadeIn(duration: 300.ms),

            const SizedBox(height: 24),

            // Список товаров
            Container(
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
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      'Ваш заказ',
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontFamily: 'G',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  ...cartItems.map((item) => _buildOrderItem(item, theme)),
                  const Divider(height: 1),
                  Padding(
                    padding: const EdgeInsets.all(16),
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
                          '₽${total.round()}',
                          style: theme.textTheme.titleLarge?.copyWith(
                            fontFamily: 'G',
                            fontWeight: FontWeight.bold,
                            color: theme.colorScheme.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ).animate().slideY(duration: 400.ms),

            const SizedBox(height: 24),

            // Тип заказа
            Container(
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
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      'Способ получения',
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontFamily: 'G',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  RadioListTile<String>(
                    title: const Text('Самовывоз'),
                    subtitle: const Text('Забрать в кафе'),
                    value: 'pickup',
                    groupValue: _orderType,
                    onChanged: (value) => setState(() => _orderType = value!),
                  ),
                  RadioListTile<String>(
                    title: const Text('Доставка'),
                    subtitle: const Text('Доставим к вашему столику'),
                    value: 'delivery',
                    groupValue: _orderType,
                    onChanged: (value) => setState(() => _orderType = value!),
                  ),
                ],
              ),
            ).animate().slideY(duration: 500.ms),

            const SizedBox(height: 24),

            // Комментарии к заказу
            Container(
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
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Комментарии к заказу',
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontFamily: 'G',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: _notesController,
                      maxLines: 3,
                      decoration: InputDecoration(
                        hintText: 'Особые пожелания, аллергии, etc...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ).animate().slideY(duration: 600.ms),

            const SizedBox(height: 32),

            // Кнопка оформления заказа
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: checkoutState.isLoading ? null : _placeOrder,
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.colorScheme.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child:
                    checkoutState.isLoading
                        ? const SizedBox(
                          height: 24,
                          width: 24,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                        : Text(
                          'Подтвердить заказ ₽${total.round()}',
                          style: theme.textTheme.titleLarge?.copyWith(
                            color: Colors.white,
                            fontFamily: 'G',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
              ),
            ).animate().slideY(duration: 700.ms),

            if (checkoutState.error != null) ...[
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: theme.colorScheme.errorContainer,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Icon(Icons.error_outline, color: theme.colorScheme.error),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        checkoutState.error!,
                        style: TextStyle(color: theme.colorScheme.error),
                      ),
                    ),
                  ],
                ),
              ),
            ],

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderItem(CartItem item, ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              'assets/images/${item.image}',
              width: 50,
              height: 50,
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
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  '${item.quantity} шт.',
                  style: theme.textTheme.bodySmall?.copyWith(
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
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _placeOrder() async {
    try {
      print('🛒 Начинаем оформление заказа...');

      final cartItems = ref.read(cartItemsProvider);
      if (cartItems.isEmpty) {
        print('❌ Корзина пуста');
        return;
      }

      final total = cartItems.fold<double>(
        0.0,
        (sum, item) => sum + (item.price.toDouble() * item.quantity),
      );

      print('💰 Сумма заказа: $total');

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
        notes:
            _notesController.text.trim().isEmpty
                ? null
                : _notesController.text.trim(),
        orderType: _orderType,
      );

      if (order != null) {
        print('✅ Заказ успешно создан: ${order.id}');

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
