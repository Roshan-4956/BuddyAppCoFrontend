# API Reference

Complete API reference for all classes, methods, and properties in the API provider system.

## Table of Contents

1. [AbstractAPI](#abstractapi)
2. [SimpleAPI](#simpleapi)
3. [RiverpodAPI](#riverpodapi)
4. [SimpleParameters](#simpleparameters)
5. [AbstractSimpleParameters](#abstractsimpleparameters)
6. [APIState](#apistate)
7. [ApiStateHolder](#apistateholder)
8. [ApiStateFolder](#apistatefolder)
9. [FactoryUtils](#factoryutils)
10. [URLs](#urls)
11. [HTTPMethod](#httpmethod)
12. [Either](#either)

---

## AbstractAPI

Base class for all API implementations. Provides state management, error handling, and response parsing.

### File Location
`lib/utils/api/core/abstract_api.dart`

### Class Signature

```dart
abstract class AbstractAPI<
  RESULT_MODEL,
  REQUEST_PARAM,
  REQUEST_TYPE extends http.BaseRequest,
  RESPONSE_TYPE extends http.BaseResponse
> extends ApiStateHolder
```

### Type Parameters

| Parameter | Description |
|-----------|-------------|
| `RESULT_MODEL` | The type of the parsed response model |
| `REQUEST_PARAM` | The type of request parameters |
| `REQUEST_TYPE` | HTTP request type (usually `http.BaseRequest`) |
| `RESPONSE_TYPE` | HTTP response type (usually `http.Response`) |

### Constructor

```dart
AbstractAPI({
  required String completeUrl,
  required RESULT_MODEL Function(String) factory,
  required String httpMethod,
  int? timeoutSeconds = GlobalSettings.defaultTimeoutSecs,
  void Function()? onConcurrentRequestRejectListener,
  void Function()? changeListener,
})
```

**Parameters:**

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `completeUrl` | `String` | Yes | - | Full URL for the API endpoint |
| `factory` | `Function(String)` | Yes | - | Function to parse JSON string to model |
| `httpMethod` | `String` | Yes | - | HTTP method (GET, POST, etc.) |
| `timeoutSeconds` | `int?` | No | 120 | Request timeout in seconds |
| `onConcurrentRequestRejectListener` | `Function()?` | No | null | Called when concurrent request is rejected |
| `changeListener` | `Function()?` | No | null | Called when state changes |

### Properties

#### Public Properties

```dart
// Current result (null if latest request failed)
RESULT_MODEL? get currentResult

// Latest valid result (retains last successful result)
RESULT_MODEL? get latestValidResult

// Current API state
APIState get state

// Timestamp of last successful call
DateTime? get lastSuccessfulCallTime

// Request parameters
REQUEST_PARAM get requestParams
```

#### Configuration Properties

```dart
// Debug logging tag
String get debugTag => '[API]: ($RESULT_MODEL)'

// Error logging tag
String get errorTag => '[API ERROR]: ($RESULT_MODEL)'

// Whether to reset data when refreshing (default: true)
bool get resetWhileRefreshing => true

// Whether to allow concurrent requests (default: false)
bool get allowConcurrentRequests => false

// Complete URL
final String completeUrl

// HTTP method (GET, POST, etc.)
final String httpMethod

// Factory function for parsing
final RESULT_MODEL Function(String) factory

// Timeout in seconds
final int? timeoutSeconds
```

### Methods

#### execute()

Executes the API request with full error handling and state management.

```dart
Future<void> execute()
```

**Behavior:**
1. Checks concurrent request rules
2. Updates state to loading
3. Generates and sends request
4. Parses response
5. Updates state and data
6. Handles errors

**Example:**
```dart
final repo = ref.read(userRepoProvider);
repo.requestParams.userId = '123';
await repo.execute();
```

#### generateRequest()

Generates the HTTP request. Must be implemented by subclasses.

```dart
Future<REQUEST_TYPE> generateRequest()
```

**Returns:** Configured HTTP request ready to send

#### sendActual()

Sends the HTTP request and returns the raw response.

```dart
Future<RESPONSE_TYPE> sendActual()
```

**Returns:** Raw HTTP response

**Throws:**
- `TimeoutException` if timeout is reached
- `SocketException` on network errors

#### parse()

Parses the raw response into the result model type.

```dart
RESULT_MODEL parse(RESPONSE_TYPE response)
```

**Parameters:**
- `response` - Raw HTTP response

**Returns:** Parsed model instance

**Throws:** Exception if parsing fails

#### clear()

Clears all data and resets state to initial.

```dart
void clear()
```

**Example:**
```dart
@override
void dispose() {
  ref.read(userRepoProvider).clear();
  super.dispose();
}
```

---

## SimpleAPI

Concrete implementation of AbstractAPI for standard HTTP requests.

### File Location
`lib/utils/api/implementation/simple_api/simple_api.dart`

### Class Signature

```dart
class SimpleAPI<MODEL, PARAM extends AbstractSimpleParameters>
    extends AbstractAPI<MODEL, PARAM, http.BaseRequest, http.Response>
```

### Constructor

```dart
SimpleAPI({
  required String completeUrl,
  required MODEL Function(String) factory,
  required HTTPMethod method,
  required PARAM params,
  bool resetParamsOnExecute = false,
  void Function()? changeListener,
})
```

**Parameters:**

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `completeUrl` | `String` | Yes | - | Full URL for the API endpoint |
| `factory` | `Function(String)` | Yes | - | Function to parse JSON string to model |
| `method` | `HTTPMethod` | Yes | - | HTTP method enum |
| `params` | `PARAM` | Yes | - | Parameters instance |
| `resetParamsOnExecute` | `bool` | No | false | Whether to reset params after execute |
| `changeListener` | `Function()?` | No | null | Called when state changes |

### Properties

```dart
// Parameters instance
final PARAM params

// Whether to reset params after execute
final bool resetParamsOnExecute

// Access to request parameters
@override
PARAM get requestParams => params
```

### Methods

#### generateRequest()

Generates HTTP request (standard or multipart for files).

```dart
@override
Future<http.BaseRequest> generateRequest()
```

**Behavior:**
1. Formats URL with parameters
2. Handles trailing slash for POST
3. Checks for file uploads
4. Creates `MultipartRequest` if files present, otherwise `Request`
5. Adds headers and body
6. Resets parameters if configured

**Returns:** Configured `http.BaseRequest`

### Request Generation Logic

```dart
// URL formatting
String finalUrl = params.getFormattedUrl(completeUrl)

// Add trailing slash for POST (unless URL ends with #)
if (!finalUrl.endsWith('/') && httpMethod == 'POST') {
  finalUrl += '/'
}

// File uploads use MultipartRequest
if (params.getFiles().isNotEmpty) {
  var mpRequest = http.MultipartRequest(httpMethod, Uri.parse(finalUrl))
  mpRequest.headers['Content-Type'] = 'multipart/form-data'
  // Add fields and files
}

// Standard requests use Request
else {
  var simpleReq = http.Request(httpMethod, Uri.parse(finalUrl))
  simpleReq.headers['Content-Type'] = 'application/json'
  simpleReq.body = params.getBodyEncoded()
}
```

---

## RiverpodAPI

Riverpod-aware implementation that extends SimpleAPI.

### File Location
`lib/utils/api/implementation/riverpod_api/riverpod_api.dart`

### Class Signature

```dart
class RiverpodAPI<MODEL, PARAM extends AbstractSimpleParameters>
    extends SimpleAPI<MODEL, PARAM>
```

### Constructor

```dart
RiverpodAPI({
  required String completeUrl,
  required MODEL Function(String) factory,
  required HTTPMethod method,
  required PARAM params,
  required Ref ref,
  bool resetParamsOnExecute = false,
  bool requiresAuth = true,
})
```

**Parameters:**

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `completeUrl` | `String` | Yes | - | Full URL for the API endpoint |
| `factory` | `Function(String)` | Yes | - | Function to parse JSON string to model |
| `method` | `HTTPMethod` | Yes | - | HTTP method enum |
| `params` | `PARAM` | Yes | - | Parameters instance |
| `ref` | `Ref` | Yes | - | Riverpod reference |
| `resetParamsOnExecute` | `bool` | No | false | Whether to reset params after execute |
| `requiresAuth` | `bool` | No | true | Whether endpoint requires authentication |

### Properties

```dart
// Riverpod reference
final Ref ref

// Whether endpoint requires authentication
final bool requiresAuth
```

### Methods

#### generateRequest()

Extends SimpleAPI's generateRequest to add common headers.

```dart
@override
Future<http.BaseRequest> generateRequest()
```

**Behavior:**
1. Calls `super.generateRequest()`
2. Adds common headers via `generateCommonHeaders()`
3. Returns configured request

#### generateCommonHeaders()

Generates common headers (User-Agent, Version, Auth).

```dart
Future<Map<String, String>> generateCommonHeaders()
```

**Current Implementation:**
```dart
return {
  'USER-AGENT': 'mobile',
  'APP-VERSION': '2.0.0',
}
```

**Future (when auth is enabled):**
```dart
if (requiresAuth) {
  // Refresh token if needed
  // Get current token
  return {
    'Authorization': 'Bearer $token',
    'USER-AGENT': 'mobile',
    'APP-VERSION': '2.0.0',
  }
}
```

### Change Notification

Automatically calls `ref.notifyListeners()` on state changes:

```dart
RiverpodAPI(
  // ...
  changeListener: () {
    ref.notifyListeners()
  },
)
```

---

## SimpleParameters

Base implementation of API parameters.

### File Location
`lib/utils/api/implementation/simple_api/simple_params.dart`

### Class Signature

```dart
class SimpleParameters extends AbstractSimpleParameters
```

### Properties

```dart
// Request headers
@protected
Map<String, String> headers = {}

// Request body (unencoded)
@protected
Map<String, dynamic> body = {}

// Query parameters
@protected
Map<String, String> queryParams = {}

// Files to upload (key → file path)
@protected
Map<String, String> files = {}

// Override for pagination URLs
@protected
String? paginatedOverridenUrl
```

### Methods

#### getHeaders()

Returns a copy of the headers map.

```dart
@override
Map<String, String> getHeaders()
```

**Returns:** Copy of headers

#### getBodyEncoded()

Returns JSON-encoded body string.

```dart
@override
String getBodyEncoded()
```

**Returns:** JSON string of body

**Example:**
```dart
body = {'name': 'John', 'age': 30}
getBodyEncoded() // '{"name":"John","age":30}'
```

#### getBodyUnencoded()

Returns raw body map.

```dart
@override
Map<String, dynamic> getBodyUnencoded()
```

**Returns:** Unencoded body map

#### getFormattedUrl()

Formats URL with query parameters.

```dart
@override
String getFormattedUrl(String raw)
```

**Parameters:**
- `raw` - Base URL

**Returns:** URL with query params appended

**Behavior:**
- If `paginatedOverridenUrl` is set, returns that
- Otherwise appends query params: `url?key1=value1&key2=value2&`

**Example:**
```dart
queryParams = {'page': '1', 'limit': '20'}
getFormattedUrl('https://api.com/users')
// 'https://api.com/users?page=1&limit=20&'
```

#### getFiles()

Returns files map.

```dart
@override
Map<String, String> getFiles()
```

**Returns:** Files map (key → file path)

#### reset()

Clears all parameters.

```dart
@override
void reset()
```

**Behavior:** Empties headers, body, queryParams, and files

---

## AbstractSimpleParameters

Abstract interface for API parameters.

### File Location
`lib/utils/api/implementation/simple_api/abstract_simple_params.dart`

### Class Signature

```dart
abstract class AbstractSimpleParameters
```

### Methods

All methods must be implemented by subclasses:

```dart
// Returns request headers
Map<String, String> getHeaders()

// Returns JSON-encoded body
String getBodyEncoded()

// Returns raw body map
Map<String, dynamic> getBodyUnencoded()

// Returns files for upload
Map<String, String> getFiles()

// Formats URL with parameters
String getFormattedUrl(String raw)

// Optional URL override
String? get overriddenUrl

// Resets all parameters
void reset()
```

---

## APIState

Enum representing all possible API states.

### File Location
`lib/utils/api/core/api_state.dart`

### Enum Definition

```dart
enum APIState {
  initial,
  ongoingWithoutOldData,
  ongoingWithOldData,
  success,
  internetErrorWithoutOldData,
  internetErrorWithOldData,
  modelParseFailedWithoutOldData,
  modelParseFailedWithOldData,
}
```

### State Values

| State | hasData | isOngoing | error |
|-------|---------|-----------|-------|
| `initial` | false | false | none |
| `ongoingWithoutOldData` | false | true | none |
| `ongoingWithOldData` | true | true | none |
| `success` | true | false | none |
| `internetErrorWithoutOldData` | false | false | netError |
| `internetErrorWithOldData` | true | false | netError |
| `modelParseFailedWithoutOldData` | false | false | modelParseError |
| `modelParseFailedWithOldData` | true | false | modelParseError |

### Properties

```dart
// Type of error
final ErrorType error

// Whether data is available
final bool hasData

// Whether error is network-related
bool get hasInternetError => error == ErrorType.netError

// Whether any error occurred
bool get hasError => error != ErrorType.none

// Whether request is in progress
final bool isOngoing
```

### Methods

```dart
// Convert state to ongoing variant
APIState convertToOngoing()
```

**Returns:** `ongoingWithOldData` if `hasData` is true, otherwise `ongoingWithoutOldData`

---

## ApiStateHolder

Abstract base class for objects that hold API state.

### File Location
`lib/utils/api/core/api_state_holder.dart`

### Class Signature

```dart
abstract class ApiStateHolder
```

### Properties

```dart
// Current API state
APIState get state

// Setter for state
set state(APIState state)
```

---

## ApiStateFolder

Widget that renders UI based on repository states.

### File Location
`lib/utils/api_state_folder.dart`

### Class Signature

```dart
class ApiStateFolder extends StatelessWidget
```

### Constructor

```dart
const ApiStateFolder({
  required List<ApiStateHolder> repos,
  required Widget Function() buildLoaded,
  Widget Function()? buildError,
  Widget Function()? buildLoading,
  void Function()? onRefresh,
  bool showOldDataOnError = false,
  bool showInitialAsLoaded = false,
  bool skiploading = false,
  bool showOldDataWhileLoading = false,
  bool defaultErrorStateIsBouncy = true,
  Key? key,
})
```

**Parameters:**

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `repos` | `List<ApiStateHolder>` | Yes | - | Repositories to monitor |
| `buildLoaded` | `Widget Function()` | Yes | - | Builder for loaded state |
| `buildError` | `Widget Function()?` | No | null | Builder for error state |
| `buildLoading` | `Widget Function()?` | No | null | Builder for loading state |
| `onRefresh` | `void Function()?` | No | null | Refresh callback (enables pull-to-refresh) |
| `showOldDataOnError` | `bool` | No | false | Show loaded UI even on error |
| `showInitialAsLoaded` | `bool` | No | false | Show loaded UI in initial state |
| `skiploading` | `bool` | No | false | Never show loading UI |
| `showOldDataWhileLoading` | `bool` | No | false | Show loaded UI while loading |
| `defaultErrorStateIsBouncy` | `bool` | No | true | Default error UI has bouncy scroll |

### State Resolution Logic

The widget checks all repos and determines which UI to show:

1. **If any repo has error and `showOldDataOnError` is false:**
   - Show `buildError()` or default error UI

2. **If any repo is loading and `showOldDataWhileLoading` is false:**
   - Show `buildLoading()` or default loading UI

3. **If any repo is initial and `showInitialAsLoaded` is false:**
   - Show `buildLoading()` or default loading UI

4. **Otherwise:**
   - Show `buildLoaded()`

### Default Widgets

#### Default Loading

```dart
Container(
  color: BrandColors.backgroundNavMenu,
  child: Center(
    child: Lottie.asset(
      'assets/loader/loader.json',
      width: 150,
      height: 150,
    ),
  ),
)
```

#### Default Error

```dart
Center(
  child: SvgPicture.asset(SvgAssets.errorsSvg),
)
```

---

## FactoryUtils

Utility class for JSON parsing with error handling.

### File Location
`lib/utils/factory_utils.dart`

### Class Signature

```dart
class FactoryUtils
```

### Methods

#### modelFromString()

Creates a function that converts JSON string to model instance.

```dart
static T Function(String) modelFromString<T>(
  T Function(Map<String, dynamic>) factory, {
  String? subtag,
  bool showLog = true,
})
```

**Parameters:**

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `factory` | `Function(Map)` | Yes | - | Model's `fromJson` function |
| `subtag` | `String?` | No | null | Extract `json[subtag]` before parsing |
| `showLog` | `bool` | No | true | Show success/error messages |

**Returns:** Function that takes JSON string and returns model instance

**Example:**
```dart
factory: FactoryUtils.modelFromString(
  UserModel.fromJson,
  subtag: 'data',  // Extracts json['data'] first
)
```

**Behavior:**
1. Decodes JSON string
2. Extracts subtag if provided
3. Shows message if present in response
4. Calls factory function
5. Handles errors with logging

#### listFromString()

Creates a function that converts JSON string to list of models.

```dart
static List<T> Function(String) listFromString<T>(
  T Function(Map<String, dynamic>) factory, {
  String? perElementSubtag,
  String? entireDataSubTag,
})
```

**Parameters:**

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `factory` | `Function(Map)` | Yes | - | Model's `fromJson` function |
| `perElementSubtag` | `String?` | No | null | Extract for each element |
| `entireDataSubTag` | `String?` | No | null | Extract array from `json[tag]` |

**Returns:** Function that takes JSON string and returns list of models

**Example:**
```dart
factory: FactoryUtils.listFromString<UserModel>(
  UserModel.fromJson,
  entireDataSubTag: 'results',  // Extracts json['results'] array
)
```

---

## URLs

Manages URL configuration for API endpoints.

### File Location
`lib/utils/urls.dart`

### Class Signature

```dart
class URLs
```

### Constants

```dart
// Main production server
static const String _mainResourceServerUrl = 'https://buddy-back.built.systems'

// Test server
static const String _testResourceServerUrl = 'http://172.17.103.95:8000'

// Main API endpoint
static const String _mainApiServerUrl = '$_mainResourceServerUrl/main/'

// Test API endpoint
static const String _testApiServerUrl = '$_testResourceServerUrl/test/'

// Active server URL (based on GlobalSettings)
static const String serverUrl = !GlobalSettings.useProductionServer
    ? _testApiServerUrl
    : _mainApiServerUrl

// Active resource URL
static const String resourceUrl = GlobalSettings.useProductionServer
    ? _testApiServerUrl
    : _mainApiServerUrl
```

### Methods

#### complete()

Completes a partial URL path with the active server URL.

```dart
static String complete(String local)
```

**Parameters:**
- `local` - Partial URL path

**Returns:** Full URL with server prefix

**Example:**
```dart
URLs.complete('users/123')
// Returns: 'https://buddy-back.built.systems/main/users/123'
```

---

## HTTPMethod

Enum for HTTP methods.

### File Location
`lib/utils/api/core/http_method.dart`

### Enum Definition

```dart
enum HTTPMethod {
  get('GET'),
  post('POST'),
  put('PUT'),
  delete('DELETE'),
  patch('PATCH'),
}
```

### Properties

```dart
// String value of the method
final String value
```

### Usage

```dart
method: HTTPMethod.get
method: HTTPMethod.post
method: HTTPMethod.put
method: HTTPMethod.delete
method: HTTPMethod.patch
```

---

## Either

Functional error handling type.

### File Location
`lib/utils/api/core/either.dart`

### Class Signature

```dart
class Either<L, R>
```

### Type Parameters

| Parameter | Description |
|-----------|-------------|
| `L` | Left type (success value) |
| `R` | Right type (error value) |

### Properties

```dart
final L? left    // Success value
final R? right   // Error value
```

### Methods

#### fold()

Handles both success and error cases.

```dart
T fold<T>(
  T Function(L) onLeft,
  T Function(R) onRight,
)
```

**Parameters:**
- `onLeft` - Function to handle success
- `onRight` - Function to handle error

**Returns:** Result of the appropriate function

**Example:**
```dart
var result = await sendActual().toEither()

result.fold(
  (response) {
    // Handle success
    return parse(response)
  },
  (error) {
    // Handle error
    return handleError(error)
  },
)
```

### Extension: EitherFutureExtension

Adds `toEither()` method to `Future<T>`.

```dart
extension EitherFutureExtension<T> on Future<T> {
  Future<Either<T, Object?>> toEither()
}
```

**Behavior:**
- Awaits the future
- Returns `Either(left: result)` on success
- Returns `Either(right: error)` on error

**Example:**
```dart
var result = await sendActual().toEither()

// Success: result.left contains response
// Error: result.right contains exception
```

---

## ErrorType

Enum for classifying errors.

### File Location
`lib/utils/api/core/api_state.dart`

### Enum Definition

```dart
enum ErrorType {
  none,              // No error
  netError,          // Network/connectivity error
  modelParseError,   // Response parsing error
}
```

### Usage

```dart
if (state.error == ErrorType.netError) {
  // Handle network error
}

if (state.error == ErrorType.modelParseError) {
  // Handle parsing error
}
```

---

## Summary

This reference covers:

✅ **AbstractAPI** - Base class with state management
✅ **SimpleAPI** - Standard HTTP implementation
✅ **RiverpodAPI** - Riverpod integration
✅ **SimpleParameters** - Request configuration
✅ **APIState** - 8-state system
✅ **ApiStateFolder** - UI state rendering
✅ **FactoryUtils** - JSON parsing utilities
✅ **URLs** - Server configuration
✅ **HTTPMethod** - HTTP method enum
✅ **Either** - Functional error handling

All components work together to provide a type-safe, state-managed API system with comprehensive error handling!
