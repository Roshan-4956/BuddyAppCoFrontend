# API Documentation - Authentication & Onboarding

## Overview

This document provides comprehensive documentation for the **Authentication**, **Onboarding**, and **User Management** APIs. All responses follow a standardized format with consistent status codes and error handling.

### Base URL
```
http://localhost:8000/api/v1
```

### Authentication
Most endpoints require a valid JWT access token in the `Authorization` header:
```
Authorization: Bearer <access_token>
```

### Standard Response Format
All API responses follow this format:
```json
{
  "is_success": boolean,
  "message": "string",
  "data": object | null
}
```

---

## Authentication APIs

### 1. Register with Email

**Endpoint:** `POST /auth/register/email`
**Authentication:** Not required
**Description:** Register a new user with email and password

#### Request Body
```json
{
  "email": "user@example.com",
  "password": "SecurePassword123!"
}
```

**Field Specifications:**
- `email`: Valid email address (EmailStr)
- `password`: Strong password with requirements:
  - Minimum 8 characters
  - At least 1 uppercase letter
  - At least 1 lowercase letter
  - At least 1 number
  - At least 1 special character

#### Success Response (201)
```json
{
  "is_success": true,
  "message": "User registered successfully",
  "data": {
    "user_id": "550e8400-e29b-41d4-a716-446655440000",
    "access_token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
    "refresh_token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
    "onboarding_required": true,
    "onboarding_progress": {
      "flow_id": "email_signup",
      "current_step": 1,
      "total_steps": 4,
      "progress_percentage": 0.0
    }
  }
}
```

#### Error Responses

**400 - Email Already Registered**
```json
{
  "detail": "Email already registered"
}
```

**422 - Validation Error**
```json
{
  "detail": [
    {
      "type": "value_error.email",
      "loc": ["body", "email"],
      "msg": "invalid email format",
      "input": "invalid-email"
    },
    {
      "type": "value_error",
      "loc": ["body", "password"],
      "msg": "Password must contain at least 1 uppercase letter",
      "input": "weakpassword123"
    }
  ]
}
```

**500 - Server Error**
```json
{
  "detail": "Signup flow not configured"
}
```

---

### 2. Login

**Endpoint:** `POST /auth/login`
**Authentication:** Not required
**Description:** Authenticate user with email or phone and password

#### Request Body
```json
{
  "email": "user@example.com",
  "password": "SecurePassword123!"
}
```

**OR**

```json
{
  "phone": "+1234567890",
  "password": "SecurePassword123!"
}
```

**Field Specifications:**
- Either `email` (EmailStr) or `phone` (PhoneNumber) is required
- `password`: User's password (string)

#### Success Response (200)
```json
{
  "is_success": true,
  "message": "Login successful",
  "data": {
    "user_id": "550e8400-e29b-41d4-a716-446655440000",
    "access_token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
    "refresh_token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
    "onboarding_required": false,
    "onboarding_progress": null
  }
}
```

**Onboarding In Progress Response (200)**
```json
{
  "is_success": true,
  "message": "Login successful",
  "data": {
    "user_id": "550e8400-e29b-41d4-a716-446655440000",
    "access_token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
    "refresh_token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
    "onboarding_required": true,
    "onboarding_progress": {
      "flow_id": "email_signup",
      "current_step": 2,
      "total_steps": 4,
      "progress_percentage": 25.0
    }
  }
}
```

#### Error Responses

**401 - Invalid Credentials**
```json
{
  "detail": "Invalid credentials"
}
```

**403 - Account Inactive**
```json
{
  "detail": "Account is inactive"
}
```

**403 - Account Deleted**
```json
{
  "detail": "Account is deleted"
}
```

**422 - Validation Error (Missing Email/Phone)**
```json
{
  "detail": [
    {
      "type": "value_error",
      "loc": ["body"],
      "msg": "Either email or phone is required",
      "input": {"email": null, "phone": null, "password": "test"}
    }
  ]
}
```

---

### 3. Get Current User

**Endpoint:** `GET /auth/me`
**Authentication:** Required ✓
**Description:** Retrieve current authenticated user's information

#### Success Response (200)
```json
{
  "is_success": true,
  "message": "User retrieved successfully",
  "data": {
    "user_id": "550e8400-e29b-41d4-a716-446655440000",
    "email": "user@example.com",
    "phone": "+1234567890",
    "is_onboarding_complete": true,
    "profile_status": "complete",
    "auth_providers": ["email"],
    "created_at": "2024-01-15T10:30:00Z"
  }
}
```

#### Error Responses

**401 - Unauthorized (Missing/Invalid Token)**
```json
{
  "detail": "Not authenticated"
}
```

---

### 4. Forgot Password (Request OTP)

**Endpoint:** `POST /auth/forgot-password`
**Authentication:** Not required
**Description:** Request password reset OTP to be sent to email

#### Request Body
```json
{
  "email": "user@example.com"
}
```

#### Success Response (200)
```json
{
  "is_success": true,
  "message": "Password reset OTP sent",
  "data": {
    "message": "OTP sent to your email",
    "otp_sent": true
  }
}
```

#### Error Responses

**404 - User Not Found**
```json
{
  "detail": "User not found"
}
```

**403 - Account Inactive**
```json
{
  "detail": "Account is inactive"
}
```

**403 - Account Deleted**
```json
{
  "detail": "Account is deleted"
}
```

**400 - Email Auth Not Enabled**
```json
{
  "detail": "Email authentication not enabled for this account"
}
```

---

### 5. Verify OTP

**Endpoint:** `POST /auth/verify-otp`
**Authentication:** Not required
**Description:** Verify OTP and receive reset token

#### Request Body
```json
{
  "email": "user@example.com",
  "otp": "123456"
}
```

**Field Specifications:**
- `email`: User's email address (EmailStr)
- `otp`: 6-digit OTP sent to email (string)

#### Success Response (200)
```json
{
  "is_success": true,
  "message": "OTP verification completed",
  "data": {
    "valid": true,
    "reset_token": "abc123def456ghi789...",
    "expires_in": 300
  }
}
```

#### Invalid OTP Response (200)
```json
{
  "is_success": true,
  "message": "OTP verification completed",
  "data": {
    "valid": false,
    "reset_token": null,
    "expires_in": null
  }
}
```

#### Error Responses

**404 - User Not Found**
```json
{
  "detail": "User not found"
}
```

---

### 6. Reset Password

**Endpoint:** `POST /auth/reset-password`
**Authentication:** Not required
**Description:** Reset password using reset token from OTP verification

#### Request Body
```json
{
  "email": "user@example.com",
  "reset_token": "abc123def456ghi789...",
  "new_password": "NewSecurePassword123!"
}
```

**Field Specifications:**
- `email`: User's email address (EmailStr)
- `reset_token`: Token received from OTP verification endpoint
- `new_password`: New password (same requirements as registration)

#### Success Response (200)
```json
{
  "is_success": true,
  "message": "Password reset completed",
  "data": {
    "message": "Password reset successfully",
    "otp_sent": false
  }
}
```

#### Error Responses

**400 - Invalid/Expired Reset Token**
```json
{
  "detail": "Invalid or expired reset token"
}
```

**400 - Invalid User ID Format**
```json
{
  "detail": "Invalid user ID format"
}
```

**404 - User Not Found**
```json
{
  "detail": "User not found"
}
```

---

## Onboarding APIs

### 1. Get Onboarding Progress

**Endpoint:** `GET /onboarding/progress`
**Authentication:** Required ✓
**Description:** Retrieve user's current onboarding progress and next step information

#### Success Response (200)
```json
{
  "is_success": true,
  "message": "Progress retrieved successfully",
  "data": {
    "user_id": "550e8400-e29b-41d4-a716-446655440000",
    "flow_id": "email_signup",
    "current_step": {
      "step_number": 1,
      "step_id": "basic_info",
      "name": "Basic Information",
      "required_fields": ["first_name", "last_name", "date_of_birth", "state_id", "city_id", "address"],
      "skippable": false
    },
    "completed_steps": [],
    "skipped_steps": [],
    "progress_percentage": 0.0,
    "is_complete": false
  }
}
```

#### Error Response (401)
```json
{
  "detail": "Not authenticated"
}
```

---

### 2. Submit Onboarding Step

**Endpoint:** `POST /onboarding/step`
**Authentication:** Required ✓
**Description:** Submit data for a onboarding step. Auto-completes onboarding on last step.

#### Request Body - Step 1: Basic Information
```json
{
  "step_number": 1,
  "data": {
    "first_name": "John",
    "last_name": "Doe",
    "date_of_birth": "1990-05-15",
    "state_id": 1,
    "city_id": 5,
    "address": "123 Main Street, Apartment 4B"
  }
}
```

#### Request Body - Step 2: Professional Information
```json
{
  "step_number": 2,
  "data": {
    "occupation_id": 3,
    "gender_id": 1
  }
}
```

#### Request Body - Step 3: Profile Photo
```json
{
  "step_number": 3,
  "data": {
    "profile_photo": "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAADUlEQVR42mNk+M9QDwADhgGAWjR9awAAAABJRU5ErkJggg=="
  }
}
```

#### Request Body - Step 4: Interests
```json
{
  "step_number": 4,
  "data": {
    "interest_ids": [1, 2, 3, 5, 7]
  }
}
```

**Field Specifications:**
- `step_number`: Integer (1-4)
- `data`: Object with step-specific fields
  - **Step 1 (Basic Info)**: first_name, last_name, date_of_birth (YYYY-MM-DD), state_id, city_id, address
  - **Step 2 (Professional)**: occupation_id, gender_id
  - **Step 3 (Photo)**: profile_photo (base64 encoded image with data:image/ prefix)
  - **Step 4 (Interests)**: interest_ids (array of 3-10 unique integers)

#### Success Response - Step Submitted (200)
```json
{
  "is_success": true,
  "message": "Step submitted successfully",
  "data": {
    "success": true,
    "next_step": {
      "step_number": 2,
      "step_id": "professional_info",
      "name": "Professional Information",
      "required_fields": ["occupation_id", "gender_id"],
      "skippable": false
    },
    "progress_percentage": 25.0
  }
}
```

#### Success Response - Onboarding Completed (200)
```json
{
  "is_success": true,
  "message": "Onboarding completed successfully",
  "data": {
    "success": true,
    "profile_status": "complete",
    "profile_completion_percentage": 100,
    "missing_optional_fields": [],
    "redirect_to": "/home"
  }
}
```

#### Error Responses

**401 - Unauthorized**
```json
{
  "detail": "Not authenticated"
}
```

**400 - Validation Error**
```json
{
  "detail": [
    {
      "type": "value_error",
      "loc": ["body", "data", "profile_photo"],
      "msg": "Profile photo must be a base64 encoded image",
      "input": "invalid_base64"
    }
  ]
}
```

**400 - Duplicate Interests**
```json
{
  "detail": [
    {
      "type": "value_error",
      "loc": ["body", "data", "interest_ids"],
      "msg": "Duplicate interests not allowed",
      "input": [1, 2, 2, 3]
    }
  ]
}
```

**400 - Invalid Interest Count**
```json
{
  "detail": [
    {
      "type": "value_error",
      "loc": ["body", "data", "interest_ids"],
      "msg": "ensure this value has at least 3 items",
      "input": [1, 2]
    }
  ]
}
```

---

### 3. Skip Optional Step

**Endpoint:** `POST /onboarding/skip`
**Authentication:** Required ✓
**Description:** Skip an optional onboarding step

#### Request Body
```json
{
  "step_id": "professional_info"
}
```

#### Success Response (200)
```json
{
  "is_success": true,
  "message": "Step skipped successfully",
  "data": {
    "success": true,
    "skipped": true,
    "next_step": {
      "step_number": 3,
      "step_id": "profile_photo",
      "name": "Profile Photo",
      "required_fields": ["profile_photo"],
      "skippable": false
    },
    "progress_percentage": 50.0
  }
}
```

#### Error Response (401)
```json
{
  "detail": "Not authenticated"
}
```

---

### 4. Complete Onboarding

**Endpoint:** `POST /onboarding/complete`
**Authentication:** Required ✓
**Description:** Manually complete onboarding and create user profile

#### Request Body
```json
{}
```

#### Success Response (200)
```json
{
  "is_success": true,
  "message": "Onboarding completed successfully",
  "data": {
    "success": true,
    "profile_status": "complete",
    "profile_completion_percentage": 100,
    "missing_optional_fields": [],
    "redirect_to": "/home"
  }
}
```

#### Error Response (401)
```json
{
  "detail": "Not authenticated"
}
```

---

## Static Data APIs

These endpoints provide read-only access to static reference data used throughout the application (no authentication required).

### 1. Get All Signup Flows

**Endpoint:** `GET /static/flows`
**Authentication:** Not required
**Description:** Retrieve all available signup flows and their steps

#### Success Response (200)
```json
{
  "is_success": true,
  "message": "Flows retrieved successfully",
  "data": {
    "flows": [
      {
        "flow_id": "email_signup",
        "name": "Email Signup",
        "auth_provider": "email",
        "is_active": true,
        "steps": [
          {
            "step_number": 1,
            "step_id": "basic_info",
            "name": "Basic Information",
            "required": true,
            "fields": ["first_name", "last_name", "date_of_birth", "state_id", "city_id", "address"]
          },
          {
            "step_number": 2,
            "step_id": "professional_info",
            "name": "Professional Information",
            "required": true,
            "fields": ["occupation_id", "gender_id"]
          },
          {
            "step_number": 3,
            "step_id": "profile_photo",
            "name": "Profile Photo",
            "required": true,
            "fields": ["profile_photo"]
          },
          {
            "step_number": 4,
            "step_id": "interests",
            "name": "Interests",
            "required": true,
            "fields": ["interest_ids"]
          }
        ]
      }
    ]
  }
}
```

---

### 2. Get All States

**Endpoint:** `GET /static/states`
**Authentication:** Not required
**Description:** Retrieve all available states

#### Success Response (200)
```json
{
  "is_success": true,
  "message": "States retrieved successfully",
  "data": {
    "states": [
      {
        "state_id": 1,
        "name": "California",
        "country": "United States"
      },
      {
        "state_id": 2,
        "name": "Texas",
        "country": "United States"
      },
      {
        "state_id": 3,
        "name": "New York",
        "country": "United States"
      },
      {
        "state_id": 4,
        "name": "Florida",
        "country": "United States"
      }
    ]
  }
}
```

---

### 3. Get Cities

**Endpoint:** `GET /static/cities`
**Authentication:** Not required
**Description:** Retrieve cities, optionally filtered by state ID

#### Query Parameters
- `state_id` (optional): Filter cities by state ID
  - Example: `GET /static/cities?state_id=1`
  - Leave empty to get all cities

#### Success Response - All Cities (200)
```json
{
  "is_success": true,
  "message": "Cities retrieved successfully",
  "data": {
    "cities": [
      {
        "city_id": 1,
        "name": "Los Angeles",
        "state_id": 1
      },
      {
        "city_id": 2,
        "name": "San Francisco",
        "state_id": 1
      },
      {
        "city_id": 3,
        "name": "Houston",
        "state_id": 2
      },
      {
        "city_id": 4,
        "name": "Dallas",
        "state_id": 2
      },
      {
        "city_id": 5,
        "name": "New York City",
        "state_id": 3
      }
    ]
  }
}
```

#### Success Response - Filtered by State (200)
```
GET /static/cities?state_id=1
```

```json
{
  "is_success": true,
  "message": "Cities retrieved successfully",
  "data": {
    "cities": [
      {
        "city_id": 1,
        "name": "Los Angeles",
        "state_id": 1
      },
      {
        "city_id": 2,
        "name": "San Francisco",
        "state_id": 1
      }
    ]
  }
}
```

---

### 4. Get All Occupations

**Endpoint:** `GET /static/occupations`
**Authentication:** Not required
**Description:** Retrieve all available occupations

#### Success Response (200)
```json
{
  "is_success": true,
  "message": "Occupations retrieved successfully",
  "data": {
    "occupations": [
      {
        "occupation_id": 1,
        "name": "Software Engineer",
        "category": "Technology"
      },
      {
        "occupation_id": 2,
        "name": "Data Scientist",
        "category": "Technology"
      },
      {
        "occupation_id": 3,
        "name": "Product Manager",
        "category": "Management"
      },
      {
        "occupation_id": 4,
        "name": "Marketing Manager",
        "category": "Marketing"
      },
      {
        "occupation_id": 5,
        "name": "Sales Representative",
        "category": "Sales"
      },
      {
        "occupation_id": 6,
        "name": "Designer",
        "category": "Design"
      },
      {
        "occupation_id": 7,
        "name": "Business Analyst",
        "category": "Business"
      }
    ]
  }
}
```

---

### 5. Get All Genders

**Endpoint:** `GET /static/genders`
**Authentication:** Not required
**Description:** Retrieve all available gender options

#### Success Response (200)
```json
{
  "is_success": true,
  "message": "Genders retrieved successfully",
  "data": {
    "genders": [
      {
        "gender_id": 1,
        "name": "Male"
      },
      {
        "gender_id": 2,
        "name": "Female"
      },
      {
        "gender_id": 3,
        "name": "Non-binary"
      },
      {
        "gender_id": 4,
        "name": "Prefer not to say"
      }
    ]
  }
}
```

---

### 6. Get All Interests

**Endpoint:** `GET /static/interests`
**Authentication:** Not required
**Description:** Retrieve all available interests for user selection

#### Success Response (200)
```json
{
  "is_success": true,
  "message": "Interests retrieved successfully",
  "data": {
    "interests": [
      {
        "interest_id": 1,
        "name": "Technology",
        "icon_id": 1,
        "icon_url": "https://example.com/icons/technology.png"
      },
      {
        "interest_id": 2,
        "name": "Sports",
        "icon_id": 2,
        "icon_url": "https://example.com/icons/sports.png"
      },
      {
        "interest_id": 3,
        "name": "Travel",
        "icon_id": 3,
        "icon_url": "https://example.com/icons/travel.png"
      },
      {
        "interest_id": 4,
        "name": "Music",
        "icon_id": 4,
        "icon_url": "https://example.com/icons/music.png"
      },
      {
        "interest_id": 5,
        "name": "Art",
        "icon_id": 5,
        "icon_url": "https://example.com/icons/art.png"
      },
      {
        "interest_id": 6,
        "name": "Reading",
        "icon_id": 6,
        "icon_url": "https://example.com/icons/reading.png"
      },
      {
        "interest_id": 7,
        "name": "Gaming",
        "icon_id": 7,
        "icon_url": "https://example.com/icons/gaming.png"
      },
      {
        "interest_id": 8,
        "name": "Cooking",
        "icon_id": 8,
        "icon_url": "https://example.com/icons/cooking.png"
      },
      {
        "interest_id": 9,
        "name": "Photography",
        "icon_id": 9,
        "icon_url": "https://example.com/icons/photography.png"
      },
      {
        "interest_id": 10,
        "name": "Fashion",
        "icon_id": 10,
        "icon_url": "https://example.com/icons/fashion.png"
      }
    ]
  }
}
```

---

## HTTP Status Codes

| Status Code | Meaning | Typical Use |
|-------------|---------|------------|
| 200 | OK | Successful GET, POST requests |
| 201 | Created | Successful resource creation |
| 400 | Bad Request | Invalid request parameters, validation errors |
| 401 | Unauthorized | Missing/invalid authentication token |
| 403 | Forbidden | Authenticated but not authorized (inactive account, deleted account) |
| 404 | Not Found | Resource not found (user not found) |
| 422 | Unprocessable Entity | Request validation error |
| 500 | Internal Server Error | Server-side error |

---

## Authentication Token Details

### Token Claims
```json
{
  "sub": "550e8400-e29b-41d4-a716-446655440000",
  "exp": 1234567890,
  "iat": 1234567890,
  "type": "access"
}
```

### Token Expiration
- **Access Token**: 30 minutes (configurable)
- **Refresh Token**: 7 days (configurable)

### Using Tokens
```bash
curl -H "Authorization: Bearer <access_token>" \
  http://localhost:8000/api/v1/auth/me
```

---

## Password Requirements

All passwords must meet the following criteria:
- ✓ Minimum 8 characters
- ✓ At least 1 uppercase letter (A-Z)
- ✓ At least 1 lowercase letter (a-z)
- ✓ At least 1 number (0-9)
- ✓ At least 1 special character (!@#$%^&*)

**Valid Examples:**
- `SecurePass123!`
- `MyP@ssw0rd`
- `Test#1234`

**Invalid Examples:**
- `password123` (no uppercase, no special char)
- `PASSWORD` (no lowercase, no number, no special char)
- `Pass@1` (only 6 characters)

---

## Onboarding Flow Details

### Default Email Signup Flow

The application includes a 4-step onboarding flow:

1. **Basic Information** (Required)
   - First name, last name, date of birth
   - State and city selection
   - Address

2. **Professional Information** (Required)
   - Occupation selection
   - Gender selection

3. **Profile Photo** (Required)
   - Base64 encoded profile image

4. **Interests** (Required)
   - Select 3-10 interests from available list

---

## Common Use Cases

### Complete Registration & Onboarding Flow

1. **Register:**
   ```bash
   POST /auth/register/email
   {
     "email": "user@example.com",
     "password": "SecurePass123!"
   }
   ```

2. **Get Progress:**
   ```bash
   GET /onboarding/progress
   Authorization: Bearer <access_token>
   ```

3. **Submit Step 1:**
   ```bash
   POST /onboarding/step
   Authorization: Bearer <access_token>
   {
     "step_number": 1,
     "data": { "first_name": "John", ... }
   }
   ```

4. **Submit Steps 2-4:** Repeat with step_number 2, 3, 4

### Password Reset Flow

1. **Request OTP:**
   ```bash
   POST /auth/forgot-password
   { "email": "user@example.com" }
   ```

2. **Verify OTP:**
   ```bash
   POST /auth/verify-otp
   { "email": "user@example.com", "otp": "123456" }
   ```

3. **Reset Password:**
   ```bash
   POST /auth/reset-password
   {
     "email": "user@example.com",
     "reset_token": "<token_from_step_2>",
     "new_password": "NewSecure123!"
   }
   ```

---

## Error Handling Best Practices

### Always Check `is_success` Flag
```python
if response.is_success:
    # Process data
else:
    # Handle error using detail from response
```

### Handle Different Status Codes
```python
try:
    response = requests.post(url, json=data)
    if response.status_code == 401:
        # Refresh token or redirect to login
    elif response.status_code == 422:
        # Show validation errors to user
except requests.RequestException:
    # Handle network error
```

---

## Rate Limiting

Currently, there are no rate limits enforced. However, in production:
- OTP verification attempts: Limited to 3 per 10 minutes
- Login attempts: Limited to 5 per 15 minutes
- Password reset requests: Limited to 1 per hour

---

## Security Considerations

- Always use HTTPS in production
- Store tokens securely (HTTP-only cookies recommended)
- Never expose tokens in logs or error messages
- Implement token refresh logic on client side
- Clear tokens on logout
- Validate all user input on client side before sending
- Never hardcode credentials in client code

---

## Sample cURL Commands

### Register
```bash
curl -X POST http://localhost:8000/api/v1/auth/register/email \
  -H "Content-Type: application/json" \
  -d '{
    "email": "user@example.com",
    "password": "SecurePass123!"
  }'
```

### Login
```bash
curl -X POST http://localhost:8000/api/v1/auth/login \
  -H "Content-Type: application/json" \
  -d '{
    "email": "user@example.com",
    "password": "SecurePass123!"
  }'
```

### Get Current User
```bash
curl -X GET http://localhost:8000/api/v1/auth/me \
  -H "Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9..."
```

### Get Onboarding Progress
```bash
curl -X GET http://localhost:8000/api/v1/onboarding/progress \
  -H "Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9..."
```

### Submit Onboarding Step
```bash
curl -X POST http://localhost:8000/api/v1/onboarding/step \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9..." \
  -d '{
    "step_number": 1,
    "data": {
      "first_name": "John",
      "last_name": "Doe",
      "date_of_birth": "1990-05-15",
      "state_id": 1,
      "city_id": 5,
      "address": "123 Main Street"
    }
  }'
```

### Request Password Reset OTP
```bash
curl -X POST http://localhost:8000/api/v1/auth/forgot-password \
  -H "Content-Type: application/json" \
  -d '{"email": "user@example.com"}'
```

### Get All Signup Flows
```bash
curl -X GET http://localhost:8000/api/v1/static/flows
```

### Get All States
```bash
curl -X GET http://localhost:8000/api/v1/static/states
```

### Get All Cities
```bash
curl -X GET http://localhost:8000/api/v1/static/cities
```

### Get Cities for Specific State
```bash
curl -X GET "http://localhost:8000/api/v1/static/cities?state_id=1"
```

### Get All Occupations
```bash
curl -X GET http://localhost:8000/api/v1/static/occupations
```

### Get All Genders
```bash
curl -X GET http://localhost:8000/api/v1/static/genders
```

### Get All Interests
```bash
curl -X GET http://localhost:8000/api/v1/static/interests
```

---

## Version History

| Version | Date | Changes |
|---------|------|---------|
| 1.0 | 2024-01-15 | Initial API documentation |

---

## Support & Feedback

For issues or questions regarding the API:
1. Check this documentation first
2. Review error messages carefully
3. Check application logs for detailed error info
4. Contact the development team

---

**Last Updated:** 2024-11-04
**API Version:** 1.0
