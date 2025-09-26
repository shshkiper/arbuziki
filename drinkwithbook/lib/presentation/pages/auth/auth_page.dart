import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthPage extends ConsumerStatefulWidget {
  const AuthPage({super.key});

  @override
  ConsumerState<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends ConsumerState<AuthPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();

  bool _isLogin = true;
  bool _isLoading = false;
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _handleAuth() async {
    print('🔍 Form validation started');

    if (!_formKey.currentState!.validate()) {
      print('❌ Form validation failed');
      return;
    }

    print('✅ Form validation passed');

    setState(() => _isLoading = true);

    try {
      final supabase = Supabase.instance.client;

      // Отладочная информация
      print('🔍 Auth Debug:');
      print('Is authenticated: ${supabase.auth.currentUser != null}');
      print('Auth action: ${_isLogin ? "Login" : "Signup"}');
      print('Email: ${_emailController.text.trim()}');
      print('Password length: ${_passwordController.text.length}');
      if (!_isLogin) {
        print('Name: ${_nameController.text.trim()}');
      }

      if (_isLogin) {
        // Вход
        print('🔄 Attempting login...');
        final response = await supabase.auth.signInWithPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text,
        );
        print('✅ Login response: ${response.user?.email}');
        print('✅ Login successful');
      } else {
        // Регистрация
        print('🔄 Attempting signup...');
        final response = await supabase.auth.signUp(
          email: _emailController.text.trim(),
          password: _passwordController.text,
          data: {'name': _nameController.text.trim()},
        );
        print('✅ Signup response: ${response.user?.email}');
        print('✅ User confirmed: ${response.user?.emailConfirmedAt != null}');
        print('✅ Signup successful');

        // Проверяем, требуется ли подтверждение email
        if (response.user?.emailConfirmedAt == null) {
          print('📧 Email confirmation required');
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Проверьте почту для подтверждения аккаунта'),
                backgroundColor: Colors.orange,
              ),
            );
            return; // Не переходим на главную страницу
          }
        } else {
          print('✅ Email already confirmed, proceeding to home');
        }
      }

      if (mounted) {
        print('🔄 Navigating to home...');
        context.go('/home');
      }
    } on AuthException catch (e) {
      print('❌ AuthException: ${e.message}');
      print('❌ AuthException code: ${e.statusCode}');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Ошибка аутентификации: ${e.message}'),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    } catch (e) {
      print('❌ General error: $e');
      print('❌ Error type: ${e.runtimeType}');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Произошла ошибка: $e'),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [theme.colorScheme.background, theme.colorScheme.surface],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 40),

                  // Логотип и заголовок
                  Center(
                        child: Column(
                          children: [
                            // Логотип - без рамок и обрезки
                            Image.asset(
                              'assets/images/logo.png',
                              width: 120,
                              height: 120,
                              fit: BoxFit.contain,
                            ),

                            const SizedBox(height: 24),

                            Text(
                              _isLogin
                                  ? 'Добро пожаловать!'
                                  : 'Присоединяйтесь к нам!',
                              style: theme.textTheme.displaySmall,
                              textAlign: TextAlign.center,
                            ),

                            const SizedBox(height: 8),

                            Text(
                              _isLogin
                                  ? 'Войдите в свой аккаунт'
                                  : 'Создайте новый аккаунт',
                              style: theme.textTheme.bodyLarge?.copyWith(
                                color: theme.colorScheme.onBackground
                                    .withOpacity(0.7),
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      )
                      .animate()
                      .fadeIn(duration: const Duration(milliseconds: 600))
                      .slideY(
                        begin: -0.2,
                        duration: const Duration(milliseconds: 600),
                      ),

                  const SizedBox(height: 48),

                  // Поля ввода
                  if (!_isLogin) ...[
                    TextFormField(
                          controller: _nameController,
                          decoration: const InputDecoration(
                            labelText: 'Имя',
                            prefixIcon: Icon(Icons.person_outline),
                          ),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Введите ваше имя';
                            }
                            return null;
                          },
                        )
                        .animate(delay: const Duration(milliseconds: 200))
                        .slideX(
                          begin: -0.2,
                          duration: const Duration(milliseconds: 400),
                        )
                        .fadeIn(duration: const Duration(milliseconds: 400)),

                    const SizedBox(height: 16),
                  ],

                  TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          labelText: 'Email',
                          prefixIcon: Icon(Icons.email_outlined),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Введите email';
                          }
                          if (!value.contains('@')) {
                            return 'Введите корректный email';
                          }
                          return null;
                        },
                      )
                      .animate(delay: const Duration(milliseconds: 300))
                      .slideX(
                        begin: -0.2,
                        duration: const Duration(milliseconds: 400),
                      )
                      .fadeIn(duration: const Duration(milliseconds: 400)),

                  const SizedBox(height: 16),

                  TextFormField(
                        controller: _passwordController,
                        obscureText: _obscurePassword,
                        decoration: InputDecoration(
                          labelText: 'Пароль',
                          prefixIcon: const Icon(Icons.lock_outline),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscurePassword
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined,
                            ),
                            onPressed: () {
                              setState(
                                () => _obscurePassword = !_obscurePassword,
                              );
                            },
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Введите пароль';
                          }
                          if (value.length < 6) {
                            return 'Пароль должен содержать минимум 6 символов';
                          }
                          return null;
                        },
                      )
                      .animate(delay: const Duration(milliseconds: 400))
                      .slideX(
                        begin: -0.2,
                        duration: const Duration(milliseconds: 400),
                      )
                      .fadeIn(duration: const Duration(milliseconds: 400)),

                  const SizedBox(height: 32),

                  // Кнопка входа/регистрации
                  ElevatedButton(
                        onPressed: _isLoading ? null : _handleAuth,
                        child:
                            _isLoading
                                ? const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                )
                                : Text(
                                  _isLogin ? 'Войти' : 'Зарегистрироваться',
                                ),
                      )
                      .animate(delay: const Duration(milliseconds: 500))
                      .scale(begin: const Offset(0.8, 0.8))
                      .fadeIn(duration: const Duration(milliseconds: 400)),

                  const SizedBox(height: 24),

                  // Переключение между входом и регистрацией
                  Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            _isLogin ? 'Нет аккаунта? ' : 'Уже есть аккаунт? ',
                            style: theme.textTheme.bodyMedium,
                          ),
                          TextButton(
                            onPressed: () {
                              setState(() => _isLogin = !_isLogin);
                            },
                            child: Text(
                              _isLogin ? 'Зарегистрироваться' : 'Войти',
                            ),
                          ),
                        ],
                      )
                      .animate(delay: const Duration(milliseconds: 600))
                      .fadeIn(duration: const Duration(milliseconds: 400)),

                  const SizedBox(height: 32),

                  // Информация о приложении
                  Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.surface,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: theme.colorScheme.outline.withOpacity(0.2),
                          ),
                        ),
                        child: Column(
                          children: [
                            Icon(
                              Icons.local_cafe,
                              size: 32,
                              color: theme.colorScheme.primary,
                            ),
                            const SizedBox(height: 12),
                            Text(
                              'Добро пожаловать в наше уютное сообщество',
                              style: theme.textTheme.titleMedium,
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Здесь вы найдете единомышленников, любящих хорошую литературу, ароматный кофе и душевные беседы',
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: theme.colorScheme.onSurface.withOpacity(
                                  0.7,
                                ),
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      )
                      .animate(delay: const Duration(milliseconds: 700))
                      .slideY(
                        begin: 0.2,
                        duration: const Duration(milliseconds: 600),
                      )
                      .fadeIn(duration: const Duration(milliseconds: 600)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
