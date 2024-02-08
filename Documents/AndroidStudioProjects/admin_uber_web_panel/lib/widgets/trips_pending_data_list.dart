import 'package:admin_uber_web_panel/methods/common_methods.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class TripsPendingDataList extends StatefulWidget {
  const TripsPendingDataList({super.key});

  @override
  State<TripsPendingDataList> createState() => _TripsPendingDataListState();
}

class _TripsPendingDataListState extends State<TripsPendingDataList> {
  final completedTripsRecordsFromDatabase = FirebaseDatabase.instance.ref().child("tripRequests");
  CommonMethods cMethods = CommonMethods();

  // launchGoogleMapFromSourceToDestination(pickUpLat, pickUpLng, dropOffLat, dropOffLng) async{
  //   String directionAPIUrl = "https://www.google.com/maps/dir/?api=1&origin=$pickUpLat,$pickUpLng&destination=$dropOffLat,$dropOffLng&dir_action=navigate";
  //
  //   if(await canLaunchUrl(Uri.parse(directionAPIUrl))){
  //     await launchUrl(Uri.parse(directionAPIUrl));
  //   }
  //   else{
  //     throw "Error. Could not launch google map.";
  //   }
  // }


  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
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
        List itemsList = [];
        dataMap.forEach((key, value) {
          itemsList.add({"key": key, ...value});
        });

        return ListView.builder(
          shrinkWrap: true,
          itemCount: itemsList.length,
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

                  // cMethods.data(
                  //   1,
                  //   ElevatedButton(
                  //     style: ElevatedButton.styleFrom(
                  //       backgroundColor: Colors.blue,
                  //     ),
                  //     onPressed: (){
                  //       String pickUpLat = itemsList[index]["pickUpLatLng"]["latitude"];
                  //       String pickUpLng = itemsList[index]["pickUpLatLng"]["longitude"];
                  //
                  //       String dropOffLat = itemsList[index]["dropOffLatLng"]["latitude"];
                  //       String dropOffLng = itemsList[index]["dropOffLatLng"]["longitude"];
                  //
                  //       launchGoogleMapFromSourceToDestination(
                  //         pickUpLat,
                  //         pickUpLng,
                  //         dropOffLat,
                  //         dropOffLng,
                  //       );
                  //     },
                  //     child: const Text(
                  //       "View More",
                  //       style: TextStyle(
                  //         color: Colors.white,
                  //         fontWeight: FontWeight.bold,
                  //
                  //       ),
                  //     ),
                  //   ),
                  // ),
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
    );
  }
}
