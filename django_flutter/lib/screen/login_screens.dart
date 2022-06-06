import 'package:django_flutter/screen/home_screen.dart';
import 'package:django_flutter/screen/register_screens.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../state/post_stat.dart';

class LoginScreens extends StatefulWidget {
  static const routeName = '/login-screens';
  @override
  _LoginScreensState createState() => _LoginScreensState();
}

class _LoginScreensState extends State<LoginScreens> {
  final _form = GlobalKey<FormState>();
  String _username;
  String _password;
  @override
  void initState() {
    super.initState();
    cheklogin();
  }

  void cheklogin() async {
    SharedPreferences pre = await SharedPreferences.getInstance();
    String isVali = pre.getString("loginNow");
    if (isVali != null) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => home()));
    }
  }

  void loginNow() async {
    var isValid = _form.currentState.validate();
    if (!isValid) {
      return;
    }
    _form.currentState.save();
    bool islogin = await Provider.of<postState>(context, listen: false)
        .loginNow(_username, _password);
    if (!islogin) {
      Navigator.of(context).pushReplacementNamed(home.ruotename);
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("اسم المستخدم او كلمة المرور خطاء"),
            actions: [
              RaisedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("موافق"),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login To Code"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Form(
            key: _form,
            child: Column(
              children: [
                Text(
                  "Login",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 28,
                  ),
                ),
                TextFormField(
                  validator: (v) {
                    if (v.isEmpty) {
                      return 'Enter your Username';
                    }
                    return null;
                  },
                  onSaved: (v) {
                    _username = v;
                  },
                  decoration: InputDecoration(
                    labelText: "Username",
                  ),
                ),
                TextFormField(
                  validator: (v) {
                    if (v.isEmpty) {
                      return 'Enter your Password';
                    }

                    return null;
                  },
                  onSaved: (v) {
                    _password = v;
                  },
                  decoration: InputDecoration(
                    labelText: "Password",
                  ),
                  obscureText: true,
                ),
                Row(
                  children: [
                    RaisedButton(
                      color: Theme.of(context).accentColor,
                      onPressed: () {
                        loginNow();
                      },
                      child: Text("Login"),
                    ),
                    FlatButton(
                      onPressed: () {
                        Navigator.of(context)
                            .pushReplacementNamed(RegisterScreens.routeName);
                      },
                      child: Text("Register Now"),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
