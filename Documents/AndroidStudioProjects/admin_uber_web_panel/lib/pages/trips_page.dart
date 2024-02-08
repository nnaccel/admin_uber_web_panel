import 'package:admin_uber_web_panel/methods/common_methods.dart';
import 'package:admin_uber_web_panel/widgets/trips_data_list.dart';
import 'package:flutter/material.dart';

class TripsPage extends StatefulWidget {
  static const String id = "\webPageTrips";
  const TripsPage({super.key});

  @override
  State<TripsPage> createState() => _TripsPageState();
}

class _TripsPageState extends State<TripsPage> {

  CommonMethods cMethods = CommonMethods();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    alignment: Alignment.topLeft,
                    width: 250,
                    child: const Text(
                      "Manage Trips",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 100,
                    height: 18,
                  ),
                  Container(
                    alignment: Alignment.topRight,
                    width: 300,
                    child: const TextField(
                      decoration: InputDecoration(
                        labelText: "Search", suffixIcon: Icon(Icons.search),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 18,
              ),
              Row(
                children: [
                  cMethods.header(2, "TRIP ID"),
                  cMethods.header(1, "USER NAME"),
                  cMethods.header(1, "DRIVER NAME"),
                  cMethods.header(1, "CAR DETAILS"),
                  cMethods.header(1, "TIMING"),
                  cMethods.header(1, "FARE"),
                  cMethods.header(1, "VIEW DETAILS"),
                ],
              ),

              //display data
              TripsDataList(),
            ],
          ),
        ),
      ),
    );
  }
}
