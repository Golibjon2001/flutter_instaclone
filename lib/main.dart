import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_instaclone/pages/hom_page.dart';
import 'package:flutter_instaclone/pages/signin_page.dart';
import 'package:flutter_instaclone/pages/signup_page.dart';
import 'package:flutter_instaclone/pages/splesh_page.dart';
import 'package:flutter_instaclone/servise/prefs_servise.dart';

void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  Widget _CallStartPage() {
    return StreamBuilder<FirebaseUser>(
      stream: FirebaseAuth.instance.onAuthStateChanged,
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasData) {
          Prefs.saveUserId(snapshot.data!.uid);
          return SpleshPage();
        } else {
          Prefs.removeUserId();
          return SignInPage();
        }
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home:_CallStartPage(),
      routes: {
        SpleshPage.id:(context)=>SpleshPage(),
        SignInPage.id:(context)=>SignInPage(),
        SignUpPage.id:(context)=>SignUpPage(),
        HomPage.id:(context)=>HomPage(),
       },
    );
  }
}

