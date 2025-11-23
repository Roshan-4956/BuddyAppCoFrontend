import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OnboardingTemplate extends StatelessWidget {
  final int currentStep;
  final int totalSteps;
  final String title;
  final String subtitle;
  final Widget child;
  final VoidCallback onNext;
  final String nextButtonText;
  final bool isNextLoading;
  final bool showBackButton;

  final VoidCallback? onBack;

  const OnboardingTemplate({
    super.key,
    required this.currentStep,
    this.totalSteps = 4,
    required this.title,
    required this.subtitle,
    required this.child,
    required this.onNext,
    this.nextButtonText = 'Next',
    this.isNextLoading = false,
    this.showBackButton = true,
    this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: FittedBox(
              fit: BoxFit.fitWidth,
              alignment: Alignment.topCenter,
              child: Image.asset(
                // Use step 4 background for step 5 if it doesn't exist
                currentStep > 4
                    ? 'assets/onboarding/step_4.png'
                    : 'assets/onboarding/step_$currentStep.png',
                scale: 4,
                errorBuilder: (_, __, ___) => Container(color: Colors.white),
              ),
            ),
          ),

          // Back Button
          if (currentStep > 1 && showBackButton)
            Positioned(
              top: 60, // Adjusted for safe area approx
              left: 20,
              child: GestureDetector(
                onTap: onBack ?? () => context.pop(),
                child: Image.asset(
                  'assets/backArrowWhite.png',
                  scale: 4, // Matching old code
                  errorBuilder: (_, __, ___) =>
                      const Icon(Icons.arrow_back, color: Colors.white),
                ),
              ),
            ),

          // Title & Subtitle
          Positioned(
            top: screenHeight / 7,
            left: 30,
            right: 30,
            child: Align(
              alignment: Alignment.topCenter,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontFamily: 'Rethink Sans',
                      fontSize: 36,
                      fontWeight:
                          FontWeight.w900, // 1000 not standard, using w900
                      color: Color(0xFF1E1E1E),
                      height: 1.1,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontFamily: 'Rethink Sans',
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      height: 1.4,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),

          // White Card
          Positioned(
            top: screenHeight / 3,
            left: 15,
            right: 15,
            child: Container(
              width: screenWidth - 30,
              height: (2 * (screenHeight / 3)) - 37.5,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withValues(alpha: 0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 25,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Progress Bar
                    _buildStepBar(totalSteps, currentStep),

                    const SizedBox(height: 20),

                    // Content (Form)
                    Expanded(child: SingleChildScrollView(child: child)),

                    const SizedBox(height: 20),

                    // Next Button
                    GestureDetector(
                      onTap: isNextLoading ? null : onNext,
                      child: Container(
                        width: screenWidth - 120,
                        height: 55,
                        decoration: BoxDecoration(
                          color: const Color(0xFF1E1E1E),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(
                          child: isNextLoading
                              ? const SizedBox(
                                  width: 24,
                                  height: 24,
                                  child: CircularProgressIndicator(
                                    color: Color(0xFFF6DDE1),
                                    strokeWidth: 2.5,
                                  ),
                                )
                              : Text(
                                  nextButtonText,
                                  style: const TextStyle(
                                    fontFamily: 'Rethink Sans',
                                    color: Color(0xFFF6DDE1),
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                  ),
                                ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStepBar(int totalSteps, int currentStep) {
    return Row(
      children: List.generate(totalSteps, (index) {
        bool isActive = index < currentStep;
        return Expanded(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 4),
            height: 4,
            decoration: BoxDecoration(
              color: isActive
                  ? const Color(0xFF505050)
                  : const Color(0x73505050),
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        );
      }),
    );
  }
}
