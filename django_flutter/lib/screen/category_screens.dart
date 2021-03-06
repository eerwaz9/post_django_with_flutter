import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../state/post_stat.dart';

class CategoryScreens extends StatefulWidget {
  static const routeName = '/category-screens';
  @override
  _CategoryScreensState createState() => _CategoryScreensState();
}

class _CategoryScreensState extends State<CategoryScreens> {
  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context).settings.arguments;
    final posts = Provider.of<postState>(context).categoryposts(id);

    return posts.length == 0
        ? Scaffold(
            appBar: AppBar(
              title: Text("No post for This Category"),
            ),
            body: Center(
              child: Text("No Post"),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              title: Text("All Post for ${posts[0].cargrey.title} "),
              centerTitle: true,
            ),
            body: ListView.builder(
              itemCount: posts.length,
            ),
          );
  }
}
