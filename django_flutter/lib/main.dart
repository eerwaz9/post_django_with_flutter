import 'package:django_flutter/screen/home_screen.dart';
import 'package:django_flutter/screen/login_screens.dart';
import 'package:django_flutter/screen/post_details_screens.dart';
import 'package:django_flutter/screen/register_screens.dart';
import 'package:django_flutter/state/post_stat.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screen/category_screens.dart';

main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => postState(),
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme:
              ThemeData(primaryColor: Colors.white, accentColor: Colors.orange),
          home: RegisterScreens(),
          routes: {
            RegisterScreens.routeName: (ctx) => RegisterScreens(),
            LoginScreens.routeName: (ctx) => LoginScreens(),
            home.ruotename: (ctx) => home(),
            CategoryScreens.routeName: (ctx) => CategoryScreens(),
            PostDetailsScreens.routeName: (ctx) => PostDetailsScreens(),
          }),
    );
  }
}
