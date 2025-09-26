import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:go_router/go_router.dart';

import 'presentation/theme/app_theme.dart';
import 'presentation/pages/splash/splash_page.dart';
import 'presentation/pages/auth/auth_page.dart';
import 'presentation/pages/home/home_page.dart';
import 'presentation/pages/menu/menu_page.dart';
import 'presentation/pages/clubs/clubs_page.dart';
import 'presentation/pages/loyalty/loyalty_page.dart';
import 'presentation/pages/profile/profile_page.dart';
import 'presentation/pages/chat/chat_page.dart';
import 'presentation/pages/map/map_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Загружаем переменные окружения
  await dotenv.load(fileName: ".env");

  // Инициализируем Supabase
  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL'] ?? '',
    anonKey: dotenv.env['SUPABASE_ANON_KEY'] ?? '',
  );

  runApp(const ProviderScope(child: DrinkWithBookApp()));
}

final GoRouter _router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (context, state) => const SplashPage()),
    GoRoute(path: '/auth', builder: (context, state) => const AuthPage()),
    GoRoute(path: '/home', builder: (context, state) => const HomePage()),
    GoRoute(path: '/menu', builder: (context, state) => const MenuPage()),
    GoRoute(path: '/clubs', builder: (context, state) => const ClubsPage()),
    GoRoute(path: '/loyalty', builder: (context, state) => const LoyaltyPage()),
    GoRoute(path: '/profile', builder: (context, state) => const ProfilePage()),
    GoRoute(path: '/chat', builder: (context, state) => const ChatPage()),
    GoRoute(path: '/map', builder: (context, state) => const MapPage()),
  ],
);

class DrinkWithBookApp extends StatelessWidget {
  const DrinkWithBookApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Drink with Book',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      routerConfig: _router,
      debugShowCheckedModeBanner: false,
    );
  }
}
