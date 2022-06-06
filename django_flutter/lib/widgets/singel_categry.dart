import 'package:flutter/material.dart';

import '../models/post_model.dart';

class singleCargrey extends StatelessWidget {
  final Cargrey cargrey;
  singleCargrey(this.cargrey);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 12, left: 12, top: 4, bottom: 4),
      child: Card(
        color: Colors.amberAccent,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            cargrey.title,
            style: TextStyle(
                fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
