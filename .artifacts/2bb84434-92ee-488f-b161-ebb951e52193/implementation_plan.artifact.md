# Fix Connection Timeout on Android Emulator (Updated)

The previous attempt to change the `baseUrl` didn't seem to take effect, or was blocked by Android's security policies. We will now use a more robust approach:
1. Enable cleartext traffic in the Android manifest.
2. Clean up the API paths to ensure they work correctly with the base URL.
3. Recommend using `adb reverse` which is the industry standard for local development.

## User Review Required

> [!IMPORTANT]
> The most reliable way to fix this without changing code for every platform is to run this command in your terminal while the emulator is running:
> ```bash
> adb reverse tcp:8000 tcp:8000
> ```
> This makes `localhost:8000` on the emulator point directly to `localhost:8000` on your machine.

## Proposed Changes

### Android Configuration

#### [MODIFY] [AndroidManifest.xml](file:///Users/chelseafc/Documents/Development/CineMax/cinemax/android/app/src/main/AndroidManifest.xml)

- Add `android:usesCleartextTraffic="true"` to allow `http` connections.
- Ensure `INTERNET` permission is present.

### Core Data

#### [MODIFY] [api.dart](file:///Users/chelseafc/Documents/Development/CineMax/cinemax/lib/core/data/api.dart)

- Remove leading slashes from `signup` and `login` constants.
- In Dio, a path starting with `/` will override the base URL's path, which can cause unexpected behavior.

```dart
  static const signup = 'register'; // Removed /
  static const login = 'login';      // Removed /
```

## Verification Plan

### Manual Verification
1. Apply the `AndroidManifest.xml` changes.
2. Run `adb reverse tcp:8000 tcp:8000`.
3. Try to login again.
