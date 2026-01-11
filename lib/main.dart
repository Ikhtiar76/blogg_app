import 'package:blogg_app/core/secrets/app_secrets.dart';
import 'package:blogg_app/core/theme/theme.dart';
import 'package:blogg_app/features/auth/presentation/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// supabase database pass: 76-PrantoBlogg

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final supabase = await Supabase.initialize(
    url: AppSecrets.supabaseurl,
    anonKey: AppSecrets.supabaseAnonkey,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Blogg App',
      theme: AppTheme.darkThemeMode,
      home: LoginPage(),
    );
  }
}
