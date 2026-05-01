# Taalof

Taalof is a Flutter app for pre-marital compatibility assessment and counseling booking.

## Current Features

- Splash screen and dedicated home screen
- Two-participant profile flow
- Compatibility questionnaire for both users
- Compatibility and marriage-readiness result screen
- Local counseling booking request flow
- Arabic and English UI
- Theme and language settings

## Local Storage

The app currently stores data locally using `SharedPreferences`:

- Participant A profile
- Participant B profile
- Latest compatibility result
- Latest counseling booking request
- Theme and language preference

## Run

```bash
flutter pub get
flutter run
```

## Quality Checks

```bash
flutter analyze
flutter test
```

## Android Release Setup

The Android release build is configured to use a real upload keystore from
`android/key.properties`.

1. Copy `android/key.properties.example` to `android/key.properties`
2. Generate or place your upload keystore file outside version control
3. Update `storeFile`, `storePassword`, `keyAlias`, and `keyPassword`
4. Build with:

```bash
flutter build appbundle --release
```

## Notes

- The booking flow is local-only for now.
- Compatibility calculation is enabled only after both profiles and all questions are completed.
- If profile data or answers change, the old result is cleared automatically to avoid stale output.
