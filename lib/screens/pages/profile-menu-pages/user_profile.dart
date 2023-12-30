// ignore_for_file: public_member_api_docs, sort_constructors_first, avoid_unnecessary_containers
// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:com_policing_incident_app/providers/persistance_data/user_adapter.dart';
import 'package:com_policing_incident_app/widgets/button_widget.dart';
import 'package:com_policing_incident_app/widgets/my_input_field.dart';
import 'package:flutter/material.dart';

import 'package:com_policing_incident_app/utilities/global_variables.dart';
import 'package:com_policing_incident_app/widgets/avatar.dart';
import 'package:provider/provider.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _otherNameController = TextEditingController();
  final TextEditingController _emailNameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();

  final TextEditingController _dateOfBithController = TextEditingController();

  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _occupationController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  void _showBottomModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 500,
          width: double.infinity,
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Form(
                child: Column(
                  children: [
                    MyInputField(
                      hintText: 'Firsname',
                      controller: _firstNameController,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    MyInputField(
                      hintText: 'OtherField',
                      controller: _firstNameController,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    ButtonWidget(
                        text: 'Save Edit',
                        onPress: () {
                          Navigator.of(context).pop();
                        })
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _otherNameController.dispose();
    _emailNameController.dispose();
    _phoneNumberController.dispose();
    _dateOfBithController.dispose();
    _stateController.dispose();
    _occupationController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userAdapter = Provider.of<UserAdapter>(context);
    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Avatar.large(
                    img: NetworkImage('${userAdapter.user?.profilePicture}')),
                SizedBox(
                  width: 15,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${userAdapter.user?.firstName}',
                      style: TextStyle(
                        color: KprimaryColor,
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    ProfileData(
                      icon: Icons.calendar_view_month,
                      text: '${userAdapter.user?.DOB}',
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    ProfileData(
                      icon: Icons.location_on,
                      text: '${userAdapter.user?.address}',
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {
                _showBottomModal(context);
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Row(
                  children: [
                    Icon(
                      Icons.edit,
                      color: KprimaryColor,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text('Edit Your Profile'),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'User Account Information',
              style: TextStyle(
                  color: KprimaryColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            UserDetails(
                userDetail: 'FirstName',
                userDetail2: userAdapter.user!.firstName),
            SizedBox(
              height: 15,
            ),
            UserDetails(
                userDetail: 'LastName',
                userDetail2: userAdapter.user!.lastName),
            SizedBox(
              height: 15,
            ),
            UserDetails(
                userDetail: 'OtherName',
                userDetail2: userAdapter.user!.otherName),
            SizedBox(
              height: 15,
            ),
            UserDetails(
                userDetail: 'Address', userDetail2: userAdapter.user!.address!),
            SizedBox(
              height: 15,
            ),
            UserDetails(
                userDetail: 'PhoneNumber',
                userDetail2: userAdapter.user!.phoneNumber),
            SizedBox(
              height: 15,
            ),
            UserDetails(
                userDetail: 'Occupation',
                userDetail2: userAdapter.user!.occupation),
            SizedBox(
              height: 15,
            ),
            UserDetails(
                userDetail: 'email', userDetail2: userAdapter.user!.email),
            SizedBox(
              height: 15,
            ),
            UserDetails(
                userDetail: 'Date Of Birth',
                userDetail2: userAdapter.user!.DOB.trim()),
            SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    ));
  }
}

class UserDetails extends StatelessWidget {
  const UserDetails({
    super.key,
    required this.userDetail,
    required this.userDetail2,
  });

  final String userDetail;
  final String userDetail2;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [Text(userDetail), Text(userDetail2)],
      ),
    );
  }
}

class ProfileData extends StatelessWidget {
  const ProfileData({
    Key? key,
    required this.icon,
    required this.text,
  }) : super(key: key);

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: KprimaryColor,
          size: 15,
        ),
        SizedBox(
          width: 5,
        ),
        Text(
          text,
          style: TextStyle(
            color: KprimaryColor,
            fontSize: 15,
          ),
        ),
      ],
    );
  }
}

class BuildTextField extends StatelessWidget {
  final String labelText;
  final String placeHolder;
  final bool? isPassword;
  const BuildTextField({
    Key? key,
    required this.labelText,
    required this.placeHolder,
    this.isPassword,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        label: Text(labelText),
        hintText: placeHolder,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(5),
          ),
        ),
      ),
    );
  }
}
