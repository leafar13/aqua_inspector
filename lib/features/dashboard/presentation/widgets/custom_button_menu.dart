import 'package:flutter/material.dart';

class CustomButtonMenu extends StatelessWidget {
  const CustomButtonMenu({super.key, required this.tittle, required this.onPressed, required this.icon});

  final String tittle;
  final Function() onPressed;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      width: 150,
      height: 150,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: theme.colorScheme.primary,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)), // Añadimos una sombra sutil
          elevation: 4,
          shadowColor: theme.colorScheme.primary.withValues(alpha: 0.3),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: Colors.white,
              size: 60, // Ícono aún más grande
            ),
            SizedBox(height: 12),
            Text(
              tittle,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
