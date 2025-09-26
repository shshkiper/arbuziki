import 'package:flutter/material.dart';

class AppTheme {
  // Цветовая палитра точно как в Drinkit - голубые тона и минимализм
  static const Color primaryBrown = Color(
    0xFF5B7EF7,
  ); // Основной синий как в Drinkit
  static const Color lightBrown = Color(0xFF8B5CF6); // Фиолетовый акцент
  static const Color creamWhite = Color(0xFFFFFFFF); // Белые карточки
  static const Color warmBeige = Color(0xFFE8F0FF); // Светло-голубой фон
  static const Color darkBrown = Color(0xFF1A1D29); // Темный текст
  static const Color accentGold = Color(0xFF10B981); // Зеленый
  static const Color softGreen = Color(0xFF8FBC8F); // Мягкий зеленый для чая
  static const Color errorRed = Color(0xFFEF4444); // Красный
  static const Color successGreen = Color(0xFF10B981); // Зеленый

  // Акцентные цвета для темной темы - синий, голубой, белый
  static const Color darkPrimary = Color(0xFF3B82F6); // Яркий синий
  static const Color darkSecondary = Color(0xFF06B6D4); // Голубой акцент
  static const Color darkAccent = Color(0xFF0EA5E9); // Светло-голубой акцент
  static const Color darkOutline = Color(0xFF60A5FA); // Светло-синий для границ

  // Градиенты как в Drinkit
  static const LinearGradient warmGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFE8F0FF), Color(0xFFDFECFF)],
  );

  static const LinearGradient coffeeGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF5B7EF7), Color(0xFF8B5CF6)],
  );

  // Светлая тема
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      primaryColor: primaryBrown,
      scaffoldBackgroundColor: warmBeige,

      colorScheme: const ColorScheme.light(
        primary: primaryBrown,
        secondary: lightBrown,
        surface: creamWhite,
        background: warmBeige,
        error: errorRed,
        onPrimary: creamWhite,
        onSecondary: creamWhite,
        onSurface: darkBrown,
        onBackground: darkBrown,
        onError: creamWhite,
        tertiary: accentGold,
        outline: Color(0xFF6B7280),
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

      // AppBar тема - минималистичный стиль
      appBarTheme: const AppBarTheme(
        backgroundColor: creamWhite,
        foregroundColor: darkBrown,
        elevation: 2,
        shadowColor: Color(0x1A000000), // Легкая тень
        surfaceTintColor: Colors.transparent,
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: darkBrown,
        ),
      ),

      // TabBar тема - для белого AppBar
      tabBarTheme: const TabBarThemeData(
        labelColor: primaryBrown, // Синий цвет для активной вкладки
        unselectedLabelColor: Color(0x80000000), // Серый для неактивной вкладки
        indicatorColor: primaryBrown, // Синий индикатор
        labelStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        unselectedLabelStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
      ),

      // Карточки
      cardTheme: const CardThemeData(
        color: creamWhite,
        elevation: 4,
        shadowColor: Color(0x335B7EF7), // primaryBrown с прозрачностью
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
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
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
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
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: primaryBrown,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
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
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
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
      iconTheme: const IconThemeData(color: darkBrown, size: 24),

      // Чипы
      chipTheme: ChipThemeData(
        backgroundColor: lightBrown.withOpacity(0.2),
        selectedColor: primaryBrown,
        labelStyle: const TextStyle(color: darkBrown),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),

      // Диалоги
      dialogTheme: const DialogThemeData(
        backgroundColor: creamWhite,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        titleTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: darkBrown,
        ),
      ),

      // Snackbar
      snackBarTheme: SnackBarThemeData(
        backgroundColor: darkBrown,
        contentTextStyle: const TextStyle(color: creamWhite),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  // Темная тема
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      primaryColor: darkPrimary,
      scaffoldBackgroundColor: const Color(0xFF0F172A), // Темно-синий фон

      colorScheme: const ColorScheme.dark(
        primary: darkPrimary, // Яркий синий
        secondary: darkSecondary, // Голубой акцент
        surface: Color(0xFF1E293B), // Темно-синяя поверхность
        background: Color(0xFF0F172A), // Темно-синий фон
        error: errorRed,
        onPrimary: creamWhite,
        onSecondary: creamWhite,
        onSurface: creamWhite,
        onBackground: creamWhite,
        onError: creamWhite,
        tertiary: darkAccent, // Светло-голубой акцент
        outline: darkOutline, // Светло-синий для границ
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
        backgroundColor: Color(0xFF1E293B), // Темно-синий AppBar
        foregroundColor: creamWhite,
        elevation: 2,
        shadowColor: Color(0x40000000),
        surfaceTintColor: Colors.transparent,
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: creamWhite,
        ),
      ),

      // TabBar тема для темной темы
      tabBarTheme: const TabBarThemeData(
        labelColor: darkPrimary, // Яркий синий для активной вкладки
        unselectedLabelColor: Color(
          0xB3FFFFFF,
        ), // Белый с прозрачностью для неактивной
        indicatorColor: darkPrimary, // Яркий синий индикатор
        labelStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        unselectedLabelStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
      ),

      cardTheme: const CardThemeData(
        color: Color(0xFF1E293B), // Темно-синие карточки
        elevation: 4,
        shadowColor: Color(0x4D000000), // Colors.black с прозрачностью 0.3
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: darkPrimary, // Яркий синий
          foregroundColor: creamWhite,
          elevation: 2,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: darkPrimary,
          side: const BorderSide(color: darkPrimary, width: 1.5),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: darkPrimary,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),
      ),

      // Поля ввода для темной темы
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color(0xFF1E293B),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: darkOutline),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: darkOutline),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: darkPrimary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: errorRed),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        hintStyle: TextStyle(color: creamWhite.withOpacity(0.6)),
      ),

      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Color(0xFF1E293B), // Темно-синяя навигация
        selectedItemColor: darkPrimary, // Яркий синий
        unselectedItemColor: Color(0xFF60A5FA), // Светло-синий
        type: BottomNavigationBarType.fixed,
        elevation: 8,
      ),

      // Иконки для темной темы
      iconTheme: const IconThemeData(color: creamWhite, size: 24),

      // Чипы для темной темы
      chipTheme: ChipThemeData(
        backgroundColor: darkPrimary.withOpacity(0.2),
        selectedColor: darkPrimary,
        labelStyle: const TextStyle(color: creamWhite),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),

      // Диалоги для темной темы
      dialogTheme: const DialogThemeData(
        backgroundColor: Color(0xFF1E293B),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        titleTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: creamWhite,
        ),
      ),

      // Snackbar для темной темы
      snackBarTheme: SnackBarThemeData(
        backgroundColor: const Color(0xFF1E293B),
        contentTextStyle: const TextStyle(color: creamWhite),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
