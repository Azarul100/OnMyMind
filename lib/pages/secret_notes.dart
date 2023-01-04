import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:on_my_mind/pages/home_page.dart';
import 'package:on_my_mind/pages/login_page.dart';
import 'package:on_my_mind/style/app_style.dart';
import 'package:on_my_mind/widgets/note_card.dart';
import 'package:on_my_mind/pages/private_editor.dart';
import 'package:on_my_mind/pages/private_reader.dart';
import '../auth.dart';

// Code for current user
String? user_id = FirebaseAuth.instance.currentUser?.uid;
String? user_email = FirebaseAuth.instance.currentUser?.email;

class SecretNotes extends StatefulWidget {
  const SecretNotes({super.key, required this.title});
  final String title;

  @override
  _SecretNotes createState() => _SecretNotes();
}

class _SecretNotes extends State<SecretNotes> {
  static const String _title = 'OnMyMind';
  bool typing = true;

  refresh() {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyle.mainColor,
      extendBodyBehindAppBar: true,
      // AppBar
      appBar: AppBar(
          backgroundColor: AppStyle.bgColor,
          leading: Icon(Icons.file_copy_rounded),
          automaticallyImplyLeading: false,
          title: Text(
            _title,
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          actions: <Widget>[
            Builder(builder: (context) {
              return IconButton(
                icon: const Icon(Icons.logout),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginPage()));
                },
              );
            })
          ],
          iconTheme: IconThemeData(color: Colors.black)),
      body: Stack(
        children: <Widget>[
          Container(
            color: AppStyle.mainColor,
          ),
          Positioned(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
            ),
          ),
          Positioned(
            top: 80.0,
            left: 20.0,
            bottom: 20.0,
            right: 20.0,

            //here the body
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "$user_email's Secret Notes",
                    style: GoogleFonts.roboto(
                      color: AppStyle.accentColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  // making placeholder for future
                  Expanded(
                    child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection("private-notes")
                          .orderBy("timestamp", descending: true)
                          .snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        //check conection XD
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        List<QueryDocumentSnapshot<Object?>> notes = snapshot
                            .data!.docs
                            .where((element) => element['email'] == email)
                            .toList();

                        if (notes.isNotEmpty) {
                          return GridView.builder(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount:
                                    (MediaQuery.of(context).size.width ~/ 250),
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                                mainAxisExtent: 300,
                              ),
                              shrinkWrap: true,
                              itemCount: notes.length,
                              itemBuilder: (context, index) {
                                QueryDocumentSnapshot<Object?> note =
                                    notes[index];
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 7.0),
                                  child: noteCard(() {
                                    color_id = -1;
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              PrivateReaderScreen(note),
                                        ));
                                  }, note),
                                );
                              });
                        }

                        return Text("You Have No Notes",
                            style: GoogleFonts.nunito(
                              color: Colors.black,
                            ));
                      },
                    ),
                  ),
                ]),
          ),
        ],
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
      floatingActionButton: Padding(
        padding: EdgeInsets.only(left: 30),
        child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
          FloatingActionButton(
            child: Icon(Icons.lock_open),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MyHomePage(
                            title: 'OnMyMind',
                          )));
            },
            backgroundColor: AppStyle.bgColor,
          ),
          SizedBox(
            height: 10,
          ),
          FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const PrivateEditorScreen()));
            },
            backgroundColor: AppStyle.bgColor,
          )
        ]),
      ),
      //floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
