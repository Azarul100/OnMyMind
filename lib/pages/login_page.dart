import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:on_my_mind/pages/home_page.dart';
import 'package:on_my_mind/pages/signup_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPage createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    const String _title = 'OnMyMind';

    return Scaffold(
        appBar: AppBar(
          //centerTitle: true,
          backgroundColor: Colors
              .black, //Color(0xffFFF69E), //Color.fromARGB(255, 228, 218, 132),
          elevation: 0,
          automaticallyImplyLeading: false,
          /*leading: Icon(Icons.file_copy_rounded),
				title: const Text(
					_title,
					style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)
				),
				iconTheme: IconThemeData(color: Colors.black)*/
        ),
        body: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(children: <Widget>[
                SizedBox(
                  height: 50,
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
                      boxShadow: [BoxShadow(color: Color(0xffFFF69E))]),
                  child: Column(children: [
                    Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(10),
                        child: const Text(
                          '\n\n\nSign In',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 30),
                        )),
                    Container(
                      // input for email address
                      padding: const EdgeInsets.all(10),
                      child: TextField(
                        controller: nameController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black)),
                          labelText: 'Email',
                        ),
                      ),
                    ),
                    Container(
                      // input for password
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                      child: TextField(
                        obscureText: true,
                        controller: passwordController,
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
                        // login button
                        height: 50,
                        width: 150,
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: ElevatedButton(
                          style:
                              ElevatedButton.styleFrom(primary: Colors.black),
                          child: const Text('Login',
                              style: TextStyle(
                                  fontSize: 20, color: Color(0xffFFF69E))),
                          onPressed: () async {
                            try {
                              final credential = await FirebaseAuth.instance
                                  .signInWithEmailAndPassword(
                                      email: nameController.text,
                                      password: passwordController.text)
                                  .then((value) {
                                print('Signed in successfully');
                                //Go to Home Page
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            MyHomePage(title: 'OnMyMind')));
                              });
                            } on FirebaseAuthException catch (e) {
                              if (e.code == 'user-not-found') {
                                print('No user found for that email.');
                              } else if (e.code == 'wrong-password') {
                                print('Wrong password provided for that user.');
                              }
                            }
                          },
                        )),
                    Row(
                      children: <Widget>[
                        const Text(
                          "\n Don't have an account? \n",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 19),
                        ),
                      ],
                      mainAxisAlignment: MainAxisAlignment.center,
                    ),
                    Container(
                        height: 50,
                        width: 150,
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: ElevatedButton(
                          style:
                              ElevatedButton.styleFrom(primary: Colors.black),
                          child: const Text('Sign Up',
                              style: TextStyle(
                                  fontSize: 20, color: Color(0xffFFF69E))),
                          onPressed: () {
                            // Go to Sign Up Page
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignUpPage()));
                          },
                        )),
                  ]),
                )
              ]),
              Column(children: <Widget>[
                SizedBox(
                  height: 100,
                ),
                Image.asset(
                  'assets/onmymind.png',
                  height: 275,
                  width: 275,
                ),
                Container(
                  width: 700,
                  child: Text(
                    '\n\n\n"If you wish to forget anything on the spot, make a note that this thing is to be remembered.” ',
                    //textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.black,
                    ),
                  ),
                ),
                Container(
                  width: 700,
                  child: Text(
                    '\n - Edgar Allan Poe ',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ]),
            ],
          ),
        ));
  }
}
