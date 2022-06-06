import 'package:django_flutter/widgets/singel_comment.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/post_model.dart';
import '../screen/post_details_screens.dart';
import '../state/post_stat.dart';

class singlePosr extends StatefulWidget {
  final Post post;
  final Cargrey cargrey;
  singlePosr(this.post, this.cargrey);

  @override
  State<singlePosr> createState() => _singlePosrState();
}

class _singlePosrState extends State<singlePosr> {
  bool _comment = false;
  String commentt = '';
  final commentcontroler = TextEditingController();
  void _Addcpmment() {
    if (commentt.length <= 0) {
      return;
    }
    Provider.of<postState>(context, listen: false)
        .Addcomment(widget.post.id, commentt);
    print(commentt);
    commentcontroler.text = '';
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed(
                        PostDetailsScreens.routeName,
                        arguments: widget.post.id);
                  },
                  child: Text(
                    widget.post.title,
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                Card(
                    child: Padding(
                  padding: EdgeInsets.all(3.0),
                  child: Text(
                    widget.cargrey.title,
                    style: TextStyle(fontSize: 16),
                  ),
                )),
              ],
            ),
            if (widget.post.code.length != 0)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "code :",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20),
                    child: Card(
                        color: Colors.red[200],
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(
                            widget.post.code,
                            style: TextStyle(fontSize: 14, color: Colors.black),
                          ),
                        )),
                  ),
                ],
              ),
            widget.post.content.length > 100
                ? Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${widget.post.content.substring(0, 100)}.........",
                          style: TextStyle(fontSize: 16),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushNamed(
                                PostDetailsScreens.routeName,
                                arguments: widget.post.id);
                          },
                          child: Text(
                            "read more",
                            style: TextStyle(
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : Container(
                    child: Text(
                      "${widget.post.content}",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
            Divider(),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  FlatButton.icon(
                    onPressed: () {
                      Provider.of<postState>(context, listen: false)
                          .Addlike(widget.post.id);
                    },
                    icon: Icon(
                      widget.post.like ? Icons.favorite : Icons.favorite_border,
                      color: Colors.amberAccent,
                    ),
                    label: Text(
                      "like(${widget.post.totalike})",
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                  ),
                  FlatButton.icon(
                    onPressed: () {
                      setState(() {
                        _comment = !_comment;
                      });
                    },
                    icon: Icon(
                      Icons.comment,
                      color: Colors.amberAccent,
                    ),
                    label: Text(
                      "comment(${widget.post.comment.length})",
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            if (_comment)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: TextField(
                      controller: commentcontroler,
                      onChanged: (v) {
                        setState(() {
                          commentt = v;
                        });
                      },
                      decoration: InputDecoration(
                          hintText: "comment.......",
                          suffix: IconButton(
                            onPressed: commentt.length <= 0
                                ? null
                                : () {
                                    _Addcpmment();
                                  },
                            icon: Icon(Icons.send),
                            color: Colors.blue,
                          )),
                    ),
                  ),
                  Container(
                    child: Card(
                      child: Column(
                        children: widget.post.comment
                            .map(
                              (e) => singleComment(e),
                            )
                            .toList(),
                      ),
                    ),
                  ),
                ],
              )
          ],
        ),
      ),
    );
  }
}
