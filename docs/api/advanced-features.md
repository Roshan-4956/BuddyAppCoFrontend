# Advanced Features

This document covers advanced configuration options and optimization techniques for the API provider system.

## Table of Contents

1. [Reset Parameters on Execute](#reset-parameters-on-execute)
2. [Concurrent Request Control](#concurrent-request-control)
3. [Timeout Configuration](#timeout-configuration)
4. [Old Data Retention](#old-data-retention)
5. [Pagination Support](#pagination-support)
6. [Custom Change Listeners](#custom-change-listeners)
7. [Response Transformation](#response-transformation)
8. [Factory Utilities](#factory-utilities)
9. [HTTP Client Configuration](#http-client-configuration)
10. [Performance Optimization](#performance-optimization)

---

## Reset Parameters on Execute

### Purpose

Automatically clear request parameters after execution to prevent parameter leakage between requests.

### Configuration

```dart
@Riverpod(keepAlive: true)
RiverpodAPI<UserModel, UserParams> userRepo(Ref ref) {
  return RiverpodAPI<UserModel, UserParams>(
    completeUrl: URLs.complete('users'),
    factory: FactoryUtils.modelFromString(UserModel.fromJson),
    params: UserParams(),
    method: HTTPMethod.post,
    ref: ref,
    resetParamsOnExecute: true,  // Clear params after each request
  );
}
```

### When to Use

✅ **POST/PUT requests** - Form submissions where data shouldn't persist
✅ **Search endpoints** - Clear search terms after each search
✅ **Dynamic forms** - Prevent old form data from contaminating new submissions

❌ **GET requests** - Usually don't need reset
❌ **Paginated lists** - Need to keep page number
❌ **Filtered lists** - Need to keep filter state

### Example: Form Submission

```dart
class CreateUserForm extends ConsumerWidget {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();

  void _submit(WidgetRef ref) {
    final repo = ref.read(createUserRepoProvider);

    // Set parameters
    repo.requestParams.name = _nameController.text;
    repo.requestParams.email = _emailController.text;

    // Execute - params will be cleared automatically after request
    repo.execute();

    // Next time execute() is called, params will be empty
  }

  // ...
}
```

### Without Reset

```dart
// First submission
repo.requestParams.name = 'John';
repo.requestParams.email = 'john@example.com';
repo.execute();

// Second submission (without clearing)
repo.requestParams.name = 'Jane';  // email still has 'john@example.com'
repo.execute();  // ⚠️ Sends { name: 'Jane', email: 'john@example.com' }
```

### With Reset

```dart
// First submission
repo.requestParams.name = 'John';
repo.requestParams.email = 'john@example.com';
repo.execute();  // Params cleared after

// Second submission
repo.requestParams.name = 'Jane';  // email is now empty
repo.execute();  // ✅ Sends { name: 'Jane' }
```

---

## Concurrent Request Control

### Purpose

Prevent multiple simultaneous requests to the same endpoint.

### Configuration

```dart
abstract class AbstractAPI {
  bool get allowConcurrentRequests => false;  // Default: false (rejects)

  final void Function()? onConcurrentRequestRejectListener;
}
```

### Behavior

When `allowConcurrentRequests = false` (default):
- If a request is already in progress (`state.isOngoing = true`)
- New `execute()` calls are ignored
- `onConcurrentRequestRejectListener` is called if provided

### Example: Preventing Double Submissions

```dart
class SubmitButton extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final repo = ref.watch(submitFormRepoProvider);

    return ElevatedButton(
      onPressed: repo.state.isOngoing
          ? null  // Disable button while loading
          : () {
              repo.execute();
              // If user clicks again before response, request is rejected
            },
      child: repo.state.isOngoing
          ? const CircularProgressIndicator()
          : const Text('Submit'),
    );
  }
}
```

### Custom Concurrent Rejection Handler

```dart
// Not directly exposed in RiverpodAPI, but available in AbstractAPI
// To implement custom handling, extend SimpleAPI:

class CustomAPI<MODEL, PARAM extends AbstractSimpleParameters>
    extends SimpleAPI<MODEL, PARAM> {

  CustomAPI({
    required super.completeUrl,
    required super.factory,
    required super.method,
    required super.params,
    super.changeListener,
  }) : super(
    onConcurrentRequestRejectListener: () {
      debugLog('API', 'Concurrent request rejected');
      // Show snackbar, toast, etc.
    },
  );
}
```

### When to Use

✅ **Form submissions** - Prevent duplicate submissions
✅ **Payment processing** - Avoid double charges
✅ **Create/Update operations** - Prevent duplicate records
✅ **Critical actions** - Delete, transfer, etc.

❌ **Search** - Allow rapid re-searching
❌ **Real-time updates** - Allow frequent polling
❌ **Analytics** - Allow multiple simultaneous tracking calls

---

## Timeout Configuration

### Purpose

Automatically cancel requests that take too long.

### Configuration

```dart
@Riverpod(keepAlive: true)
RiverpodAPI<DataModel, DataParams> dataRepo(Ref ref) {
  return RiverpodAPI<DataModel, DataParams>(
    completeUrl: URLs.complete('data'),
    factory: FactoryUtils.modelFromString(DataModel.fromJson),
    params: DataParams(),
    method: HTTPMethod.get,
    ref: ref,
    timeoutSeconds: 30,  // Default: GlobalSettings.defaultTimeoutSecs (120)
  );
}
```

### Setting Global Default

In `lib/utils/global_settings.dart`:

```dart
class GlobalSettings {
  static const int defaultTimeoutSecs = 120;  // 2 minutes
  static const bool useProductionServer = true;
}
```

### Timeout Behavior

When timeout is reached:
- Request is cancelled
- `TimeoutException` is thrown
- State changes to `internetErrorWithoutOldData` or `internetErrorWithOldData`

### Example: Different Timeouts for Different Endpoints

```dart
// Quick data fetch - 10 seconds
@Riverpod(keepAlive: true)
RiverpodAPI<QuickDataModel, QuickDataParams> quickDataRepo(Ref ref) {
  return RiverpodAPI<QuickDataModel, QuickDataParams>(
    completeUrl: URLs.complete('quick-data'),
    factory: FactoryUtils.modelFromString(QuickDataModel.fromJson),
    params: QuickDataParams(),
    method: HTTPMethod.get,
    ref: ref,
    timeoutSeconds: 10,
  );
}

// File upload - 5 minutes
@Riverpod(keepAlive: true)
RiverpodAPI<UploadModel, UploadParams> uploadRepo(Ref ref) {
  return RiverpodAPI<UploadModel, UploadParams>(
    completeUrl: URLs.complete('upload'),
    factory: FactoryUtils.modelFromString(UploadModel.fromJson),
    params: UploadParams(),
    method: HTTPMethod.post,
    ref: ref,
    timeoutSeconds: 300,  // 5 minutes for large uploads
  );
}

// No timeout (null)
@Riverpod(keepAlive: true)
RiverpodAPI<StreamModel, StreamParams> streamRepo(Ref ref) {
  return RiverpodAPI<StreamModel, StreamParams>(
    completeUrl: URLs.complete('stream'),
    factory: FactoryUtils.modelFromString(StreamModel.fromJson),
    params: StreamParams(),
    method: HTTPMethod.get,
    ref: ref,
    timeoutSeconds: null,  // No timeout
  );
}
```

### Recommended Timeouts

| Endpoint Type | Timeout | Reason |
|---------------|---------|--------|
| GET (small data) | 10-30s | Quick response expected |
| POST (form) | 30-60s | Server processing time |
| File upload | 300-600s | Network transfer time |
| File download | 300-600s | Network transfer time |
| Real-time data | 5-10s | Need fresh data |
| Analytics | 5-10s | Not critical, fail fast |
| Background sync | null | Can take indefinite time |

---

## Old Data Retention

### Purpose

Keep previously successful data available during refresh or errors.

### Configuration

```dart
abstract class AbstractAPI {
  bool get resetWhileRefreshing => true;  // Default: true (keeps old data)
}
```

### Behavior

When `resetWhileRefreshing = true` (default):
- During refresh, state becomes `ongoingWithOldData`
- `latestValidResult` still contains previous successful result
- On error, state becomes `internetErrorWithOldData` or `modelParseFailedWithOldData`
- Previous data remains accessible

When `resetWhileRefreshing = false`:
- During refresh, state becomes `ongoingWithoutOldData`
- Previous result is cleared
- On error, state becomes `internetErrorWithoutOldData` or `modelParseFailedWithoutOldData`

### Data Access Properties

```dart
// Current result - null if latest request failed
RESULT_MODEL? get currentResult => _currentResult;

// Latest valid result - retains last successful result
RESULT_MODEL? get latestValidResult => _currentResult ?? _latestValidResult;

// Timestamp of last success
DateTime? get lastSuccessfulCallTime => _lastSuccessfulCallTime;
```

### Example: Offline-First UI

```dart
class FeedScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final repo = ref.watch(feedRepoProvider);

    return ApiStateFolder(
      repos: [repo],
      onRefresh: () => repo.execute(),
      showOldDataOnError: true,  // Show cached data on error
      showOldDataWhileLoading: true,  // Show cached data during refresh
      buildLoaded: () {
        final feed = repo.latestValidResult!;
        final isStale = repo.state.hasError;
        final lastUpdate = repo.lastSuccessfulCallTime;

        return Column(
          children: [
            // Stale data indicator
            if (isStale)
              Container(
                color: Colors.orange.shade100,
                padding: const EdgeInsets.all(8),
                child: Row(
                  children: [
                    const Icon(Icons.wifi_off, size: 16),
                    const SizedBox(width: 8),
                    Text(
                      'Showing cached data from ${_formatTime(lastUpdate)}',
                      style: const TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ),

            // Feed content
            Expanded(
              child: ListView.builder(
                itemCount: feed.posts.length,
                itemBuilder: (context, index) {
                  return PostCard(post: feed.posts[index]);
                },
              ),
            ),
          ],
        );
      },
    );
  }

  String _formatTime(DateTime? time) {
    if (time == null) return 'unknown time';
    final diff = DateTime.now().difference(time);
    if (diff.inMinutes < 1) return 'just now';
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    return '${diff.inDays}d ago';
  }
}
```

---

## Pagination Support

### Purpose

Handle paginated API responses with next/previous URLs.

### Using `paginatedOverridenUrl`

```dart
class PaginatedParams extends SimpleParameters {
  @override
  String getFormattedUrl(String raw) {
    // If paginated URL is set, use it instead of base URL
    if (paginatedOverridenUrl != null) {
      return paginatedOverridenUrl!;
    }
    return super.getFormattedUrl(raw);
  }

  void setNextPage(String nextUrl) {
    paginatedOverridenUrl = nextUrl;
  }

  void resetPagination() {
    paginatedOverridenUrl = null;
  }
}
```

### Example: Infinite Scroll

```dart
class InfiniteListScreen extends ConsumerStatefulWidget {
  @override
  ConsumerState<InfiniteListScreen> createState() => _InfiniteListScreenState();
}

class _InfiniteListScreenState extends ConsumerState<InfiniteListScreen> {
  final _scrollController = ScrollController();
  final List<Item> _allItems = [];

  @override
  void initState() {
    super.initState();
    _loadFirstPage();
    _scrollController.addListener(_onScroll);
  }

  void _loadFirstPage() {
    final repo = ref.read(paginatedRepoProvider);
    repo.requestParams.resetPagination();
    repo.execute();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      _loadNextPage();
    }
  }

  void _loadNextPage() {
    final repo = ref.read(paginatedRepoProvider);
    final currentData = repo.latestValidResult;

    if (currentData != null &&
        currentData.hasNext &&
        !repo.state.isOngoing) {
      repo.requestParams.setNextPage(currentData.nextUrl!);
      repo.execute();
    }
  }

  @override
  Widget build(BuildContext context) {
    final repo = ref.watch(paginatedRepoProvider);

    // Accumulate items from each page
    if (repo.state == APIState.success) {
      final newItems = repo.currentResult!.items;
      _allItems.addAll(newItems);
    }

    return ListView.builder(
      controller: _scrollController,
      itemCount: _allItems.length + (repo.state.isOngoing ? 1 : 0),
      itemBuilder: (context, index) {
        if (index == _allItems.length) {
          return const Center(child: CircularProgressIndicator());
        }
        return ItemCard(item: _allItems[index]);
      },
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
```

### Example: Page-Based Pagination

```dart
class PagedListScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final repo = ref.watch(pagedRepoProvider);
    final currentPage = ref.watch(currentPageProvider);

    void _loadPage(int page) {
      final repo = ref.read(pagedRepoProvider);
      repo.requestParams.resetPagination();
      repo.requestParams.page = page;
      repo.execute();
      ref.read(currentPageProvider.notifier).state = page;
    }

    return Column(
      children: [
        Expanded(
          child: ApiStateFolder(
            repos: [repo],
            buildLoaded: () {
              final data = repo.lastestValidResult!;
              return ListView.builder(
                itemCount: data.items.length,
                itemBuilder: (context, index) {
                  return ItemCard(item: data.items[index]);
                },
              );
            },
          ),
        ),

        // Pagination controls
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: const Icon(Icons.chevron_left),
              onPressed: currentPage > 1
                  ? () => _loadPage(currentPage - 1)
                  : null,
            ),
            Text('Page $currentPage'),
            IconButton(
              icon: const Icon(Icons.chevron_right),
              onPressed: repo.latestValidResult?.hasNext ?? false
                  ? () => _loadPage(currentPage + 1)
                  : null,
            ),
          ],
        ),
      ],
    );
  }
}
```

---

## Custom Change Listeners

### Purpose

Execute custom code when API state changes (beyond Riverpod notifications).

### Configuration

The `changeListener` callback is called whenever state changes:

```dart
RiverpodAPI<MODEL, PARAM>(
  // ... other params
  changeListener: () {
    // Custom logic on state change
  },
)
```

### Example: Analytics Tracking

```dart
@Riverpod(keepAlive: true)
RiverpodAPI<UserModel, UserParams> userRepo(Ref ref) {
  return RiverpodAPI<UserModel, UserParams>(
    completeUrl: URLs.complete('users/{userId}'),
    factory: FactoryUtils.modelFromString(UserModel.fromJson),
    params: UserParams(),
    method: HTTPMethod.get,
    ref: ref,
    // RiverpodAPI already sets: changeListener: () => ref.notifyListeners()
  );
}

// For custom behavior, extend SimpleAPI:
class AnalyticsAPI<MODEL, PARAM extends AbstractSimpleParameters>
    extends SimpleAPI<MODEL, PARAM> {

  final AnalyticsService analytics;

  AnalyticsAPI({
    required super.completeUrl,
    required super.factory,
    required super.method,
    required super.params,
    required this.analytics,
  }) : super(
    changeListener: () {
      // Track API state changes
      analytics.track('api_state_change', {
        'url': completeUrl,
        'state': state.toString(),
      });
    },
  );
}
```

### Example: State Logging

```dart
class LoggingAPI<MODEL, PARAM extends AbstractSimpleParameters>
    extends SimpleAPI<MODEL, PARAM> {

  LoggingAPI({
    required super.completeUrl,
    required super.factory,
    required super.method,
    required super.params,
  }) : super(
    changeListener: () {
      debugLog(
        'API State Change',
        'URL: $completeUrl, State: ${state.toString()}',
      );
    },
  );
}
```

---

## Response Transformation

### Purpose

Transform or filter response data before it becomes the model.

### Custom Parse Method

Override `parse()` in AbstractAPI:

```dart
class CustomAPI<MODEL, PARAM extends AbstractSimpleParameters>
    extends SimpleAPI<MODEL, PARAM> {

  CustomAPI({
    required super.completeUrl,
    required super.factory,
    required super.method,
    required super.params,
  });

  @override
  MODEL parse(http.Response response) {
    // Custom parsing logic
    final json = jsonDecode(response.body);

    // Transform data
    json['processedAt'] = DateTime.now().toIso8601String();

    // Apply factory
    return factory(jsonEncode(json));
  }
}
```

### Example: Filtering Response

```dart
@override
MODEL parse(http.Response response) {
  final json = jsonDecode(response.body);

  // Filter out inactive items
  if (json['items'] is List) {
    json['items'] = (json['items'] as List)
        .where((item) => item['active'] == true)
        .toList();
  }

  return factory(jsonEncode(json));
}
```

### Example: Response Validation

```dart
@override
MODEL parse(http.Response response) {
  // Validate status code
  if (response.statusCode != 200) {
    throw Exception('Unexpected status: ${response.statusCode}');
  }

  // Validate content type
  if (!response.headers['content-type']?.contains('application/json') ?? false) {
    throw Exception('Invalid content type');
  }

  return super.parse(response);
}
```

---

## Factory Utilities

### Purpose

Provide reusable JSON parsing utilities with error handling and logging.

### modelFromString

Parse single model from JSON string:

```dart
factory: FactoryUtils.modelFromString(
  UserModel.fromJson,
  subtag: 'data',        // Optional: Extract json['data'] first
  showLog: true,         // Optional: Show success/error messages
)
```

### listFromString

Parse list of models from JSON string:

```dart
factory: FactoryUtils.listFromString<UserModel>(
  UserModel.fromJson,
  perElementSubtag: null,          // Optional: Extract for each element
  entireDataSubTag: 'results',     // Optional: Extract json['results']
)
```

### Example: Nested Response

```json
{
  "status": "success",
  "data": {
    "user": {
      "id": "123",
      "name": "John"
    }
  }
}
```

```dart
// Extract json['data'] before parsing
factory: FactoryUtils.modelFromString(
  UserWrapper.fromJson,
  subtag: 'data',
)
```

### Example: List in Nested Object

```json
{
  "status": "success",
  "results": [
    {"id": "1", "name": "John"},
    {"id": "2", "name": "Jane"}
  ]
}
```

```dart
factory: FactoryUtils.listFromString<UserModel>(
  UserModel.fromJson,
  entireDataSubTag: 'results',  // Extract json['results'] array
)
```

---

## HTTP Client Configuration

### Purpose

Configure the singleton HTTP client used for all requests.

### HttpClientSingleton

Located in `lib/utils/api/core/http_client_singleton.dart`:

```dart
class HttpClientSingleton {
  static http.Client? _httpClient;

  static http.Client get instance {
    _httpClient ??= http.Client();
    return _httpClient!;
  }
}
```

### Custom Client Configuration

To use a custom HTTP client (e.g., with SSL pinning, proxy):

```dart
// In your app initialization
class HttpClientSingleton {
  static http.Client? _httpClient;

  static http.Client get instance {
    _httpClient ??= _createClient();
    return _httpClient!;
  }

  static http.Client _createClient() {
    // Example: Custom client with certificate pinning
    final client = http.Client();

    // Add interceptors, certificate pinning, etc.

    return client;
  }
}
```

---

## Performance Optimization

### 1. Use `keepAlive: true` for Providers

```dart
@Riverpod(keepAlive: true)  // Keeps provider alive
RiverpodAPI<UserModel, UserParams> userRepo(Ref ref) {
  // ...
}
```

### 2. Minimize Parameter Resets

```dart
// ✅ Good - Don't reset if parameters are reused
resetParamsOnExecute: false

// ❌ Bad - Resetting when not needed adds overhead
resetParamsOnExecute: true
```

### 3. Debounce Rapid Executions

```dart
Timer? _debounce;

void _onSearchChanged(String query) {
  _debounce?.cancel();
  _debounce = Timer(const Duration(milliseconds: 500), () {
    final repo = ref.read(searchRepoProvider);
    repo.requestParams.query = query;
    repo.execute();
  });
}
```

### 4. Cache Parsed Models

```dart
// Store parsed results to avoid re-parsing
final cachedUser = repo.latestValidResult;  // Reuse when possible
```

### 5. Clear Unused Repositories

```dart
@override
void dispose() {
  // Clear repo to free memory
  ref.read(largeDataRepoProvider).clear();
  super.dispose();
}
```

### 6. Optimize JSON Parsing

```dart
// Use efficient fromJson implementations
factory UserModel.fromJson(Map<String, dynamic> json) {
  return UserModel(
    id: json['id'] as String,  // Type casting
    name: json['name'] as String,
    // Avoid heavy computations here
  );
}
```

### 7. Monitor State Changes Efficiently

```dart
// ✅ Good - Watch only when needed
final repo = ref.watch(userRepoProvider);

// ❌ Bad - Watching unnecessarily causes rebuilds
// Watch in build(), not in initState()
```

---

## Summary

Advanced features enable:

✅ **resetParamsOnExecute** - Auto-clear params after requests
✅ **allowConcurrentRequests** - Prevent duplicate requests
✅ **timeoutSeconds** - Configure request timeouts
✅ **resetWhileRefreshing** - Keep old data during refresh
✅ **paginatedOverridenUrl** - Handle pagination URLs
✅ **changeListener** - Custom state change handling
✅ **Custom parse()** - Transform responses
✅ **FactoryUtils** - Reusable JSON parsing
✅ **HttpClientSingleton** - Centralized HTTP client
✅ **Performance tips** - Optimize for production

These features provide fine-grained control over API behavior while maintaining the simple, declarative API!
