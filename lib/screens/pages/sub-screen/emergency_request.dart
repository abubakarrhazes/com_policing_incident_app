// ignore_for_file: prefer_const_constructors

import 'package:com_policing_incident_app/models/emergency_contact.dart';
import 'package:com_policing_incident_app/providers/features-providers/request_emergency_providers.dart';
import 'package:com_policing_incident_app/screens/pages/sub-screen/report_crime/crime_detail_page.dart';
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
  bool isLoading = false;
  final _emergencyFormKey = GlobalKey<FormState>();
  final RequestEmergecyProvider requestEmergecyProvider =
      RequestEmergecyProvider();

  @override
  void dispose() {
    _emergencyNameController.dispose();
    _emergencyEmailController.dispose();
    _emergencyPhoneController.dispose();
    _emergencyRelationController.dispose();
    _emergencyAddressController.dispose();

    super.dispose();
  }

  void addContacts() {
    requestEmergecyProvider.addEmergencyContactDetails(
        Data(
          name: _emergencyNameController.text,
          mobileNumber: _emergencyPhoneController.text,
          email: _emergencyEmailController.text,
          relation: _emergencyRelationController.text,
          address: _emergencyAddressController.text,
        ),
        context);
  }

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
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Name is Required';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text('Mobile Number'),
                      MyInputField(
                        label: 'Enter Phone',
                        controller: _emergencyPhoneController,
                        prefix: Icon(Icons.contact_phone),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Mobile Number Required';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text('Email'),
                      MyInputField(
                        controller: _emergencyEmailController,
                        label: 'Enter Email',
                        validator: (value) {
                          RegExp emailRegExp = RegExp(
                              r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");

                          if (value == null || value.isEmpty) {
                            return 'Email can\'t be empty';
                          } else if (!emailRegExp.hasMatch(value)) {
                            return 'Enter a correct email';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text('Relation'),
                      MyInputField(
                        controller: _emergencyRelationController,
                        label: 'Enter Relation',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Relation is Required';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text('Address'),
                      MyInputField(
                        controller: _emergencyAddressController,
                        label: 'Enter Address',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Address Required';
                          }
                          return null;
                        },
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
              child: Text(
                isLoading ? 'Adding ....' : 'Add Contact',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                if (!isLoading && _emergencyFormKey.currentState!.validate()) {
                  setState(() {
                    isLoading = true;
                  });
                  addContacts();
                  Future.delayed(Duration(seconds: 3), () {
                    // After the simulated operation is complete, reset the loading state
                    setState(() {
                      isLoading = false;
                      Navigator.of(context).pop();
                    });
                  });
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          elevation: 0,
        ),
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
              ),
              Expanded(
                child: FutureBuilder<EmergencyContact>(
                  future: requestEmergecyProvider.getEmergencyContact(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else {
                      return ListView.builder(
                        itemCount: snapshot.data!.data!.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              SizedBox(
                                height: 15,
                              ),
                              Container(
                                height: 80,
                                decoration: BoxDecoration(
                                    color: KprimaryColor,
                                    borderRadius: BorderRadius.circular(10)),
                                child: ListTile(
                                  onTap: () {},
                                  title: Text(
                                    'Name: ${snapshot.data!.data![index].name} ',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 15),
                                  ),
                                  subtitle: Text(
                                    'Phone Number: ${snapshot.data!.data![index].mobileNumber}',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 15),
                                  ),
                                  // Add more UI components as needed
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
