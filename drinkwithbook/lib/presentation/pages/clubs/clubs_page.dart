import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ClubsPage extends ConsumerStatefulWidget {
  const ClubsPage({super.key});

  @override
  ConsumerState<ClubsPage> createState() => _ClubsPageState();
}

class _ClubsPageState extends ConsumerState<ClubsPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SizedBox(
          height: 40,
          child: Image.asset(
            'assets/images/logo.png',
            fit: BoxFit.contain,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _showCreateClubDialog(context),
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Мои клубы'),
            Tab(text: 'Все клубы'),
            Tab(text: 'События'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          _MyClubsTab(),
          _AllClubsTab(),
          _EventsTab(),
        ],
      ),
    );
  }

  void _showCreateClubDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => const _CreateClubDialog(),
    );
  }
}

class _MyClubsTab extends StatelessWidget {
  const _MyClubsTab();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _myClubs.length,
      itemBuilder: (context, index) {
        final club = _myClubs[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: _ClubCard(
            club: club,
            isMember: true,
            onTap: () => _showClubDetails(context, club),
          ),
        )
            .animate(delay: Duration(milliseconds: index * 100))
            .fadeIn(duration: const Duration(milliseconds: 400))
            .slideX(begin: -0.2, duration: const Duration(milliseconds: 400));
      },
    );
  }

  void _showClubDetails(BuildContext context, Map<String, dynamic> club) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => _ClubDetailsPage(club: club),
      ),
    );
  }
}

class _AllClubsTab extends StatelessWidget {
  const _AllClubsTab();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _allClubs.length,
      itemBuilder: (context, index) {
        final club = _allClubs[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: _ClubCard(
            club: club,
            isMember: _myClubs.any((myClub) => myClub['id'] == club['id']),
            onTap: () => _showClubDetails(context, club),
          ),
        )
            .animate(delay: Duration(milliseconds: index * 100))
            .fadeIn(duration: const Duration(milliseconds: 400))
            .slideX(begin: 0.2, duration: const Duration(milliseconds: 400));
      },
    );
  }

  void _showClubDetails(BuildContext context, Map<String, dynamic> club) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => _ClubDetailsPage(club: club),
      ),
    );
  }
}

class _EventsTab extends StatelessWidget {
  const _EventsTab();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _upcomingEvents.length,
      itemBuilder: (context, index) {
        final event = _upcomingEvents[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: _EventCard(event: event),
        )
            .animate(delay: Duration(milliseconds: index * 100))
            .fadeIn(duration: const Duration(milliseconds: 400))
            .slideY(begin: 0.2, duration: const Duration(milliseconds: 400));
      },
    );
  }
}

class _ClubCard extends StatelessWidget {
  final Map<String, dynamic> club;
  final bool isMember;
  final VoidCallback onTap;

  const _ClubCard({
    required this.club,
    required this.isMember,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Изображение клуба
            Container(
              height: 120,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: _getClubColors(club['type']),
                ),
              ),
              child: Center(
                child: Icon(
                  _getClubIcon(club['type']),
                  size: 48,
                  color: Colors.white,
                ),
              ),
            ),
            
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          club['name'],
                          style: theme.textTheme.titleLarge,
                        ),
                      ),
                      if (isMember)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.primary.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            'Участник',
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.colorScheme.primary,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    club['description'],
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurface.withOpacity(0.7),
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Icon(
                        Icons.people,
                        size: 16,
                        color: theme.colorScheme.onSurface.withOpacity(0.6),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${club['members']} участников',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurface.withOpacity(0.6),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Icon(
                        Icons.event,
                        size: 16,
                        color: theme.colorScheme.onSurface.withOpacity(0.6),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${club['events']} событий',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurface.withOpacity(0.6),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Color> _getClubColors(String type) {
    switch (type) {
      case 'coffee':
        return [const Color(0xFF8B4513), const Color(0xFFD2B48C)];
      case 'tea':
        return [const Color(0xFF8FBC8F), const Color(0xFF90EE90)];
      case 'book':
        return [const Color(0xFF4682B4), const Color(0xFF87CEEB)];
      default:
        return [Colors.grey, Colors.grey.shade300];
    }
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

class _EventCard extends StatelessWidget {
  final Map<String, dynamic> event;

  const _EventCard({required this.event});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.event,
                    color: theme.colorScheme.primary,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        event['title'],
                        style: theme.textTheme.titleMedium,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        event['clubName'],
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              event['description'],
              style: theme.textTheme.bodyMedium,
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Icon(
                  Icons.access_time,
                  size: 16,
                  color: theme.colorScheme.onSurface.withOpacity(0.6),
                ),
                const SizedBox(width: 4),
                Text(
                  event['time'],
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurface.withOpacity(0.6),
                  ),
                ),
                const SizedBox(width: 16),
                Icon(
                  Icons.location_on,
                  size: 16,
                  color: theme.colorScheme.onSurface.withOpacity(0.6),
                ),
                const SizedBox(width: 4),
                Text(
                  event['location'],
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurface.withOpacity(0.6),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${event['attendees']} участников',
                  style: theme.textTheme.bodySmall,
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('Участвовать'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ClubDetailsPage extends StatelessWidget {
  final Map<String, dynamic> club;

  const _ClubDetailsPage({required this.club});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(club['name']),
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: _getClubColors(club['type']),
                  ),
                ),
                child: Center(
                  child: Icon(
                    _getClubIcon(club['type']),
                    size: 64,
                    color: Colors.white.withOpacity(0.8),
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'О клубе',
                    style: theme.textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    club['description'],
                    style: theme.textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 24),
                  
                  Row(
                    children: [
                      Expanded(
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              children: [
                                Icon(
                                  Icons.people,
                                  color: theme.colorScheme.primary,
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  '${club['members']}',
                                  style: theme.textTheme.titleLarge,
                                ),
                                Text(
                                  'Участников',
                                  style: theme.textTheme.bodySmall,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              children: [
                                Icon(
                                  Icons.event,
                                  color: theme.colorScheme.primary,
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  '${club['events']}',
                                  style: theme.textTheme.titleLarge,
                                ),
                                Text(
                                  'Событий',
                                  style: theme.textTheme.bodySmall,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 24),
                  
                  Text(
                    'Последние обсуждения',
                    style: theme.textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 16),
                  
                  ..._clubPosts.map((post) => Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 16,
                                backgroundColor: theme.colorScheme.primary,
                                child: Text(
                                  (post['author'] as String? ?? 'U')[0],
                                  style: TextStyle(
                                    color: theme.colorScheme.onPrimary,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      post['author'] as String? ?? 'Аноним',
                                      style: theme.textTheme.titleSmall,
                                    ),
                                    Text(
                                      post['time'] as String? ?? '',
                                      style: theme.textTheme.bodySmall?.copyWith(
                                        color: theme.colorScheme.onSurface.withOpacity(0.6),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Text(
                            post['content'] as String? ?? '',
                            style: theme.textTheme.bodyMedium,
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              TextButton.icon(
                                onPressed: () {},
                                icon: const Icon(Icons.favorite_border, size: 16),
                                label: Text('${post['likes'] ?? 0}'),
                              ),
                              TextButton.icon(
                                onPressed: () {},
                                icon: const Icon(Icons.comment_outlined, size: 16),
                                label: Text('${post['comments'] ?? 0}'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        icon: const Icon(Icons.add),
        label: const Text('Новый пост'),
      ),
    );
  }

  List<Color> _getClubColors(String type) {
    switch (type) {
      case 'coffee':
        return [const Color(0xFF8B4513), const Color(0xFFD2B48C)];
      case 'tea':
        return [const Color(0xFF8FBC8F), const Color(0xFF90EE90)];
      case 'book':
        return [const Color(0xFF4682B4), const Color(0xFF87CEEB)];
      default:
        return [Colors.grey, Colors.grey.shade300];
    }
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

class _CreateClubDialog extends StatefulWidget {
  const _CreateClubDialog();

  @override
  State<_CreateClubDialog> createState() => _CreateClubDialogState();
}

class _CreateClubDialogState extends State<_CreateClubDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  String _selectedType = 'coffee';

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Dialog(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 400),
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Создать клуб',
                style: theme.textTheme.headlineSmall,
              ),
              const SizedBox(height: 20),
              
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Название клуба',
                  hintText: 'Введите название',
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Введите название клуба';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Описание',
                  hintText: 'Расскажите о клубе',
                ),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Введите описание клуба';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              
              Text(
                'Тип клуба',
                style: theme.textTheme.titleSmall,
              ),
              const SizedBox(height: 8),
              
              Row(
                children: [
                  Expanded(
                    child: RadioListTile<String>(
                      title: const Text('Кофе'),
                      value: 'coffee',
                      groupValue: _selectedType,
                      onChanged: (value) => setState(() => _selectedType = value!),
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                  Expanded(
                    child: RadioListTile<String>(
                      title: const Text('Чай'),
                      value: 'tea',
                      groupValue: _selectedType,
                      onChanged: (value) => setState(() => _selectedType = value!),
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                  Expanded(
                    child: RadioListTile<String>(
                      title: const Text('Книги'),
                      value: 'book',
                      groupValue: _selectedType,
                      onChanged: (value) => setState(() => _selectedType = value!),
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 24),
              
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Отмена'),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Navigator.of(context).pop();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Клуб создан!'),
                          ),
                        );
                      }
                    },
                    child: const Text('Создать'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Данные для примера
final _myClubs = [
  {
    'id': '1',
    'name': 'Кофейные гурманы',
    'description': 'Обсуждаем лучшие сорта кофе и способы приготовления',
    'type': 'coffee',
    'members': 24,
    'events': 5,
  },
  {
    'id': '2',
    'name': 'Книжные вечера',
    'description': 'Читаем и обсуждаем современную литературу',
    'type': 'book',
    'members': 18,
    'events': 8,
  },
];

final _allClubs = [
  ..._myClubs,
  {
    'id': '3',
    'name': 'Чайная церемония',
    'description': 'Изучаем традиции чаепития разных стран',
    'type': 'tea',
    'members': 15,
    'events': 3,
  },
  {
    'id': '4',
    'name': 'Философский кофе',
    'description': 'Размышляем о жизни за чашкой ароматного кофе',
    'type': 'coffee',
    'members': 32,
    'events': 12,
  },
];

final _upcomingEvents = [
  {
    'title': 'Дегустация эфиопского кофе',
    'clubName': 'Кофейные гурманы',
    'description': 'Попробуем редкие сорта кофе из Эфиопии',
    'time': 'Завтра в 18:00',
    'location': 'Основной зал',
    'attendees': 12,
  },
  {
    'title': 'Обсуждение "Мастер и Маргарита"',
    'clubName': 'Книжные вечера',
    'description': 'Разбираем классику русской литературы',
    'time': 'Пятница в 19:00',
    'location': 'Тихий уголок',
    'attendees': 8,
  },
  {
    'title': 'Японская чайная церемония',
    'clubName': 'Чайная церемония',
    'description': 'Изучаем искусство приготовления матча',
    'time': 'Суббота в 16:00',
    'location': 'Зал для мероприятий',
    'attendees': 15,
  },
];

final _clubPosts = [
  {
    'author': 'Анна Смирнова',
    'time': '2 часа назад',
    'content': 'Попробовала новый сорт кофе из Гватемалы - просто восхитительно! Кто-нибудь еще пробовал?',
    'likes': 5,
    'comments': 3,
  },
  {
    'author': 'Михаил Петров',
    'time': '5 часов назад',
    'content': 'Поделюсь рецептом идеального капучино. Главное - правильная температура молока!',
    'likes': 8,
    'comments': 6,
  },
  {
    'author': 'Елена Козлова',
    'time': '1 день назад',
    'content': 'Кто-нибудь читал "Кофе с молоком и временем" Тамары Мелашвили? Очень атмосферная книга!',
    'likes': 12,
    'comments': 9,
  },
];
