import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'dart:ui';

class NotificationsModal extends StatelessWidget {
  const NotificationsModal({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      decoration: BoxDecoration(
        color: theme.colorScheme.background,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Column(
        children: [
          // Drag handle
          Center(
            child: Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: theme.colorScheme.outline.withOpacity(0.3),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          
          // Header with glass effect
          ClipRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 0.0, sigmaY: 25.0),
              child: Container(
                padding: EdgeInsets.only(top:12, bottom:6, left: 22, right: 20),
                /* const EdgeInsets.symmetric(horizontal: 20, vertical: 16),*/
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
                ),
                child: Row(
                  children: [
                    Text(
                      'Уведомления',
                      style: theme.textTheme.headlineSmall?.copyWith(
                        fontFamily: 'G',
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                    const Spacer(),
                    Container(
                      child: 
                      IconButton(
                    padding: EdgeInsets.only(bottom: 0,left:0),
                    onPressed: () => Navigator.of(context).pop(),
                    icon: Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.close_rounded,
                        color: Colors.grey[600],
                        size: 20,
                      ),
                    ),
                  ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          
          // Notifications list
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.only(top: 0, left: 16, right: 16, bottom: 16),
              itemCount: _notifications.length,
              itemBuilder: (context, index) {
                final notification = _notifications[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: _NotificationCard(
                    notification: notification,
                    onTap: () => _handleNotificationTap(context, notification),
                  ),
                )
                    .animate(delay: Duration(milliseconds: index * 100))
                    .fadeIn(duration: const Duration(milliseconds: 300))
                    .slideX(begin: 0.2, duration: const Duration(milliseconds: 300));
              },
            ),
          ),
        ],
      ),
    );
  }

  void _handleNotificationTap(BuildContext context, Map<String, dynamic> notification) {
    // TODO: Handle notification tap
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Открыто: ${notification['title']}'),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}

class _NotificationCard extends StatelessWidget {
  final Map<String, dynamic> notification;
  final VoidCallback onTap;

  const _NotificationCard({
    required this.notification,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isUnread = notification['isUnread'] as bool;
    
    return Card(
      elevation: isUnread ? 4 : 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),

            gradient: isUnread 
                ? LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      theme.colorScheme.primary.withOpacity(0.05),
                      Colors.transparent,
                    ],
                  )
                : null,
          ),
          child: Row(
            children: [
              // Icon with enhanced styling
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      _getNotificationColor(notification['type']).withOpacity(0.15),
                      _getNotificationColor(notification['type']).withOpacity(0.05),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: _getNotificationColor(notification['type']).withOpacity(0.2),
                    width: 1,
                  ),
                ),
                child: Icon(
                  _getNotificationIcon(notification['type']),
                  color: _getNotificationColor(notification['type']),
                  size: 26,
                ),
              ),
              
              const SizedBox(width: 16),
              
              // Content with enhanced styling
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            notification['title'],
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontFamily: 'G',
                              fontSize: 17,
                              fontWeight: isUnread ? FontWeight.w700 : FontWeight.w600,
                              color: isUnread ? theme.colorScheme.onSurface : theme.colorScheme.onSurface.withOpacity(0.8),
                              height: 1.2,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (isUnread)
                          Container(
                            width: 10,
                            height: 10,
                            decoration: BoxDecoration(
                              color: theme.colorScheme.primary,
                              borderRadius: BorderRadius.circular(13),
                              boxShadow: [
                                BoxShadow(
                                  color: theme.colorScheme.primary.withOpacity(0.3),
                                  blurRadius: 4,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      notification['message'],
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontFamily: 'G',
                        fontSize: 15,
                        color: theme.colorScheme.onSurface.withOpacity(0.7),
                        height: 1.4,
                        fontWeight: FontWeight.w400,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Icon(
                          Icons.access_time,
                          size: 16,
                          color: theme.colorScheme.onSurface.withOpacity(0.5),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          notification['time'],
                          style: theme.textTheme.bodySmall?.copyWith(
                            fontFamily: 'G',
                            fontSize: 13,
                            color: theme.colorScheme.onSurface.withOpacity(0.6),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const Spacer(),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  IconData _getNotificationIcon(String type) {
    switch (type) {
      case 'order':
        return Icons.shopping_bag;
      case 'club':
        return Icons.groups;
      case 'loyalty':
        return Icons.card_giftcard;
      case 'promotion':
        return Icons.local_offer;
      default:
        return Icons.notifications;
    }
  }

  Color _getNotificationColor(String type) {
    switch (type) {
      case 'order':
        return Colors.blue;
      case 'club':
        return Colors.green;
      case 'loyalty':
        return Colors.orange;
      case 'promotion':
        return Colors.purple;
      default:
        return Colors.grey;
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Готов':
        return Colors.green;
      case 'Готовится':
        return Colors.orange;
      case 'Отменен':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}

// Данные для примера
final _notifications = [
  {
    'id': '1',
    'type': 'order',
    'title': 'Ваш заказ готов!',
    'message': 'Капучино и круассан готовы к получению. Заказ №12345',
    'time': '5 минут назад',
    'isUnread': true,
    'status': 'Готов',
  },
  {
    'id': '2',
    'type': 'club',
    'title': 'Новое мероприятие в клубе',
    'message': 'Кофейный клуб приглашает на дегустацию новых сортов кофе завтра в 18:00',
    'time': '1 час назад',
    'isUnread': true,
    'status': null,
  },
  {
    'id': '3',
    'type': 'loyalty',
    'title': 'Новые баллы начислены!',
    'message': 'За покупку на 250₽ вы получили 25 баллов лояльности',
    'time': '2 часа назад',
    'isUnread': false,
    'status': null,
  },
  {
    'id': '4',
    'type': 'promotion',
    'title': 'Специальное предложение',
    'message': 'Скидка 20% на все десерты до конца недели!',
    'time': '1 день назад',
    'isUnread': false,
    'status': null,
  },
  {
    'id': '5',
    'type': 'order',
    'title': 'Заказ отменен',
    'message': 'Ваш заказ №12340 был отменен. Средства вернутся в течение 24 часов',
    'time': '2 дня назад',
    'isUnread': false,
    'status': 'Отменен',
  },
];
