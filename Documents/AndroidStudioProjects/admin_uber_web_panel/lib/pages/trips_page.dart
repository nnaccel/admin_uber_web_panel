import 'package:admin_uber_web_panel/methods/common_methods.dart';
import 'package:admin_uber_web_panel/widgets/trips_data_list.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class TripsPage extends StatefulWidget {
  static const String id = "\webPageTrips";
  const TripsPage({super.key});

  @override
  State<TripsPage> createState() => _TripsPageState();
}

class _TripsPageState extends State<TripsPage> {
  String name = "";
  List<Map> itemsList = [];
  final completedTripsRecordsFromDatabase = FirebaseDatabase.instance.ref().child("tripRequests");
  CommonMethods cMethods = CommonMethods();

  launchGoogleMapFromSourceToDestination(pickUpLat, pickUpLng, dropOffLat, dropOffLng) async{
    String directionAPIUrl = "https://www.google.com/maps/dir/?api=1&origin=$pickUpLat,$pickUpLng&destination=$dropOffLat,$dropOffLng&dir_action=navigate";

    if(await canLaunchUrl(Uri.parse(directionAPIUrl))){
      await launchUrl(Uri.parse(directionAPIUrl));
    }
    else{
      throw "Error. Could not launch google map.";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                alignment: Alignment.topLeft,
                child: const Text(
                  "Manage Trips",
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
                child: TextField(
                  decoration: const InputDecoration(
                    labelText: "Search", suffixIcon: Icon(Icons.search),
                  ),
                  onChanged: (text){
                    SearchMethod(text);
                  },
                ),
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
              //TripsDataList(),
              StreamBuilder(
                stream: completedTripsRecordsFromDatabase.onValue,
                builder: (BuildContext context, snapshotData){
                  if(snapshotData.hasError){
                    return const Center(
                      child: Text(
                        "Error Occurred. Try Again Later.",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                          color: Colors.pink,
                        ),
                      ),
                    );
                  }
                  if(snapshotData.connectionState == ConnectionState.waiting){
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  Map dataMap = snapshotData.data!.snapshot.value as Map;
                  itemsList = [];
                  dataMap.forEach((key, value) {
                    itemsList.add({"key": key, ...value});
                  });

                  List<Map> filteredItemsList = itemsList.where((item) =>
                      item["userName"].toString().toLowerCase().contains(name.toLowerCase())
                  ).toList();

                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: filteredItemsList.length,
                    itemBuilder: ((context, index){
                      if(itemsList[index]["status"] != null && itemsList[index]["status"] == "ended"){
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            cMethods.data(
                              2,
                              Text(itemsList[index]["tripID"].toString()),
                            ),

                            cMethods.data(
                              1,
                              Text(itemsList[index]["userName"].toString()),
                            ),

                            cMethods.data(
                              1,
                              Text(itemsList[index]["driverName"].toString()),
                            ),

                            cMethods.data(
                              1,
                              Text(itemsList[index]["carDetails"].toString()),
                            ),

                            cMethods.data(
                              1,
                              Text(itemsList[index]["publishDateTime"].toString()),
                            ),

                            cMethods.data(
                              1,
                              Text(itemsList[index]["₱" + "deliveryAmount"].toString()),
                            ),

                            cMethods.data(
                              1,
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue,
                                ),
                                onPressed: (){
                                  String pickUpLat = itemsList[index]["pickUpLatLng"]["latitude"];
                                  String pickUpLng = itemsList[index]["pickUpLatLng"]["longitude"];

                                  String dropOffLat = itemsList[index]["dropOffLatLng"]["latitude"];
                                  String dropOffLng = itemsList[index]["dropOffLatLng"]["longitude"];

                                  launchGoogleMapFromSourceToDestination(
                                    pickUpLat,
                                    pickUpLng,
                                    dropOffLat,
                                    dropOffLng,
                                  );
                                },
                                child: const Text(
                                  "View More",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      }
                      else{
                        return Container();
                      }
                    }),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void SearchMethod(String text){
    setState(() {
      name = text;
    });
  }
}
