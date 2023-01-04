import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'main.dart';

// import sign in button
import 'package:flutter_signin_button/flutter_signin_button.dart';

String? email = FirebaseAuth.instance.currentUser?.email;