import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:on_my_mind/pages/login_page.dart';
import 'package:on_my_mind/pages/pass_page.dart';
import 'home_page.dart';
import 'package:on_my_mind/pages/home_page.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _newEmailController = TextEditingController();
  final _newPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    const String _title = 'OnMyMind';

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        //centerTitle: true,
        backgroundColor: Colors.black, //.fromARGB(255, 228, 218, 132),
        automaticallyImplyLeading: false,
        //leading: Icon(Icons.file_copy_rounded),
        /*title: const Text(
              _title,
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              //textAlign: TextAlign.center,
            ),*/
        //iconTheme: IconThemeData(color: Colors.black)
      ),
      //
      body: Center(
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: <Widget>[
                  SizedBox(
                    height: 100,
                  ),
                  Container(
                    width: 500,
                    height: 600,
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black,
                          width: 0,
                        ),
                        borderRadius: BorderRadius.circular(30.0),
                        boxShadow: [BoxShadow(color: (Color(0xffFFF69E)))]),
                    child: Column(children: [
                      Container(
                        width: 500,
                        child: Column(children: [
                          Container(
                              alignment: Alignment.center,
                              padding: const EdgeInsets.all(10),
                              child: const Text(
                                '\n\n\nSign Up',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 30),
                              )),
                          Container(
                            padding: const EdgeInsets.all(10),
                            child: TextField(
                              controller: _newEmailController,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.black)),
                                labelText: 'Email',
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                            child: TextField(
                              obscureText: true,
                              controller: _newPasswordController,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Password',
                              ),
                            ),
                          ),
                          const Text(
                            '\n',
                          ),
                          Container(
                              height: 50,
                              width: 200,
                              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.black),
                                child: const Text('Create Account',
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Color(0xffFFF69E))),
                                onPressed: () async {
                                  try {
                                    final credential = await FirebaseAuth
                                        .instance
                                        .createUserWithEmailAndPassword(
                                            email: _newEmailController.text,
                                            password:
                                                _newPasswordController.text)
                                        .then((value) {
                                      print("Created New Account");
                                      //Go to Home Page
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  PassPage(title: 'OnMyMind')));
                                      // Print Stack Trace
                                    }).onError((error, stackTrace) {
                                      print("Error ${error.toString()}");
                                    });
                                  } on FirebaseAuthException catch (e) {
                                    if (e.code == 'weak-password') {
                                      print(
                                          'The password provided is too weak.');
                                    } else if (e.code ==
                                        'email-already-in-use') {
                                      print(
                                          'The account already exists for that email.');
                                    }
                                  } catch (e) {
                                    print(e);
                                  }
                                },
                              )),
                          SizedBox(
                            height: 30,
                          ),
                          Row(
                            children: <Widget>[
                              const Text(
                                "Already have an account? \n",
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 19),
                              ),
                            ],
                            mainAxisAlignment: MainAxisAlignment.center,
                          ),
                          Container(
                              height: 50,
                              width: 200,
                              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.black),
                                child: const Text('Login',
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Color(0xffFFF69E))),
                                onPressed: () async {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => LoginPage()));
                                },
                              )),
                        ]),
                      )
                    ]),
                  ),
                ],
              ),
              Column(children: <Widget>[
                SizedBox(
                  height: 120,
                ),
                Image.asset(
                  'assets/onmymind.png',
                  height: 275,
                  width: 275,
                ),
                Container(
                  width: 500,
                  child: Text(
                    '\n\n\nBy making an account, users will be able to create notes that can be accessed anytime anywhere. Notes can be edited, deleted, or made private using the secret password that you will make on the next page',
                    //textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ]),
            ]),
      ),
    );
  }
}
