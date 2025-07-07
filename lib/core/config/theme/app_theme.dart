import 'package:flutter/material.dart';

const seedColor = Color.fromARGB(255, 70, 153, 227);

class AppTheme {
  final bool isDarkmode;

  AppTheme({required this.isDarkmode});

  // Colores personalizados de AquaInspector
  static const Color primaryBlue = Color.fromARGB(255, 119, 178, 226);
  static const Color darkBlue = Color.fromARGB(255, 18, 95, 172);
  static const Color lightBlue = Color.fromARGB(255, 70, 153, 227);

  // Colores adicionales
  static const Color surfaceColor = Color.fromARGB(255, 214, 238, 249);
  static const Color errorColor = Colors.red;
  static const Color successColor = Colors.green;
  static const Color warningColor = Colors.orange;

  // Colores para modo oscuro - Paleta mejorada
  static const Color darkBackground = Color.fromARGB(255, 12, 12, 12); // Fondo principal muy oscuro
  static const Color darkSurfaceColor = Color.fromARGB(255, 18, 18, 18); // Superficies (cards, etc.)
  static const Color darkSurfaceVariant = Color.fromARGB(255, 20, 30, 50); // Variante de superficie
  static const Color darkPrimaryBlue = Color.fromARGB(255, 60, 135, 211); // Azul principal más brillante
  static const Color darkSecondaryBlue = Color.fromARGB(255, 130, 190, 250); // Azul secundario más claro
  static const Color darkAccentBlue = Color.fromARGB(255, 80, 160, 230); // Azul de acento

  // Estados y acciones para modo oscuro
  static const Color darkError = Color.fromARGB(255, 255, 99, 99); // Rojo más suave
  static const Color darkSuccess = Color.fromARGB(255, 102, 255, 102); // Verde más brillante
  static const Color darkWarning = Color.fromARGB(255, 255, 193, 99); // Naranja más suave

  // Textos para modo oscuro
  static const Color darkOnPrimary = Color.fromARGB(255, 255, 255, 255); // Texto sobre primario
  static const Color darkOnSurface = Color.fromARGB(255, 240, 240, 240); // Texto sobre superficie
  static const Color darkOnSurfaceVariant = Color.fromARGB(255, 200, 200, 200); // Texto secundario

  ThemeData getTheme() => ThemeData(
    // useMaterial3: true,
    // colorSchemeSeed: seedColor,
    brightness: isDarkmode ? Brightness.dark : Brightness.light,

    colorScheme: isDarkmode
        ? ColorScheme.dark(
            primary: darkPrimaryBlue, // Color principal
            secondary: darkSecondaryBlue, // Color secundario
            surface: darkBlue, // Superficie de cards
            // background: darkBackground, // Fondo general
            error: darkError, // Errores
            onPrimary: darkOnPrimary, // Texto sobre primario
            onSurface: darkOnSurface, // Texto sobre superficie
            // onBackground: darkOnSurface, // Texto sobre fondo
            onError: Colors.white, // Texto sobre error
            outline: darkOnSurfaceVariant, // Bordes
            // surfaceVariant: darkSurfaceVariant, // Variante de superficie
          )
        : ColorScheme.light(primary: primaryBlue, secondary: lightBlue, surface: surfaceColor, background: surfaceColor, error: errorColor),
    // Personalización del AppBar
    appBarTheme: AppBarTheme(
      backgroundColor: isDarkmode ? darkBlue : primaryBlue, // Color más oscuro para dark mode
      foregroundColor: Colors.white,
      elevation: 4,
      centerTitle: true,
      surfaceTintColor: Colors.transparent, // Evita tintes no deseados
    ),

    // Personalización de botones
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: isDarkmode ? darkPrimaryBlue : primaryBlue,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),

    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        backgroundColor: isDarkmode ? darkBlue : primaryBlue, // Color más sutil para dark mode
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),

    // Personalización de tarjetas
    cardTheme: CardThemeData(
      elevation: 30,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: isDarkmode ? const Color.fromARGB(255, 4, 95, 186) : const Color.fromARGB(90, 255, 255, 255),
    ),

    // Personalización de campos de texto
    inputDecorationTheme: InputDecorationTheme(
      fillColor: isDarkmode ? darkSurfaceColor : surfaceColor,
      filled: true,
      border: OutlineInputBorder(borderSide: BorderSide(color: isDarkmode ? const Color.fromARGB(255, 254, 254, 254) : Colors.grey)),
      prefixIconColor: isDarkmode ? const Color.fromARGB(255, 4, 4, 4) : Colors.grey,
      suffixIconColor: isDarkmode ? const Color.fromARGB(255, 2, 2, 2) : Colors.grey,
      labelStyle: TextStyle(color: isDarkmode ? const Color.fromARGB(255, 0, 0, 0) : Colors.grey), // Color del label
      hintStyle: TextStyle(color: isDarkmode ? const Color.fromARGB(255, 0, 0, 0) : Colors.grey),
      // Color del hint
    ),

    // Personalización del color del texto que escribe el usuario
    textTheme: TextTheme(
      bodyLarge: TextStyle(color: isDarkmode ? Colors.black : Colors.black),
      bodyMedium: TextStyle(color: isDarkmode ? Colors.black : Colors.black),
      bodySmall: TextStyle(color: isDarkmode ? Colors.black : Colors.black),
      labelLarge: TextStyle(color: isDarkmode ? Colors.black : Colors.black),
      labelMedium: TextStyle(color: isDarkmode ? Colors.black : Colors.black),
      labelSmall: TextStyle(color: isDarkmode ? Colors.black : Colors.black),
    ),

    listTileTheme: ListTileThemeData(iconColor: isDarkmode ? darkAccentBlue : seedColor),
  );

  // Método para obtener el gradiente de fondo
  static LinearGradient getBackgroundGradient(bool isDarkMode) {
    return LinearGradient(
      colors: isDarkMode
          ? [
              darkBlue,
              Color.fromARGB(255, 29, 45, 74), // Negro casi puro abajo
            ]
          : [primaryBlue, darkBlue], // Gradiente original para modo claro
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    );
  }
}
