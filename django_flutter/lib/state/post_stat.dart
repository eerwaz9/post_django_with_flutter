import 'dart:convert';

import 'package:django_flutter/models/post_model.dart';
import 'package:django_flutter/screen/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:localstorage/localstorage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class postState with ChangeNotifier {
  List<Post> posts;
  LocalStorage storge = LocalStorage("usertoken");
  Future<bool> getPostData() async {
    try {
      var token = "17dde37ce87375a6ad43f32e0bffbdcba80e317e";
      String url = 'http://10.0.2.2:8000/Api/post/';
      http.Response response =
          await http.get(url, headers: {'Authorization': 'token $token'});
      var data = json.decode(utf8.decode(response.bodyBytes));
      print(data);
      List<Post> temp = [];

      data.forEach((element) {
        Post post = Post.fromJson(element);
        temp.add(post);
      });
      posts = temp;
      notifyListeners();
      return true;
    } catch (e) {
      print("error getPostData");
      print(e);
      return false;
    }
  }
  List<Post> get post {
    if (posts != null) {
      return [...posts];
    }
    return null;
  }

  Future<bool> loginNow(String username, String password) async {
    try {
      String url = 'http://10.0.2.2:8000/Api/login/';
      http.Response response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
        },
        body: json.encode({
          'username': username,
          'password': password,
        }),
      );
      var data = json.decode(utf8.decode(response.bodyBytes)) as Map;
      // print(data);
      if (data.containsKey('token')) {
        storge.setItem('token', data['token']);
        print(storge.getItem('token'));
        return false;
      }

      return true;
    } catch (e) {
      print("error loginnow");
      print(e);
      return true;
    }
  }

  Future<bool> Reguster(String username, String password) async {
    try {
      String url = 'http://10.0.2.2:8000/ِِِApi/reguster/';
      http.Response response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'token 17dde37ce87375a6ad43f32e0bffbdcba80e317e',
        },
        body: json.encode({
          'username': username,
          'password': password,
        }),
      );
      var data = json.decode(utf8.decode(response.bodyBytes));

      pageroute(data['token']);
      print(data);
      return data['error'];
    } catch (e) {
      print("error register now");
      print(e);
      return true;
    }
  }

  void pageroute(String token) async {
    SharedPreferences pre = await SharedPreferences.getInstance();
    await pre.setString("loginNow", token);
    BuildContext context;
    Navigator.push(context, MaterialPageRoute(builder: (context) => home()));
  }

  Future<void> Addlike(int id) async {
    try {
      var token = '17dde37ce87375a6ad43f32e0bffbdcba80e317e';
      String url = 'http://10.0.2.2:8000/Api/Addlike/';
      http.Response response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'token $token',
        },
        body: json.encode(
          {"id": id},
        ),
      );
      var data = json.decode(utf8.decode(response.bodyBytes)) as Map;

      if (data['error'] == false) {
        getPostData();
      }
      print(response.bodyBytes);
    } catch (e) {
      print(e);
      print("error addlike");
    }
  }

  List<Cargrey> _cargrey;
  Future<void> getCategryData() async {
    try {
      var token = '17dde37ce87375a6ad43f32e0bffbdcba80e317e';
      String url = 'http://10.0.2.2:8000/Api/categry/';
      http.Response response =
          await http.get(url, headers: {'Authorization': 'token $token'});
      var data = json.decode(utf8.decode(response.bodyBytes)) as List;

      List<Cargrey> temp = [];
      data.forEach((element) {
        Cargrey cargrey = Cargrey.fromJson(element);
        temp.add(cargrey);
      });
      _cargrey = temp;
      notifyListeners();
    } catch (e) {
      print("error getCategryData");
      print(e);
    }
  }

  List<Cargrey> get cargrey {
    if (_cargrey != null) {
      return [..._cargrey];
    }
    return null;
  }

  Future<void> Addcomment(int postid, String commetxt) async {
    try {
      var token = '17dde37ce87375a6ad43f32e0bffbdcba80e317e';
      String url = 'http://10.0.2.2:8000/Api/Addcommet/';
      http.Response response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'token $token',
        },
        body: json.encode(
          {"postid": postid, "comment": commetxt},
        ),
      );
      var data = json.decode(utf8.decode(response.bodyBytes));
      if (data['error'] == false) {
        getPostData();
      }
      print(response.body);
    } catch (e) {
      print(e);
      print("error Addcomment");
    }
  }

  Future<void> Addreplay(int commetid, String replaytxt) async {
    try {
      var token = '17dde37ce87375a6ad43f32e0bffbdcba80e317e';
      String url = 'http://10.0.2.2:8000/Api/Addreplay/';
      http.Response response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'token $token',
        },
        body: json.encode(
          {"commentid": commetid, "replytext": replaytxt},
        ),
      );
      var data = json.decode(utf8.decode(response.bodyBytes));
      if (data['error'] == false) {
        getPostData();
      }
      print(response.body);
    } catch (e) {
      print(e);
      print("error Addreplay");
    }
  }

  Post singlePost(int id) {
    return posts.firstWhere((element) => element.id == id);
  }

  List<Post> categoryposts(int id) {
    return [...posts.where((element) => element.cargrey.id == id)];
  }
}
