// import 'package:flutter/material.dart';
// // import 'package:flutter_app/new_page.dart';
//
// class HomeScreen extends StatefulWidget {
//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   int _indiceAtual = 0;
//   final List<Widget> _telas = [
//     // NewPageScreen("Minha conta"),
//     // NewPageScreen("Meus pedidos"),
//     // NewPageScreen("Favoritos")
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: _telas[_indiceAtual],
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: _indiceAtual,
//         onTap: onTabTapped,
//         items: [
//           BottomNavigationBarItem(
//               icon: Icon(Icons.person),
//               title: Text("Minha conta")
//           ),
//           BottomNavigationBarItem(
//               icon: Icon(Icons.shopping_basket),
//               title: Text("Meus pedidos")
//           ),
//           BottomNavigationBarItem(
//               icon: Icon(Icons.favorite),
//               title: Text("Favoritos")
//           ),
//         ],
//       ),
//     );
//   }
//
//   void onTabTapped(int index) {
//     setState(() {
//       _indiceAtual = index;
//     });
//   }
// }