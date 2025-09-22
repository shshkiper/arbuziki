import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ChatPage extends ConsumerStatefulWidget {
  const ChatPage({super.key});

  @override
  ConsumerState<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends ConsumerState<ChatPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Общение'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Общий чат'),
            Tab(text: 'Клубы'),
            Tab(text: 'Владельцы'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _GeneralChatTab(messageController: _messageController),
          const _ClubChatsTab(),
          const _OwnerChatTab(),
        ],
      ),
    );
  }
}

class _GeneralChatTab extends StatelessWidget {
  final TextEditingController messageController;

  const _GeneralChatTab({required this.messageController});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Column(
      children: [
        // Список сообщений
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: _generalMessages.length,
            itemBuilder: (context, index) {
              final message = _generalMessages[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: _MessageBubble(
                  message: message,
                  isOwn: (message['isOwn'] as bool?) ?? false,
                ),
              )
                  .animate(delay: Duration(milliseconds: index * 50))
                  .fadeIn(duration: const Duration(milliseconds: 300))
                  .slideX(
                    begin: (message['isOwn'] as bool?) == true ? 0.2 : -0.2,
                    duration: const Duration(milliseconds: 300),
                  );
            },
          ),
        ),
        
        // Поле ввода сообщения
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            border: Border(
              top: BorderSide(
                color: theme.colorScheme.outline.withOpacity(0.2),
              ),
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: messageController,
                  decoration: InputDecoration(
                    hintText: 'Написать сообщение...',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                  ),
                  maxLines: null,
                ),
              ),
              const SizedBox(width: 8),
              FloatingActionButton.small(
                onPressed: () => _sendMessage(context),
                child: const Icon(Icons.send),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _sendMessage(BuildContext context) {
    if (messageController.text.trim().isNotEmpty) {
      // TODO: Отправить сообщение
      messageController.clear();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Сообщение отправлено!'),
          duration: Duration(seconds: 1),
        ),
      );
    }
  }
}

class _ClubChatsTab extends StatelessWidget {
  const _ClubChatsTab();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _clubChats.length,
      itemBuilder: (context, index) {
        final chat = _clubChats[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: _ChatListItem(
            chat: chat,
            onTap: () => _openClubChat(context, chat),
          ),
        )
            .animate(delay: Duration(milliseconds: index * 100))
            .fadeIn(duration: const Duration(milliseconds: 400))
            .slideX(begin: -0.2, duration: const Duration(milliseconds: 400));
      },
    );
  }

  void _openClubChat(BuildContext context, Map<String, dynamic> chat) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => _ClubChatPage(chat: chat),
      ),
    );
  }
}

class _OwnerChatTab extends StatelessWidget {
  const _OwnerChatTab();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Информация о владельцах
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: theme.colorScheme.primary,
                        child: const Icon(
                          Icons.store,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Команда Drink with Book',
                              style: theme.textTheme.titleMedium,
                            ),
                            Text(
                              'Мы всегда готовы помочь',
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: theme.colorScheme.onSurface.withOpacity(0.7),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () => _startChat(context),
                          icon: const Icon(Icons.chat),
                          label: const Text('Написать'),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () => _callOwners(context),
                          icon: const Icon(Icons.phone),
                          label: const Text('Позвонить'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
              .animate()
              .fadeIn(duration: const Duration(milliseconds: 600))
              .slideY(begin: -0.2, duration: const Duration(milliseconds: 600)),

          const SizedBox(height: 24),

          // Часто задаваемые вопросы
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Частые вопросы',
                  style: theme.textTheme.titleLarge,
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: ListView.builder(
                    itemCount: _faqItems.length,
                    itemBuilder: (context, index) {
                      final faq = _faqItems[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: _FAQItem(faq: faq),
                      )
                          .animate(delay: Duration(milliseconds: index * 100))
                          .fadeIn(duration: const Duration(milliseconds: 400))
                          .slideX(begin: 0.2, duration: const Duration(milliseconds: 400));
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _startChat(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const _OwnerChatPage(),
      ),
    );
  }

  void _callOwners(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Звонок владельцам - в разработке'),
      ),
    );
  }
}

class _MessageBubble extends StatelessWidget {
  final Map<String, dynamic> message;
  final bool isOwn;

  const _MessageBubble({
    required this.message,
    required this.isOwn,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Align(
      alignment: isOwn ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        child: Column(
          crossAxisAlignment: isOwn ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            if (!isOwn)
              Padding(
                padding: const EdgeInsets.only(left: 8, bottom: 4),
                child: Text(
                  message['author'],
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: isOwn
                    ? theme.colorScheme.primary
                    : theme.colorScheme.surface,
                borderRadius: BorderRadius.circular(20),
                border: isOwn
                    ? null
                    : Border.all(
                        color: theme.colorScheme.outline.withOpacity(0.2),
                      ),
              ),
              child: Text(
                message['text'],
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: isOwn
                      ? theme.colorScheme.onPrimary
                      : theme.colorScheme.onSurface,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 4, left: 8, right: 8),
              child: Text(
                message['time'],
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurface.withOpacity(0.5),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ChatListItem extends StatelessWidget {
  final Map<String, dynamic> chat;
  final VoidCallback onTap;

  const _ChatListItem({
    required this.chat,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: theme.colorScheme.primary.withOpacity(0.1),
          child: Icon(
            _getClubIcon(chat['type']),
            color: theme.colorScheme.primary,
          ),
        ),
        title: Text(chat['name']),
        subtitle: Text(
          chat['lastMessage'],
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              chat['time'],
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurface.withOpacity(0.6),
              ),
            ),
            if (chat['unreadCount'] > 0) ...[
              const SizedBox(height: 4),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  chat['unreadCount'].toString(),
                  style: TextStyle(
                    color: theme.colorScheme.onPrimary,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ],
        ),
        onTap: onTap,
      ),
    );
  }

  IconData _getClubIcon(String type) {
    switch (type) {
      case 'coffee':
        return Icons.local_cafe;
      case 'tea':
        return Icons.emoji_food_beverage;
      case 'book':
        return Icons.menu_book;
      default:
        return Icons.group;
    }
  }
}

class _FAQItem extends StatelessWidget {
  final Map<String, dynamic> faq;

  const _FAQItem({required this.faq});

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(faq['question']),
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            faq['answer'],
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      ],
    );
  }
}

class _ClubChatPage extends StatelessWidget {
  final Map<String, dynamic> chat;

  const _ClubChatPage({required this.chat});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(chat['name']),
        actions: [
          IconButton(
            icon: const Icon(Icons.info),
            onPressed: () {},
          ),
        ],
      ),
      body: const Center(
        child: Text('Чат клуба - в разработке'),
      ),
    );
  }
}

class _OwnerChatPage extends StatelessWidget {
  const _OwnerChatPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Чат с владельцами'),
      ),
      body: const Center(
        child: Text('Чат с владельцами - в разработке'),
      ),
    );
  }
}

// Данные для примера
final _generalMessages = [
  {
    'author': 'Анна Смирнова',
    'text': 'Привет всем! Кто-нибудь пробовал новый сорт кофе из Эфиопии?',
    'time': '14:30',
    'isOwn': false,
  },
  {
    'author': 'Михаил Петров',
    'text': 'Да, очень интересный вкус! Фруктовые нотки прямо чувствуются',
    'time': '14:32',
    'isOwn': false,
  },
  {
    'author': 'Вы',
    'text': 'Обязательно попробую завтра!',
    'time': '14:35',
    'isOwn': true,
  },
  {
    'author': 'Елена Козлова',
    'text': 'А кто-нибудь читал "Кофе с молоком и временем"? Очень атмосферная книга для нашего кафе!',
    'time': '14:40',
    'isOwn': false,
  },
  {
    'author': 'Вы',
    'text': 'Спасибо за рекомендацию! Добавлю в список для чтения',
    'time': '14:42',
    'isOwn': true,
  },
];

final _clubChats = [
  {
    'name': 'Кофейные гурманы',
    'type': 'coffee',
    'lastMessage': 'Обсуждаем новый сорт арабики',
    'time': '14:30',
    'unreadCount': 3,
  },
  {
    'name': 'Книжный клуб',
    'type': 'book',
    'lastMessage': 'Кто уже прочитал главу 5?',
    'time': '13:15',
    'unreadCount': 0,
  },
  {
    'name': 'Чайная церемония',
    'type': 'tea',
    'lastMessage': 'Завтра мастер-класс по матча',
    'time': '12:45',
    'unreadCount': 1,
  },
];

final _faqItems = [
  {
    'question': 'Как заказать кофе через приложение?',
    'answer': 'Перейдите во вкладку "Меню", выберите напиток, добавьте в корзину и оформите заказ. Вы получите уведомление, когда заказ будет готов.',
  },
  {
    'question': 'Как накопить баллы лояльности?',
    'answer': 'Баллы начисляются автоматически за каждую покупку (1 балл за каждые 10 рублей) и за участие в мероприятиях клубов.',
  },
  {
    'question': 'Можно ли отменить заказ?',
    'answer': 'Заказ можно отменить в течение 5 минут после оформления. После начала приготовления отмена невозможна.',
  },
  {
    'question': 'Как присоединиться к клубу?',
    'answer': 'Перейдите во вкладку "Клубы", выберите интересующий клуб и нажмите "Присоединиться". Участие в большинстве клубов бесплатное.',
  },
  {
    'question': 'Работает ли программа лояльности для книг?',
    'answer': 'Да, при покупке книг также начисляются баллы лояльности, а участники клубов получают дополнительные скидки.',
  },
];
