import 'package:admin_uber_web_panel/methods/common_methods.dart';
import 'package:flutter/material.dart';

class CSTicketsPage extends StatefulWidget {
  static const String id = "\webPageCSTickets";
  const CSTicketsPage({super.key});

  @override
  State<CSTicketsPage> createState() => _CSTicketsPageState();
}

class _CSTicketsPageState extends State<CSTicketsPage> {

  CommonMethods cMethods = CommonMethods();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Oops! This Page is Under Construction.",
                style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Image.asset("images/under.png"),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.start,
              //   children: [
              //
              //   ],
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
