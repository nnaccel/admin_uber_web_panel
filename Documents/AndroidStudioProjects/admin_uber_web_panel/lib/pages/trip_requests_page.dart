import 'package:admin_uber_web_panel/methods/common_methods.dart';
import 'package:admin_uber_web_panel/widgets/trips_data_list.dart';
import 'package:admin_uber_web_panel/widgets/trips_pending_data_list.dart';
import 'package:flutter/material.dart';

class TripRequestsPage extends StatefulWidget {
  static const String id = "\webPageTripRequests";
  const TripRequestsPage({super.key});

  @override
  State<TripRequestsPage> createState() => _TripRequestsPageState();
}

class _TripRequestsPageState extends State<TripRequestsPage> {

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
                      "Manage Trip Requests",
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
                  cMethods.header(1, "PICK UP ADDRESS"),
                  cMethods.header(1, "DROP OFF ADDRESS"),
                  cMethods.header(1, "TIMING"),
                  cMethods.header(2, "UPDATE PENDING STATUS"),
                  //cMethods.header(1, "VIEW DETAILS"),
                ],
              ),

              //display data
              TripsPendingDataList(),
            ],
          ),
        ),
      ),
    );
  }
}
