import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../theme/app_colors.dart';
import '../../../../theme/app_text_styles.dart';
import '../../application/models/profile_models.dart';
import 'profile_assets.dart';

class ProfileQuestionCard extends StatelessWidget {
  const ProfileQuestionCard({
    super.key,
    required this.section,
    required this.question,
    required this.answer,
    this.isCompact = false,
    this.showActions = true,
    this.onTap,
    this.onPinTap,
  });

  final ProfileSection section;
  final ProfileQuestionModel question;
  final ProfileAnswerModel? answer;
  final bool isCompact;
  final bool showActions;
  final VoidCallback? onTap;
  final VoidCallback? onPinTap;

  @override
  Widget build(BuildContext context) {
    final category = question.category;
    final isPinned = answer?.isPinned ?? false;
    final text = answer?.answerText ??
        question.placeholderText ??
        question.questionText;
    final hasAnswer = answer?.answerText.trim().isNotEmpty ?? false;

    final categoryText = category ?? '';
    final hasCategory = categoryText.isNotEmpty;
    final overlaySpace = (hasCategory || showActions) ? 12.0 : 0.0;

    return Padding(
      padding: EdgeInsets.only(top: overlaySpace),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onTap,
              borderRadius: BorderRadius.circular(16),
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: isCompact ? 12 : 16,
                ),
                decoration: BoxDecoration(
                  color: AppColors.surfaceLight,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.borderLight),
                  boxShadow: const [
                    BoxShadow(
                      color: AppColors.cardShadowColor,
                      blurRadius: 12,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text(
                        text,
                        style: AppTextStyles.bodySmall.copyWith(
                          color: hasAnswer
                              ? AppColors.textPrimary
                              : AppColors.textTertiary,
                          fontWeight: hasAnswer
                              ? FontWeight.w600
                              : FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    if (!isCompact)
                      SvgPicture.asset(
                        text.isEmpty
                            ? ProfileAssets.iconEdit
                            : ProfileAssets.iconEditActive,
                        width: 12,
                        height: 12,
                      ),
                    if (showActions) ...[
                      const SizedBox(width: 10),
                      Column(
                        children: [
                          Text(
                            '0',
                            style:
                                AppTextStyles.labelSmall.copyWith(fontSize: 8),
                          ),
                          const SizedBox(height: 4),
                          SvgPicture.asset(
                            ProfileAssets.iconHeart,
                            width: 10,
                            height: 10,
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
          if (hasCategory)
            Positioned(
              left: 14,
              top: -12,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.primaryPink,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: const [
                    BoxShadow(
                      color: AppColors.cardShadowColor,
                      blurRadius: 6,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Text(
                  categoryText,
                  style: AppTextStyles.labelSmall.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          if (showActions)
            Positioned(
              right: 12,
              top: -12,
              child: GestureDetector(
                onTap: onPinTap,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceLight,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AppColors.borderLight),
                    boxShadow: const [
                      BoxShadow(
                        color: AppColors.cardShadowColor,
                        blurRadius: 6,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: SvgPicture.asset(
                    ProfileAssets.iconPin,
                    width: 12,
                    height: 12,
                    colorFilter: ColorFilter.mode(
                      isPinned ? AppColors.primaryDark : AppColors.textTertiary,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
