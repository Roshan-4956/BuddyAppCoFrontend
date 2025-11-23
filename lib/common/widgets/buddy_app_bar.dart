import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'buddy_app_bar_logo.dart';

/// Reusable AppBar widget with consistent styling across the app
class BuddyAppBar extends StatelessWidget implements PreferredSizeWidget {
  /// Creates a BuddyAppBar
  const BuddyAppBar({
    super.key,
    this.title,
    this.showBackButton = true,
    this.onBackPressed,
    this.backgroundColor,
    this.elevation = 0,
    this.centerTitle = true,
    this.transparent = false,
    this.actions,
  });

  /// Custom title widget. If null, defaults to BuddyAppBarLogo
  final Widget? title;

  /// Whether to show the back button
  final bool showBackButton;

  /// Custom back button handler. If null, uses context.pop()
  final VoidCallback? onBackPressed;

  /// AppBar background color. If null, uses theme's AppBar color
  final Color? backgroundColor;

  /// AppBar elevation
  final double elevation;

  /// Whether to center the title
  final bool centerTitle;

  /// Whether to make the AppBar transparent
  final bool transparent;

  /// Optional action buttons
  final List<Widget>? actions;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AppBar(
      backgroundColor: transparent ? Colors.transparent : backgroundColor,
      elevation: elevation,
      centerTitle: centerTitle,
      title: title ?? const BuddyAppBarLogo(),
      leading: showBackButton
          ? Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: theme.colorScheme.onSurface,
                  size: 24,
                ),
                onPressed: onBackPressed ?? () => context.pop(),
              ),
            )
          : null,
      actions: actions,
    );
  }
}
