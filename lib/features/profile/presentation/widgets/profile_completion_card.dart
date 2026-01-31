import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../theme/app_colors.dart';
import '../../../../theme/app_text_styles.dart';
import '../../application/models/profile_models.dart';
import 'profile_assets.dart';

class ProfileCompletionCard extends StatelessWidget {
  const ProfileCompletionCard({super.key, required this.completion});

  final ProfileCompletionModel? completion;

  @override
  Widget build(BuildContext context) {
    if (completion == null) {
      return const SizedBox.shrink();
    }

    final completionValue = completion!.completionPercentage;

    return Container(
      padding: const EdgeInsets.fromLTRB(16, 16, 12, 16),
      decoration: BoxDecoration(
        color: AppColors.primaryYellow,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Your profile is ${completionValue.toStringAsFixed(0)}% complete',
                  style: AppTextStyles.bodyLarge.copyWith(
                    color: AppColors.white,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  '*min. three questions need to be answered and one needs to be pinned',
                  style: AppTextStyles.labelSmall.copyWith(
                    color: AppColors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 12),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: LinearProgressIndicator(
                    minHeight: 4,
                    value: (completionValue / 100).clamp(0.0, 1.0),
                    backgroundColor: AppColors.progressTrack,
                    valueColor: const AlwaysStoppedAnimation<Color>(
                      AppColors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          SvgPicture.asset(
            ProfileAssets.completionIllustration,
            width: 92,
            height: 72,
            fit: BoxFit.contain,
          ),
        ],
      ),
    );
  }
}
