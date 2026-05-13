import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app.dart';
import 'core/config/firebase_bootstrap.dart';
import 'data/local/local_storage_service.dart';
import 'presentation/providers/app_state.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FirebaseBootstrap.initialize();
  final storage = await LocalStorageService.create();

  runApp(
    ChangeNotifierProvider(
      create: (_) => AppState(storage)..initialize(),
      child: const PreMaritalMatchApp(),
    ),
  );
}
