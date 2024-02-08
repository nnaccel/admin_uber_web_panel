import 'package:admin_uber_web_panel/dashboard/side_navigation_drawer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: "AIzaSyD4lbP7ywKd7DH_Zf6iK6Sv8eHhC8MPsJ0",
        authDomain: "thesis2-207ad.firebaseapp.com",
        databaseURL: "https://thesis2-207ad-default-rtdb.firebaseio.com",
        projectId: "thesis2-207ad",
        storageBucket: "thesis2-207ad.appspot.com",
        messagingSenderId: "205456388687",
        appId: "1:205456388687:web:86f0cff60b848d7988b03a",
        measurementId: "G-H36XVEKPTE"
    )
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Admin Panel',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: SideNavigationDrawer(),
    );
  }
}


