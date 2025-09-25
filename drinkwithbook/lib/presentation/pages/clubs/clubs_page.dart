import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'dart:ui';

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
        toolbarHeight: 100,
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Container(),
          centerTitle: false,
          flexibleSpace: ClipRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 0.0, sigmaY: 25.0),
              child: Container(
                color: Colors.white.withOpacity(0.00001),
                child: Column(
                  children: [
                    // Верхняя часть с логотипом и корзиной
                    Container(
                      height: 80,
                      child: Row(
                        children: [
                          // Логотип
                          Padding(
                            padding: const EdgeInsets.only(left: 17.0, top:24.0 ),
                            child: Image.asset(
                              height: 45,
                              'assets/images/logo.png',
                              fit: BoxFit.contain,
                            ),
                          ),
                          Spacer(),
                          // Иконка корзины
                          Stack(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 15.0, top: 26), // ← Добавь этот отступ
                                child: IconButton(
                                  icon: const Icon(Icons.add),
                                  iconSize: 30,
                                  onPressed: () => _showCreateClubDialog(context),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    // TabBar
                          Expanded(
                            child: TabBar(
                              dividerHeight: 0,
                              controller: _tabController,
                              labelStyle: TextStyle(
                                fontSize: 16.4,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'G'
                              ),
                              unselectedLabelStyle: TextStyle(
                                fontSize: 16.4,
                                fontWeight: FontWeight.normal,
                                fontFamily: 'G',
                              ),
                              tabs: const [
                                Tab(text: 'Мои клубы'),
                                Tab(text: 'Все клубы'),
                                Tab(text: 'События'),
                              ],
                            ),
                            
                          ),
                        ],
                      ),
                    ),
                ),
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
          padding: const EdgeInsets.only(bottom: 5),
          child: _ClubCard(
            club: club,
            isMember: true,
            onTap: () => _showClubDetails(context, club),
          ),
        )
            .animate(delay: Duration(milliseconds: index * 100))
            .fadeIn(duration: const Duration(milliseconds: 200))
            .slideX(begin: -0.2, duration: const Duration(milliseconds: 200));
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
          padding: const EdgeInsets.only(bottom: 5),
          child: _ClubCard(
            club: club,
            isMember: _myClubs.any((myClub) => myClub['id'] == club['id']),
            onTap: () => _showClubDetails(context, club),
          ),
        )
            .animate(delay: Duration(milliseconds: index *80))
            .fadeIn(duration: const Duration(milliseconds: 200))
            .slideX(begin: 0.2, duration: const Duration(milliseconds: 200));
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
          padding: const EdgeInsets.only(bottom: 0),
          child: _EventCard(event: event),
        )
            .animate(delay: Duration(milliseconds: index * 100))
            .fadeIn(duration: const Duration(milliseconds: 150))
            .slideY(begin: 0.2, duration: const Duration(milliseconds: 250));
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
    
    return Container(
      margin: const EdgeInsets.only(bottom: 4),
      child: Card(
        clipBehavior: Clip.antiAlias,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
          side: BorderSide(
            color: Colors.grey.withOpacity(0.1),
            width: 1,
          ),
        ),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(24),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 140,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: _getClubColors(club['type']),
                      ),
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          top: -30,
                          right: -30,
                          child: Container(
                            width: 120,
                            height: 120,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.15),
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                        //иконка карточк
                        Center(
                          child: Container(
                            padding: const EdgeInsets.all(22),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  Colors.white.withOpacity(0.3),
                                  Colors.white.withOpacity(0.1),
                                ],
                              ),
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.white.withOpacity(0.3),
                                width: 2,
                              ),
                            ),
                            child: Icon(
                              _getClubIcon(club['type']),
                              size: 42,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  


                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Заголовок + участник
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                club['name'],
                                style: TextStyle(
                                  fontFamily: 'G',
                                  fontSize: 22,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black87,
                                  height: 1.2,
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            if (club['isOwner'] == true)
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.orange,
                                      Colors.orange.withOpacity(0.8),
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.orange.withOpacity(0.3),
                                      blurRadius: 8,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Text(
                                  'Создатель',
                                  style: TextStyle(
                                    fontFamily: 'G',
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                  ),
                                ),
                              )
                            else if (isMember)
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      theme.colorScheme.primary,
                                      theme.colorScheme.primary.withOpacity(0.8),
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: theme.colorScheme.primary.withOpacity(0.3),
                                      blurRadius: 8,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Text(
                                  'Участник',
                                  style: TextStyle(
                                    fontFamily: 'G',
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                          ],
                        ),
                        
                        const SizedBox(height: 12),
                        
                        // Описание
                        Text(
                          club['description'],
                          style: TextStyle(
                            fontFamily: 'G',
                            fontSize: 15,
                            color: Colors.grey[600],
                            height: 1.4,
                            fontWeight: FontWeight.w400,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        
                        const SizedBox(height: 16),
                        
                        // Статистика
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.05),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: Colors.grey.withOpacity(0.1),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              _buildModernStatItem(
                                icon: Icons.people_rounded,
                                value: club['members'].toString(),
                                label: 'Участников',
                                theme: theme,
                              ),
                              Container(
                                height: 30,
                                width: 1,
                                color: Colors.grey.withOpacity(0.2),
                              ),
                              _buildModernStatItem(
                                icon: Icons.event_available_rounded,
                                value: club['events'].toString(),
                                label: 'Событий',
                                theme: theme,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              
              //стрелка выход
              Positioned(
                top: 16,
                right: 16,
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 14,
                    color: Colors.grey[600],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Widget _buildModernStatItem({
    required IconData icon,
    required String value,
    required String label,
    required ThemeData theme,
  }) {
    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 22,
              color: theme.colorScheme.primary,
            ),
            const SizedBox(width: 6),
            Text(
              value,
              style: TextStyle(
                fontFamily: 'G',
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Colors.black87,
              ),
            ),
          ],
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: TextStyle(
            fontFamily: 'G',
            fontSize: 14,
            color: Colors.grey[600],
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
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
    
    return Container(
      margin: const EdgeInsets.only(bottom: 17),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
      ),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        child: InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(24),
          child: Padding(
            padding: const EdgeInsets.all(28),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Верхняя часть с основной информацией
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Иконка события
                    Container(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            theme.colorScheme.primary,
                            theme.colorScheme.primaryContainer,
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: theme.colorScheme.primary.withOpacity(0.3),
                            blurRadius: 12,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: Icon(
                        Icons.event_rounded,
                        color: Colors.white,
                        size: 28,
                      ),
                    ),
                    const SizedBox(width: 20),
                    
                    // Заголовок, клуб и участники
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Заголовок события
                          Text(
                            event['title'] ?? 'Название события',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w800,
                              color: Colors.black87,
                              fontFamily: 'G',
                              height: 1.3,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 12),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                          Row(
                            children: [
                              // Название клуба
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  color: theme.colorScheme.primary.withOpacity(0.08),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: theme.colorScheme.primary.withOpacity(0.2),
                                    width: 1.5,
                                  ),
                                ),
                                child: Text(
                                  event['clubName'] ?? 'Клуб',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: theme.colorScheme.primary,
                                    fontFamily: 'G',
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              
                              // Участники
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                decoration: BoxDecoration(
                                  color: Colors.grey.withOpacity(0.08),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.people_alt_rounded,
                                      size: 16,
                                      color: Colors.grey[600],
                                    ),
                                    const SizedBox(width: 6),
                                    Text(
                                      '${event['attendees'] ?? 0}',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.grey[700],
                                        fontFamily: 'G',
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                const SizedBox(height: 15),
                
                // Описание
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.grey.withOpacity(0.02),
                        Colors.grey.withOpacity(0.05),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: Colors.grey.withOpacity(0.15),
                      width: 1.5,
                    ),
                  ),
                  child: Text(
                    event['description'] ?? 'Описание события',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[800],
                      fontFamily: 'G',
                      height: 1.5,
                    ),
                    textAlign: TextAlign.start,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                
                const SizedBox(height: 15),
                
                // Детали события
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: Colors.grey.withOpacity(0.1),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      // Время
                      Expanded(
                        child: _buildDetailItem(
                          icon: Icons.schedule_rounded,
                          title: 'Время',
                          value: event['time'] ?? '--:--',
                          color: Colors.blue,
                        ),
                      ),
                      
                      // Вертикальный разделитель
                      Container(
                        width: 1,
                        height: 40,
                        color: Colors.grey.withOpacity(0.2),
                        margin: const EdgeInsets.symmetric(horizontal: 16),
                      ),
                      
                      // Местоположение
                      Expanded(
                        child: _buildDetailItem(
                          icon: Icons.location_on_rounded,
                          title: 'Место',
                          value: event['location'] ?? 'Не указано',
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height:15),
                
                // Кнопка присоединения
                Container(
                  height: 56,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        theme.colorScheme.primary,
                        theme.colorScheme.primary.withOpacity(0.9),
                      ],
                      stops: const [0.0, 0.8],
                    ),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: theme.colorScheme.primary.withOpacity(0.4),
                        blurRadius: 15,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {},
                      borderRadius: BorderRadius.circular(16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.add_circle_rounded,
                            size: 22,
                            color: Colors.white,
                          ),
                          const SizedBox(width: 12),
                          Text(
                            'Присоединиться к событию',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                              fontFamily: 'G',
                              letterSpacing: -0.3,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDetailItem({
    required IconData icon,
    required String title,
    required String value,
    required Color color,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon,
                size: 16,
                color: color,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              title,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Colors.grey[600],
                fontFamily: 'G',
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w700,
            color: Colors.black87,
            fontFamily: 'G',
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}

class _ClubDetailsPage extends StatelessWidget {
  final Map<String, dynamic> club;

  const _ClubDetailsPage({required this.club});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final clubColors = _getClubColors(club['type']);
    
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 220,
            pinned: true,
            stretch: true,
            backgroundColor: clubColors[0], // Фиксированный цвет при скролле
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true, // Название по центру
              title: Text(
                club['name'],
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  fontFamily: 'G',
                  shadows: [
                    Shadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
              ),
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: clubColors,
                  ),
                ),
                child: Stack(
                  children: [
                    // Фоновый узор
                    Positioned(
                      right: -50,
                      top: -50,
                      child: Container(
                        width: 200,
                        height: 200,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withOpacity(0.1),
                        ),
                      ),
                    ),
                    Center(
                      child: Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          _getClubIcon(club['type']),
                          size: 50,
                          color: Colors.white.withOpacity(0.9),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(top: 24, left: 24, right: 24, bottom: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Заголовок "О клубе"
                  Row(
                    children: [
                      Container(
                        width: 4,
                        height: 24,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(colors: clubColors),
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        'О клубе',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                          color: Colors.black87,
                          fontFamily: 'G',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  
                  // Описание клуба
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.08),
                          blurRadius: 20,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Text(
                      club['description'] ?? 'Описание клуба',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[800],
                        fontFamily: 'G',
                        height: 1.5,
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 20),
                  
                  // Статистика
                  Row(
                    children: [
                      Expanded(
                        child: _buildStatCard(
                          context: context,
                          icon: Icons.people_alt_rounded,
                          value: '${club['members'] ?? 0}',
                          label: 'Участников',
                          gradient: clubColors,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _buildStatCard(
                          context: context,
                          icon: Icons.event_available_rounded,
                          value: '${club['events'] ?? 0}',
                          label: 'Событий',
                          gradient: clubColors,
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 20),
                  
                  // Заголовок "Обсуждения"
                  Row(
                    children: [
                      Container(
                        width: 4,
                        height: 24,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(colors: clubColors),
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        'Последние обсуждения',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                          color: Colors.black87,
                          fontFamily: 'G',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          
          // Список постов
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final post = _clubPosts[index];
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                  child: _buildPostCard(post, theme, clubColors),
                );
              },
              childCount: _clubPosts.length,
            ),
          ),
          
          const SliverToBoxAdapter(
            child: SizedBox(height: 105),
          ),
        ],
      ),
      
      // Кнопка нового поста
      floatingActionButton: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: clubColors),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: clubColors[0].withOpacity(0.4),
              blurRadius: 15,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: FloatingActionButton.extended(
          onPressed: () {},
          backgroundColor: Colors.transparent,
          elevation: 0,
          icon: Icon(
            Icons.add_comment_rounded,
            color: Colors.white,
          ),
          label: Text(
            'Новый пост',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Colors.white,
              fontFamily: 'G',
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard({
    required BuildContext context,
    required IconData icon,
    required String value,
    required String label,
    required List<Color> gradient,
  }) {
    return Container(
      height: 160,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            gradient[0].withOpacity(0.1),
            gradient[1].withOpacity(0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: gradient[0].withOpacity(0.2),
          width: 1.5,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: gradient),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: Colors.white,
              size: 24,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w800,
              color: gradient[0],
              fontFamily: 'G',
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.grey[600],
              fontFamily: 'G',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPostCard(Map<String, dynamic> post, ThemeData theme, List<Color> clubColors) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Автор поста
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: clubColors),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      (post['author'] as String? ?? 'U')[0].toUpperCase(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'G',
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        post['author'] as String? ?? 'Аноним',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.black87,
                          fontFamily: 'G',
                        ),
                      ),
                      Text(
                        post['time'] as String? ?? '',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey[600],
                          fontFamily: 'G',
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            
            // Контент поста
            Text(
              post['content'] as String? ?? '',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: Colors.grey[800],
                fontFamily: 'G',
                height: 1.4,
              ),
            ),
            const SizedBox(height: 16),
            
            // Действия
            Row(
              children: [
                _buildPostAction(
                  icon: Icons.favorite_rounded,
                  count: post['likes'] ?? 0,
                  color: Colors.red,
                ),
                const SizedBox(width: 20),
                _buildPostAction(
                  icon: Icons.comment_rounded,
                  count: post['comments'] ?? 0,
                  color: Colors.grey[800]!,
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: clubColors[0].withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    'Ответить',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: clubColors[0],
                      fontFamily: 'G',
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPostAction({
    required IconData icon,
    required int count,
    required Color color,
  }) {
    return Row(
      children: [
        Icon(
          icon,
          size: 20,
          color: color.withOpacity(0.7),
        ),
        const SizedBox(width: 6),
        Text(
          count.toString(),
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: color,
            fontFamily: 'G',
          ),
        ),
      ],
    );
  }
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

  void _createClub(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      if (_nameController.text.trim().isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Пожалуйста, введите название клуба'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      if (_descriptionController.text.trim().isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Пожалуйста, введите описание клуба'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      // Создаем новый клуб
      final newClub = {
        'id': DateTime.now().millisecondsSinceEpoch.toString(),
        'name': _nameController.text.trim(),
        'description': _descriptionController.text.trim(),
        'type': _selectedType,
        'members': 1,
        'events': 0,
        'isOwner': true,
        'createdAt': DateTime.now(),
        'image': _getClubImage(_selectedType),
      };

      // Добавляем клуб в списки
      _addNewClub(newClub);

      // Закрываем диалог
      Navigator.of(context).pop();

      // Показываем уведомление об успешном создании
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Клуб "${_nameController.text.trim()}" успешно создан!'),
          backgroundColor: Colors.green,
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }

  String _getClubImage(String type) {
    switch (type) {
      case 'coffee':
        return 'coffee_club.jpg';
      case 'tea':
        return 'tea_club.jpg';
      case 'book':
        return 'book_club.jpg';
      default:
        return 'default_club.jpg';
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Dialog(
  backgroundColor: Colors.transparent,
  elevation: 0,
  insetPadding: const EdgeInsets.all(20),
  child: Container(
    constraints: const BoxConstraints(maxWidth: 500),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(28),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.25),
          blurRadius: 40,
          offset: const Offset(0, 15),
        ),
      ],
    ),
    child: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Заголовок с иконкой
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              theme.colorScheme.primary,
                              theme.colorScheme.primary.withOpacity(0.8),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Icon(
                          Icons.groups_rounded,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Создать клуб',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.w800,
                              color: Colors.black87,
                              fontFamily: 'G',
                              height: 1.1,
                            ),
                          ),

                        ],
                      ),
                    ],
                  ),
                  IconButton(
                    padding: EdgeInsets.only(bottom: 3,left: 20),
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
                ],
              ),
              
              const SizedBox(height: 10),
              
              // Название клуба
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Название клуба',
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                      fontFamily: 'G',
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: Colors.grey.withOpacity(0.2),
                        width: 1.5,
                      ),
                    ),
                    child: TextFormField(
                      controller: _nameController,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Введите название клуба';
                        }
                        if (value.trim().length < 3) {
                          return 'Название должно содержать минимум 3 символа';
                        }
                        return null;
                      },
                      style: TextStyle(
                        fontSize: 17,
                        fontFamily: 'G',
                        fontWeight: FontWeight.w500,
                      ),
                      decoration: const InputDecoration(
                        hintText: 'Кофейные гурманы, Книжный клуб...',
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(20),
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 10),
              
              // Описание
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Описание',
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                      fontFamily: 'G',
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: Colors.grey.withOpacity(0.2),
                        width: 1.5,
                      ),
                    ),
                    child: TextFormField(
                      controller: _descriptionController,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Введите описание клуба';
                        }
                        if (value.trim().length < 10) {
                          return 'Описание должно содержать минимум 10 символов';
                        }
                        return null;
                      },
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'G',
                        fontWeight: FontWeight.w400,
                      ),
                      maxLines: 3,
                      decoration: const InputDecoration(
                        hintText: 'Опишите цели, тематику и правила клуба',
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(20),
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 10),
              
              // Тип клуба
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Тематика клуба',
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                      fontFamily: 'G',
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: _buildPremiumTypeCard(
                          type: 'coffee',
                          icon: Icons.coffee_rounded,
                          title: 'Кофе',
                          theme: theme,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildPremiumTypeCard(
                          type: 'tea',
                          icon: Icons.emoji_food_beverage,
                          title: 'Чай',
                          theme: theme,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildPremiumTypeCard(
                          type: 'book',
                          icon: Icons.auto_stories_rounded,
                          title: 'Книги',
                          theme: theme,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              
              const SizedBox(height: 10),
              
              // Кнопки
              Container(
                height: 2,
                color: Colors.grey.withOpacity(0.1),
              ),
              const SizedBox(height: 10),
              
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: Colors.grey.withOpacity(0.3),
                        width: 1.5,
                      ),
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () => Navigator.of(context).pop(),
                        borderRadius: BorderRadius.circular(14),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 14,
                          ),
                          child: Text(
                            'Отмена',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey[700],
                              fontFamily: 'G',
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          theme.colorScheme.primary,
                          theme.colorScheme.primary.withOpacity(0.9),
                        ],
                        stops: [0.0, 0.8],
                      ),
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: [
                        BoxShadow(
                          color: theme.colorScheme.primary.withOpacity(0.4),
                          blurRadius: 15,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () => _createClub(context),
                        borderRadius: BorderRadius.circular(14),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 32,
                            vertical: 14,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.add_circle_rounded,
                                size: 20,
                                color: Colors.white,
                              ),
                              const SizedBox(width: 10),
                              Text(
                                'Создать клуб',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                  fontFamily: 'G',
                                  letterSpacing: -0.2,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  ),
);

// Премиум версия карточки типа


// Метод для карточки типа клуба

  }
Widget _buildPremiumTypeCard({
  required String type,
  required IconData icon,
  required String title,
  required ThemeData theme,
}) {
  final isSelected = _selectedType == type;
  
  return GestureDetector(
    onTap: () {
      setState(() {
        _selectedType = type;
      });
    },
    child: AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isSelected 
            ? theme.colorScheme.primary.withOpacity(0.08)
            : Colors.grey.withOpacity(0.03),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isSelected 
              ? theme.colorScheme.primary.withOpacity(0.3)
              : Colors.transparent,
          width: 2,
        ),
        boxShadow: isSelected 
            ? [
                BoxShadow(
                  color: theme.colorScheme.primary.withOpacity(0.1),
                  blurRadius: 15,
                  offset: const Offset(0, 5),
                ),
              ]
            : [],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: isSelected 
                  ? theme.colorScheme.primary
                  : Colors.grey.withOpacity(0.1),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(
              icon,
              size: 24,
              color: isSelected ? Colors.white : Colors.grey[600],
            ),
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: isSelected 
                  ? theme.colorScheme.primary
                  : Colors.black87,
              fontFamily: 'G',
            ),
          ),
          const SizedBox(height: 4),
        ],
      ),
    ),
  );
}

}

// Данные для примера
// Глобальные списки клубов
List<Map<String, dynamic>> _myClubs = [
  {
    'id': '1',
    'name': 'Кофейные гурманы',
    'description': 'Обсуждаем лучшие сорта кофе и способы приготовления',
    'type': 'coffee',
    'members': 24,
    'events': 5,
    'isOwner': false,
  },
  {
    'id': '2',
    'name': 'Книжные вечера',
    'description': 'Читаем и обсуждаем современную литературу',
    'type': 'book',
    'members': 18,
    'events': 8,
    'isOwner': false,
  },
];

List<Map<String, dynamic>> _allClubs = [
  ..._myClubs,
  {
    'id': '3',
    'name': 'Чайная церемония',
    'description': 'Изучаем традиции чаепития разных стран',
    'type': 'tea',
    'members': 15,
    'events': 3,
    'isOwner': false,
  },
  {
    'id': '4',
    'name': 'Философский кофе',
    'description': 'Размышляем о жизни за чашкой ароматного кофе',
    'type': 'coffee',
    'members': 32,
    'events': 12,
    'isOwner': false,
  },
];

// Функция для добавления нового клуба
void _addNewClub(Map<String, dynamic> newClub) {
  _myClubs.insert(0, newClub); // Добавляем в начало списка "Мои клубы"
  // НЕ добавляем в _allClubs, так как он уже содержит _myClubs через spread оператор
}

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
