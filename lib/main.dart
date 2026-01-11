import 'package:blogg_app/core/secrets/app_secrets.dart';
import 'package:blogg_app/core/theme/theme.dart';
import 'package:blogg_app/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:blogg_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:blogg_app/features/auth/domain/usecases/user_sign_up.dart';
import 'package:blogg_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blogg_app/features/auth/presentation/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// supabase database pass: 76-PrantoBlogg

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final supabase = await Supabase.initialize(
    url: AppSecrets.supabaseurl,
    anonKey: AppSecrets.supabaseAnonkey,
  );
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => AuthBloc(
            userSignUp: UserSignUp(
              authRepository: AuthRepositoryImpl(
                authRemoteDataSource: AuthRemoteDataSourceImpl(
                  supabaseClient: supabase.client,
                ),
              ),
            ),
          ),
        ),
      ],
      child: const MyApp(),
    ),
  );
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
