# API System Architecture

This document provides a comprehensive overview of the API provider system architecture, design decisions, and component interactions.

## Table of Contents

1. [System Overview](#system-overview)
2. [Architecture Layers](#architecture-layers)
3. [Core Components](#core-components)
4. [Data Flow](#data-flow)
5. [Design Patterns](#design-patterns)
6. [State Management](#state-management)
7. [Type System](#type-system)

## System Overview

The API provider system is built as a layered architecture that separates concerns and provides a clean abstraction for HTTP API calls.

### Design Goals

1. **Type Safety**: Compile-time guarantees for API models and parameters
2. **State Predictability**: Clear state transitions with 8 distinct states
3. **Reusability**: Single implementation pattern for all endpoints
4. **Testability**: Mockable components at each layer
5. **Developer Experience**: Minimal boilerplate, maximum clarity

### Architecture Diagram

```
┌─────────────────────────────────────────────────────────────────────┐
│                         PRESENTATION LAYER                          │
│  ┌────────────────┐  ┌────────────────┐  ┌────────────────┐       │
│  │  User Screen   │  │  Order Screen  │  │  Other Screens │       │
│  │   (Widget)     │  │    (Widget)    │  │    (Widgets)   │       │
│  └────────┬───────┘  └────────┬───────┘  └────────┬───────┘       │
│           │                   │                    │                │
│           └───────────────────┼────────────────────┘                │
│                               │                                     │
│                        ref.watch/read                               │
│                               │                                     │
└───────────────────────────────┼─────────────────────────────────────┘
                                │
┌───────────────────────────────┼─────────────────────────────────────┐
│                    APPLICATION LAYER (Features)                     │
│                               │                                     │
│  ┌────────────────────────────▼───────────────────────────────┐    │
│  │                 Riverpod Providers                          │    │
│  │  @Riverpod userRepo()    @Riverpod orderRepo()             │    │
│  │  Returns: RiverpodAPI<Model, Params>                       │    │
│  └────────────────────────────┬───────────────────────────────┘    │
│                               │                                     │
│  ┌────────────┐  ┌────────────┐  ┌──────────────┐                 │
│  │   Model    │  │   Params   │  │  Repository  │                 │
│  │  .fromJson │  │  URL/Body  │  │   Provider   │                 │
│  └────────────┘  └────────────┘  └──────────────┘                 │
└───────────────────────────────┼─────────────────────────────────────┘
                                │
┌───────────────────────────────┼─────────────────────────────────────┐
│                       API PROVIDER LAYER                            │
│                               │                                     │
│  ┌────────────────────────────▼───────────────────────────────┐    │
│  │              RiverpodAPI<MODEL, PARAMS>                     │    │
│  │  ┌────────────────────────────────────────────────────┐    │    │
│  │  │  • ref.notifyListeners() on state change          │    │    │
│  │  │  • generateCommonHeaders() - Auth + Version       │    │    │
│  │  │  • requiresAuth parameter                         │    │    │
│  │  └────────────────────────────────────────────────────┘    │    │
│  └────────────────────────────┬───────────────────────────────┘    │
│                               │ extends                             │
│  ┌────────────────────────────▼───────────────────────────────┐    │
│  │               SimpleAPI<MODEL, PARAMS>                      │    │
│  │  ┌────────────────────────────────────────────────────┐    │    │
│  │  │  • generateRequest() - Build HTTP request         │    │    │
│  │  │  • MultipartRequest for files                     │    │    │
│  │  │  • URL formatting and trailing slash handling     │    │    │
│  │  │  • Content-Type management                        │    │    │
│  │  └────────────────────────────────────────────────────┘    │    │
│  └────────────────────────────┬───────────────────────────────┘    │
│                               │ extends                             │
│  ┌────────────────────────────▼───────────────────────────────┐    │
│  │       AbstractAPI<MODEL, PARAMS, REQUEST, RESPONSE>        │    │
│  │  ┌────────────────────────────────────────────────────┐    │    │
│  │  │  • execute() - Main execution flow                │    │    │
│  │  │  • State management (8 states)                    │    │    │
│  │  │  • Error handling (network, parse, 4xx)           │    │    │
│  │  │  • Response parsing with factory                  │    │    │
│  │  │  • Timeout management                             │    │    │
│  │  │  • Old data retention                             │    │    │
│  │  │  • Concurrent request control                     │    │    │
│  │  └────────────────────────────────────────────────────┘    │    │
│  └─────────────────────────────────────────────────────────────    │
└───────────────────────────────┼─────────────────────────────────────┘
                                │
┌───────────────────────────────┼─────────────────────────────────────┐
│                      INFRASTRUCTURE LAYER                           │
│                               │                                     │
│  ┌───────────────┐  ┌─────────▼────────┐  ┌──────────────────┐    │
│  │  APIState     │  │ HttpClient       │  │  FactoryUtils    │    │
│  │  (8 states)   │  │ Singleton        │  │  (JSON parsing)  │    │
│  └───────────────┘  └──────────────────┘  └──────────────────┘    │
│                                                                     │
│  ┌───────────────┐  ┌──────────────────┐  ┌──────────────────┐    │
│  │  Either       │  │  URLs            │  │  SimpleParams    │    │
│  │  (Error wrap) │  │  (Server config) │  │  (Base params)   │    │
│  └───────────────┘  └──────────────────┘  └──────────────────┘    │
└─────────────────────────────────────────────────────────────────────┘
```

## Architecture Layers

### 1. Presentation Layer

**Purpose**: User interface and user interactions

**Components**:
- `ConsumerWidget` / `ConsumerStatefulWidget` - Riverpod widgets
- `ApiStateFolder` - UI state renderer widget

**Responsibilities**:
- Display data from repositories
- Handle user interactions
- Trigger API calls via `repo.execute()`
- Render different UI based on state

### 2. Application Layer (Features)

**Purpose**: Feature-specific business logic

**Components**:
- Model classes with `fromJson` factories
- Parameter classes extending `SimpleParameters`
- Repository providers annotated with `@Riverpod`

**Responsibilities**:
- Define data structures
- Configure API endpoints
- Manage request parameters
- Provide typed access to API operations

### 3. API Provider Layer

**Purpose**: Generic API handling and Riverpod integration

**Components**:
- `RiverpodAPI` - Riverpod integration
- `SimpleAPI` - HTTP request implementation
- `AbstractAPI` - Base functionality

**Responsibilities**:
- State management
- Error handling
- Request/response lifecycle
- Authentication integration
- Change notifications

### 4. Infrastructure Layer

**Purpose**: Shared utilities and core types

**Components**:
- `APIState` - State enum
- `Either` - Error handling
- `HttpClientSingleton` - HTTP client
- `FactoryUtils` - JSON utilities
- `URLs` - Server configuration

**Responsibilities**:
- Type definitions
- Utility functions
- Configuration management
- Shared infrastructure

## Core Components

### AbstractAPI

**File**: `lib/utils/api/core/abstract_api.dart`

The foundation of all API implementations. Provides:

```dart
abstract class AbstractAPI<RESULT_MODEL, REQUEST_PARAM, REQUEST_TYPE, RESPONSE_TYPE>
```

**Key Features**:
- Generic type system for type safety
- State management with 8 distinct states
- Error handling (network, timeout, parsing)
- Response transformation via factory pattern
- Old data retention during refresh
- Concurrent request control

**State Management**:
```dart
RESULT_MODEL? _currentResult;        // Current result or null if error
RESULT_MODEL? _latestValidResult;   // Last successful result
APIState _currentState;               // Current state enum
DateTime? _lastSuccessfulCallTime;    // Timestamp of last success
```

**Core Method**: `execute()`
- Validates concurrent requests
- Updates state to loading
- Sends request via `sendActual()`
- Parses response via `parse()`
- Handles errors (SocketException, TimeoutException, etc.)
- Notifies listeners

### SimpleAPI

**File**: `lib/utils/api/implementation/simple_api/simple_api.dart`

Concrete implementation for standard HTTP requests.

```dart
class SimpleAPI<MODEL, PARAM extends AbstractSimpleParameters>
    extends AbstractAPI<MODEL, PARAM, http.BaseRequest, http.Response>
```

**Key Features**:
- Standard HTTP methods (GET, POST, PUT, DELETE, PATCH)
- Multipart form data for file uploads
- Automatic Content-Type handling
- URL formatting with trailing slash logic
- Parameter reset after execution (optional)

**Request Generation Flow**:
1. Format URL with parameters
2. Handle trailing slash for POST
3. Check for file uploads
4. Create MultipartRequest or standard Request
5. Add headers (Content-Type, custom headers)
6. Add body data (JSON or multipart)
7. Reset parameters if configured

### RiverpodAPI

**File**: `lib/utils/api/implementation/riverpod_api/riverpod_api.dart`

Riverpod-aware wrapper that extends SimpleAPI.

```dart
class RiverpodAPI<MODEL, PARAM extends AbstractSimpleParameters>
    extends SimpleAPI<MODEL, PARAM>
```

**Key Features**:
- Automatic `ref.notifyListeners()` on state change
- Common header generation (User-Agent, Version)
- Authentication header injection (when enabled)
- Seamless Riverpod integration

**Authentication**:
```dart
final bool requiresAuth;  // Default: true

Future<Map<String, String>> generateCommonHeaders() async {
  // Add USER-AGENT and APP-VERSION
  // Add Authorization header if requiresAuth is true (future enhancement)
  return headers;
}
```

### SimpleParameters

**File**: `lib/utils/api/implementation/simple_api/simple_params.dart`

Base class for API parameters.

```dart
class SimpleParameters extends AbstractSimpleParameters
```

**Provides**:
- `headers` - Map<String, String>
- `body` - Map<String, dynamic>
- `queryParams` - Map<String, String>
- `files` - Map<String, String> (key → file path)
- `paginatedOverridenUrl` - For pagination support

**Methods**:
- `getHeaders()` - Returns copy of headers
- `getBodyEncoded()` - JSON-encoded body string
- `getBodyUnencoded()` - Raw body map
- `getFormattedUrl(String raw)` - URL with query params
- `getFiles()` - File upload map
- `reset()` - Clear all parameters

### APIState

**File**: `lib/utils/api/core/api_state.dart`

Enum representing all possible API states.

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

**Properties**:
- `hasData: bool` - Whether data is available
- `isOngoing: bool` - Whether request is in progress
- `error: ErrorType` - Type of error (none, netError, modelParseError)
- `hasError: bool` - Whether any error occurred
- `hasInternetError: bool` - Whether it's a network error

### ApiStateFolder

**File**: `lib/utils/api_state_folder.dart`

Widget that renders UI based on repository states.

```dart
class ApiStateFolder extends StatelessWidget
```

**Features**:
- Monitor multiple repositories
- Pull-to-refresh support
- Custom builders for loading/loaded/error states
- Show old data during errors (optional)
- Show old data during loading (optional)
- Default loading/error widgets

**State Resolution Logic**:
1. Check all repos for error state → Show error if found
2. Check all repos for loading state → Show loading if found
3. Check all repos for initial state → Show loading if found
4. Otherwise → Show loaded state

## Data Flow

### Request Execution Flow

```
User Interaction (button press)
    │
    ▼
ref.read(repoProvider).execute()
    │
    ▼
AbstractAPI.execute()
    │
    ├─► Validate concurrent requests
    │
    ├─► State = ongoingWithoutOldData (or ongoingWithOldData)
    │
    ├─► ref.notifyListeners() [via changeListener]
    │
    ▼
SimpleAPI.generateRequest()
    │
    ├─► params.getFormattedUrl() - Format URL
    │
    ├─► Create http.Request or MultipartRequest
    │
    ├─► Add headers from params.getHeaders()
    │
    └─► Add body from params.getBodyEncoded()
    │
    ▼
RiverpodAPI.generateRequest()
    │
    ├─► Call super.generateRequest()
    │
    └─► req.headers.addAll(generateCommonHeaders())
    │
    ▼
AbstractAPI.sendActual()
    │
    ├─► HttpClientSingleton.instance.send(request)
    │
    └─► Apply timeout if configured
    │
    ▼
Response received
    │
    ├─► Wrap in Either<Response, Error>
    │
    ▼
AbstractAPI.parse(response)
    │
    ├─► factory(response.body) - Call Model.fromJson
    │
    ▼
Check status code
    │
    ├─► 4xx → modelParseFailedWithoutOldData
    │
    ├─► 2xx → success
    │
    └─► Error → internetErrorWithoutOldData
    │
    ▼
Update state and data
    │
    ├─► _currentResult = parsed
    │
    ├─► _latestValidResult = parsed (if success)
    │
    ├─► _currentState = new state
    │
    └─► changeListener() → ref.notifyListeners()
    │
    ▼
UI rebuilds (ref.watch detects change)
    │
    ▼
ApiStateFolder.build()
    │
    ├─► Check repo.state
    │
    ├─► if success → buildLoaded()
    │
    ├─► if error → buildError()
    │
    └─► if loading → buildLoading()
```

## Design Patterns

### 1. Factory Pattern

Used for JSON parsing:

```dart
factory: FactoryUtils.modelFromString(UserModel.fromJson)
```

This wraps the model's `fromJson` factory in error handling and logging.

### 2. Template Method Pattern

`AbstractAPI` defines the skeleton (`execute`), subclasses fill in details:

```dart
// AbstractAPI defines
Future<void> execute()  // Template method

// Subclasses implement
Future<REQUEST_TYPE> generateRequest()  // Step
RESULT_MODEL parse(RESPONSE_TYPE response)  // Step
```

### 3. Strategy Pattern

Different parameter strategies via `AbstractSimpleParameters`:

```dart
class UserParams extends SimpleParameters {
  // Custom URL formatting strategy
  @override
  String getFormattedUrl(String raw) {
    // Custom logic
  }
}
```

### 4. Observer Pattern

Riverpod's reactive system:

```dart
changeListener: () {
  ref.notifyListeners();  // Notify observers
}
```

### 5. Singleton Pattern

Single HTTP client instance:

```dart
class HttpClientSingleton {
  static http.Client get instance {
    _httpClient ??= http.Client();
    return _httpClient!;
  }
}
```

### 6. Either/Result Pattern

Functional error handling:

```dart
var res = await sendActual().toEither();
res.fold(
  (success) => handleSuccess(success),
  (error) => handleError(error),
);
```

## State Management

### State Transition Diagram

```
                   ┌─────────────┐
                   │   initial   │
                   └──────┬──────┘
                          │
                    execute()
                          │
                          ▼
        ┌─────────────────────────────────────┐
        │   ongoingWithoutOldData              │
        │   (first request)                    │
        └─────┬─────────────────┬──────────────┘
              │                 │
        success               error
              │                 │
              ▼                 ▼
      ┌───────────┐   ┌──────────────────────┐
      │  success  │   │ internetErrorWithout  │
      │           │   │ or                    │
      └─────┬─────┘   │ modelParseFailedWith  │
            │         └──────────────────────┘
      execute()
            │
            ▼
    ┌────────────────────┐
    │ ongoingWithOldData  │
    │ (refresh)           │
    └────┬─────────┬──────┘
         │         │
    success     error
         │         │
         ▼         ▼
   ┌─────────┐   ┌────────────────────┐
   │ success │   │ internetErrorWith  │
   │         │   │ or                 │
   └─────────┘   │ modelParseFailedWith│
                 └────────────────────┘
```

### State Properties

Each state carries information:

| State | hasData | isOngoing | error |
|-------|---------|-----------|-------|
| initial | false | false | none |
| ongoingWithoutOldData | false | true | none |
| ongoingWithOldData | true | true | none |
| success | true | false | none |
| internetErrorWithoutOldData | false | false | netError |
| internetErrorWithOldData | true | false | netError |
| modelParseFailedWithoutOldData | false | false | modelParseError |
| modelParseFailedWithOldData | true | false | modelParseError |

## Type System

### Generic Type Parameters

The system uses generics extensively for type safety:

```dart
AbstractAPI<
  RESULT_MODEL,      // The parsed model type
  REQUEST_PARAM,     // The parameters type
  REQUEST_TYPE,      // HTTP request type (usually BaseRequest)
  RESPONSE_TYPE      // HTTP response type (usually Response)
>
```

### Type Flow Example

```dart
// User defines
class UserModel { }
class UserParams extends SimpleParameters { }

// Provider returns
RiverpodAPI<UserModel, UserParams>

// Which extends
SimpleAPI<UserModel, UserParams>

// Which extends
AbstractAPI<UserModel, UserParams, http.BaseRequest, http.Response>

// Result:
repo.currentResult → UserModel?
repo.latestValidResult → UserModel?
repo.requestParams → UserParams
```

This ensures:
- ✅ Compile-time type checking
- ✅ IDE autocomplete
- ✅ Refactoring safety
- ✅ No runtime type errors

## Summary

The API system architecture provides:

1. **Layered Design**: Clear separation of concerns
2. **Type Safety**: Generics throughout the stack
3. **State Predictability**: 8 well-defined states
4. **Extensibility**: Easy to add new features via inheritance
5. **Riverpod Integration**: Seamless reactive state management
6. **Error Resilience**: Multiple error handling strategies
7. **Developer Experience**: Minimal boilerplate, clear patterns

The architecture enables AI agents and developers to quickly create new API endpoints by following established patterns while maintaining consistency across the codebase.
