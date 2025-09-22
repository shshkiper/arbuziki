import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _checkAuthAndNavigate();
  }

  Future<void> _checkAuthAndNavigate() async {
    await Future.delayed(const Duration(seconds: 2));
    
    if (!mounted) return;
    
    final user = Supabase.instance.client.auth.currentUser;
    if (user != null) {
      context.go('/home');
    } else {
      context.go('/auth');
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              theme.colorScheme.primary,
              theme.colorScheme.primary.withOpacity(0.8),
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Логотип
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: Image.asset(
                    'assets/images/logo.png',
                    fit: BoxFit.cover,
                  ),
                ),
              )
                  .animate()
                  .scale(
                    duration: const Duration(milliseconds: 600),
                    curve: Curves.elasticOut,
                  )
                  .fadeIn(duration: const Duration(milliseconds: 400)),

              const SizedBox(height: 32),

              // Название приложения
              Text(
                'Drink with Book',
                style: theme.textTheme.displayMedium?.copyWith(
                  color: theme.colorScheme.onPrimary,
                  fontWeight: FontWeight.bold,
                ),
              )
                  .animate(delay: const Duration(milliseconds: 300))
                  .slideY(
                    begin: 0.5,
                    duration: const Duration(milliseconds: 600),
                    curve: Curves.easeOutQuart,
                  )
                  .fadeIn(duration: const Duration(milliseconds: 600)),

              const SizedBox(height: 16),

              // Подзаголовок
              Text(
                'Уютное место для души и вкуса',
                style: theme.textTheme.titleLarge?.copyWith(
                  color: theme.colorScheme.onPrimary.withOpacity(0.9),
                ),
                textAlign: TextAlign.center,
              )
                  .animate(delay: const Duration(milliseconds: 600))
                  .slideY(
                    begin: 0.3,
                    duration: const Duration(milliseconds: 600),
                    curve: Curves.easeOutQuart,
                  )
                  .fadeIn(duration: const Duration(milliseconds: 600)),

              const SizedBox(height: 64),

              // Индикатор загрузки
              SizedBox(
                width: 40,
                height: 40,
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    theme.colorScheme.onPrimary.withOpacity(0.8),
                  ),
                ),
              )
                  .animate(delay: const Duration(milliseconds: 900))
                  .fadeIn(duration: const Duration(milliseconds: 400))
                  .scale(
                    begin: const Offset(0.8, 0.8),
                    duration: const Duration(milliseconds: 400),
                  ),
            ],
          ),
        ),
      ),
    );
  }
}
