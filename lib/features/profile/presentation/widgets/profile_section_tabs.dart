import 'package:flutter/material.dart';
import '../../../../common/widgets/error_message.dart';
import '../../../../common/widgets/loading_indicator.dart';
import '../../../../theme/app_colors.dart';
import '../../../../theme/app_text_styles.dart';
import '../../application/models/profile_models.dart';
import 'profile_interest_chip.dart';
import 'profile_question_card.dart';

class ProfileSectionTabs extends StatelessWidget {
  const ProfileSectionTabs({
    super.key,
    required this.controller,
    required this.section,
    required this.questions,
    required this.answersByQuestionId,
    required this.interests,
    required this.isLoading,
    required this.errorMessage,
    this.onQuestionTap,
    this.onPinTap,
  });

  final TabController controller;
  final ProfileSection section;
  final List<ProfileQuestionModel> questions;
  final Map<int, ProfileAnswerModel> answersByQuestionId;
  final List<ProfileInterestModel> interests;
  final bool isLoading;
  final String? errorMessage;
  final void Function(ProfileQuestionModel, ProfileAnswerModel?)? onQuestionTap;
  final void Function(ProfileQuestionModel, ProfileAnswerModel?)? onPinTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 16),
      decoration: BoxDecoration(
        color: AppColors.surfaceLight,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: AppColors.cardShadowColor,
            blurRadius: 24,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LayoutBuilder(
            builder: (context, constraints) {
              const indicatorWidth = 52.0;
              final tabWidth = constraints.maxWidth / 3;
              final left =
                  tabWidth * controller.index + (tabWidth - indicatorWidth) / 2;
              return SizedBox(
                height: 34,
                child: Stack(
                  children: [
                    TabBar(
                      controller: controller,
                      indicatorColor: Colors.transparent,
                      dividerColor: Colors.transparent,
                      dividerHeight: 0,
                      labelColor: AppColors.primaryDark,
                      labelStyle: AppTextStyles.bodySmall.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                      unselectedLabelColor: AppColors.textTertiary,
                      unselectedLabelStyle: AppTextStyles.bodySmall,
                      tabs: const [
                        Tab(text: 'About'),
                        Tab(text: 'Relocation Qns'),
                        Tab(text: 'Recommendations'),
                      ],
                    ),
                    AnimatedPositioned(
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.easeInOut,
                      left: left,
                      bottom: 0,
                      child: Container(
                        width: indicatorWidth,
                        height: 2,
                        decoration: BoxDecoration(
                          color: AppColors.primaryDark,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          const SizedBox(height: 12),
          if (section == ProfileSection.about) ...[
            _buildInterests(),
            const SizedBox(height: 12),
          ],
          if (isLoading)
            const LoadingIndicator(size: 28)
          else if (errorMessage != null)
            ErrorMessage(message: errorMessage!)
          else if (questions.isEmpty)
            Text(
              'No questions yet.',
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.textTertiary,
              ),
            )
          else
            _buildQuestions(),
        ],
      ),
    );
  }

  Widget _buildInterests() {
    final chips = interests
        .take(3)
        .map(
          (interest) => _InterestChipData(
            interest.name,
            iconUrl: interest.iconUrl,
          ),
        )
        .toList();

    if (chips.isEmpty) {
      return const SizedBox.shrink();
    }

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        for (final chip in chips)
          ProfileInterestChip(
            label: chip.label,
            iconUrl: chip.iconUrl,
          ),
      ],
    );
  }

  Widget _buildQuestions() {
    final items = <Widget>[];
    int index = 0;
    while (index < questions.length) {
      final question = questions[index];
      final next =
          index + 1 < questions.length ? questions[index + 1] : null;
      if (_shouldPair(question, next)) {
        items.add(
          Row(
            children: [
              Expanded(
                child: ProfileQuestionCard(
                  section: section,
                  question: question,
                  answer: answersByQuestionId[question.id],
                  isCompact: true,
                  showActions: false,
                  onTap: onQuestionTap == null
                      ? null
                      : () =>
                          onQuestionTap!(question, answersByQuestionId[question.id]),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: ProfileQuestionCard(
                  section: section,
                  question: next!,
                  answer: answersByQuestionId[next.id],
                  isCompact: true,
                  showActions: false,
                  onTap: onQuestionTap == null
                      ? null
                      : () => onQuestionTap!(next, answersByQuestionId[next.id]),
                ),
              ),
            ],
          ),
        );
        index += 2;
      } else {
        items.add(
          ProfileQuestionCard(
            section: section,
            question: question,
            answer: answersByQuestionId[question.id],
            onTap: onQuestionTap == null
                ? null
                : () => onQuestionTap!(question, answersByQuestionId[question.id]),
            onPinTap: onPinTap == null
                ? null
                : () => onPinTap!(question, answersByQuestionId[question.id]),
          ),
        );
        index += 1;
      }
      if (index < questions.length) {
        items.add(const SizedBox(height: 20));
      }
    }

    return Column(children: items);
  }

  bool _shouldPair(ProfileQuestionModel question, ProfileQuestionModel? next) {
    if (section != ProfileSection.about || next == null) {
      return false;
    }
    final category = (question.category ?? '').toLowerCase();
    final nextCategory = (next.category ?? '').toLowerCase();
    return category.contains('city') && nextCategory.contains('city');
  }
}

class _InterestChipData {
  const _InterestChipData(this.label, {this.iconUrl});

  final String label;
  final String? iconUrl;
}
