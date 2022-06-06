import 'package:flutter/material.dart';

import '../models/post_model.dart';

class singleReplay extends StatelessWidget {
  final Reploy reploy;
  singleReplay(this.reploy);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "by ${reploy.user.username} on ${reploy.time}",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              reploy.title,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
