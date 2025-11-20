# API Provider System Documentation

Welcome to the Buddy App API provider system documentation. This system provides a robust, type-safe, and state-managed approach to handling HTTP API calls in your Flutter application using Riverpod.

## Overview

The API provider system is built on three core principles:

1. **Type Safety**: Every API endpoint has strongly typed models and parameters
2. **State Management**: Automatic handling of loading, success, and error states
3. **Riverpod Integration**: Seamless integration with Riverpod for reactive UI updates

## Key Features

- ✅ Automatic state management (8 distinct states)
- ✅ Built-in error handling (network errors, parsing errors)
- ✅ Support for all HTTP methods (GET, POST, PUT, DELETE, PATCH)
- ✅ File upload support with multipart form data
- ✅ URL parameter formatting and query strings
- ✅ Timeout configuration
- ✅ Request headers management
- ✅ Authentication support (configurable)
- ✅ Pagination support
- ✅ Old data retention during refresh
- ✅ Concurrent request control
- ✅ UI widgets for state rendering

## Documentation Structure

### Getting Started
- [Quick Start Guide](./getting-started.md) - Create your first API endpoint in 5 minutes

### Core Documentation
- [Architecture Overview](./architecture.md) - Understanding the system design
- [API Reference](./api-reference.md) - Complete API documentation
- [Error Handling](./error-handling.md) - Managing API states and errors
- [Advanced Features](./advanced-features.md) - Configuration and optimization

### Examples & Guides
- [Examples](./examples.md) - Complete working examples for common scenarios

## Quick Example

Here's a minimal example of creating an API endpoint:

```dart
// 1. Define your model
class User {
  final String name;
  final String email;

  User({required this.name, required this.email});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(name: json['name'], email: json['email']);
  }
}

// 2. Create parameters class
class UserParams extends SimpleParameters {}

// 3. Create repository provider
@Riverpod(keepAlive: true)
RiverpodAPI<User, UserParams> userRepo(Ref ref) {
  return RiverpodAPI<User, UserParams>(
    completeUrl: URLs.complete('users/123'),
    factory: FactoryUtils.modelFromString(User.fromJson),
    params: UserParams(),
    method: HTTPMethod.get,
    ref: ref,
  );
}

// 4. Use in UI
class UserScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final repo = ref.watch(userRepoProvider);

    return ApiStateFolder(
      repos: [repo],
      onRefresh: () => repo.execute(),
      buildLoading: () => CircularProgressIndicator(),
      buildLoaded: () => Text('User: ${repo.latestValidResult?.name}'),
    );
  }
}
```

## System Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                      Your Feature Code                       │
│  ┌────────────┐  ┌────────────┐  ┌────────────┐            │
│  │   Model    │  │   Params   │  │    Repo    │            │
│  │  (JSON)    │  │ (URL/Body) │  │ (Provider) │            │
│  └────────────┘  └────────────┘  └────────────┘            │
└────────────┬────────────────────────────┬───────────────────┘
             │                            │
             ▼                            ▼
┌─────────────────────────────────────────────────────────────┐
│                    API Provider Layer                        │
│  ┌──────────────────────────────────────────────────────┐   │
│  │              RiverpodAPI<MODEL, PARAMS>              │   │
│  │  • Authentication headers                            │   │
│  │  • Riverpod state notifications                      │   │
│  │  • Common headers (User-Agent, Version)              │   │
│  └──────────────────────────────────────────────────────┘   │
│                            │                                 │
│                            ▼                                 │
│  ┌──────────────────────────────────────────────────────┐   │
│  │              SimpleAPI<MODEL, PARAMS>                │   │
│  │  • Request generation                                │   │
│  │  • File upload handling                              │   │
│  │  • URL formatting                                    │   │
│  └──────────────────────────────────────────────────────┘   │
│                            │                                 │
│                            ▼                                 │
│  ┌──────────────────────────────────────────────────────┐   │
│  │            AbstractAPI<MODEL, PARAMS>                │   │
│  │  • State management (8 states)                       │   │
│  │  • Error handling                                    │   │
│  │  • Response parsing                                  │   │
│  │  • Timeout management                                │   │
│  └──────────────────────────────────────────────────────┘   │
└────────────┬────────────────────────────┬───────────────────┘
             │                            │
             ▼                            ▼
┌─────────────────────────┐  ┌──────────────────────────────┐
│   HTTP Client Layer     │  │      State Management        │
│  • HttpClientSingleton  │  │  • APIState (8 states)       │
│  • Request execution    │  │  • ApiStateHolder            │
│  • Response streaming   │  │  • ApiStateFolder (UI)       │
└─────────────────────────┘  └──────────────────────────────┘
```

## Core Components

| Component | Purpose | File |
|-----------|---------|------|
| **AbstractAPI** | Base class for all APIs | `lib/utils/api/core/abstract_api.dart` |
| **SimpleAPI** | Standard HTTP implementation | `lib/utils/api/implementation/simple_api/simple_api.dart` |
| **RiverpodAPI** | Riverpod-aware API wrapper | `lib/utils/api/implementation/riverpod_api/riverpod_api.dart` |
| **SimpleParameters** | Request configuration | `lib/utils/api/implementation/simple_api/simple_params.dart` |
| **APIState** | State enum (8 states) | `lib/utils/api/core/api_state.dart` |
| **ApiStateFolder** | UI state handler widget | `lib/utils/api_state_folder.dart` |
| **Either** | Functional error handling | `lib/utils/api/core/either.dart` |
| **FactoryUtils** | JSON parsing utilities | `lib/utils/factory_utils.dart` |
| **URLs** | URL management | `lib/utils/urls.dart` |

## The 8 API States

The system manages 8 distinct states to handle all scenarios:

1. **initial** - No API call made yet
2. **ongoingWithoutOldData** - First request in progress
3. **ongoingWithOldData** - Refreshing with previous data available
4. **success** - Request succeeded with data
5. **internetErrorWithoutOldData** - Network error, no previous data
6. **internetErrorWithOldData** - Network error, previous data available
7. **modelParseFailedWithoutOldData** - JSON parsing failed, no previous data
8. **modelParseFailedWithOldData** - JSON parsing failed, previous data available

## Getting Help

- Check the [Examples](./examples.md) for common use cases
- Review the [API Reference](./api-reference.md) for detailed documentation
- Read [Error Handling](./error-handling.md) for troubleshooting

## Next Steps

Start with the [Quick Start Guide](./getting-started.md) to create your first API endpoint.
