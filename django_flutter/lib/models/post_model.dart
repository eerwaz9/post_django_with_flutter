class Post {
  int id;
  String title;
  String code;
  String content;
  String date;
  Cargrey cargrey;
  bool like;
  int totalike;
  List<Comment> comment;

  Post(
      {this.id,
      this.title,
      this.code,
      this.content,
      this.date,
      this.cargrey,
      this.like,
      this.totalike,
      this.comment});

  Post.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    code = json['code'];
    content = json['content'];
    date = json['date'];
    cargrey =
        json['cargrey'] != null ? new Cargrey.fromJson(json['cargrey']) : null;
    like = json['like'];
    totalike = json['totalike'];
    if (json['Comment'] != null) {
      comment = new List<Comment>();
      json['Comment'].forEach((v) {
        comment.add(new Comment.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['code'] = this.code;
    data['content'] = this.content;
    data['date'] = this.date;
    if (this.cargrey != null) {
      data['cargrey'] = this.cargrey.toJson();
    }
    data['like'] = this.like;
    data['totalike'] = this.totalike;
    if (this.comment != null) {
      data['Comment'] = this.comment.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Cargrey {
  int id;
  String title;

  Cargrey({this.id, this.title});

  Cargrey.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    return data;
  }
}

class Comment {
  int id;
  String title;
  String time;
  User user;
  int post;
  List<Reploy> reploy;

  Comment({this.id, this.title, this.time, this.user, this.post, this.reploy});

  Comment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    time = json['time'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    post = json['post'];
    if (json['reploy'] != null) {
      reploy = new List<Reploy>();
      json['reploy'].forEach((v) {
        reploy.add(new Reploy.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['time'] = this.time;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    data['post'] = this.post;
    if (this.reploy != null) {
      data['reploy'] = this.reploy.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class User {
  int id;
  String username;
  String email;

  User({this.id, this.username, this.email});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['email'] = this.email;
    return data;
  }
}

class Reploy {
  int id;
  String title;
  String time;
  User user;
  int commat;

  Reploy({this.id, this.title, this.time, this.user, this.commat});

  Reploy.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    time = json['time'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    commat = json['commat'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['time'] = this.time;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    data['commat'] = this.commat;
    return data;
  }
}

class Cargreyw {
  int id;
  String title;

  Cargreyw({this.id, this.title});

  Cargreyw.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    return data;
  }
}
