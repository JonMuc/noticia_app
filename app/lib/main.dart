import 'package:app_noticia/services/avaliacao.service.dart';
import 'package:app_noticia/services/noticia.service.dart';
import 'package:app_noticia/views/pages/home.page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'services/usuario.service.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<NoticiaService>.value(value: NoticiaService()),
        ChangeNotifierProvider<UsuarioService>.value(value: UsuarioService()),
        ChangeNotifierProvider<AvaliacaoService>.value(value: AvaliacaoService()),
      ],
      child: Main(),
    );
  }
}

class Main extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    //TODO - ONESIGNAL
    // OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);
    // OneSignal.shared.setAppId("8cae9b11-beab-4ffc-afdb-c6bdd3800fe6");
    //
    // OneSignal.shared.promptUserForPushNotificationPermission().then((accepted) {
    //   // print("Accepted permission: $accepted");
    // });


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

