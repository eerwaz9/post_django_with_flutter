import 'package:django_flutter/state/post_stat.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/app_drower.dart';
import '../widgets/singel_categry.dart';
import '../widgets/singel_post.dart';

class home extends StatefulWidget {
  static const ruotename = '/home';

  @override
  _homeState createState() => _homeState();
}

class _homeState extends State<home> {
  String token = "";
  @override
  void initState() {
    super.initState();
    // getCred();
  }

  // void getCred() async {
  //   SharedPreferences pre = await SharedPreferences.getInstance();
  //   setState(() {
  //     token = pre.getString('loginNow');
  //   });
  // }

  bool _init = true;
  bool isloading = false;
  @override
  void didChangeDependencies() async {
    if (_init) {
      Provider.of<postState>(context, listen: false).getCategryData();
      isloading =
          await Provider.of<postState>(context, listen: false).getPostData();
      setState(() {});
    }
    _init = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final posts = Provider.of<postState>(context).post;
    final cargrey = Provider.of<postState>(context).cargrey;
    if (isloading == false || posts == null || cargrey == null)
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    else
      return Scaffold(
          drawer: AddDrower(),
          backgroundColor: Colors.red[300],
          appBar: AppBar(
            title: Text("welcome Code "),
            centerTitle: true,
          ),
          body: Column(
            children: [
              Container(
                height: 55,
                child: ListView.builder(
                  itemCount: cargrey.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (ctx, i) {
                    return singleCargrey(cargrey[i]);
                  },
                ),
              ),
              Divider(),
              SizedBox(
                height: 20,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: posts.length,
                  itemBuilder: (ctx, i) {
                    return singlePosr(posts[i], cargrey[i]);
                  },
                ),
              ),
            ],
          ));
  }
}
