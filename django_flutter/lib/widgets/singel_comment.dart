import 'package:django_flutter/models/post_model.dart';
import 'package:django_flutter/widgets/singel_Replay.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../state/post_stat.dart';

class singleComment extends StatefulWidget {
  final Comment comment;
  singleComment(this.comment);

  @override
  State<singleComment> createState() => _singleCommentState();
}

class _singleCommentState extends State<singleComment> {
  bool _shoeReplay = false;
  String replayt = '';
  final replaycontroler = TextEditingController();
  void _Addreplay() {
    if (replayt.length <= 0) {
      return;
    }
    Provider.of<postState>(context, listen: false)
        .Addreplay(widget.comment.id, replayt);
    print(replayt);
    replaycontroler.text = '';
    replayt = '';
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "By  ${widget.comment.user.username} at ${widget.comment.time}",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Container(
                margin: EdgeInsets.only(left: 10),
                padding: EdgeInsets.all(4),
                child: Text(
                  widget.comment.title,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                )),
            FlatButton(
              onPressed: () {
                setState(() {
                  _shoeReplay = !_shoeReplay;
                });
              },
              child: Text("Replay(${widget.comment.reploy.length})"),
            ),
            if (_shoeReplay)
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: TextField(
                        controller: replaycontroler,
                        onChanged: (v) {
                          setState(() {
                            replayt = v;
                          });
                        },
                        decoration: InputDecoration(
                            hintText: "Replay",
                            suffix: IconButton(
                              onPressed: replayt.length <= 0
                                  ? null
                                  : () {
                                      _Addreplay();
                                    },
                              icon: Icon(
                                Icons.send,
                                color: Colors.blueAccent,
                              ),
                            )),
                      ),
                    ),
                    if (widget.comment.reploy.length != 0)
                      Column(
                        children: widget.comment.reploy
                            .map((r) => singleReplay(r))
                            .toList(),
                      )
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
