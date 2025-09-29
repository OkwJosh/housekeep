import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:housekeep/utilities/colors.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final Widget? leading;
  final List<Widget>? actions;
  final bool centerTitle;
  final double elevation;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final PreferredSizeWidget? bottom;
  final bool automaticallyImplyLeading;
  final VoidCallback? onLeadingPressed;
  final TextStyle? titleStyle;

  const CustomAppbar({
    super.key,
    this.title,
    this.leading,
    this.actions,
    this.centerTitle = true,
    this.elevation = 0,
    this.backgroundColor,
    this.foregroundColor,
    this.bottom,
    this.automaticallyImplyLeading = true,
    this.onLeadingPressed,
    this.titleStyle,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final defaultBackgroundColor = isDark ? AppColors.darkCard : Colors.white;
    final defaultForegroundColor = isDark ? Colors.white : Colors.black87;

    return AppBar(
      title: title != null
          ? Text(
              title!,
              style: titleStyle ??
                  GoogleFonts.spaceGrotesk(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: foregroundColor ?? defaultForegroundColor,
                  ),
            )
          : null,
      leading: leading ??
          (automaticallyImplyLeading && Navigator.of(context).canPop()
              ? IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: foregroundColor ?? defaultForegroundColor,
                    size: 20,
                  ),
                  onPressed: onLeadingPressed ?? () => Navigator.of(context).pop(),
                )
              : null),
      actions: actions,
      centerTitle: centerTitle,
      elevation: elevation,
      backgroundColor: backgroundColor ?? defaultBackgroundColor,
      foregroundColor: foregroundColor ?? defaultForegroundColor,
      bottom: bottom,
      automaticallyImplyLeading: false, // We handle this manually
      systemOverlayStyle: isDark
          ? SystemUiOverlayStyle.light
          : SystemUiOverlayStyle.dark,
      surfaceTintColor: Colors.transparent, // Removes Material 3 color tint
      shadowColor: isDark ? Colors.black54 : Colors.black12,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(
        kToolbarHeight + (bottom?.preferredSize.height ?? 0.0),
      );
}


class CustomAppbarWithProfile extends CustomAppbar {
  final VoidCallback? onProfilePressed;
  final String? profileImageUrl;
  final Widget? profileWidget;

  const CustomAppbarWithProfile({
    super.key,
    super.title,
    super.leading,
    super.centerTitle,
    super.elevation,
    super.backgroundColor,
    super.foregroundColor,
    super.automaticallyImplyLeading,
    super.onLeadingPressed,
    super.titleStyle,
    this.onProfilePressed,
    this.profileImageUrl,
    this.profileWidget,
  });

  @override
  Widget build(BuildContext context) {
    return CustomAppbar(
      title: title,
      leading: leading,
      centerTitle: centerTitle,
      elevation: elevation,
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      automaticallyImplyLeading: automaticallyImplyLeading,
      onLeadingPressed: onLeadingPressed,
      titleStyle: titleStyle,
      actions: [
        GestureDetector(
          onTap: onProfilePressed,
          child: profileWidget ??
              Container(
                width: 36,
                height: 36,
                margin: const EdgeInsets.only(right: 16),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.getBorderColor(context),
                    width: 2,
                  ),
                ),
                child: profileImageUrl != null
                    ? ClipOval(
                        child: Image.network(
                          profileImageUrl!,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              const Icon(Icons.person, size: 20),
                        ),
                      )
                    : const Icon(Icons.person, size: 20),
              ),
        ),
      ],
    );
  }
}

class CustomAppbarWithMenu extends CustomAppbar {
  final VoidCallback? onMenuPressed;
  final VoidCallback? onNotificationPressed;
  final int? notificationCount;

  const CustomAppbarWithMenu({
    super.key,
    super.title,
    super.centerTitle,
    super.elevation,
    super.backgroundColor,
    super.foregroundColor,
    super.titleStyle,
    this.onMenuPressed,
    this.onNotificationPressed,
    this.notificationCount,
  }) : super(
          automaticallyImplyLeading: false,
        );

  @override
  Widget build(BuildContext context) {
    return CustomAppbar(
      title: title,
      centerTitle: centerTitle,
      elevation: elevation,
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      titleStyle: titleStyle,
      automaticallyImplyLeading: false,
      leading: IconButton(
        icon: const Icon(Icons.menu_rounded),
        onPressed: onMenuPressed ?? () => Scaffold.of(context).openDrawer(),
      ),
      actions: [
        if (onNotificationPressed != null)
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.notifications_outlined),
                onPressed: onNotificationPressed,
              ),
              if (notificationCount != null && notificationCount! > 0)
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: AppColors.error,
                      shape: BoxShape.circle,
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 16,
                      minHeight: 16,
                    ),
                    child: Text(
                      notificationCount! > 99 ? '99+' : '$notificationCount',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),
        const SizedBox(width: 8),
      ],
    );
  }
}