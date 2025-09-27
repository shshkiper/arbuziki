import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/order_model.dart';
import 'order_simulation_service.dart';

class OrderService {
  static final SupabaseClient _supabase = Supabase.instance.client;

  static DateTime _parseDateTime(String? dateString) {
    if (dateString == null || dateString.isEmpty) {
      return DateTime.now();
    }
    try {
      return DateTime.parse(dateString);
    } catch (e) {
      print('⚠️ Ошибка парсинга даты: $dateString, используем текущую дату');
      return DateTime.now();
    }
  }

  // Создание заказа
  static Future<OrderModel> createOrder({
    required List<OrderItem> items,
    required double totalAmount,
    String? notes,
    String orderType = 'pickup',
    int loyaltyPointsUsed = 0,
  }) async {
    try {
      print('🛒 Начинаем создание заказа...');

      final user = _supabase.auth.currentUser;
      if (user == null) {
        print('❌ Пользователь не авторизован');
        throw Exception('Пользователь не авторизован');
      }

      print('👤 Пользователь: ${user.email}');

      // Создаем заказ в БД
      print('📝 Создаем заказ в БД...');
      final orderResponse =
          await _supabase
              .from('orders')
              .insert({
                'user_id': user.id,
                'total_amount': totalAmount,
                'status': 'pending',
                'order_type': orderType,
                'notes': notes,
                'loyalty_points_used': loyaltyPointsUsed,
                'loyalty_points_earned': (totalAmount / 10).round(),
                'estimated_time': 90,
              })
              .select()
              .single();

      final orderId = orderResponse['id'] as String;
      print('✅ Заказ создан с ID: $orderId');

      // Создаем позиции заказа
      print('📦 Создаем позиции заказа...');
      for (final item in items) {
        await _supabase.from('order_items').insert({
          'order_id': orderId,
          'product_id': item.productId,
          'product_name': item.productName,
          'quantity': item.quantity,
          'price': item.price,
          'customizations': item.customizations,
          'notes': item.notes,
        });
      }
      print('✅ Позиции заказа созданы');

      // Запускаем симуляцию статуса заказа
      OrderSimulationService.startOrderSimulation(orderId);
      print('⏰ Симуляция статуса запущена');

      // Возвращаем созданный заказ
      return OrderModel(
        id: orderId,
        userId: user.id,
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
    } catch (e, stackTrace) {
      print('❌ Ошибка создания заказа: $e');
      print('📚 Stack trace: $stackTrace');
      rethrow;
    }
  }

  // Получение заказов пользователя
  static Future<List<OrderModel>> getUserOrders() async {
    final user = _supabase.auth.currentUser;
    if (user == null) throw Exception('Пользователь не авторизован');

    final response = await _supabase
        .from('orders')
        .select('''
          *,
          order_items(*)
        ''')
        .eq('user_id', user.id)
        .order('created_at', ascending: false);

    return response.map<OrderModel>((orderData) {
      final items =
          (orderData['order_items'] as List).map((itemData) {
            return OrderItem(
              productId: itemData['product_id'] as String,
              productName: itemData['product_name'] as String,
              quantity: itemData['quantity'] as int,
              price: (itemData['price'] as num?)?.toDouble() ?? 0.0,
              customizations:
                  itemData['customizations'] as Map<String, dynamic>?,
              notes: itemData['notes'] as String?,
            );
          }).toList();

      return OrderModel(
        id: orderData['id'] as String,
        userId: orderData['user_id'] as String,
        items: items,
        totalAmount: (orderData['total_amount'] as num?)?.toDouble() ?? 0.0,
        status: orderData['status'] as String,
        createdAt: _parseDateTime(orderData['created_at'] as String?),
        readyAt:
            orderData['ready_at'] != null
                ? _parseDateTime(orderData['ready_at'] as String)
                : null,
        completedAt:
            orderData['completed_at'] != null
                ? _parseDateTime(orderData['completed_at'] as String)
                : null,
        notes: orderData['notes'] as String?,
        orderType: orderData['order_type'] as String,
        estimatedTime: orderData['estimated_time'] as int?,
        loyaltyPointsEarned: orderData['loyalty_points_earned'] as int? ?? 0,
        loyaltyPointsUsed: orderData['loyalty_points_used'] as int? ?? 0,
      );
    }).toList();
  }

  // Обновление статуса заказа (для админов)
  static Future<void> updateOrderStatus(String orderId, String status) async {
    await _supabase
        .from('orders')
        .update({
          'status': status,
          if (status == 'ready') 'ready_at': DateTime.now().toIso8601String(),
          if (status == 'completed')
            'completed_at': DateTime.now().toIso8601String(),
        })
        .eq('id', orderId);
  }

  // Отмена заказа
  static Future<void> cancelOrder(String orderId) async {
    await _supabase
        .from('orders')
        .update({'status': 'cancelled'})
        .eq('id', orderId);
  }

  // Подписка на изменения заказов в реальном времени
  static Stream<List<OrderModel>> watchUserOrders() {
    final user = _supabase.auth.currentUser;
    if (user == null) throw Exception('Пользователь не авторизован');

    return _supabase
        .from('orders')
        .stream(primaryKey: ['id'])
        .eq('user_id', user.id)
        .order('created_at', ascending: false)
        .map(
          (data) =>
              data.map<OrderModel>((orderData) {
                // Здесь упрощенная версия для стрима
                return OrderModel(
                  id: orderData['id'] as String,
                  userId: orderData['user_id'] as String,
                  items:
                      [], // В стриме не загружаем items для производительности
                  totalAmount:
                      (orderData['total_amount'] as num?)?.toDouble() ?? 0.0,
                  status: orderData['status'] as String,
                  createdAt: _parseDateTime(orderData['created_at'] as String?),
                  readyAt:
                      orderData['ready_at'] != null
                          ? _parseDateTime(orderData['ready_at'] as String)
                          : null,
                  completedAt:
                      orderData['completed_at'] != null
                          ? _parseDateTime(orderData['completed_at'] as String)
                          : null,
                  notes: orderData['notes'] as String?,
                  orderType: orderData['order_type'] as String,
                  estimatedTime: orderData['estimated_time'] as int?,
                  loyaltyPointsEarned:
                      orderData['loyalty_points_earned'] as int? ?? 0,
                  loyaltyPointsUsed:
                      orderData['loyalty_points_used'] as int? ?? 0,
                );
              }).toList(),
        );
  }
}
