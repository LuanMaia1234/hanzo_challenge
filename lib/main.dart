import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'src/core/di/injection_container.dart';
import 'src/core/routes/app_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await setupDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hanzo Challenge',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      navigatorKey: navigatorKey,
      initialRoute: AppRoutes.onboarding,
      onGenerateRoute: AppRoutes.generate,
    );
  }
}
