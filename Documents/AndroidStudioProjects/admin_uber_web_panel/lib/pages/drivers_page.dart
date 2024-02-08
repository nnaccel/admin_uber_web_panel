import 'package:admin_uber_web_panel/methods/common_methods.dart';
import 'package:admin_uber_web_panel/widgets/drivers_data_list.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class DriversPage extends StatefulWidget {
  static const String id = "\webPageDrivers";
  const DriversPage({super.key});

  @override
  State<DriversPage> createState() => _DriversPageState();
}

class _DriversPageState extends State<DriversPage> {
  final driversRecordsFromDatabase = FirebaseDatabase.instance.ref().child("drivers");
  CommonMethods cMethods = CommonMethods();


  // @override
  // initState() {
  //   _foundDrivers = driversRecordsFromDatabase;
  //   super.initState();
  // }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.start,
              //   children: [
              //
              //   ],
              // ),
              Container(
                alignment: Alignment.topLeft,
                width: 250,
                child: const Text(
                  "Manage Drivers",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                alignment: Alignment.topRight,
                child: const TextField(
                  decoration: InputDecoration(
                    labelText: "Search", suffixIcon: Icon(Icons.search),
                  ),
                ),
              ),
              // const SizedBox(
              //   height: 18,
              // ),
              // Container(
              //   alignment: Alignment.topRight,
              //   child: TextButton.icon(
              //     icon: const RotatedBox(
              //       quarterTurns: 1,
              //       child: Icon(Icons.compare_arrows, size: 20),
              //     ),
              //     label: const Text(
              //       "Ascending",
              //       style: TextStyle(
              //         fontSize: 18,
              //
              //       ),
              //     ),
              //     onPressed: (){
              //
              //     },
              //   ),
              // ),
              const SizedBox(
                height: 18,
              ),
              Row(
                children: [
                  cMethods.header(2, "DRIVER ID"),
                  cMethods.header(1, "PICTURE"),
                  cMethods.header(1, "NAME"),
                  cMethods.header(1, "CAR DETAILS"),
                  cMethods.header(1, "PHONE"),
                  cMethods.header(1, "TOTAL EARNINGS"),
                  cMethods.header(1, "ACTION"),
                ],
              ),

              //display data
              DriversDataList(),

            ],
          ),
        ),
      ),
    );
  }
}
