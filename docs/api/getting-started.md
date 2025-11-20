# Getting Started with the API Provider System

This guide will walk you through creating your first API endpoint from scratch. By the end, you'll have a complete working example that you can use as a template for your own endpoints.

## Prerequisites

Ensure you have the following dependencies in your `pubspec.yaml`:

```yaml
dependencies:
  flutter_riverpod: ^2.0.0
  riverpod_annotation: ^2.0.0
  http: ^1.0.0

dev_dependencies:
  build_runner: ^2.0.0
  riverpod_generator: ^2.0.0
```

## Step-by-Step Guide

Let's create a complete API endpoint to fetch user data from `GET /users/{userId}`.

### Step 1: Create the Feature Folder Structure

Create the following folder structure under `lib/features/`:

```
lib/features/user/
├── application/
│   ├── user_model.dart
│   ├── user_params.dart
│   └── user_repo.dart
└── presentation/
    └── user_screen.dart
```

### Step 2: Define the Model

Create `lib/features/user/application/user_model.dart`:

```dart
/// Model representing a user from the API.
class UserModel {
  final String id;
  final String name;
  final String email;
  final String? avatarUrl;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.avatarUrl,
  });

  /// Factory constructor to create a UserModel from JSON.
  /// This is required by the API system for response parsing.
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      avatarUrl: json['avatar_url'],
    );
  }

  /// Optional: Convert model to JSON (useful for caching or logging)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'avatar_url': avatarUrl,
    };
  }
}
```

### Step 3: Create the Parameters Class

Create `lib/features/user/application/user_params.dart`:

```dart
import '../../../utils/api/implementation/simple_api/simple_params.dart';

/// Parameters for the user API endpoint.
/// Handles URL formatting and request configuration.
class UserParams extends SimpleParameters {
  // URL placeholder constants
  static const String userIdPlaceholder = '{userId}';

  // Parameter properties
  String? userId;

  /// Formats the URL by replacing placeholders with actual values.
  @override
  String getFormattedUrl(String raw) {
    String formatted = super.getFormattedUrl(raw);

    // Replace the userId placeholder if provided
    if (userId != null) {
      formatted = formatted.replaceFirst(userIdPlaceholder, userId!);
    }

    return formatted;
  }
}
```

### Step 4: Create the Repository Provider

Create `lib/features/user/application/user_repo.dart`:

```dart
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../utils/api/core/http_method.dart';
import '../../../utils/api/implementation/riverpod_api/riverpod_api.dart';
import '../../../utils/factory_utils.dart';
import '../../../utils/urls.dart';
import 'user_model.dart';
import 'user_params.dart';

// This tells build_runner where to generate the code
part 'user_repo.g.dart';

/// Repository provider for user API calls.
///
/// The @Riverpod annotation with keepAlive: true ensures the provider
/// stays in memory and maintains its state across widget rebuilds.
@Riverpod(keepAlive: true)
RiverpodAPI<UserModel, UserParams> userRepo(Ref ref) {
  return RiverpodAPI<UserModel, UserParams>(
    // Complete URL with placeholder
    completeUrl: URLs.complete('users/{userId}'),

    // Factory function to parse JSON response into UserModel
    factory: FactoryUtils.modelFromString(UserModel.fromJson),

    // Parameters instance for this API call
    params: UserParams(),

    // HTTP method
    method: HTTPMethod.get,

    // Riverpod reference for state management
    ref: ref,

    // Whether this endpoint requires authentication (default: true)
    requiresAuth: true,
  );
}
```

### Step 5: Generate the Provider Code

The `part 'user_repo.g.dart';` directive tells build_runner to generate the provider code. Since you mentioned build_runner is watching in the background, the file will be generated automatically.

If you need to run it manually:

```bash
fvm flutter pub run build_runner build --delete-conflicting-outputs
```

This generates `lib/features/user/application/user_repo.g.dart` which contains the actual `userRepoProvider` that you'll use in your UI.

### Step 6: Create the UI Screen

Create `lib/features/user/presentation/user_screen.dart`:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../utils/api_state_folder.dart';
import '../../../utils/widgets/screen_outline.dart';
import '../application/user_repo.dart';

/// Screen that displays user information.
class UserScreen extends ConsumerStatefulWidget {
  final String userId;

  const UserScreen({
    required this.userId,
    super.key,
  });

  @override
  ConsumerState<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends ConsumerState<UserScreen> {
  @override
  void initState() {
    super.initState();
    // Load user data when screen initializes
    _loadUser();
  }

  void _loadUser() {
    // Get the repository
    final repo = ref.read(userRepoProvider);

    // Set the userId parameter
    repo.requestParams.userId = widget.userId;

    // Execute the API call
    repo.execute();
  }

  @override
  Widget build(BuildContext context) {
    // Watch the repository for state changes
    final repo = ref.watch(userRepoProvider);

    return ScreenOutline(
      title: 'User Profile',
      body: ApiStateFolder(
        // List of repositories whose state to monitor
        repos: [repo],

        // Refresh callback - called when user pulls to refresh
        onRefresh: () {
          _loadUser();
        },

        // Loading state UI
        buildLoading: () {
          return const Center(
            child: CircularProgressIndicator(),
          );
        },

        // Success state UI
        buildLoaded: () {
          // Get the latest successful result
          final user = repo.latestValidResult;

          if (user == null) {
            return const Center(
              child: Text('No user data available'),
            );
          }

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Display avatar if available
                if (user.avatarUrl != null)
                  Center(
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(user.avatarUrl!),
                    ),
                  ),
                const SizedBox(height: 24),

                // Display user information
                Text(
                  'Name: ${user.name}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Email: ${user.email}',
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 8),
                Text(
                  'ID: ${user.id}',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          );
        },

        // Optional: Custom error state UI
        buildError: () {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.error_outline,
                  size: 64,
                  color: Colors.red,
                ),
                const SizedBox(height: 16),
                const Text(
                  'Failed to load user',
                  style: TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _loadUser,
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
```

## Understanding the Code Flow

Let's trace what happens when a user opens the `UserScreen`:

1. **Initialization**:
   - `initState()` calls `_loadUser()`
   - Repository is obtained via `ref.read(userRepoProvider)`

2. **Parameter Configuration**:
   - `repo.requestParams.userId = widget.userId` sets the parameter
   - This will be used to format the URL

3. **Execution**:
   - `repo.execute()` triggers the API call
   - State changes to `ongoingWithoutOldData`

4. **Request Building** (inside the system):
   - `UserParams.getFormattedUrl()` replaces `{userId}` with actual value
   - `RiverpodAPI.generateRequest()` adds common headers
   - `SimpleAPI.generateRequest()` creates the HTTP request

5. **Response Handling** (inside the system):
   - Response is received and parsed using `UserModel.fromJson`
   - State changes to `success`
   - `ref.notifyListeners()` triggers UI rebuild

6. **UI Update**:
   - `ref.watch(userRepoProvider)` detects the change
   - `ApiStateFolder` checks the state
   - `buildLoaded()` is called to render the user data

## Common Patterns

### Pattern 1: Loading with Parameters

```dart
// Set parameter and execute
repo.requestParams.userId = '123';
repo.execute();
```

### Pattern 2: Checking State Before Action

```dart
if (repo.state == APIState.success) {
  // Data is available
  final user = repo.latestValidResult;
}
```

### Pattern 3: Accessing Current vs Latest Valid Result

```dart
// Current result (null if error occurred)
final current = repo.currentResult;

// Latest valid result (retains previous successful data)
final latest = repo.latestValidResult;
```

### Pattern 4: Manual Error Handling

```dart
if (repo.state.hasError) {
  if (repo.state.hasInternetError) {
    // Handle network error
  } else {
    // Handle parsing error
  }
}
```

## File Checklist

After completing this guide, you should have these files:

- ✅ `lib/features/user/application/user_model.dart` - Model definition
- ✅ `lib/features/user/application/user_params.dart` - Parameters class
- ✅ `lib/features/user/application/user_repo.dart` - Repository provider
- ✅ `lib/features/user/application/user_repo.g.dart` - Generated code (automatic)
- ✅ `lib/features/user/presentation/user_screen.dart` - UI screen

## Next Steps

Now that you have a working example:

1. **Explore Different HTTP Methods**: Check the [Examples](./examples.md) for POST, PUT, DELETE
2. **Learn Advanced Features**: See [Advanced Features](./advanced-features.md) for optimization
3. **Handle Complex States**: Read [Error Handling](./error-handling.md) for robust error management
4. **Understand the System**: Review [Architecture](./architecture.md) for deeper understanding

## Troubleshooting

### Issue: Provider not found

**Error**: `The provider userRepoProvider doesn't exist`

**Solution**: Make sure build_runner has generated the `.g.dart` file. Check that:
- The `part` directive is correct
- The file name matches the pattern `filename.g.dart`
- Build runner is watching or has been run

### Issue: JSON parsing fails

**Error**: `type 'Null' is not a subtype of type 'String'`

**Solution**:
- Make required fields non-nullable
- Add null checks in `fromJson`
- Use nullable types (`String?`) for optional fields

### Issue: State not updating in UI

**Solution**:
- Use `ref.watch()` not `ref.read()` in build method
- Ensure `@Riverpod(keepAlive: true)` is set
- Check that `ApiStateFolder` includes the repo in `repos` list

## Summary

You've learned:
- ✅ How to structure API feature folders
- ✅ Creating models with `fromJson` factories
- ✅ Defining parameters with URL formatting
- ✅ Setting up repository providers
- ✅ Building UI with `ApiStateFolder`
- ✅ Understanding the code execution flow

This pattern can be replicated for any API endpoint in your application!
