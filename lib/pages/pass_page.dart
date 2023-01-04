import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:on_my_mind/pages/home_page.dart';
import 'package:on_my_mind/pages/signup_page.dart';


class PassPage extends StatefulWidget {
	const PassPage({super.key, required this.title});
	final String title;

	@override
	_PassPage createState() => _PassPage();
}

class _PassPage extends State<PassPage> {
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
							'\n\nYou must create a password for your secret notes. This password cannot be reset.\n\n', textAlign: TextAlign.center,
							style: TextStyle(
								color: Colors.black,
								fontWeight: FontWeight.w500,
								fontSize: 30
							),
						)
					),
					Container(
						padding: const EdgeInsets.all(10),
						child: TextField(
							obscureText: true,
							controller: passController,
							decoration: const InputDecoration(
								border: OutlineInputBorder(
									borderSide: BorderSide(color: Colors.red)
								),
								labelText: 'Secret notes password',
							),
						),
					),
				const Text(
					'\n',
				),
				Container(
					height: 50,
					width: 300,
					padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
					child: ElevatedButton(
						style: ElevatedButton.styleFrom(
							primary: Color.fromARGB(255, 228, 218, 132)),
						child: const Text('Create Secret Password',
							style: TextStyle(fontSize: 20, color: Colors.black)),
						onPressed: () async {
							FirebaseFirestore.instance.collection("priv-PW").add({
								"email": FirebaseAuth.instance.currentUser?.email,
								"password": passController.text
							}).then((value) {
								Navigator.push(
									context,
									MaterialPageRoute(
										builder: (context) => MyHomePage(title: 'OnMyMind')
									)
								);
							}).catchError((error) => print("Failed to save secret notes password! Error: $error"));
						},
                	)
				),
            	]),
          		),
        	)
		);
  	}
}