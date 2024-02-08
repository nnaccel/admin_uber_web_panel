import 'package:admin_uber_web_panel/methods/common_methods.dart';
import 'package:admin_uber_web_panel/widgets/users_data_list.dart';
import 'package:flutter/material.dart';

class UsersPage extends StatefulWidget {
  static const String id = "\webPageUsers";
  const UsersPage({super.key});

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {

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
                      "Manage Customers",
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
                  cMethods.header(2, "USER ID"),
                  cMethods.header(1, "NAME"),
                  cMethods.header(1, "EMAIL"),
                  cMethods.header(1, "PHONE"),
                  cMethods.header(1, "ACTION"),
                ],
              ),

              //display data
              UsersDataList(),
            ],
          ),
        ),
      ),
    );
  }
}
