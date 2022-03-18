import 'package:app_noticia/models/view-noticia.model.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AbrindoLinkNoticiaWidget extends StatefulWidget {
  ViewNoticiaModel noticiaModel;

  AbrindoLinkNoticiaWidget({Key key, this.noticiaModel}) : super(key: key);

  @override
  _AbrindoLinkNoticiaWidget createState() => _AbrindoLinkNoticiaWidget();
}

class _AbrindoLinkNoticiaWidget extends State<AbrindoLinkNoticiaWidget> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('WebView WNews'),
      ),
      body: WebView(
        initialUrl: widget.noticiaModel.Link,
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
