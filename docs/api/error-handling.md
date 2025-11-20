# Error Handling and State Management

This document explains the 8 API states and provides comprehensive error handling strategies.

## Table of Contents

1. [The 8 API States](#the-8-api-states)
2. [State Properties](#state-properties)
3. [State Transitions](#state-transitions)
4. [Using ApiStateFolder](#using-apistatefolder)
5. [Manual State Handling](#manual-state-handling)
6. [Error Types](#error-types)
7. [Best Practices](#best-practices)
8. [Real-World Examples](#real-world-examples)

## The 8 API States

The system manages 8 distinct states to handle all possible scenarios during API calls:

### 1. `initial`
- **When**: Before any API call has been made
- **hasData**: `false`
- **isOngoing**: `false`
- **error**: `none`

**Example**: User opens a screen but data hasn't loaded yet.

### 2. `ongoingWithoutOldData`
- **When**: First API call is in progress, no previous data available
- **hasData**: `false`
- **isOngoing**: `true`
- **error**: `none`

**Example**: Initial loading spinner when user first opens a screen.

### 3. `ongoingWithOldData`
- **When**: API call is in progress while previous successful data is available
- **hasData**: `true`
- **isOngoing**: `true`
- **error**: `none`

**Example**: Pull-to-refresh while showing existing data.

### 4. `success`
- **When**: API call succeeded and data is available
- **hasData**: `true`
- **isOngoing**: `false`
- **error**: `none`

**Example**: Successfully loaded user profile.

### 5. `internetErrorWithoutOldData`
- **When**: Network error occurred, no previous data available
- **hasData**: `false`
- **isOngoing**: `false`
- **error**: `netError`

**Example**: First load failed due to no internet connection.

### 6. `internetErrorWithOldData`
- **When**: Network error occurred, but previous successful data is available
- **hasData**: `true`
- **isOngoing**: `false`
- **error**: `netError`

**Example**: Refresh failed but can still show cached data.

### 7. `modelParseFailedWithoutOldData`
- **When**: Response received but JSON parsing failed, no previous data
- **hasData**: `false`
- **isOngoing**: `false`
- **error**: `modelParseError`

**Example**: API returned unexpected JSON structure.

### 8. `modelParseFailedWithOldData`
- **When**: Response received but JSON parsing failed, previous data available
- **hasData**: `true`
- **isOngoing**: `false`
- **error**: `modelParseError`

**Example**: Refresh returned bad data but can show cached data.

## State Properties

Each state has three key properties you can check:

```dart
final state = repo.state;

// Check if data is available (current or cached)
if (state.hasData) {
  // Safe to access repo.latestValidResult
}

// Check if a request is in progress
if (state.isOngoing) {
  // Show loading indicator
}

// Check for any error
if (state.hasError) {
  // Show error message
}

// Check specifically for network error
if (state.hasInternetError) {
  // Show "No internet" message
}

// Get the error type
switch (state.error) {
  case ErrorType.none:
    // No error
    break;
  case ErrorType.netError:
    // Network/connection error
    break;
  case ErrorType.modelParseError:
    // JSON parsing error
    break;
}
```

## State Transitions

### State Transition Diagram

```
┌─────────────┐
│   initial   │
└──────┬──────┘
       │
       │ execute()
       ▼
┌──────────────────────┐
│ ongoingWithoutOldData│────┐
└──────┬───────────────┘    │
       │                    │
       │ success            │ error
       ▼                    ▼
┌──────────┐         ┌───────────────────────┐
│ success  │         │ internetErrorWithout  │
└────┬─────┘         │        or             │
     │               │ modelParseFailedWith  │
     │               └───────────────────────┘
     │ execute()
     ▼
┌───────────────────┐
│ ongoingWithOldData│────┐
└────┬──────────────┘    │
     │                   │
     │ success           │ error
     ▼                   ▼
┌──────────┐      ┌──────────────────────┐
│ success  │      │ internetErrorWith    │
└──────────┘      │       or             │
                  │ modelParseFailedWith │
                  └──────────────────────┘
```

### Key Transitions

1. **Initial Load**:
   ```
   initial → ongoingWithoutOldData → success
   ```

2. **Initial Load Failed**:
   ```
   initial → ongoingWithoutOldData → internetErrorWithoutOldData
   ```

3. **Refresh with Data**:
   ```
   success → ongoingWithOldData → success
   ```

4. **Refresh Failed (keeps old data)**:
   ```
   success → ongoingWithOldData → internetErrorWithOldData
   ```

## Using ApiStateFolder

`ApiStateFolder` is a widget that automatically handles state rendering.

### Basic Usage

```dart
ApiStateFolder(
  repos: [userRepo],
  onRefresh: () => userRepo.execute(),
  buildLoading: () => CircularProgressIndicator(),
  buildLoaded: () => UserProfileWidget(),
  // buildError is optional - uses default error widget
)
```

### Complete Example

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final repo = ref.watch(userRepoProvider);

    return Scaffold(
      body: ApiStateFolder(
        // Monitor one or more repositories
        repos: [repo],

        // Enable pull-to-refresh
        onRefresh: () {
          repo.execute();
        },

        // Custom loading indicator
        buildLoading: () {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 16),
                Text('Loading user data...'),
              ],
            ),
          );
        },

        // Main content when loaded
        buildLoaded: () {
          final user = repo.latestValidResult;

          if (user == null) {
            return const Center(
              child: Text('No data available'),
            );
          }

          return ListView(
            children: [
              ListTile(
                title: Text(user.name),
                subtitle: Text(user.email),
              ),
            ],
          );
        },

        // Custom error widget
        buildError: () {
          // Determine error type
          final hasInternet = !repo.state.hasInternetError;
          final errorMessage = hasInternet
              ? 'Failed to load data. Please try again.'
              : 'No internet connection. Please check your network.';

          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  hasInternet ? Icons.error : Icons.wifi_off,
                  size: 64,
                  color: Colors.red,
                ),
                const SizedBox(height: 16),
                Text(errorMessage),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => repo.execute(),
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

### ApiStateFolder Configuration Options

```dart
ApiStateFolder(
  repos: [repo1, repo2],  // Monitor multiple repos
  onRefresh: () {},       // Optional: Enable pull-to-refresh
  buildLoading: () {},    // Optional: Custom loading widget
  buildLoaded: () {},     // Required: Success state widget
  buildError: () {},      // Optional: Custom error widget

  // Advanced options:
  showOldDataOnError: false,        // If true, shows buildLoaded() even on error
  showOldDataWhileLoading: false,   // If true, shows buildLoaded() while loading
  showInitialAsLoaded: false,       // If true, shows buildLoaded() before first load
  skiploading: false,               // If true, never shows loading state
  defaultErrorStateIsBouncy: true,  // If true, default error has bouncy scroll
)
```

### Multiple Repository Monitoring

Monitor multiple APIs and show loading until all complete:

```dart
ApiStateFolder(
  repos: [
    ref.watch(userRepoProvider),
    ref.watch(postsRepoProvider),
    ref.watch(commentsRepoProvider),
  ],
  onRefresh: () {
    ref.read(userRepoProvider).execute();
    ref.read(postsRepoProvider).execute();
    ref.read(commentsRepoProvider).execute();
  },
  buildLoaded: () {
    // All three repos have completed successfully
    final user = ref.read(userRepoProvider).latestValidResult!;
    final posts = ref.read(postsRepoProvider).latestValidResult!;
    final comments = ref.read(commentsRepoProvider).latestValidResult!;

    return CombinedView(
      user: user,
      posts: posts,
      comments: comments,
    );
  },
  buildLoading: () => LoadingWidget(),
)
```

## Manual State Handling

For more control, handle states manually in your widget:

### Using State Enum Directly

```dart
class UserScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final repo = ref.watch(userRepoProvider);

    // Manual state checking
    switch (repo.state) {
      case APIState.initial:
        // Trigger initial load
        Future.microtask(() => repo.execute());
        return LoadingWidget();

      case APIState.ongoingWithoutOldData:
        return LoadingWidget();

      case APIState.ongoingWithOldData:
        // Show data with loading overlay
        return Stack(
          children: [
            UserDataWidget(repo.latestValidResult!),
            Positioned(
              top: 50,
              right: 20,
              child: CircularProgressIndicator(),
            ),
          ],
        );

      case APIState.success:
        return UserDataWidget(repo.latestValidResult!);

      case APIState.internetErrorWithoutOldData:
        return ErrorWidget(
          message: 'No internet connection',
          onRetry: () => repo.execute(),
        );

      case APIState.internetErrorWithOldData:
        // Show error snackbar but keep data visible
        WidgetsBinding.instance.addPostFrameCallback((_) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Failed to refresh. Showing cached data.'),
              action: SnackBarAction(
                label: 'Retry',
                onPressed: () => repo.execute(),
              ),
            ),
          );
        });
        return UserDataWidget(repo.latestValidResult!);

      case APIState.modelParseFailedWithoutOldData:
        return ErrorWidget(
          message: 'Invalid data received',
          onRetry: () => repo.execute(),
        );

      case APIState.modelParseFailedWithOldData:
        return UserDataWidget(repo.latestValidResult!);
    }
  }
}
```

### Using State Properties

```dart
Widget build(BuildContext context, WidgetRef ref) {
  final repo = ref.watch(userRepoProvider);
  final state = repo.state;

  // Show error banner if error exists
  if (state.hasError) {
    return Column(
      children: [
        ErrorBanner(
          message: state.hasInternetError
              ? 'Network error'
              : 'Data error',
          onDismiss: () => repo.clear(),
        ),
        if (state.hasData)
          Expanded(
            child: UserDataWidget(repo.latestValidResult!),
          ),
      ],
    );
  }

  // Show loading indicator
  if (state.isOngoing && !state.hasData) {
    return LoadingWidget();
  }

  // Show data with optional loading overlay
  if (state.hasData) {
    return Stack(
      children: [
        UserDataWidget(repo.latestValidResult!),
        if (state.isOngoing)
          Positioned(
            top: 10,
            right: 10,
            child: CircularProgressIndicator(),
          ),
      ],
    );
  }

  // Initial state - trigger load
  Future.microtask(() => repo.execute());
  return LoadingWidget();
}
```

## Error Types

### Network Errors (ErrorType.netError)

Detected when:
- `SocketException` is thrown
- `TimeoutException` is thrown
- No internet connection
- Connection refused
- DNS resolution failed

**How to handle**:
```dart
if (repo.state.hasInternetError) {
  // Show offline UI
  // Provide retry button
  // Cache data if possible
}
```

### Parsing Errors (ErrorType.modelParseError)

Detected when:
- JSON structure doesn't match model
- Required field is missing
- Type mismatch (expected String, got int)
- `fromJson` throws exception

**How to handle**:
```dart
if (repo.state.error == ErrorType.modelParseError) {
  // Log the error for debugging
  // Show generic error to user
  // Provide contact support option
}
```

### HTTP 4xx Errors

The system treats 4xx status codes as parsing errors:

```dart
// In AbstractAPI.execute():
if (int.parse(rawModel.statusCode.toString()[0]) == 4) {
  // Sets state to modelParseFailedWithoutOldData
  // or modelParseFailedWithOldData
}
```

**Example 4xx scenarios**:
- 400 Bad Request → Invalid input
- 401 Unauthorized → Authentication required
- 403 Forbidden → Access denied
- 404 Not Found → Resource doesn't exist

**How to handle**:
```dart
// Check the actual status code if needed
if (repo.state.error == ErrorType.modelParseError) {
  // You might want to parse error response differently
  // Or show specific message based on endpoint
}
```

## Best Practices

### 1. Always Use `lastestValidResult` for Display

```dart
// ✅ Good - Uses latest valid result
final user = repo.latestValidResult;

// ❌ Bad - Returns null if current request failed
final user = repo.currentResult;
```

### 2. Show Old Data During Errors

```dart
ApiStateFolder(
  repos: [repo],
  showOldDataOnError: true,  // Keep showing old data on error
  buildLoaded: () {
    // This runs even during error if old data exists
    return UserWidget(repo.latestValidResult!);
  },
)
```

### 3. Provide Clear Error Messages

```dart
buildError: () {
  String message;
  IconData icon;

  if (repo.state.hasInternetError) {
    message = 'No internet connection. Please check your network.';
    icon = Icons.wifi_off;
  } else {
    message = 'Something went wrong. Please try again.';
    icon = Icons.error;
  }

  return ErrorWidget(message: message, icon: icon);
}
```

### 4. Handle Initial Load Gracefully

```dart
@override
void initState() {
  super.initState();
  // Trigger load after build
  WidgetsBinding.instance.addPostFrameCallback((_) {
    ref.read(userRepoProvider).execute();
  });
}
```

### 5. Clear State When Navigating Away (Optional)

```dart
@override
void dispose() {
  // Clear repo state if needed
  ref.read(userRepoProvider).clear();
  super.dispose();
}
```

### 6. Use Loading Overlays for Refresh

```dart
if (repo.state.isOngoing && repo.state.hasData) {
  // Show small loading indicator while keeping data visible
  return Stack(
    children: [
      UserDataWidget(repo.latestValidResult!),
      Positioned(
        top: 16,
        right: 16,
        child: SizedBox(
          width: 20,
          height: 20,
          child: CircularProgressIndicator(strokeWidth: 2),
        ),
      ),
    ],
  );
}
```

### 7. Log Errors for Debugging

```dart
// In your error handling
if (repo.state.hasError) {
  debugLog(
    'API Error',
    'State: ${repo.state}, Error: ${repo.state.error}',
  );
}
```

## Real-World Examples

### Example 1: Social Feed with Pull-to-Refresh

```dart
class FeedScreen extends ConsumerStatefulWidget {
  @override
  ConsumerState<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends ConsumerState<FeedScreen> {
  @override
  void initState() {
    super.initState();
    _loadFeed();
  }

  void _loadFeed() {
    ref.read(feedRepoProvider).execute();
  }

  @override
  Widget build(BuildContext context) {
    final repo = ref.watch(feedRepoProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Feed')),
      body: ApiStateFolder(
        repos: [repo],
        onRefresh: _loadFeed,
        showOldDataWhileLoading: true,  // Keep showing posts during refresh
        buildLoading: () {
          return const Center(child: CircularProgressIndicator());
        },
        buildLoaded: () {
          final posts = repo.latestValidResult?.posts ?? [];

          if (posts.isEmpty) {
            return const Center(
              child: Text('No posts yet'),
            );
          }

          return ListView.builder(
            itemCount: posts.length,
            itemBuilder: (context, index) {
              return PostCard(post: posts[index]);
            },
          );
        },
        buildError: () {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error, size: 64),
                const SizedBox(height: 16),
                Text(
                  repo.state.hasInternetError
                      ? 'No internet connection'
                      : 'Failed to load feed',
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _loadFeed,
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

### Example 2: Form Submission with Error Handling

```dart
class CreatePostScreen extends ConsumerWidget {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();

  void _submitPost(WidgetRef ref) {
    if (!_formKey.currentState!.validate()) return;

    final repo = ref.read(createPostRepoProvider);

    // Set form data
    repo.requestParams.title = _titleController.text;
    repo.requestParams.content = _contentController.text;

    // Execute
    repo.execute();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final repo = ref.watch(createPostRepoProvider);

    // Listen for success
    ref.listen(createPostRepoProvider, (previous, next) {
      if (next.state == APIState.success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Post created!')),
        );
        Navigator.pop(context);
      }
    });

    return Scaffold(
      appBar: AppBar(title: const Text('Create Post')),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Title'),
                validator: (v) => v?.isEmpty ?? true ? 'Required' : null,
              ),
              TextFormField(
                controller: _contentController,
                decoration: const InputDecoration(labelText: 'Content'),
                maxLines: 5,
                validator: (v) => v?.isEmpty ?? true ? 'Required' : null,
              ),
              const SizedBox(height: 16),

              // Show error message
              if (repo.state.hasError)
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Text(
                    repo.state.hasInternetError
                        ? 'No internet connection'
                        : 'Failed to create post',
                    style: const TextStyle(color: Colors.red),
                  ),
                ),

              // Submit button
              ElevatedButton(
                onPressed: repo.state.isOngoing
                    ? null
                    : () => _submitPost(ref),
                child: repo.state.isOngoing
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text('Create Post'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
```

### Example 3: Offline-First with Cached Data

```dart
class ProfileScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final repo = ref.watch(profileRepoProvider);

    return Scaffold(
      body: ApiStateFolder(
        repos: [repo],
        onRefresh: () => repo.execute(),
        showOldDataOnError: true,  // Always show cached data
        showOldDataWhileLoading: true,  // Show during refresh
        buildLoaded: () {
          final profile = repo.latestValidResult!;

          return Stack(
            children: [
              // Main content
              ProfileContent(profile: profile),

              // Show banner if using cached data
              if (repo.state.hasError)
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: MaterialBanner(
                    content: Text(
                      repo.state.hasInternetError
                          ? 'Offline - showing cached data'
                          : 'Using cached data',
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => repo.execute(),
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                ),

              // Show loading indicator during refresh
              if (repo.state.isOngoing)
                Positioned(
                  top: 50,
                  right: 16,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
```

## Summary

The 8-state system provides:

✅ **Clear state distinction** - Know exactly what's happening
✅ **Old data retention** - Never lose successful results
✅ **Granular error handling** - Network vs parsing errors
✅ **Flexible UI options** - Show data, errors, loading as needed
✅ **Multiple monitoring** - Track multiple APIs simultaneously
✅ **Pull-to-refresh support** - Built-in refresh handling
✅ **Type-safe access** - Compile-time guarantees

By understanding these states and using the provided tools, you can build robust, user-friendly applications that gracefully handle all API scenarios!
