import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:buddy_app/features/auth/application/providers/auth_providers.dart';
import 'package:buddy_app/utils/api/providers/api_error_providers.dart';
import 'package:buddy_app/utils/logger.dart';

import 'routing/app_router.dart';
import 'theme/app_theme.dart';

void main() async {
  runApp(
    ProviderScope(
      overrides: [
        unauthorizedErrorProvider.overrideWith(
          (ref) => (r) {
            debugLog(DebugTags.auth, 'Global 401 Handler: Signing out user.');
            r.read(authProvider.notifier).signOut();
          },
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(goRouterProvider);

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: router,
      // Apply light and dark themes
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      // Use light theme mode by default
      themeMode: ThemeMode.light,
      title: 'Buddy App',
    );
  }
}
