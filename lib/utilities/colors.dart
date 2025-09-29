import 'package:flutter/material.dart';

class AppColors {

  AppColors._();

  
  static const Color border = Color(0xFFE6E9EE);
  static const Color primary = Color(0xFF0EA5A4);
  static const Color secondary = Color(0xFFF1F5F9);
  static const Color success = Color(0xFF10B981);
  static const Color warning = Color(0xFFF97316);
  static const Color error = Color(0xFFEF4444);

  
  static const Color darkSecondary = Color(0xFF0B1220);
  static const Color darkCard = Color(0xFF111827);
  static const Color darkBorder = Color(0xFF1F2937);

  
  static Color getBorderColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark 
        ? darkBorder 
        : border;
  }

  static Color getSecondaryColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark 
        ? darkSecondary 
        : secondary;
  }

  static Color getCardColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark 
        ? darkCard 
        : Colors.white;
  }

  
  static const Color primaryColor = primary;
  static const Color successColor = success;
  static const Color warningColor = warning;
  static const Color errorColor = error;
}