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
  String name = "";
  List<Map> itemsList = [];
  final driversRecordsFromDatabase = FirebaseDatabase.instance.ref().child("drivers");
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
                  "Manage Driver Accounts",
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
              //DriversDataList(),
              StreamBuilder(
                stream: driversRecordsFromDatabase.onValue,
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
                      item["name"].toString().toLowerCase().contains(name.toLowerCase())
                  ).toList();

                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: filteredItemsList.length,
                    itemBuilder: ((context, index){
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          cMethods.data(
                            2,
                            Text(itemsList[index]["id"].toString()),
                          ),

                          cMethods.data(
                            1,
                            Image.network(
                              itemsList[index]["photo"].toString(),
                              width: 50,
                              height: 50,
                            ),
                          ),
                          cMethods.data(
                            1,
                            Text(itemsList[index]["name"].toString()),
                          ),
                          cMethods.data(
                            1,
                            Text(
                                itemsList[index]["car_details"]["carModel"].toString() + " - " +
                                    itemsList[index]["car_details"]["carPlateNumber"].toString()
                            ),
                          ),
                          cMethods.data(
                            1,
                            Text(itemsList[index]["phone"].toString()),
                          ),
                          cMethods.data(
                            1,
                            itemsList[index]["earnings"] != null ?
                            Text("\$" + itemsList[index]["earnings"].toString())
                                : const Text("\₱0"),
                          ),
                          cMethods.data(
                            1,
                            itemsList[index]["blockStatus"] == "no" ?
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                              ),
                              onPressed: () async{
                                await FirebaseDatabase.instance.ref()
                                    .child("drivers").child(itemsList[index]["id"])
                                    .update({
                                  "blockStatus": "yes",
                                });
                              },
                              child: const Text(
                                "Block",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )
                                : ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                              ),
                              onPressed: () async{
                                await FirebaseDatabase.instance.ref()
                                    .child("drivers").child(itemsList[index]["id"])
                                    .update({
                                  "blockStatus": "no",
                                });
                              },
                              child: const Text(
                                "Approve",
                                style: TextStyle(
                                  backgroundColor: Colors.green,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,

                                ),
                              ),
                            ),
                          ),
                        ],
                      );
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

  void SearchMethod(String text) {
    setState(() {
      name = text;
    });
  }
}
