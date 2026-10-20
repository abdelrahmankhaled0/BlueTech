import 'package:beauty_app/core/routes/app_routes.dart';
import 'package:beauty_app/core/service/remote/dio_helper.dart';
import 'package:beauty_app/core/utils/app_theme.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: AppRoutes.routes,
      theme: AppTheme.lightTheme,
    );
  }
}
