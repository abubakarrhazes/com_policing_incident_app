// ignore_for_file: prefer_const_constructors

import 'package:com_policing_incident_app/utilities/global_variables.dart';
import 'package:com_policing_incident_app/widgets/my_input_field.dart';
import 'package:flutter/material.dart';

class EmergencyRequest extends StatefulWidget {
  const EmergencyRequest({super.key});

  @override
  State<EmergencyRequest> createState() => _EmergencyRequestState();
}

class _EmergencyRequestState extends State<EmergencyRequest> {
  final _emergencyNameController = TextEditingController();
  final _emergencyPhoneController = TextEditingController();
  final _emergencyEmailController = TextEditingController();
  final _emergencyRelationController = TextEditingController();
  final _emergencyAddressController = TextEditingController();
  final _emergencyFormKey = GlobalKey<FormState>();
  void showEmegencyContactDialog(BuildContext context, String title) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: Column(
              children: [
                Form(
                  key: _emergencyFormKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Name'),
                      MyInputField(
                        label: 'Enter Name',
                        controller: _emergencyNameController,
                        prefix: Icon(Icons.person),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text('Mobile Number'),
                      MyInputField(
                        label: 'Enter Phone',
                        controller: _emergencyPhoneController,
                        prefix: Icon(Icons.contact_phone),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text('Email'),
                      MyInputField(
                        controller: _emergencyEmailController,
                        label: 'Enter Email',
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text('Relation'),
                      MyInputField(
                        controller: _emergencyRelationController,
                        label: 'Enter Relation',
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text('Address'),
                      MyInputField(
                        controller: _emergencyAddressController,
                        label: 'Enter Address',
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              style: TextButton.styleFrom(
                  backgroundColor: KprimaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  )),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Add Contact',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _emergencyNameController.dispose();
    _emergencyEmailController.dispose();
    _emergencyPhoneController.dispose();
    _emergencyRelationController.dispose();
    _emergencyAddressController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'To whom you want contact in Case of Cases',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      showEmegencyContactDialog(
                        context,
                        'Add Emergency Contacts',
                      );
                    },
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        color: KprimaryColor,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
