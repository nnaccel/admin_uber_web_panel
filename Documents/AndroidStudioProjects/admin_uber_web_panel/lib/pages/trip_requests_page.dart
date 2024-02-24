import 'package:admin_uber_web_panel/methods/common_methods.dart';
import 'package:admin_uber_web_panel/widgets/trips_data_list.dart';
import 'package:admin_uber_web_panel/widgets/trips_pending_data_list.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class TripRequestsPage extends StatefulWidget {
  static const String id = "\webPageTripRequests";
  const TripRequestsPage({super.key});

  @override
  State<TripRequestsPage> createState() => _TripRequestsPageState();
}

class _TripRequestsPageState extends State<TripRequestsPage> {
  String name = "";
  List<Map> itemsList = [];
  final tripsRecordsFromDatabase = FirebaseDatabase.instance.ref().child("tripRequests");
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
              Container(
                alignment: Alignment.topLeft,
                child: const Text(
                  "Manage Trip Requests",
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
                  cMethods.header(1, "PICK UP ADDRESS"),
                  cMethods.header(1, "DROP OFF ADDRESS"),
                  cMethods.header(1, "TIMING"),
                  cMethods.header(2, "UPDATE PENDING STATUS"),
                  //cMethods.header(1, "VIEW DETAILS"),
                ],
              ),

              //display data
              //TripsPendingDataList(),
              StreamBuilder(
                stream: tripsRecordsFromDatabase.onValue,
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
                      if(itemsList[index]["dispatchStatus"] != null && itemsList[index]["dispatchStatus"] == "pending"){
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
                              Text(itemsList[index]["pickUpAddress"].toString()),
                            ),

                            cMethods.data(
                              1,
                              Text(itemsList[index]["dropOffAddress"].toString()),
                            ),

                            cMethods.data(
                              1,
                              Text(itemsList[index]["publishDateTime"].toString()),
                            ),

                            cMethods.data(
                              1,
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green,
                                ),
                                onPressed: () async{
                                  await FirebaseDatabase.instance.ref()
                                      .child("tripRequests").child(itemsList[index]["tripID"])
                                      .update({
                                    "dispatchStatus": "accept",
                                  });
                                },
                                child: const Text(
                                  "Accept",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,

                                  ),
                                ),
                              ),
                            ),
                            cMethods.data(
                              1,
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red,
                                ),
                                onPressed: () async{
                                  await FirebaseDatabase.instance.ref()
                                      .child("tripRequests").child(itemsList[index]["tripID"])
                                      .remove();
                                },
                                child: const Text(
                                  "Reject",
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
