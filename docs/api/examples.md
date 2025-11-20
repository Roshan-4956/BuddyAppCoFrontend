# API Examples

This document provides complete, copy-paste ready examples for common API scenarios.

## Table of Contents

1. [GET Request](#get-request)
2. [POST Request with Body](#post-request-with-body)
3. [PUT Request (Update)](#put-request-update)
4. [DELETE Request](#delete-request)
5. [File Upload](#file-upload)
6. [List/Array Response](#listarray-response)
7. [Query Parameters](#query-parameters)
8. [Custom Headers](#custom-headers)
9. [Pagination](#pagination)
10. [Authentication](#authentication)
11. [Multiple URL Parameters](#multiple-url-parameters)
12. [Nested JSON Response](#nested-json-response)

---

## GET Request

**Scenario**: Fetch a single user by ID

### Folder Structure
```
lib/features/user_detail/
├── application/
│   ├── user_detail_model.dart
│   ├── user_detail_params.dart
│   └── user_detail_repo.dart
└── presentation/
    └── user_detail_screen.dart
```

### Model

`lib/features/user_detail/application/user_detail_model.dart`:

```dart
class UserDetailModel {
  final String id;
  final String name;
  final String email;
  final String? phone;

  UserDetailModel({
    required this.id,
    required this.name,
    required this.email,
    this.phone,
  });

  factory UserDetailModel.fromJson(Map<String, dynamic> json) {
    return UserDetailModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
    );
  }
}
```

### Parameters

`lib/features/user_detail/application/user_detail_params.dart`:

```dart
import '../../../utils/api/implementation/simple_api/simple_params.dart';

class UserDetailParams extends SimpleParameters {
  static const String userIdPlaceholder = '{userId}';
  String? userId;

  @override
  String getFormattedUrl(String raw) {
    String formatted = super.getFormattedUrl(raw);
    if (userId != null) {
      formatted = formatted.replaceFirst(userIdPlaceholder, userId!);
    }
    return formatted;
  }
}
```

### Repository

`lib/features/user_detail/application/user_detail_repo.dart`:

```dart
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../utils/api/core/http_method.dart';
import '../../../utils/api/implementation/riverpod_api/riverpod_api.dart';
import '../../../utils/factory_utils.dart';
import '../../../utils/urls.dart';
import 'user_detail_model.dart';
import 'user_detail_params.dart';

part 'user_detail_repo.g.dart';

@Riverpod(keepAlive: true)
RiverpodAPI<UserDetailModel, UserDetailParams> userDetailRepo(Ref ref) {
  return RiverpodAPI<UserDetailModel, UserDetailParams>(
    completeUrl: URLs.complete('users/{userId}'),
    factory: FactoryUtils.modelFromString(UserDetailModel.fromJson),
    params: UserDetailParams(),
    method: HTTPMethod.get,
    ref: ref,
  );
}
```

### Usage

```dart
// In your widget
final repo = ref.read(userDetailRepoProvider);
repo.requestParams.userId = '123';
repo.execute();
```

---

## POST Request with Body

**Scenario**: Create a new user with form data

### Model

`lib/features/user_create/application/user_create_model.dart`:

```dart
class UserCreateModel {
  final String id;
  final String message;

  UserCreateModel({
    required this.id,
    required this.message,
  });

  factory UserCreateModel.fromJson(Map<String, dynamic> json) {
    return UserCreateModel(
      id: json['id'],
      message: json['message'] ?? 'User created successfully',
    );
  }
}
```

### Parameters

`lib/features/user_create/application/user_create_params.dart`:

```dart
import '../../../utils/api/implementation/simple_api/simple_params.dart';

class UserCreateParams extends SimpleParameters {
  // Setters for body fields
  set name(String value) => body['name'] = value;
  set email(String value) => body['email'] = value;
  set phone(String value) => body['phone'] = value;
  set age(int value) => body['age'] = value;

  // Getters for body fields
  String get name => body['name'] ?? '';
  String get email => body['email'] ?? '';
  String get phone => body['phone'] ?? '';
  int get age => body['age'] ?? 0;
}
```

### Repository

`lib/features/user_create/application/user_create_repo.dart`:

```dart
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../utils/api/core/http_method.dart';
import '../../../utils/api/implementation/riverpod_api/riverpod_api.dart';
import '../../../utils/factory_utils.dart';
import '../../../utils/urls.dart';
import 'user_create_model.dart';
import 'user_create_params.dart';

part 'user_create_repo.g.dart';

@Riverpod(keepAlive: true)
RiverpodAPI<UserCreateModel, UserCreateParams> userCreateRepo(Ref ref) {
  return RiverpodAPI<UserCreateModel, UserCreateParams>(
    completeUrl: URLs.complete('users'),
    factory: FactoryUtils.modelFromString(UserCreateModel.fromJson),
    params: UserCreateParams(),
    method: HTTPMethod.post,
    ref: ref,
    resetParamsOnExecute: true,  // Clear params after request
  );
}
```

### Usage

```dart
// In your widget
final repo = ref.read(userCreateRepoProvider);

// Set request body
repo.requestParams.name = 'John Doe';
repo.requestParams.email = 'john@example.com';
repo.requestParams.phone = '+1234567890';
repo.requestParams.age = 30;

// Execute
repo.execute();
```

---

## PUT Request (Update)

**Scenario**: Update an existing user

### Model

`lib/features/user_update/application/user_update_model.dart`:

```dart
class UserUpdateModel {
  final String message;
  final Map<String, dynamic> updatedData;

  UserUpdateModel({
    required this.message,
    required this.updatedData,
  });

  factory UserUpdateModel.fromJson(Map<String, dynamic> json) {
    return UserUpdateModel(
      message: json['message'],
      updatedData: json['data'] ?? {},
    );
  }
}
```

### Parameters

`lib/features/user_update/application/user_update_params.dart`:

```dart
import '../../../utils/api/implementation/simple_api/simple_params.dart';

class UserUpdateParams extends SimpleParameters {
  // URL parameter
  static const String userIdPlaceholder = '{userId}';
  String? userId;

  // Body setters
  set name(String value) => body['name'] = value;
  set email(String value) => body['email'] = value;
  set phone(String value) => body['phone'] = value;

  @override
  String getFormattedUrl(String raw) {
    String formatted = super.getFormattedUrl(raw);
    if (userId != null) {
      formatted = formatted.replaceFirst(userIdPlaceholder, userId!);
    }
    return formatted;
  }
}
```

### Repository

`lib/features/user_update/application/user_update_repo.dart`:

```dart
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../utils/api/core/http_method.dart';
import '../../../utils/api/implementation/riverpod_api/riverpod_api.dart';
import '../../../utils/factory_utils.dart';
import '../../../utils/urls.dart';
import 'user_update_model.dart';
import 'user_update_params.dart';

part 'user_update_repo.g.dart';

@Riverpod(keepAlive: true)
RiverpodAPI<UserUpdateModel, UserUpdateParams> userUpdateRepo(Ref ref) {
  return RiverpodAPI<UserUpdateModel, UserUpdateParams>(
    completeUrl: URLs.complete('users/{userId}'),
    factory: FactoryUtils.modelFromString(UserUpdateModel.fromJson),
    params: UserUpdateParams(),
    method: HTTPMethod.put,
    ref: ref,
  );
}
```

### Usage

```dart
final repo = ref.read(userUpdateRepoProvider);

// Set URL parameter
repo.requestParams.userId = '123';

// Set body fields to update
repo.requestParams.name = 'John Updated';
repo.requestParams.email = 'john.updated@example.com';

repo.execute();
```

---

## DELETE Request

**Scenario**: Delete a user by ID

### Model

`lib/features/user_delete/application/user_delete_model.dart`:

```dart
class UserDeleteModel {
  final bool success;
  final String message;

  UserDeleteModel({
    required this.success,
    required this.message,
  });

  factory UserDeleteModel.fromJson(Map<String, dynamic> json) {
    return UserDeleteModel(
      success: json['success'] ?? true,
      message: json['message'] ?? 'Deleted successfully',
    );
  }
}
```

### Parameters

`lib/features/user_delete/application/user_delete_params.dart`:

```dart
import '../../../utils/api/implementation/simple_api/simple_params.dart';

class UserDeleteParams extends SimpleParameters {
  static const String userIdPlaceholder = '{userId}';
  String? userId;

  @override
  String getFormattedUrl(String raw) {
    String formatted = super.getFormattedUrl(raw);
    if (userId != null) {
      formatted = formatted.replaceFirst(userIdPlaceholder, userId!);
    }
    return formatted;
  }
}
```

### Repository

`lib/features/user_delete/application/user_delete_repo.dart`:

```dart
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../utils/api/core/http_method.dart';
import '../../../utils/api/implementation/riverpod_api/riverpod_api.dart';
import '../../../utils/factory_utils.dart';
import '../../../utils/urls.dart';
import 'user_delete_model.dart';
import 'user_delete_params.dart';

part 'user_delete_repo.g.dart';

@Riverpod(keepAlive: true)
RiverpodAPI<UserDeleteModel, UserDeleteParams> userDeleteRepo(Ref ref) {
  return RiverpodAPI<UserDeleteModel, UserDeleteParams>(
    completeUrl: URLs.complete('users/{userId}'),
    factory: FactoryUtils.modelFromString(UserDeleteModel.fromJson),
    params: UserDeleteParams(),
    method: HTTPMethod.delete,
    ref: ref,
  );
}
```

### Usage

```dart
final repo = ref.read(userDeleteRepoProvider);
repo.requestParams.userId = '123';
repo.execute();
```

---

## File Upload

**Scenario**: Upload a profile picture with form data

### Model

`lib/features/profile_upload/application/profile_upload_model.dart`:

```dart
class ProfileUploadModel {
  final String fileUrl;
  final String message;

  ProfileUploadModel({
    required this.fileUrl,
    required this.message,
  });

  factory ProfileUploadModel.fromJson(Map<String, dynamic> json) {
    return ProfileUploadModel(
      fileUrl: json['file_url'],
      message: json['message'] ?? 'Upload successful',
    );
  }
}
```

### Parameters

`lib/features/profile_upload/application/profile_upload_params.dart`:

```dart
import '../../../utils/api/implementation/simple_api/simple_params.dart';

class ProfileUploadParams extends SimpleParameters {
  // URL parameter
  static const String userIdPlaceholder = '{userId}';
  String? userId;

  // File path setter (key → local file path)
  set profilePicture(String filePath) => files['profile_picture'] = filePath;

  // Optional: Additional form fields
  set description(String value) => body['description'] = value;

  @override
  String getFormattedUrl(String raw) {
    String formatted = super.getFormattedUrl(raw);
    if (userId != null) {
      formatted = formatted.replaceFirst(userIdPlaceholder, userId!);
    }
    return formatted;
  }
}
```

### Repository

`lib/features/profile_upload/application/profile_upload_repo.dart`:

```dart
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../utils/api/core/http_method.dart';
import '../../../utils/api/implementation/riverpod_api/riverpod_api.dart';
import '../../../utils/factory_utils.dart';
import '../../../utils/urls.dart';
import 'profile_upload_model.dart';
import 'profile_upload_params.dart';

part 'profile_upload_repo.g.dart';

@Riverpod(keepAlive: true)
RiverpodAPI<ProfileUploadModel, ProfileUploadParams> profileUploadRepo(
  Ref ref,
) {
  return RiverpodAPI<ProfileUploadModel, ProfileUploadParams>(
    completeUrl: URLs.complete('users/{userId}/upload'),
    factory: FactoryUtils.modelFromString(ProfileUploadModel.fromJson),
    params: ProfileUploadParams(),
    method: HTTPMethod.post,
    ref: ref,
    resetParamsOnExecute: true,
  );
}
```

### Usage

```dart
// Pick file using file_picker or image_picker
final result = await FilePicker.platform.pickFiles(type: FileType.image);

if (result != null && result.files.single.path != null) {
  final repo = ref.read(profileUploadRepoProvider);

  // Set URL parameter
  repo.requestParams.userId = '123';

  // Set file path
  repo.requestParams.profilePicture = result.files.single.path!;

  // Optional: Set description
  repo.requestParams.description = 'My new profile picture';

  // Execute
  repo.execute();
}
```

---

## List/Array Response

**Scenario**: Fetch a list of users

### Model

`lib/features/user_list/application/user_list_model.dart`:

```dart
class UserListModel {
  final List<UserItem> users;
  final int total;

  UserListModel({
    required this.users,
    required this.total,
  });

  factory UserListModel.fromJson(Map<String, dynamic> json) {
    return UserListModel(
      users: (json['users'] as List)
          .map((item) => UserItem.fromJson(item))
          .toList(),
      total: json['total'] ?? 0,
    );
  }
}

class UserItem {
  final String id;
  final String name;
  final String email;

  UserItem({
    required this.id,
    required this.name,
    required this.email,
  });

  factory UserItem.fromJson(Map<String, dynamic> json) {
    return UserItem(
      id: json['id'],
      name: json['name'],
      email: json['email'],
    );
  }
}
```

**Alternative**: If response is a direct array:

```dart
// For response: [{"id": "1", "name": "John"}, ...]

class UserListModel {
  final List<UserItem> users;

  UserListModel({required this.users});

  // Use FactoryUtils.listFromString instead
  static List<UserItem> fromJsonList(String jsonString) {
    return FactoryUtils.listFromString<UserItem>(
      UserItem.fromJson,
    )(jsonString);
  }
}
```

### Repository (for wrapped array)

```dart
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../utils/api/core/http_method.dart';
import '../../../utils/api/implementation/riverpod_api/riverpod_api.dart';
import '../../../utils/factory_utils.dart';
import '../../../utils/urls.dart';
import 'user_list_model.dart';
import 'user_list_params.dart';

part 'user_list_repo.g.dart';

@Riverpod(keepAlive: true)
RiverpodAPI<UserListModel, UserListParams> userListRepo(Ref ref) {
  return RiverpodAPI<UserListModel, UserListParams>(
    completeUrl: URLs.complete('users'),
    factory: FactoryUtils.modelFromString(UserListModel.fromJson),
    params: UserListParams(),
    method: HTTPMethod.get,
    ref: ref,
  );
}
```

### Repository (for direct array)

```dart
@Riverpod(keepAlive: true)
RiverpodAPI<List<UserItem>, UserListParams> userListRepo(Ref ref) {
  return RiverpodAPI<List<UserItem>, UserListParams>(
    completeUrl: URLs.complete('users'),
    factory: FactoryUtils.listFromString<UserItem>(UserItem.fromJson),
    params: UserListParams(),
    method: HTTPMethod.get,
    ref: ref,
  );
}
```

---

## Query Parameters

**Scenario**: Search users with filters

### Parameters

`lib/features/user_search/application/user_search_params.dart`:

```dart
import '../../../utils/api/implementation/simple_api/simple_params.dart';

class UserSearchParams extends SimpleParameters {
  // Query parameter setters
  set searchQuery(String value) => queryParams['q'] = value;
  set page(int value) => queryParams['page'] = value.toString();
  set limit(int value) => queryParams['limit'] = value.toString();
  set sortBy(String value) => queryParams['sort_by'] = value;
  set order(String value) => queryParams['order'] = value;

  // Getters
  String get searchQuery => queryParams['q'] ?? '';
  int get page => int.tryParse(queryParams['page'] ?? '1') ?? 1;
  int get limit => int.tryParse(queryParams['limit'] ?? '20') ?? 20;
}
```

### Repository

```dart
@Riverpod(keepAlive: true)
RiverpodAPI<UserSearchModel, UserSearchParams> userSearchRepo(Ref ref) {
  return RiverpodAPI<UserSearchModel, UserSearchParams>(
    completeUrl: URLs.complete('users/search'),
    factory: FactoryUtils.modelFromString(UserSearchModel.fromJson),
    params: UserSearchParams(),
    method: HTTPMethod.get,
    ref: ref,
  );
}
```

### Usage

```dart
final repo = ref.read(userSearchRepoProvider);

// Set query parameters
repo.requestParams.searchQuery = 'john';
repo.requestParams.page = 1;
repo.requestParams.limit = 20;
repo.requestParams.sortBy = 'name';
repo.requestParams.order = 'asc';

repo.execute();

// Resulting URL: /users/search?q=john&page=1&limit=20&sort_by=name&order=asc
```

---

## Custom Headers

**Scenario**: Add custom headers to a request

### Parameters

`lib/features/custom_header_api/application/custom_header_params.dart`:

```dart
import '../../../utils/api/implementation/simple_api/simple_params.dart';

class CustomHeaderParams extends SimpleParameters {
  // Add custom headers
  void addCustomHeader(String key, String value) {
    headers[key] = value;
  }

  // Convenience setters for common headers
  set apiKey(String value) => headers['X-API-Key'] = value;
  set customToken(String value) => headers['X-Custom-Token'] = value;
  set acceptLanguage(String value) => headers['Accept-Language'] = value;
}
```

### Usage

```dart
final repo = ref.read(customHeaderRepoProvider);

// Add custom headers
repo.requestParams.apiKey = 'your-api-key-here';
repo.requestParams.acceptLanguage = 'en-US';
repo.requestParams.addCustomHeader('X-Request-ID', 'unique-id-123');

repo.execute();
```

---

## Pagination

**Scenario**: Paginated list with next/previous URLs from API

### Model

`lib/features/paginated_users/application/paginated_users_model.dart`:

```dart
class PaginatedUsersModel {
  final List<UserItem> users;
  final int total;
  final String? nextUrl;
  final String? previousUrl;

  PaginatedUsersModel({
    required this.users,
    required this.total,
    this.nextUrl,
    this.previousUrl,
  });

  factory PaginatedUsersModel.fromJson(Map<String, dynamic> json) {
    return PaginatedUsersModel(
      users: (json['results'] as List)
          .map((item) => UserItem.fromJson(item))
          .toList(),
      total: json['count'],
      nextUrl: json['next'],
      previousUrl: json['previous'],
    );
  }

  bool get hasNext => nextUrl != null;
  bool get hasPrevious => previousUrl != null;
}
```

### Parameters

`lib/features/paginated_users/application/paginated_users_params.dart`:

```dart
import '../../../utils/api/implementation/simple_api/simple_params.dart';

class PaginatedUsersParams extends SimpleParameters {
  // For manual pagination
  set page(int value) => queryParams['page'] = value.toString();

  // For API-provided next/previous URLs
  void setNextPageUrl(String url) {
    paginatedOverridenUrl = url;
  }

  void setPreviousPageUrl(String url) {
    paginatedOverridenUrl = url;
  }

  void clearOverriddenUrl() {
    paginatedOverridenUrl = null;
  }
}
```

### Repository

```dart
@Riverpod(keepAlive: true)
RiverpodAPI<PaginatedUsersModel, PaginatedUsersParams> paginatedUsersRepo(
  Ref ref,
) {
  return RiverpodAPI<PaginatedUsersModel, PaginatedUsersParams>(
    completeUrl: URLs.complete('users'),
    factory: FactoryUtils.modelFromString(PaginatedUsersModel.fromJson),
    params: PaginatedUsersParams(),
    method: HTTPMethod.get,
    ref: ref,
  );
}
```

### Usage

```dart
// Initial load
final repo = ref.read(paginatedUsersRepoProvider);
repo.execute();

// Load next page (using API URL)
  void loadNextPage() {
    final repo = ref.read(paginatedUsersRepoProvider);
    final currentResult = repo.latestValidResult;
  if (currentResult != null && currentResult.hasNext) {
    repo.requestParams.setNextPageUrl(currentResult.nextUrl!);
    repo.execute();
  }
}

// Load previous page
  void loadPreviousPage() {
    final repo = ref.read(paginatedUsersRepoProvider);
    final currentResult = repo.latestValidResult;
  if (currentResult != null && currentResult.hasPrevious) {
    repo.requestParams.setPreviousPageUrl(currentResult.previousUrl!);
    repo.execute();
  }
}

// Load specific page (manual pagination)
void loadPage(int pageNumber) {
  final repo = ref.read(paginatedUsersRepoProvider);
  repo.requestParams.clearOverriddenUrl();
  repo.requestParams.page = pageNumber;
  repo.execute();
}
```

---

## Authentication

**Scenario**: Configure authentication for API calls

### Understanding `requiresAuth`

The `RiverpodAPI` class has a `requiresAuth` parameter (default: `true`) that controls whether authentication headers should be added to requests.

```dart
@Riverpod(keepAlive: true)
RiverpodAPI<UserModel, UserParams> userRepo(Ref ref) {
  return RiverpodAPI<UserModel, UserParams>(
    completeUrl: URLs.complete('users/{userId}'),
    factory: FactoryUtils.modelFromString(UserModel.fromJson),
    params: UserParams(),
    method: HTTPMethod.get,
    ref: ref,
    requiresAuth: true,  // This endpoint requires authentication
  );
}
```

### Public Endpoints (No Auth)

For public endpoints that don't require authentication:

```dart
@Riverpod(keepAlive: true)
RiverpodAPI<PublicDataModel, PublicDataParams> publicDataRepo(Ref ref) {
  return RiverpodAPI<PublicDataModel, PublicDataParams>(
    completeUrl: URLs.complete('public/data'),
    factory: FactoryUtils.modelFromString(PublicDataModel.fromJson),
    params: PublicDataParams(),
    method: HTTPMethod.get,
    ref: ref,
    requiresAuth: false,  // No authentication required
  );
}
```

### Current Headers (when `requiresAuth: true`)

Currently, `RiverpodAPI` adds these headers:

```dart
{
  'USER-AGENT': 'mobile',
  'APP-VERSION': '2.0.0',
}
```

### Future: Adding Authentication

When you're ready to enable authentication, you'll update the `generateCommonHeaders()` method in `RiverpodAPI` (currently commented out):

```dart
// In lib/utils/api/implementation/riverpod_api/riverpod_api.dart

Future<Map<String, String>> generateCommonHeaders() async {
  if (requiresAuth) {
    // 1. Refresh token if needed
    await ref
        .read(authenticationControllerProvider.notifier)
        .refreshAccessTokenIfNeeded();

    // 2. Get current tokens
    var currentTokens = ref.read(authTokensRepoProvider).latestValidResult;

    if (currentTokens == null) {
      throw Exception('Auth token not found.');
    }

    // 3. Return headers with auth
    return {
      'Authorization': 'Bearer ${currentTokens.access}',
      'USER-AGENT': 'mobile',
      'APP-VERSION': '2.0.0',
    };
  }

  // No auth required
  return {
    'USER-AGENT': 'mobile',
    'APP-VERSION': '2.0.0',
  };
}
```

### Custom Auth Headers (Current Workaround)

If you need custom auth headers now, use the params:

```dart
final repo = ref.read(userRepoProvider);

// Add auth header manually
repo.requestParams.headers['Authorization'] = 'Bearer $yourToken';

repo.execute();
```

---

## Multiple URL Parameters

**Scenario**: API with multiple placeholders like `/organizations/{orgId}/projects/{projectId}`

### Parameters

`lib/features/project_detail/application/project_detail_params.dart`:

```dart
import '../../../utils/api/implementation/simple_api/simple_params.dart';

class ProjectDetailParams extends SimpleParameters {
  // Placeholders
  static const String orgIdPlaceholder = '{orgId}';
  static const String projectIdPlaceholder = '{projectId}';

  // Parameters
  String? orgId;
  String? projectId;

  @override
  String getFormattedUrl(String raw) {
    String formatted = super.getFormattedUrl(raw);

    // Replace all placeholders
    if (orgId != null) {
      formatted = formatted.replaceFirst(orgIdPlaceholder, orgId!);
    }

    if (projectId != null) {
      formatted = formatted.replaceFirst(projectIdPlaceholder, projectId!);
    }

    return formatted;
  }
}
```

### Repository

```dart
@Riverpod(keepAlive: true)
RiverpodAPI<ProjectDetailModel, ProjectDetailParams> projectDetailRepo(
  Ref ref,
) {
  return RiverpodAPI<ProjectDetailModel, ProjectDetailParams>(
    completeUrl: URLs.complete('organizations/{orgId}/projects/{projectId}'),
    factory: FactoryUtils.modelFromString(ProjectDetailModel.fromJson),
    params: ProjectDetailParams(),
    method: HTTPMethod.get,
    ref: ref,
  );
}
```

### Usage

```dart
final repo = ref.read(projectDetailRepoProvider);

repo.requestParams.orgId = 'org-123';
repo.requestParams.projectId = 'project-456';

repo.execute();

// Result: /organizations/org-123/projects/project-456
```

---

## Nested JSON Response

**Scenario**: API returns nested JSON structure

### Example Response

```json
{
  "status": "success",
  "data": {
    "user": {
      "id": "123",
      "name": "John Doe",
      "profile": {
        "bio": "Developer",
        "location": "San Francisco"
      }
    }
  }
}
```

### Model

`lib/features/nested_user/application/nested_user_model.dart`:

```dart
class NestedUserModel {
  final String status;
  final UserData data;

  NestedUserModel({
    required this.status,
    required this.data,
  });

  factory NestedUserModel.fromJson(Map<String, dynamic> json) {
    return NestedUserModel(
      status: json['status'],
      data: UserData.fromJson(json['data']),
    );
  }
}

class UserData {
  final User user;

  UserData({required this.user});

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      user: User.fromJson(json['user']),
    );
  }
}

class User {
  final String id;
  final String name;
  final Profile profile;

  User({
    required this.id,
    required this.name,
    required this.profile,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      profile: Profile.fromJson(json['profile']),
    );
  }
}

class Profile {
  final String bio;
  final String location;

  Profile({
    required this.bio,
    required this.location,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      bio: json['bio'],
      location: json['location'],
    );
  }
}
```

### Alternative: Using FactoryUtils with subtag

If you only need the nested data:

```dart
@Riverpod(keepAlive: true)
RiverpodAPI<User, UserParams> nestedUserRepo(Ref ref) {
  return RiverpodAPI<User, UserParams>(
    completeUrl: URLs.complete('user/nested'),
    // Extract 'data.user' from response before parsing
    factory: FactoryUtils.modelFromString(
      User.fromJson,
      subtag: 'data',  // This extracts json['data'] before calling fromJson
    ),
    params: UserParams(),
    method: HTTPMethod.get,
    ref: ref,
  );
}
```

---

## Summary

These examples cover the most common API scenarios:

- ✅ GET requests with URL parameters
- ✅ POST requests with JSON body
- ✅ PUT requests for updates
- ✅ DELETE requests
- ✅ File uploads with multipart form data
- ✅ List/array responses
- ✅ Query parameters for filtering
- ✅ Custom headers
- ✅ Pagination (manual and API-provided)
- ✅ Authentication configuration
- ✅ Multiple URL parameters
- ✅ Nested JSON responses

All examples follow the same pattern and can be adapted to your specific API needs!
