import 'dart:math';
import '../models/order_model.dart';

class MockOrderService {
  static final List<OrderModel> _orders = [];
  static final Random _random = Random();

  // Создание заказа (мок-версия)
  static Future<OrderModel> createOrder({
    required List<OrderItem> items,
    required double totalAmount,
    String? notes,
    String orderType = 'pickup',
    int loyaltyPointsUsed = 0,
  }) async {
    // Имитируем задержку сети
    await Future.delayed(const Duration(milliseconds: 500));

    print('🛒 [MOCK] Начинаем создание заказа...');
    print('👤 [MOCK] Пользователь авторизован');
    print('📝 [MOCK] Создаем заказ в БД...');

    // Генерируем случайный ID
    final orderId = 'mock_${_random.nextInt(999999)}';
    print('✅ [MOCK] Заказ создан с ID: $orderId');

    // Создаем заказ
    final order = OrderModel(
      id: orderId,
      userId: 'mock_user_id',
      items: items,
      totalAmount: totalAmount,
      status: 'pending',
      createdAt: DateTime.now(),
      notes: notes,
      orderType: orderType,
      estimatedTime: 90,
      loyaltyPointsUsed: loyaltyPointsUsed,
      loyaltyPointsEarned: (totalAmount / 10).round(),
    );

    // Сохраняем в памяти
    _orders.insert(0, order);

    print('📦 [MOCK] Позиции заказа созданы');
    print('⏰ [MOCK] Симуляция статуса запущена');

    // Запускаем симуляцию статуса
    _startMockSimulation(orderId);

    return order;
  }

  // Получение заказов пользователя
  static Future<List<OrderModel>> getUserOrders() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return List.from(_orders);
  }

  // Стрим заказов
  static Stream<List<OrderModel>> watchUserOrders() async* {
    while (true) {
      yield List.from(_orders);
      await Future.delayed(const Duration(seconds: 2));
    }
  }

  // Симуляция изменения статуса
  static void _startMockSimulation(String orderId) {
    Future.delayed(const Duration(seconds: 30), () {
      _updateOrderStatus(orderId, 'preparing');
    });

    Future.delayed(const Duration(seconds: 90), () {
      _updateOrderStatus(orderId, 'ready');
    });
  }

  static void _updateOrderStatus(String orderId, String newStatus) {
    final orderIndex = _orders.indexWhere((order) => order.id == orderId);
    if (orderIndex != -1) {
      final order = _orders[orderIndex];
      final updatedOrder = order.copyWith(
        status: newStatus,
        readyAt: newStatus == 'ready' ? DateTime.now() : order.readyAt,
        completedAt:
            newStatus == 'completed' ? DateTime.now() : order.completedAt,
      );
      _orders[orderIndex] = updatedOrder;
      print('📦 [MOCK] Статус заказа $orderId изменен на: $newStatus');
    }
  }

  // Отмена заказа
  static Future<void> cancelOrder(String orderId) async {
    _updateOrderStatus(orderId, 'cancelled');
  }

  // Обновление статуса заказа
  static Future<void> updateOrderStatus(String orderId, String status) async {
    _updateOrderStatus(orderId, status);
  }

  // Очистка всех заказов (для тестирования)
  static void clearAllOrders() {
    _orders.clear();
  }
}
