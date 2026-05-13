class FirebaseEnvironment {
  const FirebaseEnvironment._();

  // Connected Firebase runtime is enabled for Android only in the current phase.
  static const enabled = true;

  // App Check stays off until Firebase is fully wired on device.
  static const enableAppCheck = false;

  // This flag is reserved for future emulator wiring in dev/staging.
  static const useEmulators = false;
}
