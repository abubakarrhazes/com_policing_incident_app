// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:com_policing_incident_app/screens/onboard_screen/model/onboard_model.dart';
import 'package:com_policing_incident_app/utilities/global_variables.dart';
import 'package:flutter/material.dart';

class GetCases extends StatefulWidget {
  const GetCases({super.key});

  @override
  State<GetCases> createState() => _GetCasesState();
}

final List<dynamic> dummyData = [
  "Case 1",
  "Case 2",
  "Case 3",
  "Case 4",
  "Case 5",
  "Case 6",
  "Case 7",
];

class _GetCasesState extends State<GetCases> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: dummyData.length,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 15,
              ),
              Container(
                height: 100,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: KprimaryColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Report Reference Number ',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          );
        });
  }
}
