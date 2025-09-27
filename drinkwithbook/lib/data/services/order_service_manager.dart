import 'order_service.dart';
import 'mock_order_service.dart';
import '../models/order_model.dart';

class OrderServiceManager {
  // Переключатель между реальным и мок-сервисом
  // Установите в true для использования мок-сервиса (без БД)
  static const bool useMockService = true;

  static Future<OrderModel> createOrder({
    required List<OrderItem> items,
    required double totalAmount,
    String? notes,
    String orderType = 'pickup',
    int loyaltyPointsUsed = 0,
  }) async {
    if (useMockService) {
      return await MockOrderService.createOrder(
        items: items,
        totalAmount: totalAmount,
        notes: notes,
        orderType: orderType,
        loyaltyPointsUsed: loyaltyPointsUsed,
      );
    } else {
      return await OrderService.createOrder(
        items: items,
        totalAmount: totalAmount,
        notes: notes,
        orderType: orderType,
        loyaltyPointsUsed: loyaltyPointsUsed,
      );
    }
  }

  static Future<List<OrderModel>> getUserOrders() async {
    if (useMockService) {
      return await MockOrderService.getUserOrders();
    } else {
      return await OrderService.getUserOrders();
    }
  }

  static Stream<List<OrderModel>> watchUserOrders() {
    if (useMockService) {
      return MockOrderService.watchUserOrders();
    } else {
      return OrderService.watchUserOrders();
    }
  }

  static Future<void> cancelOrder(String orderId) async {
    if (useMockService) {
      return await MockOrderService.cancelOrder(orderId);
    } else {
      return await OrderService.cancelOrder(orderId);
    }
  }

  static Future<void> updateOrderStatus(String orderId, String status) async {
    if (useMockService) {
      return await MockOrderService.updateOrderStatus(orderId, status);
    } else {
      return await OrderService.updateOrderStatus(orderId, status);
    }
  }
}
