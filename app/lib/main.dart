import 'package:app_noticia/services/noticia.service.dart';
import 'package:app_noticia/views/pages/home.page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'services/usuario.service.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<NoticiaService>.value(value: NoticiaService()),
        ChangeNotifierProvider<UsuarioService>.value(value: UsuarioService()),
      ],
      child: Main(),
    );
  }
}

class Main extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
      SharedPreferences.setMockInitialValues({});
    return MaterialApp(
      title: 'WoNew',
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        DefaultWidgetsLocalizations.delegate,
      ],
      supportedLocales: [const Locale('pt', 'BR')],
    );
  }
}

