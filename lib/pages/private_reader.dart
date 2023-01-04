import 'dart:html';
import 'package:cloud_firestore/cloud_firestore.dart';
import "package:flutter/material.dart";
import 'package:intl/intl.dart';
import 'package:on_my_mind/style/app_style.dart';
import 'package:on_my_mind/pages/home_page.dart';

QueryDocumentSnapshot? docSave;
int color_id = -1;
TextEditingController _titleControllerChanges = TextEditingController();
TextEditingController _mainControllerChanges = TextEditingController();

void main() {
  runApp(MaterialApp(
    home: PrivateReaderScreen(docSave!),
  ));
}

class PrivateReaderScreen extends StatefulWidget {
  PrivateReaderScreen(this.doc, {Key? key}) : super(key: key);
  QueryDocumentSnapshot doc;
  @override
  State<PrivateReaderScreen> createState() => _PrivateReaderScreen();
}

class _PrivateReaderScreen extends State<PrivateReaderScreen> {
  @override
  Widget build(BuildContext context) {
    docSave = widget.doc;

    // set before color pick
    if (color_id == -1) {
      color_id = widget.doc["color"];
      _titleControllerChanges =
          TextEditingController(text: widget.doc["title"]);
      _mainControllerChanges = TextEditingController(text: widget.doc["note"]);
    }

    DateTime dt = (widget.doc['timestamp'] as Timestamp).toDate();
    String date = DateFormat('MM/dd/yyyy, hh:mm a').format(dt);
    Timestamp timestampDate = Timestamp.now();

    return Scaffold(
      backgroundColor: AppStyle.cardsColor[color_id],
      appBar: AppBar(
        backgroundColor: AppStyle.cardsColor[color_id],
        elevation: 0.0,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _titleControllerChanges,
              decoration: InputDecoration(
                border: InputBorder.none,
              ),
              style: AppStyle.mainTitle,
            ),
            SizedBox(
              height: 4.0,
            ),
            Text(
              date,
              style: AppStyle.dateTitle,
            ),
            SizedBox(
              height: 28.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                FloatingActionButton(
                  child: Text('red',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold)),
                  backgroundColor: AppStyle.cardsColor[0],
                  onPressed: () => {
                    setState(() {
                      color_id = 0;
                    }),
                  },
                ),
                FloatingActionButton(
                  child: Text('pink',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold)),
                  backgroundColor: AppStyle.cardsColor[1],
                  onPressed: () => {
                    setState(() {
                      color_id = 1;
                    }),
                  },
                ),
                FloatingActionButton(
                  child: Text('orange',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold)),
                  backgroundColor: AppStyle.cardsColor[2],
                  onPressed: () => {
                    setState(() {
                      color_id = 2;
                    }),
                  },
                ),
                FloatingActionButton(
                  child: Text('yellow',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold)),
                  backgroundColor: AppStyle.cardsColor[3],
                  onPressed: () => {
                    setState(() {
                      color_id = 3;
                    }),
                  },
                ),
                FloatingActionButton(
                  child: Text('green',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold)),
                  backgroundColor: AppStyle.cardsColor[4],
                  onPressed: () => {
                    setState(() {
                      color_id = 4;
                    }),
                  },
                ),
                FloatingActionButton(
                  child: Text('blue',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold)),
                  backgroundColor: AppStyle.cardsColor[5],
                  onPressed: () => {
                    setState(() {
                      color_id = 5;
                    }),
                  },
                ),
                FloatingActionButton(
                  child: Text('grey',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold)),
                  backgroundColor: AppStyle.cardsColor[6],
                  onPressed: () => {
                    setState(() {
                      color_id = 6;
                    }),
                  },
                ),
              ],
            ),
            SizedBox(
              height: 28.0,
            ),
            TextField(
              controller: _mainControllerChanges,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              decoration: InputDecoration(border: InputBorder.none),
              style: AppStyle.mainContent,
            ),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.only(left: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            FloatingActionButton(
              heroTag: "btn1",
              backgroundColor: AppStyle.accentColor,
              onPressed: () async {
                await FirebaseFirestore.instance
                    .collection("private-notes")
                    .doc(widget.doc.reference.id.toString())
                    .delete()
                    .then(
                  (value) {
                    print("Note deleted");
                    Navigator.pop(context);
                  },
                ).catchError((error) =>
                        print("Failed to add new Note due to $error"));
              },
              child: Icon(Icons.delete),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: FloatingActionButton(
                heroTag: "btn2",
                backgroundColor: AppStyle.accentColor,
                onPressed: () async {
                  setState(() {
                    color_id = -1;
                  });
                },
                child: Icon(Icons.restart_alt),
              ),
            ),
            Expanded(child: Container()),
            FloatingActionButton(
              heroTag: "btn3",
              backgroundColor: AppStyle.accentColor,
              onPressed: () async {
                await FirebaseFirestore.instance
                    .collection("private-notes")
                    .doc(widget.doc.reference.id.toString())
                    .update({
                  "title": _titleControllerChanges.text,
                  "timestamp": timestampDate,
                  "note": _mainControllerChanges.text,
                  "color": color_id
                }).then(
                  (value) {
                    print("Note updated");
                    Navigator.pop(context);
                  },
                ).catchError((error) =>
                        print("Failed to add new Note due to $error"));
              },
              child: Icon(Icons.save),
            ),
          ],
        ),
      ),
    );
  }
}
