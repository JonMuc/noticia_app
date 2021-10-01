import 'dart:convert';

import 'package:app/themes/style_app.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:url_launcher/url_launcher.dart';
import "package:http/http.dart" as http;


GoogleSignIn _googleSignIn = GoogleSignIn(
  // Optional clientId
  // clientId: '479882132969-9i9aqik3jfjd7qhci1nqf0bm2g71rm1u.apps.googleusercontent.com',
  scopes: <String>[
    'email',
    'https://www.googleapis.com/auth/userinfo.email',
  ],
);


class EndDrawerWidget extends StatefulWidget{
  @override
  _EndDrawerWidget createState() => _EndDrawerWidget();
}

class _EndDrawerWidget extends State<EndDrawerWidget>{
  GoogleSignInAccount _currentUser;
  String _contactText = '';

  // @override
  // void initState() {
  //   super.initState();
  //   _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount account) {
  //     print(account);
  //     setState(() {
  //       _currentUser = account;
  //     });
  //     if (_currentUser != null) {
  //       _handleGetContact(_currentUser);
  //     }
  //   });
  //   _googleSignIn.signInSilently();
  // }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(backgroundColor: Colors.black), //hex color
      child: Drawer(
        child: Container(
          color: ThemeApp.test,
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
              Container(

                child: FittedBox(
                  fit: BoxFit.contain,
                  child: Text("Fazer login",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 34
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30),
              Column(
                children:[
                  Container(
                    width: 273.0,
                    height: 50,
                    padding: EdgeInsets.all(5),
                    child: TextFormField(  //textform https://om-m-mestry.medium.com/to-create-a-beautiful-text-box-with-in-flutter-a7a4d11ae13f
                      decoration: new InputDecoration(
                        labelText: "Email",
                        fillColor: Colors.white,
                        border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(15.0),
                          borderSide: new BorderSide(
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 273.0,
                    height: 50,
                    padding: EdgeInsets.all(5),
                    child: TextFormField(
                      decoration: new InputDecoration(
                        labelText: "Senha",
                        fillColor: Colors.white,
                        border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(15.0),
                          borderSide: new BorderSide(
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    width: 269.0,
                    height: 50,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.blue),
                        padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(15)),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          //side: BorderSide(color: Colors.red)
                        )
                        )
                      ),
                      onPressed: (){},
                      child: Text("Avancar",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 50),

                  RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan (
                          children: [
                            TextSpan(
                                style: TextStyle(color: Colors.black, fontSize: 14),
                                text: "Ainda nao tem uma conta? "
                            ),
                            TextSpan(
                              style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold, decoration: TextDecoration.underline),
                              text: "Criar Conta",
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
                  // Align(
                  //   alignment: Alignment.bottomCenter,
                  //   child: Text(
                  //       'Ao continuar, voce aceita os Termos de Uso e\n a Politica de Privacidade',
                  //       style: TextStyle(fontSize: 10,),
                  //       textAlign: TextAlign.center,
                  //   ),
                  // )
                ],

              )

            ],
          ),
        ),
      ),
    );
  }


  //
  // Widget _buildBody() {
  //   GoogleSignInAccount user = _currentUser;
  //   if (user != null) {
  //     return Column(
  //       mainAxisAlignment: MainAxisAlignment.spaceAround,
  //       children: <Widget>[
  //         ListTile(
  //           leading: GoogleUserCircleAvatar(
  //             identity: user,
  //           ),
  //           title: Text(user.displayName ?? ''),
  //           subtitle: Text(user.email),
  //         ),
  //         const Text("Signed in successfully."),
  //         Text("Carregando contato"),
  //         ElevatedButton(
  //           child: const Text('SIGN OUT'),
  //           onPressed: _handleSignOut,
  //         ),
  //         ElevatedButton(
  //           child: const Text('REFRESH'),
  //           onPressed: () => _handleGetContact(user),
  //         ),
  //       ],
  //     );
  //   } else {
  //     return Column(
  //       mainAxisAlignment: MainAxisAlignment.spaceAround,
  //       children: <Widget>[
  //         const Text("You are not currently signed in."),
  //         ElevatedButton(
  //           child: const Text('SIGN IN'),
  //           onPressed: _handleSignIn,
  //         ),
  //       ],
  //     );
  //   }
  // }
  //
  // Future<void> _handleSignOut() => _googleSignIn.disconnect();
  //
  // Future<void> _handleSignIn() async {
  //   try {
  //     print(2323);
  //     var result = await _googleSignIn.signIn();
  //     print(result.email);
  //     print(result.displayName);
  //     print(result.photoUrl);
  //   } catch (error) {
  //     print(error);
  //   }
  // }
  //
  // Future<void> _handleGetContact(GoogleSignInAccount user) async {
  //   setState(() {
  //     _contactText = "Loading contact info...";
  //   });
  //   print(user);
  //   final http.Response response = await http.get(
  //     Uri.parse('https://people.googleapis.com/v1/people/me/connections'
  //         '?requestMask.includeField=person.names'),
  //     headers: await user.authHeaders,
  //   );
  //   print(response.body);
  //   if (response.statusCode != 200) {
  //     setState(() {
  //       _contactText = "People API gave a ${response.statusCode} "
  //           "response. Check logs for details.";
  //     });
  //     print('People API ${response.statusCode} response: ${response.body}');
  //     return;
  //   }
  //   final Map<String, dynamic> data = json.decode(response.body);
  //   print(data);
  //   final String namedContact = _pickFirstNamedContact(data);
  //   setState(() {
  //     if (namedContact != null) {
  //       _contactText = "I see you know $namedContact!";
  //     } else {
  //       _contactText = "No contacts to display.";
  //     }
  //   });
  // }
  //
  // String _pickFirstNamedContact(Map<String, dynamic> data) {
  //   final List<dynamic> connections = data['connections'];
  //   final Map<String, dynamic> contact = connections?.firstWhere(
  //         (dynamic contact) => contact['names'] != null,
  //     orElse: () => null,
  //   );
  //   if (contact != null) {
  //     final Map<String, dynamic> name = contact['names'].firstWhere(
  //           (dynamic name) => name['displayName'] != null,
  //       orElse: () => null,
  //     );
  //     if (name != null) {
  //       return name['displayName'];
  //     }
  //   }
  //   return null;
  // }


}

