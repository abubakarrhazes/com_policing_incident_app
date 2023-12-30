// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, non_constant_identifier_names, prefer_final_fields, unused_field

import 'package:com_policing_incident_app/models/get-models/police.dart';
import 'package:com_policing_incident_app/providers/admin-providers/admin_provider.dart';
import 'package:com_policing_incident_app/widgets/button_widget.dart';
import 'package:com_policing_incident_app/widgets/my_input_field.dart';
import 'package:flutter/material.dart';

class AddPoliceStation extends StatefulWidget {
  const AddPoliceStation({super.key});

  @override
  State<AddPoliceStation> createState() => _AddPoliceStationState();
}

class _AddPoliceStationState extends State<AddPoliceStation> {
  bool _isLoading = false;
  final _NameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final TextEditingController _telePhoneController = TextEditingController();
  final AdminProvider adminProvider = AdminProvider();
  final _addPoliceformKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _NameController.dispose();
    _lastNameController.dispose();
    _telePhoneController.dispose();

    super.dispose();
  }

  // Add Police Station

  void addPoliceStation() {
    adminProvider.adminCreatePoliceStation(
        Data(
          name: _NameController.text,
          address: _lastNameController.text,
          telephone: _telePhoneController.text,
        ),
        context);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Image.asset('assets/images/police.png'),
              Form(
                key: _addPoliceformKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Station Name'),
                    MyInputField(
                      hintText: 'Station',
                      keyboardType: TextInputType.text,
                      controller: _NameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return ' Required';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text('Station Address'),
                    MyInputField(
                      hintText: 'Station Address',
                      keyboardType: TextInputType.text,
                      controller: _lastNameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return ' Required';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text('Station Telephone Number'),
                    MyInputField(
                      hintText: 'Station Telephone Number',
                      controller: _telePhoneController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return ' Required';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    ButtonWidget(
                      text: _isLoading
                          ? 'Creating Please Wait ...'
                          : 'Create Station',
                      onPress: () {
                        if (!_isLoading &&
                            _addPoliceformKey.currentState!.validate()) {
                          setState(() {
                            _isLoading = true; // Set loading state to true
                          });

                          // Call the function to reset the password
                          addPoliceStation();

                          // You may remove the Future.delayed block if forgotUserPassword is synchronous.
                          // This block is here to simulate an asynchronous operation.
                          Future.delayed(Duration(seconds: 15), () {
                            // After the simulated operation is complete, reset the loading state
                            setState(() {
                              _isLoading = false;
                            });
                          });
                        }
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
