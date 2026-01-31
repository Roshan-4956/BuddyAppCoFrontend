import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../common/widgets/generated_avatar.dart';
import '../../../../theme/app_colors.dart';
import '../../../../theme/app_text_styles.dart';
import '../../../../utils/image_source_utils.dart';
import '../../application/models/profile_models.dart';
import 'profile_assets.dart';

class ProfileSummaryCard extends StatelessWidget {
  const ProfileSummaryCard({
    super.key,
    required this.profile,
    required this.tagline,
    this.buddiesCount,
    this.eventsCount,
    this.communitiesCount,
  });

  final ProfileViewModel? profile;
  final String? tagline;
  final int? buddiesCount;
  final int? eventsCount;
  final int? communitiesCount;

  @override
  Widget build(BuildContext context) {
    final fullName = profile == null
        ? ''
        : '${profile!.firstName} ${profile!.lastName}'.trim();
    final age = profile == null ? null : _calculateAge(profile!.dateOfBirth);
    final avatarImage =
        ImageSourceUtils.resolveProviderOrNull(profile?.profilePhotoUrl);
    final seed = (profile?.userId ?? profile?.firstName ?? '')
            .trim()
            .isEmpty
        ? DateTime.now().millisecondsSinceEpoch.toString()
        : (profile?.userId ?? profile?.firstName ?? '');
    final showStats =
        buddiesCount != null || eventsCount != null || communitiesCount != null;
    final hasTagline = tagline != null && tagline!.trim().isNotEmpty;

    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.topCenter,
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(16, 64, 16, 16),
          decoration: BoxDecoration(
            color: AppColors.surfaceLight,
            borderRadius: BorderRadius.circular(16),
            boxShadow: const [
              BoxShadow(
                color: AppColors.cardShadowColor,
                blurRadius: 18,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Stack(
            children: [
              Positioned(
                right: 0,
                top: 0,
                child: age == null
                    ? const SizedBox.shrink()
                    : Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primaryYellow,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          'Age $age',
                          style: AppTextStyles.labelSmall.copyWith(
                            fontSize: 10,
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (fullName.isNotEmpty) ...[
                    const SizedBox(height: 12),
                Text(
                  fullName,
                  style: AppTextStyles.headlineMedium.copyWith(fontSize: 20),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                  ],
                  if (hasTagline) ...[
                    const SizedBox(height: 6),
                Text(
                  tagline!,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.textTertiary,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                  ],
                  if (showStats) ...[
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (buddiesCount != null)
                          _StatCard(label: 'Buddies', value: buddiesCount!),
                        if (buddiesCount != null && eventsCount != null)
                          const SizedBox(width: 8),
                        if (eventsCount != null)
                          _StatCard(label: 'Events', value: eventsCount!),
                        if ((buddiesCount != null || eventsCount != null) &&
                            communitiesCount != null)
                          const SizedBox(width: 8),
                        if (communitiesCount != null)
                          _StatCard(
                            label: 'Communities',
                            value: communitiesCount!,
                          ),
                      ],
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
        Positioned(
          top: -56,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              CircleAvatar(
                radius: 56,
                backgroundColor: AppColors.primaryPink,
                backgroundImage: avatarImage,
                onBackgroundImageError:
                    avatarImage == null ? null : (_, __) {},
                child: avatarImage == null
                    ? GeneratedAvatar(seed: seed, size: 112)
                    : null,
              ),
              Positioned(
                right: 6,
                bottom: 6,
                child: SvgPicture.asset(
                  ProfileAssets.avatarEdit,
                  width: 13,
                  height: 13,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  int _calculateAge(DateTime dob) {
    final today = DateTime.now();
    int age = today.year - dob.year;
    if (today.month < dob.month ||
        (today.month == dob.month && today.day < dob.day)) {
      age -= 1;
    }
    return age;
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({required this.label, required this.value});

  final String label;
  final int value;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 74,
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.statCardBg,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.borderLight),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '$value',
            style: AppTextStyles.labelLarge.copyWith(
              color: AppColors.primaryDark,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: AppTextStyles.labelSmall.copyWith(
              color: AppColors.textTertiary,
              fontSize: 8,
            ),
          ),
        ],
      ),
    );
  }
}
