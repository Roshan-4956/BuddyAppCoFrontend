import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../common/widgets/generated_avatar.dart';
import '../../../../theme/app_colors.dart';
import '../../../../theme/app_text_styles.dart';
import '../../../../utils/image_source_utils.dart';
import '../../application/models/profile_models.dart';
import 'profile_assets.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key, required this.profile});

  final ProfileViewModel? profile;

  @override
  Widget build(BuildContext context) {
    final name = profile?.firstName;
    final trimmedName = name?.trim() ?? '';
    final displayName = trimmedName.isEmpty ? 'Hi' : 'Hi $trimmedName';
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                displayName,
                style: AppTextStyles.headlineMedium.copyWith(
                  color: AppColors.primaryDark,
                  fontSize: 24,
                  height: 1.1,
                ),
              ),
            ],
          ),
        ),
        Row(
          children: [
            _CircleIconButton(
              assetPath: ProfileAssets.iconWallet,
              onTap: () {},
            ),
            const SizedBox(width: 8),
            _CircleIconButton(
              assetPath: ProfileAssets.iconNotifications,
              onTap: () {},
            ),
            const SizedBox(width: 8),
            _ProfileAvatar(
              profilePhotoUrl: profile?.profilePhotoUrl,
              seed: profile?.userId ?? profile?.firstName ?? '',
            ),
          ],
        ),
      ],
    );
  }
}

class _CircleIconButton extends StatelessWidget {
  const _CircleIconButton({
    required this.assetPath,
    required this.onTap,
  });

  final String assetPath;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(20),
          child: Container(
            height: 28,
            width: 28,
            decoration: const BoxDecoration(
              color: AppColors.primaryDark,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: SvgPicture.asset(
                assetPath,
                width: 14,
                height: 14,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _ProfileAvatar extends StatelessWidget {
  const _ProfileAvatar({required this.profilePhotoUrl, required this.seed});

  final String? profilePhotoUrl;
  final String seed;

  @override
  Widget build(BuildContext context) {
    final imageProvider =
        ImageSourceUtils.resolveProviderOrNull(profilePhotoUrl);
    final resolvedSeed = seed.trim().isEmpty
        ? DateTime.now().millisecondsSinceEpoch.toString()
        : seed;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        CircleAvatar(
          radius: 13.5,
          backgroundColor: AppColors.primaryPink,
          backgroundImage: imageProvider,
          onBackgroundImageError:
              imageProvider == null ? null : (_, __) {},
          child: imageProvider == null
              ? GeneratedAvatar(seed: resolvedSeed, size: 27)
              : null,
        ),
        Positioned(
          right: -1,
          bottom: -1,
          child: SvgPicture.asset(
            ProfileAssets.iconAvatarDot,
            width: 6,
            height: 6,
          ),
        ),
      ],
    );
  }
}
