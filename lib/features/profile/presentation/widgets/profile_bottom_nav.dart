import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../theme/app_colors.dart';
import '../../../../theme/app_text_styles.dart';
import 'profile_assets.dart';

class ProfileBottomNav extends StatelessWidget {
  const ProfileBottomNav({super.key, this.currentIndex = 2, this.onTap});

  final int currentIndex;
  final ValueChanged<int>? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: AppColors.bottomBarShadowColor,
            blurRadius: 4,
            offset: Offset(0, -1),
          ),
        ],
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: onTap,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
        backgroundColor: AppColors.white,
        selectedItemColor: AppColors.primaryDark,
        unselectedItemColor: AppColors.textTertiary,
        selectedLabelStyle: AppTextStyles.labelSmall.copyWith(fontSize: 9),
        unselectedLabelStyle: AppTextStyles.labelSmall.copyWith(fontSize: 9),
        items: [
          BottomNavigationBarItem(
            icon: _NavIcon(
              assetPath: ProfileAssets.navHome,
              color: AppColors.textTertiary,
            ),
            activeIcon: _NavIcon(
              assetPath: ProfileAssets.navHome,
              color: AppColors.primaryDark,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: _NavIcon(
              assetPath: ProfileAssets.navCommunity,
              color: AppColors.textTertiary,
            ),
            activeIcon: _NavIcon(
              assetPath: ProfileAssets.navCommunity,
              color: AppColors.primaryDark,
            ),
            label: 'Community',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(ProfileAssets.navNudge, width: 20, height: 20),
            label: 'Nudge',
          ),
          BottomNavigationBarItem(
            icon: _NavIcon(
              assetPath: ProfileAssets.navMessages,
              color: AppColors.textTertiary,
            ),
            activeIcon: _NavIcon(
              assetPath: ProfileAssets.navMessages,
              color: AppColors.primaryDark,
            ),
            label: 'Messages',
          ),
          BottomNavigationBarItem(
            icon: _EventsIcon(color: AppColors.textTertiary),
            activeIcon: _EventsIcon(color: AppColors.primaryDark),
            label: 'Events',
          ),
        ],
      ),
    );
  }
}

class _NavIcon extends StatelessWidget {
  const _NavIcon({required this.assetPath, required this.color});

  final String assetPath;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      assetPath,
      width: 18,
      height: 18,
      colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
    );
  }
}

class _EventsIcon extends StatelessWidget {
  const _EventsIcon({required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        SvgPicture.asset(
          ProfileAssets.navEvents,
          width: 16,
          height: 16,
          colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
        ),
        Positioned(
          right: -1,
          bottom: -1,
          child: SvgPicture.asset(
            ProfileAssets.navEventsStar,
            width: 4,
            height: 4,
            colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
          ),
        ),
      ],
    );
  }
}
