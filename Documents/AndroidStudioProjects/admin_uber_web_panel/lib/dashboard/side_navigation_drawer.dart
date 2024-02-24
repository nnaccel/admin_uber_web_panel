import 'package:admin_uber_web_panel/pages/drivers_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';

import '../pages/trips_page.dart';
import '../pages/customers_page.dart';
import '../pages/trip_requests_page.dart';
import '../pages/cs_tickets_page.dart';
import 'dashboard.dart';

class SideNavigationDrawer extends StatefulWidget {
  const SideNavigationDrawer({super.key});

  @override
  State<SideNavigationDrawer> createState() => _SideNavigationDrawerState();
}

class _SideNavigationDrawerState extends State<SideNavigationDrawer> {

  Widget chosenScreen = Dashboard();
  sendAdminTo(selectedPage){
    switch(selectedPage.route){
      case DriversPage.id:
        setState(() {
          chosenScreen = DriversPage();
        });
        break;
      case CustomersPage.id:
        setState(() {
          chosenScreen = CustomersPage();
        });
        break;
      case TripsPage.id:
        setState(() {
          chosenScreen = TripsPage();
        });
        break;
      case TripRequestsPage.id:
        setState(() {
          chosenScreen = TripRequestsPage();
        });
        break;
      // case CSTicketsPage.id:
      //   setState(() {
      //     chosenScreen = CSTicketsPage();
      //   });
      //   break;
    }
  }
  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
      backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: const Color(0xff030126),
        title: Image.asset(
          "images/logo2.png",
          width: 200,
          height: 50,
        ),

      ),
      sideBar: SideBar(
        items: const [
          AdminMenuItem(
            title: "Drivers",
            route: DriversPage.id,
            icon: CupertinoIcons.car_detailed,
          ),
          AdminMenuItem(
            title: "Customers",
            route: CustomersPage.id,
            icon: CupertinoIcons.person_2_fill,
          ),
          AdminMenuItem(
            title: "Trip Requests",
            route: TripRequestsPage.id,
            icon: CupertinoIcons.location_fill,
          ),
          AdminMenuItem(
            title: "Trips Approved",
            route: TripsPage.id,
            icon: CupertinoIcons.checkmark_circle_fill,
          ),
          // AdminMenuItem(
          //   title: "CS Tickets",
          //   route: CSTicketsPage.id,
          //   icon: CupertinoIcons.tickets_fill,
          // ),
        ],
        selectedRoute: DriversPage.id,
        onSelected: (selectedPage){
          sendAdminTo(selectedPage);
        },
        header: Container(
          height: 52,
          width: double.infinity,
          color: const Color(0xffffdd00),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Admin/Dispatcher Web Panel",
                style: TextStyle(
                    //fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                ),
              ),

              // Icon(
              //   Icons.accessibility,
              //   color: Colors.white,
              // ),
              // SizedBox(
              //   width: 10,
              // ),
              // Icon(
              //   Icons.settings,
              //   color: Colors.white,
              // ),
            ],
          ),
        ),
        footer: Container(
          height: 52,
          width: double.infinity,
          color: const Color(0xffffdd00),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Icon(
              //   Icons.admin_panel_settings_outlined,
              //   color: Colors.white,
              // ),
              // SizedBox(
              //   width: 10,
              // ),
              // Icon(
              //   Icons.computer,
              //   color: Colors.white,
              // ),
              Text(
                "Developed by: Agoo, Lanuza, Lee, Rivera",
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white
                ),
              ),
            ],
          ),
        ),
      ),
      body: chosenScreen,
    );
  }
}
