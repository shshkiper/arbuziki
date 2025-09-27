import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
import 'presentation/pages/checkout/checkout_page.dart';

// Провайдер для управления темой
final themeProvider = StateNotifierProvider<ThemeNotifier, ThemeMode>((ref) {
  return ThemeNotifier();
});

class ThemeNotifier extends StateNotifier<ThemeMode> {
  ThemeNotifier() : super(ThemeMode.system) {
    _loadTheme();
  }

  void _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final themeModeString = prefs.getString('themeMode');

    if (themeModeString != null) {
      switch (themeModeString) {
        case 'light':
          state = ThemeMode.light;
          break;
        case 'dark':
          state = ThemeMode.dark;
          break;
        case 'system':
        default:
          state = ThemeMode.system;
          break;
      }
    } else {
      // По умолчанию используем системную тему
      state = ThemeMode.system;
    }
  }

  void setThemeMode(ThemeMode mode) async {
    final prefs = await SharedPreferences.getInstance();
    state = mode;

    String themeModeString;
    switch (mode) {
      case ThemeMode.light:
        themeModeString = 'light';
        break;
      case ThemeMode.dark:
        themeModeString = 'dark';
        break;
      case ThemeMode.system:
        themeModeString = 'system';
        break;
    }

    await prefs.setString('themeMode', themeModeString);
  }

  void toggleTheme() async {
    final currentMode = state;

    // Переключаем между light и dark, пропуская system
    ThemeMode newMode;
    if (currentMode == ThemeMode.light) {
      newMode = ThemeMode.dark;
    } else if (currentMode == ThemeMode.dark) {
      newMode = ThemeMode.light;
    } else {
      // Если сейчас system, переключаем на light
      newMode = ThemeMode.light;
    }

    setThemeMode(newMode);
  }
}

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
    GoRoute(
      path: '/checkout',
      builder: (context, state) => const CheckoutPage(),
    ),
  ],
);

class DrinkWithBookApp extends ConsumerWidget {
  const DrinkWithBookApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);

    return MaterialApp.router(
      title: 'Drink with Book',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeMode,
      routerConfig: _router,
      debugShowCheckedModeBanner: false,
    );
  }
}
