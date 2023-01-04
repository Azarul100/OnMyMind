import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:on_my_mind/pages/home_page.dart';
import 'package:on_my_mind/pages/secret_notes.dart';
import 'package:on_my_mind/pages/signup_page.dart';

class SecretPWPage extends StatefulWidget {
  const SecretPWPage({super.key, required this.title});
  final String title;

  @override
  _SecretPWPage createState() => _SecretPWPage();
}

class _SecretPWPage extends State<SecretPWPage> {
  TextEditingController passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    const String _title = 'OnMyMind';

    return Scaffold(
        body: Center(
          child: Container(
            width: 500,
            child: Column(children: [
              Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  child: const Text(
                    '\n\nEnter your secret notes password.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 30),
                  )),
              Container(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  obscureText: true,
                  controller: passController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red)),
                    labelText: 'Secret notes password',
                  ),
                ),
              ),
              const Text(
                '\n',
              ),
              Container(
                height: 150,
                width: 300,
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                  .collection("priv-PW")
                  .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    //check conection XD
                    if (snapshot.connectionState ==ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    QueryDocumentSnapshot<Object?> document = snapshot
                        .data!.docs
                        .where((element) => element['email'] == FirebaseAuth.instance.currentUser?.email)
                        .toList().first;

                    if(document.exists) {
                      return Column(
                        children: [
                          Container(
                            height: 50,
                            width: 300,
                            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: Color.fromARGB(255, 228, 218, 132)),
                              child: const Text(
                                'Go To Secret Notes',
                                style: TextStyle(fontSize: 20, color: Colors.black)
                              ),
                              onPressed: () async {
                                if(document['password'].toString() == passController.text) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              SecretNotes(title: 'OnMyMind')
                                      )
                                  );
                                }
                                else {
                                  print("incorrect password");
                                }
                              },
                            )
                          ),
                          SizedBox(
                            height: 30.0,
                          ),
                          Container(
                            height: 50,
                            width: 300,
                            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: Color.fromARGB(255, 228, 218, 132)),
                              child: const Text(
                                'Return To Notes',
                                style: TextStyle(fontSize: 20, color: Colors.black)
                              ),
                              onPressed: () async {
                                Navigator.pop(context);
                              },
                            )
                          ),
                        ],
                      );
                    }
                    return Text(
                      'You have no password',
                      style: TextStyle(fontSize: 20, color: Colors.black)
                    );
                  }
                ),
              ),
            ]
          ),
        ),
      )
    );
  }
}
