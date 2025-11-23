import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../routing/app_router.dart';
import '../../../../theme/app_text_styles.dart';
import '../../../../utils/api/core/api_state.dart';
import '../../../../utils/constants/assets.dart';
import '../../../auth/application/providers/auth_providers.dart';
import '../../application/repositories/static_repo.dart';
import '../../application/repositories/submit_step_repo.dart';

/// Onboarding Step 5: Interests Selection
/// Collects: 3-10 interest selections
class OnboardingStep5Screen extends ConsumerStatefulWidget {
  const OnboardingStep5Screen({super.key});

  @override
  ConsumerState<OnboardingStep5Screen> createState() =>
      _OnboardingStep5ScreenState();
}

class _OnboardingStep5ScreenState extends ConsumerState<OnboardingStep5Screen> {
  final Set<int> _selectedInterestIds = {};
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(interestsRepoProvider).execute();
    });
  }

  void _toggleInterest(int interestId) {
    setState(() {
      if (_selectedInterestIds.contains(interestId)) {
        _selectedInterestIds.remove(interestId);
      } else {
        if (_selectedInterestIds.length < 3) {
          _selectedInterestIds.add(interestId);
        }
      }
    });
  }

  void _handleContinue() async {
    if (_selectedInterestIds.length < 3) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please select at least 3 interests')),
      );
      return;
    }

    setState(() => _isLoading = true);

    final repo = ref.read(submitStepRepoProvider);
    repo.requestParams.setStepData(5, {
      'interest_ids': _selectedInterestIds.toList(),
    });

    await repo.execute();

    if (!mounted) return;
    setState(() => _isLoading = false);

    if (repo.state == APIState.success) {
      // Mark onboarding as complete in auth state
      ref.read(authProvider.notifier).markOnboardingComplete();

      // Navigate to home after completing interests
      context.goNamed(AppRouter.home.name);
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
    final interestsRepo = ref.watch(interestsRepoProvider);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Image.asset('assets/buddyLogoTitle.png', scale: 4),
        backgroundColor: Colors.white,
      ),
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(padding: EdgeInsets.symmetric(vertical: 10)),
              Center(
                child: Text(
                  'Select your interests',
                  style: TextStyle(
                    fontFamily: 'Rethink Sans',
                    fontSize: 36,
                    fontVariations: [FontVariation('wght', 1000)],
                    color: Color(0xFF555555),
                  ),
                ),
              ),
              Padding(padding: EdgeInsets.symmetric(vertical: 2.5)),
              Center(
                child: Text(
                  'Pick up to 3 things you love most',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Rethink Sans',
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF8793A1),
                  ),
                ),
              ),
              Padding(padding: EdgeInsets.symmetric(vertical: 25)),
              // Interests list
              Expanded(child: _buildInterestsSection(interestsRepo)),
            ],
          ),
          // Continue button at bottom
          Positioned(
            left: 20,
            right: 20,
            bottom: 90,
            child: GestureDetector(
              onTap: _isLoading ? null : _handleContinue,
              child: Container(
                width: (MediaQuery.of(context).size.width) - 30,
                height: 55,
                decoration: BoxDecoration(
                  color: Color(0xFF1E1E1E),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: _isLoading
                      ? SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(
                            color: Color(0xFFF6DDE1),
                            strokeWidth: 2.5,
                          ),
                        )
                      : const Text(
                          'Continue',
                          style: TextStyle(
                            fontFamily: 'Rethink Sans',
                            color: Color(0xFFF6DDE1),
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                ),
              ),
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white,
    );
  }

  Widget _buildInterestsSection(dynamic interestsRepo) {
    if (interestsRepo.state.hasError) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Failed to load interests', style: AppTextStyles.error),
            TextButton(
              onPressed: () => interestsRepo.execute(),
              child: Text('Retry'),
            ),
          ],
        ),
      );
    }

    if (interestsRepo.latestValidResult == null) {
      return Center(child: CircularProgressIndicator());
    }

    return SingleChildScrollView(
      child: _buildInterestsList(interestsRepo.latestValidResult!.interests),
    );
  }

  Widget _buildInterestsList(List interests) {
    // Layout exactly like old interestCapture.dart
    final List<List<int>> rows = [
      [0, 1], // Row 1: 2 items
      [2, 3], // Row 2: 2 items
      [4, 5, 6], // Row 3: 3 items
      [7, 8], // Row 4: 2 items
      [9, 10], // Row 5: 2 items
      [11], // Row 6: 1 item
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        ...rows.map(
          (rowIndexes) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ...rowIndexes.map((i) {
                  if (i >= interests.length) return SizedBox.shrink();

                  final interest = interests[i];
                  final isSelected = _selectedInterestIds.contains(
                    interest.interestId,
                  );

                  // Unselected: pink bg, dark pink border
                  final unselectedBg = Color(0x54F6DDE1);
                  final unselectedBorder = Color(0xFFF6DDE1);

                  // Selected colors based on interest type
                  Color selectedBg;
                  Color selectedBorder;
                  final name = interest.name.toLowerCase();

                  if (name.contains('sport')) {
                    selectedBg = Color(0xFFFDE5F6);
                    selectedBorder = Color(0xFFFFA3EC);
                  } else if (name.contains('food')) {
                    selectedBg = Color(0xFFFFF9D4);
                    selectedBorder = Color(0xFFFFE872);
                  } else if (name.contains('health')) {
                    selectedBg = Color(0xFFE5F8E5);
                    selectedBorder = Color(0xFFA3D89C);
                  } else if (name.contains('game')) {
                    selectedBg = Color(0xFFDBE8FE);
                    selectedBorder = Color(0xFF8EB4FE);
                  } else if (name.contains('music')) {
                    selectedBg = Color(0xFFD4EDFF);
                    selectedBorder = Color(0xFF64BFFF);
                  } else if (name.contains('art') || name.contains('design')) {
                    selectedBg = Color(0xFFFFE8D5);
                    selectedBorder = Color(0xFFFFB074);
                  } else if (name.contains('book') || name.contains('litera')) {
                    selectedBg = Color(0xFFF3E6FF);
                    selectedBorder = Color(0xFFCEA3FF);
                  } else if (name.contains('tech') || name.contains('gadget')) {
                    selectedBg = Color(0xFFE3F5E8);
                    selectedBorder = Color(0xFF8FD4A4);
                  } else if (name.contains('travel') ||
                      name.contains('explor')) {
                    selectedBg = Color(0xFFFFF6D4);
                    selectedBorder = Color(0xFFFEE165);
                  } else if (name.contains('advent') ||
                      name.contains('outdoor')) {
                    selectedBg = Color(0xFFFFE5D4);
                    selectedBorder = Color(0xFFFFAA74);
                  } else if (name.contains('fashion') ||
                      name.contains('style')) {
                    selectedBg = Color(0xFFFDE8F3);
                    selectedBorder = Color(0xFFFFB3E6);
                  } else if (name.contains('pop') ||
                      name.contains('entertain')) {
                    selectedBg = Color(0xFFE8F5FF);
                    selectedBorder = Color(0xFF74BFFF);
                  } else {
                    selectedBg = Color(0xFFE8F5FF);
                    selectedBorder = Color(0xFF74BFFF);
                  }

                  final bgColor = isSelected ? selectedBg : unselectedBg;
                  final borderColor = isSelected
                      ? selectedBorder
                      : unselectedBorder;

                  return GestureDetector(
                    onTap: () {
                      _toggleInterest(interest.interestId);
                    },
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 160),
                      curve: Curves.easeInOut,
                      margin: const EdgeInsets.symmetric(horizontal: 7),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 5,
                        vertical: 9,
                      ),
                      decoration: BoxDecoration(
                        color: bgColor,
                        border: Border.all(color: borderColor, width: 2.4),
                        borderRadius: BorderRadius.circular(28),
                      ),
                      child: Row(
                        children: [
                          Image.asset(
                            _getAssetForInterest(interest.name),
                            scale: 4,
                            errorBuilder: (_, __, ___) => Icon(
                              Icons.interests,
                              size: 20,
                              color: Colors.black54,
                            ),
                          ),
                          SizedBox(width: 9),
                          Text(
                            interest.name,
                            style: TextStyle(
                              fontFamily: 'Rethink Sans',
                              fontWeight: FontWeight.w900,
                              fontSize: 12,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
        ),
      ],
    );
  }

  String _getAssetForInterest(String interestName) {
    final name = interestName.toLowerCase();
    if (name.contains('tech')) return Assets.interestTech;
    if (name.contains('sport')) return Assets.interestSports;
    if (name.contains('travel')) return Assets.interestTravel;
    if (name.contains('music')) return Assets.interestMusic;
    if (name.contains('art')) return Assets.interestArt;
    if (name.contains('read') || name.contains('book')) {
      return Assets.interestBooks;
    }
    if (name.contains('game') || name.contains('gaming')) {
      return Assets.interestGaming;
    }
    if (name.contains('cook') || name.contains('food')) {
      return Assets.interestFood;
    }
    if (name.contains('photo')) return Assets.interestArt;
    if (name.contains('fashion')) return Assets.interestFashion;
    if (name.contains('health') || name.contains('well')) {
      return Assets.interestHealth;
    }
    if (name.contains('advent')) return Assets.interestAdventure;
    if (name.contains('entertainment') || name.contains('pop')) {
      return Assets.interestEntertainment;
    }

    return Assets.interestEntertainment;
  }
}
