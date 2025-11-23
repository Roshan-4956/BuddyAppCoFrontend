import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../routing/app_router.dart';
import '../../../../theme/app_text_styles.dart';
import '../../../../utils/api/core/api_state.dart';
import '../../application/repositories/static_repo.dart';
import '../../application/repositories/submit_step_repo.dart';
import '../widgets/onboarding_template.dart';
import '../widgets/selection_option.dart';

/// Onboarding Step 2: Professional Information
/// Collects: Occupation
class OnboardingStep2Screen extends ConsumerStatefulWidget {
  const OnboardingStep2Screen({super.key});

  @override
  ConsumerState<OnboardingStep2Screen> createState() =>
      _OnboardingStep2ScreenState();
}

class _OnboardingStep2ScreenState extends ConsumerState<OnboardingStep2Screen> {
  int? _selectedOccupationId;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(occupationsRepoProvider).execute();
    });
  }

  void _handleNext() async {
    if (_selectedOccupationId == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Please select an occupation')));
      return;
    }

    setState(() => _isLoading = true);

    final repo = ref.read(submitStepRepoProvider);
    repo.requestParams.setStepData(2, {'occupation_id': _selectedOccupationId});

    await repo.execute();

    if (!mounted) return;
    setState(() => _isLoading = false);

    if (repo.state == APIState.success) {
      // Navigate to next step
      context.goNamed(AppRouter.step3.name);
    } else if (repo.state.hasError) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            repo.state.hasInternetError
                ? 'Network error. Please check your connection.'
                : 'Failed to submit. Please try again.',
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final occupationsRepo = ref.watch(occupationsRepoProvider);

    return OnboardingTemplate(
      currentStep: 2,
      totalSteps: 4,
      title: 'Getting closer!',
      subtitle:
          'These details will help us curate the\nbest experience for you',
      onNext: _handleNext,
      isNextLoading: _isLoading,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 4),
          // Question text
          Text(
            'what best describes your\noccupation?',
            textAlign: TextAlign.center,
            style: AppTextStyles.questionText,
          ),
          const SizedBox(height: 20),
          // Occupations list
          _buildOccupationsSection(occupationsRepo),
        ],
      ),
    );
  }

  Widget _buildOccupationsSection(dynamic occupationsRepo) {
    if (occupationsRepo.state.hasError) {
      return Center(
        child: Column(
          children: [
            Text('Failed to load occupations', style: AppTextStyles.error),
            TextButton(
              onPressed: () => occupationsRepo.execute(),
              child: Text('Retry'),
            ),
          ],
        ),
      );
    }

    if (occupationsRepo.latestValidResult == null) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: Center(child: CircularProgressIndicator()),
      );
    }

    return _buildOccupationsList(
      occupationsRepo.latestValidResult!.occupations,
    );
  }

  Widget _buildOccupationsList(List occupations) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: occupations.length,
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final occupation = occupations[index];
        final isSelected = _selectedOccupationId == occupation.occupationId;

        // Determine icon based on occupation name
        IconData icon = Icons.work;
        final name = occupation.name.toLowerCase();
        if (name.contains('undergraduate') || name.contains('postgraduate')) {
          icon = Icons.school;
        } else if (name.contains('fresher')) {
          icon = Icons.computer;
        } else if (name.contains('entry')) {
          icon = Icons.engineering;
        } else if (name.contains('other')) {
          icon = Icons.cancel_presentation;
        }

        return SelectionOption(
          text: occupation.name,
          icon: icon,
          isSelected: isSelected,
          onTap: () {
            setState(() {
              _selectedOccupationId = occupation.occupationId;
            });
          },
        );
      },
    );
  }
}
