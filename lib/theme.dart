import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Modern App theme configuration with neomorphic and glassmorphic influences
class AppTheme {
  // Primary and accent colors - modern palette
  static const Color primaryColor = Color(0xFF6C63FF); // Vibrant purple
  static const Color secondaryColor = Color(0xFFFF6584); // Coral pink
  static const Color accentColor = Color(0xFF43CBFF); // Bright cyan
  static const Color neutralColor = Color(0xFF2A2A2A); // Dark grey

  // Semantic colors
  static const Color errorColor = Color(0xFFFF5252); // Bright red
  static const Color successColor = Color(0xFF4CAF50); // Green
  static const Color warningColor = Color(0xFFFFB74D); // Orange

  // Text colors
  static const Color primaryTextColor = Color(0xFF303030);
  static const Color secondaryTextColor = Color(0xFF757575);
  static const Color lightTextColor = Color(0xFFFFFFFF);

  // Background colors
  static const Color backgroundColor = Color(0xFFF8F9FA);
  static const Color cardColor = Color(0xFFFFFFFF);
  static const Color dividerColor = Color(0xFFEEEEEE);

  // Gradient colors
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primaryColor, Color(0xFF8774FF)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient secondaryGradient = LinearGradient(
    colors: [secondaryColor, Color(0xFFFF8597)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  /// Light theme for the app
  static ThemeData get lightTheme {
    final baseTextTheme = GoogleFonts.poppinsTextTheme();

    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        brightness: Brightness.light,
        seedColor: primaryColor,
        primary: primaryColor,
        secondary: secondaryColor,
        tertiary: accentColor,
        error: errorColor,
        background: backgroundColor,
        onBackground: primaryTextColor,
        surface: cardColor,
        onSurface: primaryTextColor,
      ),

      // Typography with Google Fonts
      textTheme: TextTheme(
        headlineLarge: baseTextTheme.headlineLarge!.copyWith(
          fontWeight: FontWeight.bold,
          fontSize: 28,
          color: primaryTextColor,
          letterSpacing: -0.5,
        ),
        headlineMedium: baseTextTheme.headlineMedium!.copyWith(
          fontWeight: FontWeight.bold,
          fontSize: 24,
          color: primaryTextColor,
          letterSpacing: -0.5,
        ),
        titleLarge: baseTextTheme.titleLarge!.copyWith(
          fontWeight: FontWeight.bold,
          fontSize: 20,
          color: primaryTextColor,
        ),
        titleMedium: baseTextTheme.titleMedium!.copyWith(
          fontWeight: FontWeight.w500,
          fontSize: 16,
          color: primaryTextColor,
        ),
        bodyLarge: baseTextTheme.bodyLarge!.copyWith(
          fontSize: 16,
          color: primaryTextColor,
        ),
        bodyMedium: baseTextTheme.bodyMedium!.copyWith(
          fontSize: 14,
          color: primaryTextColor,
        ),
        labelLarge: baseTextTheme.labelLarge!.copyWith(
          fontWeight: FontWeight.w500,
          fontSize: 14,
          color: primaryColor,
          letterSpacing: 0.5,
        ),
      ),

      // AppBar theme - modern and clean
      appBarTheme: AppBarTheme(
        backgroundColor: primaryColor,
        foregroundColor: lightTextColor,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: GoogleFonts.poppins(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          letterSpacing: 0,
          color: lightTextColor,
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(16)),
        ),
      ),

      // Card theme - soft shadows and rounded corners
      cardTheme: CardTheme(
        elevation: 4,
        shadowColor: Colors.black.withOpacity(0.1),
        clipBehavior: Clip.antiAlias,
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),

      // Elevated button theme - gradient background
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith<Color>((states) {
            if (states.contains(MaterialState.disabled)) {
              return primaryColor.withOpacity(0.3);
            }
            return primaryColor;
          }),
          foregroundColor: MaterialStateProperty.all(lightTextColor),
          padding: MaterialStateProperty.all(
            const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          ),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
          elevation: MaterialStateProperty.all(2),
          overlayColor: MaterialStateProperty.all(
            Colors.white.withOpacity(0.1),
          ),
        ),
      ),

      // Text button theme
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all(primaryColor),
          padding: MaterialStateProperty.all(
            const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          ),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          textStyle: MaterialStateProperty.all(
            GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 14),
          ),
        ),
      ),

      // Input decoration theme - clean and minimal
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: cardColor,
        contentPadding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 16,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: primaryColor, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: errorColor, width: 1),
        ),
        labelStyle: GoogleFonts.poppins(
          color: secondaryTextColor,
          fontWeight: FontWeight.w500,
        ),
        hintStyle: GoogleFonts.poppins(
          color: secondaryTextColor.withOpacity(0.7),
        ),
        floatingLabelStyle: GoogleFonts.poppins(
          color: primaryColor,
          fontWeight: FontWeight.w500,
        ),
      ),

      // Floating action button theme - gradient background
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: secondaryColor,
        foregroundColor: lightTextColor,
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),

      // Scaffold background color
      scaffoldBackgroundColor: backgroundColor,

      // Divider theme
      dividerTheme: const DividerThemeData(
        color: dividerColor,
        thickness: 1,
        space: 24,
      ),

      // Snackbar theme - modern and rounded
      snackBarTheme: SnackBarThemeData(
        backgroundColor: neutralColor.withOpacity(0.9),
        contentTextStyle: GoogleFonts.poppins(
          color: lightTextColor,
          fontSize: 14,
        ),
        actionTextColor: accentColor,
        behavior: SnackBarBehavior.floating,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
      ),

      // Progress indicator theme
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: primaryColor,
        circularTrackColor: dividerColor,
        linearTrackColor: dividerColor,
      ),

      // Icon theme
      iconTheme: const IconThemeData(color: primaryColor, size: 24),

      // Bottom navigation bar theme
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: cardColor,
        selectedItemColor: primaryColor,
        unselectedItemColor: secondaryTextColor,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
      ),

      // Checkbox theme
      checkboxTheme: CheckboxThemeData(
        fillColor: MaterialStateProperty.resolveWith<Color>((states) {
          if (states.contains(MaterialState.selected)) {
            return primaryColor;
          }
          return Colors.transparent;
        }),
        side: const BorderSide(color: secondaryTextColor),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      ),

      // List tile theme
      listTileTheme: const ListTileThemeData(
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
      ),
    );
  }

  /// Dark theme for the app
  static ThemeData get darkTheme {
    final baseTextTheme = GoogleFonts.poppinsTextTheme();
    const darkCardColor = Color(0xFF2C2C2C);
    const darkBackgroundColor = Color(0xFF1E1E1E);

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: ColorScheme.fromSeed(
        brightness: Brightness.dark,
        seedColor: primaryColor,
        primary: primaryColor,
        secondary: secondaryColor,
        tertiary: accentColor,
        error: errorColor,
        background: darkBackgroundColor,
        onBackground: lightTextColor,
        surface: darkCardColor,
        onSurface: lightTextColor,
      ),

      // Typography with Google Fonts
      textTheme: TextTheme(
        headlineLarge: baseTextTheme.headlineLarge!.copyWith(
          fontWeight: FontWeight.bold,
          fontSize: 28,
          color: lightTextColor,
          letterSpacing: -0.5,
        ),
        headlineMedium: baseTextTheme.headlineMedium!.copyWith(
          fontWeight: FontWeight.bold,
          fontSize: 24,
          color: lightTextColor,
          letterSpacing: -0.5,
        ),
        titleLarge: baseTextTheme.titleLarge!.copyWith(
          fontWeight: FontWeight.bold,
          fontSize: 20,
          color: lightTextColor,
        ),
        titleMedium: baseTextTheme.titleMedium!.copyWith(
          fontWeight: FontWeight.w500,
          fontSize: 16,
          color: lightTextColor,
        ),
        bodyLarge: baseTextTheme.bodyLarge!.copyWith(
          fontSize: 16,
          color: lightTextColor.withOpacity(0.9),
        ),
        bodyMedium: baseTextTheme.bodyMedium!.copyWith(
          fontSize: 14,
          color: lightTextColor.withOpacity(0.9),
        ),
        labelLarge: baseTextTheme.labelLarge!.copyWith(
          fontWeight: FontWeight.w500,
          fontSize: 14,
          color: accentColor,
          letterSpacing: 0.5,
        ),
      ),

      // AppBar theme
      appBarTheme: AppBarTheme(
        backgroundColor: darkCardColor,
        foregroundColor: lightTextColor,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: GoogleFonts.poppins(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          letterSpacing: 0,
          color: lightTextColor,
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(16)),
        ),
      ),

      // Card theme
      cardTheme: CardTheme(
        color: darkCardColor,
        elevation: 4,
        shadowColor: Colors.black.withOpacity(0.2),
        clipBehavior: Clip.antiAlias,
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),

      // Scaffold background color
      scaffoldBackgroundColor: darkBackgroundColor,

      // Input decoration theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: darkCardColor.withOpacity(0.7),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 16,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: primaryColor, width: 2),
        ),
        labelStyle: GoogleFonts.poppins(
          color: lightTextColor.withOpacity(0.7),
          fontWeight: FontWeight.w500,
        ),
        hintStyle: GoogleFonts.poppins(color: lightTextColor.withOpacity(0.5)),
      ),
    );
  }
}
