enum BackendMode { localOnly, connectedPreview, connectedLive }

class BackendConfig {
  const BackendConfig._();

  static const currentMode = BackendMode.localOnly;
}
