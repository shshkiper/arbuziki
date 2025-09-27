import 'dart:async';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'order_service.dart';

class OrderSimulationService {
  static final Map<String, Timer> _activeTimers = {};
  static const int _preparationTime = 90; // 1.5 минуты в секундах

  // Запуск симуляции для нового заказа
  static void startOrderSimulation(String orderId) {
    // Отменяем предыдущий таймер, если он есть
    _activeTimers[orderId]?.cancel();

    // Создаем новый таймер
    _activeTimers[orderId] = Timer.periodic(
      const Duration(seconds: 30), // Обновляем каждые 30 секунд
      (timer) => _updateOrderStatus(orderId, timer),
    );

    print('🔄 Запущена симуляция для заказа $orderId');
  }

  // Обновление статуса заказа
  static Future<void> _updateOrderStatus(String orderId, Timer timer) async {
    try {
      // Получаем текущий заказ
      final response =
          await Supabase.instance.client
              .from('orders')
              .select('status, created_at')
              .eq('id', orderId)
              .single();

      final currentStatus = response['status'] as String;
      final createdAt = DateTime.parse(response['created_at'] as String);
      final timeElapsed = DateTime.now().difference(createdAt).inSeconds;

      String newStatus;

      // Логика изменения статуса
      if (currentStatus == 'pending' && timeElapsed >= 30) {
        newStatus = 'preparing';
      } else if (currentStatus == 'preparing' &&
          timeElapsed >= _preparationTime) {
        newStatus = 'ready';
        // Завершаем таймер, когда заказ готов
        timer.cancel();
        _activeTimers.remove(orderId);
      } else {
        // Статус не изменился
        return;
      }

      // Обновляем статус в БД
      await OrderService.updateOrderStatus(orderId, newStatus);

      print('📦 Статус заказа $orderId изменен на: $newStatus');
    } catch (e) {
      print('❌ Ошибка обновления статуса заказа $orderId: $e');
      // Отменяем таймер при ошибке
      timer.cancel();
      _activeTimers.remove(orderId);
    }
  }

  // Отмена симуляции для заказа
  static void cancelOrderSimulation(String orderId) {
    _activeTimers[orderId]?.cancel();
    _activeTimers.remove(orderId);
    print('⏹️ Симуляция для заказа $orderId отменена');
  }

  // Отмена всех активных симуляций
  static void cancelAllSimulations() {
    for (final timer in _activeTimers.values) {
      timer.cancel();
    }
    _activeTimers.clear();
    print('⏹️ Все симуляции отменены');
  }

  // Получение оставшегося времени приготовления
  static int getRemainingTime(String orderId, DateTime createdAt) {
    final timeElapsed = DateTime.now().difference(createdAt).inSeconds;
    final remaining = _preparationTime - timeElapsed;
    return remaining > 0 ? remaining : 0;
  }

  // Получение статуса симуляции
  static bool isSimulationActive(String orderId) {
    return _activeTimers.containsKey(orderId);
  }
}
