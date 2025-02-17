import 'package:flutter/material.dart';
import 'package:refresh_token_example/core/app_service.dart';
import 'package:refresh_token_example/ui/main_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  AppService.instance.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Refresh Token Example',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MainScreen(),
    );
  }
}
