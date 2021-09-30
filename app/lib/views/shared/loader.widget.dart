import 'package:app/views/shared/progress-indicator.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Loader extends StatelessWidget {
  final object;
  final Function callback;

  Loader({@required this.object, this.callback });

  @override
  Widget build(BuildContext context) {
    if (object == null) {
      return Container(
        color: Colors.white,
        child: Center(
          child: GenericProgressIndicator(),
        ),
      );
    }

    if (object == null && object.length == 0) {
      return Center(
        child: Text("Nenhum registro encontrado"),
      );
    }

    return callback();
  }
}
