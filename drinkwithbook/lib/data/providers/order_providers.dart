import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/order_model.dart';
import '../services/order_service_manager.dart';

// Провайдер для списка заказов пользователя
final userOrdersProvider = FutureProvider<List<OrderModel>>((ref) async {
  return await OrderServiceManager.getUserOrders();
});

// Провайдер для стрима заказов в реальном времени
final userOrdersStreamProvider = StreamProvider<List<OrderModel>>((ref) {
  return OrderServiceManager.watchUserOrders();
});

// Провайдер для текущего заказа (во время оформления)
final currentOrderProvider = StateProvider<OrderModel?>((ref) => null);

// Провайдер для состояния оформления заказа
final checkoutStateProvider =
    StateNotifierProvider<CheckoutStateNotifier, CheckoutState>((ref) {
      return CheckoutStateNotifier();
    });

class CheckoutState {
  final bool isLoading;
  final String? error;
  final OrderModel? createdOrder;

  CheckoutState({this.isLoading = false, this.error, this.createdOrder});

  CheckoutState copyWith({
    bool? isLoading,
    String? error,
    OrderModel? createdOrder,
  }) {
    return CheckoutState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      createdOrder: createdOrder ?? this.createdOrder,
    );
  }
}

class CheckoutStateNotifier extends StateNotifier<CheckoutState> {
  CheckoutStateNotifier() : super(CheckoutState());

  Future<OrderModel?> createOrder({
    required List<OrderItem> items,
    required double totalAmount,
    String? notes,
    String orderType = 'pickup',
    int loyaltyPointsUsed = 0,
  }) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final order = await OrderServiceManager.createOrder(
        items: items,
        totalAmount: totalAmount,
        notes: notes,
        orderType: orderType,
        loyaltyPointsUsed: loyaltyPointsUsed,
      );

      state = state.copyWith(isLoading: false, createdOrder: order);

      return order;
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
      return null;
    }
  }

  void clearError() {
    state = state.copyWith(error: null);
  }

  void reset() {
    state = CheckoutState();
  }
}
