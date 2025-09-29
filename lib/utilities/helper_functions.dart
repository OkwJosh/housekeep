import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class AppHelpers {
  // Private constructor to prevent instantiation
  AppHelpers._();

  // Screen Dimensions
  static double getScreenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static double getScreenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static Size getScreenSize(BuildContext context) {
    return MediaQuery.of(context).size;
  }

  static double getStatusBarHeight(BuildContext context) {
    return MediaQuery.of(context).padding.top;
  }

  static double getBottomPadding(BuildContext context) {
    return MediaQuery.of(context).padding.bottom;
  }

  static bool isKeyboardVisible(BuildContext context) {
    return MediaQuery.of(context).viewInsets.bottom > 0;
  }

  static double getKeyboardHeight(BuildContext context) {
    return MediaQuery.of(context).viewInsets.bottom;
  }

  // Device Orientation
  static bool isPortrait(BuildContext context) {
    return MediaQuery.of(context).orientation == Orientation.portrait;
  }

  static bool isLandscape(BuildContext context) {
    return MediaQuery.of(context).orientation == Orientation.landscape;
  }

  // Responsive helpers
  static bool isSmallScreen(BuildContext context) {
    return getScreenWidth(context) < 600;
  }

  static bool isTablet(BuildContext context) {
    return getScreenWidth(context) >= 600 && getScreenWidth(context) < 1200;
  }

  static bool isDesktop(BuildContext context) {
    return getScreenWidth(context) >= 1200;
  }

  // URL Launcher
  static Future<bool> launchURL(String url) async {
    try {
      final uri = Uri.parse(url);
      return await launchUrl(uri);
    } catch (e) {
      debugPrint('Error launching URL: $e');
      return false;
    }
  }

  static Future<bool> launchPhone(String phoneNumber) async {
    return await launchURL('tel:$phoneNumber');
  }

  static Future<bool> launchEmail(String email, {String? subject, String? body}) async {
    String emailUrl = 'mailto:$email';
    if (subject != null || body != null) {
      emailUrl += '?';
      if (subject != null) emailUrl += 'subject=${Uri.encodeComponent(subject)}';
      if (subject != null && body != null) emailUrl += '&';
      if (body != null) emailUrl += 'body=${Uri.encodeComponent(body)}';
    }
    return await launchURL(emailUrl);
  }

  static Future<bool> launchSMS(String phoneNumber, {String? message}) async {
    String smsUrl = 'sms:$phoneNumber';
    if (message != null) {
      smsUrl += '?body=${Uri.encodeComponent(message)}';
    }
    return await launchURL(smsUrl);
  }

  // Clipboard operations
  static Future<void> copyToClipboard(String text) async {
    await Clipboard.setData(ClipboardData(text: text));
  }

  static Future<String?> getFromClipboard() async {
    final clipboardData = await Clipboard.getData(Clipboard.kTextPlain);
    return clipboardData?.text;
  }

 
  static void lightHaptic() {
    HapticFeedback.lightImpact();
  }

  static void mediumHaptic() {
    HapticFeedback.mediumImpact();
  }

  static void heavyHaptic() {
    HapticFeedback.heavyImpact();
  }

  static void selectionHaptic() {
    HapticFeedback.selectionClick();
  }


  static void pushPage(BuildContext context, Widget page) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => page),
    );
  }

  static void pushReplacementPage(BuildContext context, Widget page) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => page),
    );
  }

  static void pushAndClearStack(BuildContext context, Widget page) {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => page),
      (route) => false,
    );
  }

  static void popPage(BuildContext context) {
    if (Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
    }
  }


  static void showSnackBar(
    BuildContext context,
    String message, {
    Color? backgroundColor,
    Duration duration = const Duration(seconds: 3),
    SnackBarAction? action,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: backgroundColor,
        duration: duration,
        action: action,
      ),
    );
  }

  static void showErrorSnackBar(BuildContext context, String message) {
    showSnackBar(
      context,
      message,
      backgroundColor: Colors.red,
    );
  }

  static void showSuccessSnackBar(BuildContext context, String message) {
    showSnackBar(
      context,
      message,
      backgroundColor: Colors.green,
    );
  }

  static Future<bool?> showConfirmDialog(
    BuildContext context, {
    required String title,
    required String content,
    String confirmText = 'Yes',
    String cancelText = 'No',
  }) async {
    return await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(cancelText),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(confirmText),
          ),
        ],
      ),
    );
  }



  static String formatDate(DateTime date, {String pattern = 'dd/MM/yyyy'}) {
    
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
  }

  static bool isToday(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year && date.month == now.month && date.day == now.day;
  }

  static bool isYesterday(DateTime date) {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return date.year == yesterday.year && date.month == yesterday.month && date.day == yesterday.day;
  }


  static bool isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  static bool isValidPhone(String phone) {
    return RegExp(r'^\+?[\d\s\-\(\)]+$').hasMatch(phone);
  }

  static bool isValidURL(String url) {
    try {
      Uri.parse(url);
      return url.startsWith('http://') || url.startsWith('https://');
    } catch (e) {
      return false;
    }
  }

  static String capitalize(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1).toLowerCase();
  }

  static String truncateText(String text, int maxLength) {
    if (text.length <= maxLength) return text;
    return '${text.substring(0, maxLength)}...';
  }


  static bool isDarkMode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  static Color getTextColor(BuildContext context) {
    return Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black;
  }
}