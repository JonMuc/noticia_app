import 'package:app_noticia/themes/style_app.dart';
import 'package:app_noticia/views/pages/cadastro-step1.page.dart';
import 'package:app_noticia/views/pages/cadastro-usuario.page.dart';
import 'package:app_noticia/views/widgets/modal.widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class MenuUsuario extends StatefulWidget{
  @override
  _MenuUsuarioWidget createState() => _MenuUsuarioWidget();
}
//            width:  MediaQuery.of(context).size.width * 0.7,
class _MenuUsuarioWidget extends State<MenuUsuario>{
  @override
  Widget build(BuildContext context){
    return Drawer(
      child: Container(
        color: ThemeApp.backGround,
        child: Column(
          children: [
            SizedBox(height: 140),
            Align(
              alignment: Alignment.center,
              child: CircleAvatar(
                radius: 30.0,
                backgroundImage:
                NetworkImage("https://www.pinpng.com/pngs/m/131-1315114_png-pain-pain-akatsuki-black-and-white-transparent.png"),
              ),
            ),
            SizedBox(height: 50),
            Column(
              children:[
                Container(
                  width: 260.0,
                  height: 45,
                  child: ElevatedButton.icon(
                    icon: Image.asset('assets/images/google.png', height: 40, width: 30,),
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.white),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(7.0),
                            )
                        )
                    ),
                    onPressed: (){},
                    label:Text("  Continuar com o Google    ", style: TextStyle(fontWeight: FontWeight.w300, fontSize: 15, color: Colors.black),),
                  ),
                ),
                SizedBox(height: 5),
                Container(
                  width: 260.0,
                  height: 45,
                  child: ElevatedButton.icon(
                    icon: Image.asset('assets/images/facebook.png', height: 40, width: 41),
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.white),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(7.0),
                            )
                        )
                    ),
                    onPressed: (){},
                    label:Text("Continuar com o Facebook", style: TextStyle(fontWeight: FontWeight.w300, fontSize: 15, color: Colors.black),),
                  ),
                ),
                SizedBox(height: 5),
                Container(
                  width: 260.0,
                  height: 45,
                  child: ElevatedButton.icon(
                    icon: Image.asset('assets/images/personplus.png', height: 35, width: 35,),
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.white),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(7.0),
                            )
                        )
                    ),
                    onPressed: (){
                      Navigator.push(
                        context,
                        new MaterialPageRoute(
                          builder: (BuildContext context)
                          => new TelaCadastroStep1()
                        )
                      );
                    },
                    label:Text("        Criar Conta                 ", style: TextStyle(fontWeight: FontWeight.w300, fontSize: 15, color: Colors.black),),
                  ),
                ),
                SizedBox(height: 50),
                RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan (
                        children: [
                          TextSpan(
                              style: TextStyle(color: Colors.black, fontSize: 14),
                              text: "Ja tem uma conta? "
                          ),
                          TextSpan(
                            style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold, decoration: TextDecoration.underline),
                            text: "Entrar",
                            recognizer: new TapGestureRecognizer()
                              ..onTap = () { launch('https://docs.flutter.io/flutter/services/UrlLauncher-class.html');
                              },
                          )
                        ]
                    )
                ),
                SizedBox(height: 15),
                RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan (
                        children: [
                          TextSpan(
                              style: TextStyle(color: Colors.black, fontSize: 10),
                              text: "Ao continuar, voce aceita os "
                          ),
                          TextSpan(
                            style: TextStyle(color: Colors.black, fontSize: 10, fontWeight: FontWeight.bold, decoration: TextDecoration.underline),
                            text: "Termos de uso ",
                            recognizer: new TapGestureRecognizer()
                              ..onTap = () { launch('https://docs.flutter.io/flutter/services/UrlLauncher-class.html');
                              },
                          ) ,
                          TextSpan(
                            style: TextStyle(color: Colors.black, fontSize: 10),

                            text: "e a\n",
                          ),
                          TextSpan(
                            style: TextStyle(color: Colors.black, fontSize: 10, fontWeight: FontWeight.bold, decoration: TextDecoration.underline),
                            text: "Politica de Privacidade.",
                            recognizer: new TapGestureRecognizer()
                              ..onTap = () { launch('https://docs.flutter.io/flutter/services/UrlLauncher-class.html');
                              },
                          )
                        ]
                    )
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}