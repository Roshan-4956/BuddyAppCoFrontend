import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../theme/app_colors.dart';
import 'api/core/api_state_holder.dart';

/// A robust widget that handles multiple API states and renders appropriate UI based on loading,
/// error, and success states of multiple repositories.
///
/// Automatically handles:
/// * Loading states (with optional Lottie loader)
/// * Error states (with retry support if onRefresh provided)
/// * Data persistence (showing old data while refreshing or on error)
/// * Empty/Initial states
class ApiStateFolder extends StatelessWidget {
  /// List of repository state holders to monitor
  final List<ApiStateHolder> repos;

  /// Callback for refresh action (pull-to-refresh)
  final Future<void> Function()? onRefresh;

  /// Builder function for the loaded/success state UI
  final Widget Function(BuildContext context) buildLoaded;

  /// Optional builder for custom loading state UI
  final Widget Function(BuildContext context)? buildLoading;

  /// Optional builder for custom error state UI
  final Widget Function(BuildContext context, String? error)? buildError;

  /// Configuration flags
  final bool showOldDataOnError;
  final bool showInitialAsLoaded;
  final bool skipLoading;
  final bool showOldDataWhileLoading;
  final bool enableBouncyError;

  const ApiStateFolder({
    super.key,
    required this.repos,
    required this.buildLoaded,
    this.buildError,
    this.buildLoading,
    this.showOldDataOnError =
        true, // Default to true for better UX (optimistic)
    this.showInitialAsLoaded = false,
    this.showOldDataWhileLoading =
        true, // Default to true for "pull-to-refresh" feel
    this.skipLoading = false,
    this.enableBouncyError = true,
    this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    Widget content = _buildContent(context);

    if (onRefresh != null) {
      return RefreshIndicator(
        color: AppColors.primaryPink, // Use app theme color
        backgroundColor: Theme.of(context).colorScheme.surface,
        onRefresh: () async => await onRefresh!(),
        child: content,
      );
    }
    return content;
  }

  Widget _buildContent(BuildContext context) {
    // 1. Analyze aggregate state
    bool hasError = false;
    bool isLoading = false;
    bool isInitial = false;
    bool hasData = true;
    String? errorMessage;

    for (var repo in repos) {
      if (repo.state.isInitial) isInitial = true;
      if (repo.isLoading) isLoading = true;
      if (repo.hasError) {
        hasError = true;
        errorMessage ??= repo.state.errorMessage;
      }
      // If any repo is missing data, we consider the aggregate as "missing data"
      // unless we are in a specific robust mode.
      // Actually, standard logic: if any repo is critical and empty, we can't show loaded.
      if (repo.data == null) hasData = false;
    }

    // 2. Determine UI State

    // Case A: Error State
    // Show error if we have an error AND (we don't have data OR we chose not to show old data)
    if (hasError && (!showOldDataOnError || !hasData)) {
      return _buildErrorInternal(context, errorMessage);
    }

    // Case B: Loading State
    // Show loading if loading AND (we don't have data OR we chose not to show old data while loading)
    // Also skip if explicitly requested.
    if (isLoading && !skipLoading && (!showOldDataWhileLoading || !hasData)) {
      return _buildLoadingInternal(context);
    }

    // Case C: Initial State
    // If just initialized and no data, show loading or loaded based on config
    if (isInitial && !hasData && !showInitialAsLoaded) {
      return _buildLoadingInternal(context);
    }

    // Case D: Success / Loaded (or Error/Loading with valid Data shown)
    return buildLoaded(context);
  }

  Widget _buildLoadingInternal(BuildContext context) {
    if (buildLoading != null) return buildLoading!(context);

    return Center(
      child: SizedBox(
        width: 150,
        height: 150,
        child: Lottie.asset(
          'assets/loader/loader.json', // Ensure this asset exists or fallback
          errorBuilder: (context, error, stackTrace) =>
              CircularProgressIndicator(color: AppColors.primaryPink),
        ),
      ),
    );
  }

  Widget _buildErrorInternal(BuildContext context, String? error) {
    if (buildError != null) return buildError!(context, error);

    final cleanError =
        error?.replaceAll('Exception: ', '') ?? 'Something went wrong';

    final errorWidget = Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline_rounded, size: 48, color: AppColors.error),
            const SizedBox(height: 16),
            Text(
              cleanError,
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
            if (onRefresh != null) ...[
              const SizedBox(height: 24),
              FilledButton.icon(
                onPressed: () => onRefresh!(),
                icon: const Icon(Icons.refresh),
                label: const Text('Retry'),
              ),
            ],
          ],
        ),
      ),
    );

    // If we have a refresh handler or bouncy error is enabled, we need a scrollable area
    // to support the RefreshIndicator or just for the bounce effect.
    if (enableBouncyError || onRefresh != null) {
      return CustomScrollView(
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        slivers: [
          SliverFillRemaining(hasScrollBody: false, child: errorWidget),
        ],
      );
    }

    return errorWidget;
  }
}
