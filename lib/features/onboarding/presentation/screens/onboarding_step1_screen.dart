import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../common/widgets/custom_text_field.dart';
import '../../../../routing/app_router.dart';
import '../../../../theme/app_colors.dart';
import '../../../../theme/app_text_styles.dart';
import '../../../../utils/api/core/api_state.dart';
import '../../application/repositories/static_repo.dart';
import '../../application/repositories/submit_step_repo.dart';
import '../widgets/onboarding_template.dart';

/// Onboarding Step 1: Basic Information
/// Collects: Full Name, DOB, State, City, Address
class OnboardingStep1Screen extends ConsumerStatefulWidget {
  const OnboardingStep1Screen({super.key});

  @override
  ConsumerState<OnboardingStep1Screen> createState() =>
      _OnboardingStep1ScreenState();
}

class _OnboardingStep1ScreenState extends ConsumerState<OnboardingStep1Screen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  int? _selectedStateId;
  int? _selectedCityId;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(statesRepoProvider).execute();
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _dobController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      setState(() {
        _dobController.text = DateFormat('dd/MM/yyyy').format(picked);
      });
    }
  }

  void _handleNext() async {
    // Validate inputs
    final nameParts = _nameController.text.trim().split(' ');
    if (_nameController.text.isEmpty || nameParts.length < 2) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter first name and last name')),
      );
      return;
    }

    if (_dobController.text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Please select date of birth')));
      return;
    }

    if (_selectedStateId == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Please select a state')));
      return;
    }

    if (_selectedCityId == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Please select a city')));
      return;
    }

    if (_addressController.text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Please enter your address')));
      return;
    }

    // Parse name
    final firstName = nameParts.first;
    final lastName = nameParts.skip(1).join(' ');

    // Parse DOB to YYYY-MM-DD format
    final dobParts = _dobController.text.split('/');
    final dobFormatted =
        '${dobParts[2]}-${dobParts[1]}-${dobParts[0]}'; // YYYY-MM-DD

    setState(() => _isLoading = true);

    final repo = ref.read(submitStepRepoProvider);
    repo.requestParams.setStepData(1, {
      'first_name': firstName,
      'last_name': lastName,
      'date_of_birth': dobFormatted,
      'state_id': _selectedStateId,
      'city_id': _selectedCityId,
      'address': _addressController.text,
    });

    await repo.execute();

    if (!mounted) return;
    setState(() => _isLoading = false);

    if (repo.state == APIState.success) {
      // Navigate to next step
      context.goNamed(AppRouter.step2.name);
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
    final statesRepo = ref.watch(statesRepoProvider);
    final citiesRepo = ref.watch(citiesRepoProvider(stateId: _selectedStateId));

    return OnboardingTemplate(
      currentStep: 1,
      totalSteps: 4,
      title: "Let's get to know you :)",
      subtitle: "Just a few basics and we'll set things\nup for you",
      onNext: _handleNext,
      isNextLoading: _isLoading,
      showBackButton:
          false, // First step usually doesn't have back in this flow context
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Full Name
          CustomTextField(
            controller: _nameController,
            label: 'Full Name',
            hintText: 'First and last name',
          ),
          const SizedBox(height: 16),
          // DOB with Calendar
          Row(
            children: [
              Expanded(
                child: CustomTextField(
                  controller: _dobController,
                  label: 'Date of Birth',
                  hintText: 'dd/mm/yyyy',
                  readOnly: true,
                ),
              ),
              const SizedBox(width: 12),
              GestureDetector(
                onTap: () => _selectDate(context),
                child: Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: AppColors.primaryBlue,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.calendar_today,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          // State dropdown
          _buildStateDropdown(statesRepo),
          const SizedBox(height: 20),
          // City dropdown (only show if state selected)
          if (_selectedStateId != null)
            _buildCityDropdown(citiesRepo)
          else
            _buildDisabledCityDropdown(),
          const SizedBox(height: 20),
          // Address
          CustomTextField(
            controller: _addressController,
            label: 'Address',
            hintText: 'Enter your full address',
            maxLines: 2,
          ),
        ],
      ),
    );
  }

  Widget _buildStateDropdown(dynamic statesRepo) {
    if (statesRepo.state.hasError) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Failed to load states',
              style: AppTextStyles.labelMedium.copyWith(color: AppColors.error),
            ),
            TextButton(
              onPressed: () => statesRepo.execute(),
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: Size(50, 30),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                alignment: Alignment.centerLeft,
              ),
              child: Text(
                'Retry',
                style: AppTextStyles.labelMedium.copyWith(
                  color: AppColors.primaryBlue,
                ),
              ),
            ),
          ],
        ),
      );
    }

    final statesData = statesRepo.latestValidResult;

    if (statesData == null) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 16),
        child: Center(child: CircularProgressIndicator()),
      );
    }

    final states = statesData.states;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Select State',
          style: AppTextStyles.labelMedium.copyWith(
            color: AppColors.primaryDark,
          ),
        ),
        SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Color(0x77FFFFFF).withValues(alpha: 0.3),
              width: 0.75,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: DropdownButton<int>(
            value: _selectedStateId,
            icon: const Padding(
              padding: EdgeInsets.only(right: 12),
              child: Icon(
                Icons.keyboard_arrow_down,
                color: AppColors.primaryDark,
              ),
            ),
            hint: Text(
              'Select from the dropdown',
              style: AppTextStyles.inputText,
            ),
            isExpanded: true,
            underline: SizedBox(),
            items: states
                .map<DropdownMenuItem<int>>(
                  (state) => DropdownMenuItem<int>(
                    value: state.stateId,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      child: Text(state.name, style: AppTextStyles.inputText),
                    ),
                  ),
                )
                .toList(),
            onChanged: (value) {
              setState(() {
                _selectedStateId = value;
                _selectedCityId = null; // Reset city when state changes
              });
              if (value != null) {
                ref.read(citiesRepoProvider(stateId: value)).execute();
              }
            },
          ),
        ),
      ],
    );
  }

  Widget _buildCityDropdown(dynamic citiesRepo) {
    if (citiesRepo.state.hasError) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Failed to load cities',
              style: AppTextStyles.labelMedium.copyWith(color: AppColors.error),
            ),
            TextButton(
              onPressed: () {
                if (_selectedStateId != null) {
                  citiesRepo.execute();
                }
              },
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: Size(50, 30),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                alignment: Alignment.centerLeft,
              ),
              child: Text(
                'Retry',
                style: AppTextStyles.labelMedium.copyWith(
                  color: AppColors.primaryBlue,
                ),
              ),
            ),
          ],
        ),
      );
    }

    final citiesData = citiesRepo.latestValidResult;

    if (citiesData == null) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 16),
        child: Center(child: CircularProgressIndicator()),
      );
    }

    final cities = citiesData.cities;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Select City',
          style: AppTextStyles.labelMedium.copyWith(
            color: AppColors.primaryDark,
          ),
        ),
        SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Color(0x77FFFFFF).withValues(alpha: 0.3),
              width: 0.75,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: DropdownButton<int>(
            value: _selectedCityId,
            icon: const Padding(
              padding: EdgeInsets.only(right: 12),
              child: Icon(
                Icons.keyboard_arrow_down,
                color: AppColors.primaryDark,
              ),
            ),
            hint: Text(
              'Select from the dropdown',
              style: AppTextStyles.inputText,
            ),
            isExpanded: true,
            underline: SizedBox(),
            items: cities
                .map<DropdownMenuItem<int>>(
                  (city) => DropdownMenuItem<int>(
                    value: city.cityId,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      child: Text(city.name, style: AppTextStyles.inputText),
                    ),
                  ),
                )
                .toList(),
            onChanged: (value) {
              setState(() {
                _selectedCityId = value;
              });
            },
          ),
        ),
      ],
    );
  }

  Widget _buildDisabledCityDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Select City',
          style: AppTextStyles.labelMedium.copyWith(
            color: AppColors.primaryDark,
          ),
        ),
        SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Color(0x77FFFFFF).withValues(alpha: 0.3),
              width: 0.75,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
            child: Text(
              'Please select a state first',
              style: AppTextStyles.inputText.copyWith(
                color: AppColors.textTertiary,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
