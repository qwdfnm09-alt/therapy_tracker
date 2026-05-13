class AuthActionResult {
  const AuthActionResult({
    required this.success,
    required this.providerKey,
    this.message,
  });

  final bool success;
  final String providerKey;
  final String? message;
}
