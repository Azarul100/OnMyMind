import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:on_my_mind/style/app_style.dart';
import 'package:intl/intl.dart';
import '../auth.dart';

void main() {
  runApp(PrivateEditorScreen());
}

class PrivateEditorScreen extends StatefulWidget {
  const PrivateEditorScreen({Key? key}) : super(key: key);

  @override
  State<PrivateEditorScreen> createState() => _PrivateEditorScreen();
}

class _PrivateEditorScreen extends State<PrivateEditorScreen> {
  int color_id = Random().nextInt(AppStyle.cardsColor.length);
  String date = DateFormat().format(DateTime.now());
  Timestamp timestampDate = Timestamp.now();

  TextEditingController _titleController = TextEditingController();
  TextEditingController _mainController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyle.cardsColor[color_id],
      appBar: AppBar(
        backgroundColor: AppStyle.cardsColor[color_id],
        elevation: 0.0,
        automaticallyImplyLeading: false,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          "Add a new Note",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Note Title',
              ),
              style: AppStyle.mainTitle,
            ),
            SizedBox(height: 8.0),
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
              controller: _mainController,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Note Content',
              ),
              style: AppStyle.mainContent,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppStyle.accentColor,
        onPressed: () async {
          FirebaseFirestore.instance.collection("private-notes").add({
            "title": _titleController.text,
            "timestamp": timestampDate,
            "note": _mainController.text,
            "color": color_id,
            "email": email,
          }).then((value) {
            print(value.id);
            Navigator.pop(context);
          }).catchError(
              (error) => print("Failed to add new Note due to $error"));
        },
        child: Icon(Icons.save),
      ),
    );
  }
}
