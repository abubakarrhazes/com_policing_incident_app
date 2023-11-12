// ignore_for_file: public_member_api_docs, sort_constructors_first, avoid_unnecessary_containers
// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:com_policing_incident_app/providers/persistance_data/user_adapter.dart';
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
  @override
  Widget build(BuildContext context) {
    final userAdapter = Provider.of<UserAdapter>(context);
    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                Avatar.large(img: NetworkImage('')),
                SizedBox(
                  width: 15,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${userAdapter.user}',
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
                      text: '27 Years ',
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    ProfileData(
                      icon: Icons.location_on,
                      text: 'Sokoto , Nigeria',
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
                print('Clicked');
              },
              child: Container(
                child: Row(
                  children: [
                    Icon(
                      Icons.edit,
                      color: KprimaryColor,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text('Edit Your Profile')
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            BuildTextField(
              labelText: 'FirstName',
              placeHolder: 'Abubakar Nuuman Adam',
            ),
            SizedBox(
              height: 20,
            ),
            BuildTextField(
              labelText: 'FirstName',
              placeHolder: 'Abubakar Nuuman Adam',
            ),
            SizedBox(
              height: 20,
            ),
            BuildTextField(
              labelText: 'FirstName',
              placeHolder: 'Abubakar Nuuman Adam',
            ),
            SizedBox(
              height: 20,
            ),
            BuildTextField(
              labelText: 'FirstName',
              placeHolder: 'Abubakar Nuuman Adam',
            )
          ],
        ),
      ),
    ));
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
