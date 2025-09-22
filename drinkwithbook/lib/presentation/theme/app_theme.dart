import 'package:flutter/material.dart';

class AppTheme {
  // Цветовая палитра в стиле уютного кафе
  static const Color primaryBrown = Color(0xFF8B4513); // Коричневый кофе
  static const Color lightBrown = Color(0xFFD2B48C); // Светло-коричневый
  static const Color creamWhite = Color(0xFFFFF8DC); // Кремовый белый
  static const Color warmBeige = Color(0xFFF5F5DC); // Теплый бежевый
  static const Color darkBrown = Color(0xFF5D4037); // Темно-коричневый
  static const Color accentGold = Color(0xFFFFD700); // Золотой акцент
  static const Color softGreen = Color(0xFF8FBC8F); // Мягкий зеленый для чая
  static const Color errorRed = Color(0xFFD32F2F); // Красный для ошибок
  static const Color successGreen = Color(0xFF388E3C); // Зеленый для успеха

  // Градиенты
  static const LinearGradient warmGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [creamWhite, warmBeige],
  );

  static const LinearGradient coffeeGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [lightBrown, primaryBrown],
  );

  // Светлая тема
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      primaryColor: primaryBrown,
      scaffoldBackgroundColor: creamWhite,
      
      colorScheme: const ColorScheme.light(
        primary: primaryBrown,
        secondary: lightBrown,
        surface: creamWhite,
        background: warmBeige,
        error: errorRed,
        onPrimary: creamWhite,
        onSecondary: darkBrown,
        onSurface: darkBrown,
        onBackground: darkBrown,
        onError: creamWhite,
        tertiary: accentGold,
        outline: lightBrown,
      ),

      // Типографика
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: darkBrown,
          letterSpacing: -0.5,
        ),
        displayMedium: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: darkBrown,
        ),
        displaySmall: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: darkBrown,
        ),
        headlineLarge: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w600,
          color: darkBrown,
        ),
        headlineMedium: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w500,
          color: darkBrown,
        ),
        headlineSmall: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: darkBrown,
        ),
        titleLarge: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: darkBrown,
        ),
        titleMedium: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: darkBrown,
        ),
        titleSmall: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: darkBrown,
        ),
        bodyLarge: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.normal,
          color: darkBrown,
        ),
        bodyMedium: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.normal,
          color: darkBrown,
        ),
        bodySmall: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.normal,
          color: darkBrown,
        ),
        labelLarge: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: darkBrown,
        ),
        labelMedium: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: darkBrown,
        ),
        labelSmall: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w500,
          color: darkBrown,
        ),
      ),

      // AppBar тема
      appBarTheme: const AppBarTheme(
        backgroundColor: primaryBrown,
        foregroundColor: creamWhite,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: creamWhite,
        ),
      ),

      // Карточки
      cardTheme: CardTheme(
        color: creamWhite,
        elevation: 4,
        shadowColor: primaryBrown.withOpacity(0.2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),

      // Кнопки
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryBrown,
          foregroundColor: creamWhite,
          elevation: 2,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: primaryBrown,
          side: const BorderSide(color: primaryBrown, width: 1.5),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: primaryBrown,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          textStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),

      // Поля ввода
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: creamWhite,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: lightBrown),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: lightBrown),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: primaryBrown, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: errorRed),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        hintStyle: TextStyle(color: darkBrown.withOpacity(0.6)),
      ),

      // Нижняя навигация
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: creamWhite,
        selectedItemColor: primaryBrown,
        unselectedItemColor: lightBrown,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
      ),

      // Иконки
      iconTheme: const IconThemeData(
        color: darkBrown,
        size: 24,
      ),

      // Чипы
      chipTheme: ChipThemeData(
        backgroundColor: lightBrown.withOpacity(0.2),
        selectedColor: primaryBrown,
        labelStyle: const TextStyle(color: darkBrown),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),

      // Диалоги
      dialogTheme: DialogTheme(
        backgroundColor: creamWhite,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        titleTextStyle: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: darkBrown,
        ),
      ),

      // Snackbar
      snackBarTheme: SnackBarThemeData(
        backgroundColor: darkBrown,
        contentTextStyle: const TextStyle(color: creamWhite),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  // Темная тема
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      primaryColor: lightBrown,
      scaffoldBackgroundColor: const Color(0xFF2D1B14),
      
      colorScheme: const ColorScheme.dark(
        primary: lightBrown,
        secondary: accentGold,
        surface: Color(0xFF3E2723),
        background: Color(0xFF2D1B14),
        error: errorRed,
        onPrimary: darkBrown,
        onSecondary: darkBrown,
        onSurface: creamWhite,
        onBackground: creamWhite,
        onError: creamWhite,
        tertiary: accentGold,
        outline: lightBrown,
      ),

      textTheme: const TextTheme(
        displayLarge: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: creamWhite,
          letterSpacing: -0.5,
        ),
        displayMedium: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: creamWhite,
        ),
        displaySmall: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: creamWhite,
        ),
        headlineLarge: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w600,
          color: creamWhite,
        ),
        headlineMedium: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w500,
          color: creamWhite,
        ),
        headlineSmall: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: creamWhite,
        ),
        titleLarge: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: creamWhite,
        ),
        titleMedium: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: creamWhite,
        ),
        titleSmall: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: creamWhite,
        ),
        bodyLarge: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.normal,
          color: creamWhite,
        ),
        bodyMedium: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.normal,
          color: creamWhite,
        ),
        bodySmall: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.normal,
          color: creamWhite,
        ),
        labelLarge: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: creamWhite,
        ),
        labelMedium: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: creamWhite,
        ),
        labelSmall: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w500,
          color: creamWhite,
        ),
      ),

      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFF3E2723),
        foregroundColor: creamWhite,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: creamWhite,
        ),
      ),

      cardTheme: CardTheme(
        color: const Color(0xFF3E2723),
        elevation: 4,
        shadowColor: Colors.black.withOpacity(0.3),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: lightBrown,
          foregroundColor: darkBrown,
          elevation: 2,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),

      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Color(0xFF3E2723),
        selectedItemColor: lightBrown,
        unselectedItemColor: Color(0xFF8D6E63),
        type: BottomNavigationBarType.fixed,
        elevation: 8,
      ),
    );
  }
}
