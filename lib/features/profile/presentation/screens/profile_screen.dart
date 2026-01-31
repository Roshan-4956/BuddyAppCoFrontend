import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../common/widgets/loading_indicator.dart';
import '../../../../theme/app_colors.dart';
import '../../../../theme/app_text_styles.dart';
import '../../application/models/profile_models.dart';
import '../../application/repositories/profile_repos.dart';
import '../widgets/profile_bottom_nav.dart';
import '../widgets/profile_completion_card.dart';
import '../widgets/profile_header.dart';
import '../widgets/profile_section_tabs.dart';
import '../widgets/profile_summary_card.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen>
    with TickerProviderStateMixin {
  late final TabController _tabController;
  ProfileSection _currentSection = ProfileSection.about;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(_handleTabChange);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadData();
    });
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabChange);
    _tabController.dispose();
    super.dispose();
  }

  void _handleTabChange() {
    if (_tabController.indexIsChanging) return;
    setState(() {
      _currentSection = ProfileSection.values[_tabController.index];
    });
  }

  Future<void> _loadData() async {
    await Future.wait([
      ref.read(profileViewRepoProvider).execute(),
      ref.read(profileCompletionRepoProvider).execute(),
      ref.read(profileAnswersRepoProvider).execute(),
      for (final section in ProfileSection.values)
        ref.read(profileQuestionsRepoProvider(section: section)).execute(),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    final profileRepo = ref.watch(profileViewRepoProvider);
    final completionRepo = ref.watch(profileCompletionRepoProvider);
    final answersRepo = ref.watch(profileAnswersRepoProvider);
    final questionsRepo = ref.watch(
      profileQuestionsRepoProvider(section: _currentSection),
    );

    final profile = profileRepo.data;
    final completion = completionRepo.data;
    final answers = answersRepo.data?.answers ?? [];
    final interests = profile?.interests ?? [];
    final List<ProfileQuestionModel> questions =
        List<ProfileQuestionModel>.from(questionsRepo.data?.questions ?? [])
          ..sort((a, b) => a.displayOrder.compareTo(b.displayOrder));
    final answersByQuestionId = {
      for (final answer in answers) answer.questionId: answer,
    };

    if (profileRepo.state.isOngoing && profile == null) {
      return const Scaffold(body: LoadingIndicator());
    }

    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: _loadData,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ProfileHeader(profile: profile),
                  const SizedBox(height: 36),
                  ProfileSummaryCard(
                    profile: profile,
                    tagline: _deriveTagline(profile, answers),
                  ),
                  const SizedBox(height: 16),
                  ProfileCompletionCard(completion: completion),
                  const SizedBox(height: 16),
                  ProfileSectionTabs(
                    controller: _tabController,
                    section: _currentSection,
                    questions: questions,
                    answersByQuestionId: answersByQuestionId,
                    interests: interests,
                    isLoading:
                        questionsRepo.state.isOngoing ||
                        (questionsRepo.state.isInitial && questions.isEmpty),
                    errorMessage: questionsRepo.state.hasError
                        ? 'Failed to load questions.'
                        : null,
                    onQuestionTap: (question, answer) =>
                        _showAnswerSheet(context, question, answer),
                    onPinTap: (question, answer) =>
                        _togglePin(question, answer),
                  ),
                  const SizedBox(height: 24),
                  Center(
                    child: Text(
                      'Help & Support',
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.textTertiary,
                        height: 1.4,
                      ),
                    ),
                  ),
                  const SizedBox(height: 90),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: ProfileBottomNav(
        currentIndex: 2,
        onTap: (index) {
          if (index == 0) {
            context.go('/home');
          }
        },
      ),
    );
  }

  String? _deriveTagline(
    ProfileViewModel? profile,
    List<ProfileAnswerModel> answers,
  ) {
    final pinned = answers.where((answer) => answer.isPinned).toList();
    if (pinned.isNotEmpty) {
      return pinned.first.answerText;
    }
    if (answers.isNotEmpty) {
      return answers.first.answerText;
    }
    return profile?.address;
  }

  Future<void> _togglePin(
    ProfileQuestionModel question,
    ProfileAnswerModel? answer,
  ) async {
    if (answer == null) {
      await _showAnswerSheet(context, question, answer);
      return;
    }
    final repo = ref.read(
      pinProfileAnswerRepoProvider(
        answerId: answer.id,
        isPinned: !answer.isPinned,
      ),
    );
    await repo.execute();
    await _loadData();
  }

  Future<void> _showAnswerSheet(
    BuildContext context,
    ProfileQuestionModel question,
    ProfileAnswerModel? answer,
  ) async {
    final controller = TextEditingController(text: answer?.answerText ?? '');
    final formKey = GlobalKey<FormState>();
    bool isSaving = false;

    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (sheetContext) {
        return Padding(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            top: 16,
            bottom: MediaQuery.of(sheetContext).viewInsets.bottom + 16,
          ),
          child: StatefulBuilder(
            builder: (context, setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    question.questionText,
                    style: AppTextStyles.bodySmall.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Form(
                    key: formKey,
                    child: TextFormField(
                      controller: controller,
                      maxLines: 4,
                      decoration: InputDecoration(
                        hintText:
                            question.placeholderText ?? 'Write your answer...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: AppColors.borderLight),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: AppColors.borderLight),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            color: AppColors.primaryDark,
                            width: 1.2,
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter an answer.';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: isSaving
                          ? null
                          : () async {
                              if (!formKey.currentState!.validate()) {
                                return;
                              }
                              setState(() => isSaving = true);
                              final text = controller.text.trim();
                              if (answer == null) {
                                final repo =
                                    ref.read(submitProfileAnswerRepoProvider);
                                repo.params.setAnswer(
                                  questionId: question.id,
                                  answerText: text,
                                );
                                await repo.execute();
                              } else {
                                final repo = ref.read(
                                  updateProfileAnswerRepoProvider(
                                    answerId: answer.id,
                                  ),
                                );
                                repo.params.setUpdate(answerText: text);
                                await repo.execute();
                              }
                              if (!sheetContext.mounted) {
                                return;
                              }
                              Navigator.of(sheetContext).pop();
                              if (!mounted) {
                                return;
                              }
                              await _loadData();
                            },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryDark,
                        foregroundColor: AppColors.white,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        isSaving ? 'Saving...' : 'Save',
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}
