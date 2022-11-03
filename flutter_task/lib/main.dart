import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_task/ui/movie_list_page.dart';
import 'package:flutter_task/ui/signup_page.dart';
import 'package:provider/provider.dart';
import 'package:path_provider/path_provider.dart';

import 'generated/l10n.dart';
import 'localization/langauge_change_provider.dart';

void main() async {
  //final appDocumentDir = await getApplicationDocumentsDirectory();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LanguageChangeProvider>(
      create: (context) => LanguageChangeProvider(),
      child: Builder(builder: (context) {
        return MaterialApp(
          home: SignUpPage(),
          locale: Provider.of<LanguageChangeProvider>(context, listen: true)
              .currentLocale,
          localizationsDelegates: [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: S.delegate.supportedLocales,
          debugShowCheckedModeBanner: false,
        );
      }),
    );

    return const MaterialApp(
      home: MovieListPage()
    );
  }
}

