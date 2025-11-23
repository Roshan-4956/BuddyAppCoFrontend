import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../routing/app_router.dart';
import '../../../../theme/app_text_styles.dart';
import '../../../../utils/api/core/api_state.dart';
import '../../application/repositories/static_repo.dart';
import '../../application/repositories/submit_step_repo.dart';
import '../widgets/onboarding_template.dart';

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
          const SizedBox(height: 8),
          // Section title
          Text(
            'what best describes your\noccupation?',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              fontFamily: 'Rethink Sans',
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 16),
          // Occupations
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
      physics: NeverScrollableScrollPhysics(),
      itemCount: occupations.length,
      separatorBuilder: (context, index) => SizedBox(height: 10),
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

        return InkWell(
          borderRadius: BorderRadius.circular(24),
          onTap: () {
            setState(() {
              _selectedOccupationId = occupation.occupationId;
            });
          },
          child: Container(
            height: 40,
            decoration: BoxDecoration(
              color: Color(0xFFE9F4FF),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: isSelected ? Color(0xFF53A9FF) : Colors.transparent,
                width: 2,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(width: 10),
                CircleAvatar(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black87,
                  radius: 16,
                  child: Icon(icon, size: 20),
                ),
                SizedBox(width: 18),
                Expanded(
                  child: Text(
                    occupation.name,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                      fontFamily: 'Rethink Sans',
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(right: 14),
                  width: 16,
                  height: 16,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isSelected ? Color(0xFF53A9FF) : Colors.black26,
                      width: 1,
                    ),
                    color: isSelected
                        ? Color(0xFF53A9FF).withValues(alpha: 0.26)
                        : Colors.transparent,
                  ),
                  child: isSelected
                      ? Center(
                          child: Icon(
                            Icons.check,
                            color: Color(0xFF53A9FF),
                            size: 10,
                          ),
                        )
                      : null,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
