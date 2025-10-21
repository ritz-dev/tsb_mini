import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:tsb_main/bloc/language_bloc.dart';
import 'package:tsb_main/bloc/language_state.dart';
import 'package:tsb_main/utils/localization/app_localizations.dart';
import 'package:tsb_mini/bloc/auth_bloc.dart';
import 'package:tsb_mini/bloc/auth_event.dart';
import 'package:tsb_mini/bloc/auth_state.dart';
import 'package:tsb_mini/screen/home/home_page.dart';
import 'package:tsb_mini/services/auth/auth_service.dart';

void main() {
  final authService = AuthService();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => LanguageBloc()),
        BlocProvider(create: (_) => AuthBloc(authService: authService)),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    // Dispatch login after widgets are built
    Future.microtask(() {
      // ignore: use_build_context_synchronously
      context.read<AuthBloc>().add(LoginRequested(
        email: 'superadmin@example.com',
        password: 'superpassword',
      ));

      // context.read<AuthenticationBloc>().add(LogoutRequested());
    });
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageBloc, LanguageState>(
      builder: (context, state) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'TSB MINI APP',
          locale: Locale(state.locale),
          supportedLocales: const [Locale('en'), Locale('th')],
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          home: Builder(
            builder: (context) {
              final localize = AppLocalizations.of(context)!;
              return BlocListener<AuthBloc, AuthState>(
                listener: (context, state) {
                  if (state is AuthFailure) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Login failed: ${state.error}')),
                    );
                  } else if (state is Authenticated) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Login successful!')),
                    );
                  }
                },
                child: RewardPage(localize: localize),
              );
            },
          ),
        );
      },
    );
  }
}
