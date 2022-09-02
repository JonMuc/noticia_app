import 'package:app_noticia/services/usuario.service.dart';
import 'package:app_noticia/views/pages/cadastro-usuario/cadastro-usuario.controller.dart';
import 'package:app_noticia/views/pages/cadastro-usuario/cadastro-usuario.page.dart';
import 'package:app_noticia/views/pages/home/home.controller.dart';
import 'package:app_noticia/views/pages/home/home.page.dart';
import 'package:app_noticia/views/widgets/fazer-login/fazer-login.controller.dart';
import 'package:app_noticia/views/widgets/lista-manchetes/lista-manchetes.controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(GetMaterialApp(
    initialRoute: '/home',
    getPages: [
      GetPage(name: '/home', page: () => HomeViewPage(), binding: SampleBind()),
      GetPage(name: '/cadastro-usuario', page: () => CadastroUsuarioViewPage(), binding: SampleBind()),
    ],
  ));
}

class SampleBind extends Bindings {
  @override
  void dependencies() {
    //Constrollers
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<ListaMancheteController>(() => ListaMancheteController());
    Get.lazyPut<FazerLoginController>(() => FazerLoginController());
    Get.lazyPut<CadastroUsuarioController>(() => CadastroUsuarioController());

    //Services
    Get.lazyPut<UsuarioService>(() => UsuarioService());
  }
}

//
// class Main extends StatelessWidget {
//
//   @override
//   Widget build(BuildContext context) {
//     //TODO - ONESIGNAL
//     // OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);
//     // OneSignal.shared.setAppId("8cae9b11-beab-4ffc-afdb-c6bdd3800fe6");
//     //
//     // OneSignal.shared.promptUserForPushNotificationPermission().then((accepted) {
//     //   // print("Accepted permission: $accepted");
//     // });
//
//
//     return MaterialApp(
//       title: 'WoNew',
//       debugShowCheckedModeBanner: false,
//       home: HomePage(),
//       localizationsDelegates: [
//         GlobalMaterialLocalizations.delegate,
//         GlobalWidgetsLocalizations.delegate,
//         GlobalCupertinoLocalizations.delegate,
//         DefaultWidgetsLocalizations.delegate,
//       ],
//       supportedLocales: [const Locale('pt', 'BR')],
//     );
//   }
// }
//
