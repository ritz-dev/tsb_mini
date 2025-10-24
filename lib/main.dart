import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:tsb_main/bloc/language_bloc.dart';
import 'package:tsb_main/bloc/language_state.dart';
import 'package:tsb_main/utils/localization/app_localizations.dart';
import 'package:tsb_mini/screen/home/home_page.dart';

void main() {
  runApp(
    BlocProvider(
      create: (_) => LanguageBloc(),
      child: MyApp(), // NOT const
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageBloc, LanguageState>(
      builder: (context, state) {
        return MaterialApp(
          debugShowCheckedModeBanner: true,
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
              return RewardPage(localize: localize);
            },
          ),
        );
      },
    );
  }
}
