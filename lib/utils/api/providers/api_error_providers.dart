import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Provider for handling global unauthorized (401) errors.
/// Overridden in the main app to trigger logout/redirect logic.
final unauthorizedErrorProvider = Provider<void Function(Ref ref)?>(
  (ref) => null,
);
