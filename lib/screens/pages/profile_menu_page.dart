// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:com_policing_incident_app/screens/onboard_screen/onboard.dart';
import 'package:com_policing_incident_app/widgets/avatar.dart';
import 'package:com_policing_incident_app/widgets/profile_tab.dart';
import 'package:flutter/material.dart';

class ProfileMenuPage extends StatefulWidget {
  const ProfileMenuPage({super.key});

  @override
  State<ProfileMenuPage> createState() => _ProfileMenuPageState();
}

class _ProfileMenuPageState extends State<ProfileMenuPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: Column(
            children: [
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Avatar.large(
                      img: NetworkImage(
                          'https://www.shutterstock.com/image-photo/close-face-young-stylish-woman-600w-1671900778.jpg'),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                'Abubakar Nuuman Adam',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 30,
              ),
              ProfileTab(
                icon: Icons.person,
                onPressed: () {
                  Navigator.pushNamed(context, '/user');
                },
                text: 'User Profile',
                navIcon: Icons.arrow_forward_ios_sharp,
              ),
              SizedBox(
                height: 30,
              ),
              ProfileTab(
                icon: Icons.notifications_active,
                onPressed: () {
                  Navigator.pushNamed(context, routes.notifications);
                },
                text: 'Notifications',
                navIcon: Icons.arrow_forward_ios_sharp,
              ),
              SizedBox(
                height: 30,
              ),
              ProfileTab(
                icon: Icons.emergency,
                onPressed: () {
                  Navigator.pushNamed(context, routes.emergency_request);
                },
                text: 'Emergency  ',
                navIcon: Icons.arrow_forward_ios_sharp,
              ),
              SizedBox(
                height: 30,
              ),
              ProfileTab(
                icon: Icons.info,
                onPressed: () {
                  Navigator.pushNamed(context, routes.more_about);
                },
                text: 'More About',
                navIcon: Icons.arrow_forward_ios_sharp,
              ),
              SizedBox(
                height: 30,
              ),
              ProfileTab(
                icon: Icons.settings,
                onPressed: () {
                  Navigator.pushNamed(context, routes.settings);
                },
                text: 'Settings    ',
                navIcon: Icons.arrow_forward_ios_sharp,
              ),
              SizedBox(
                height: 30,
              ),
              ProfileTab(
                icon: Icons.support_agent,
                onPressed: () {
                  Navigator.pushNamed(context, routes.help_desk);
                },
                text: 'Help Desk ',
                navIcon: Icons.arrow_forward_ios_sharp,
              ),
              SizedBox(
                height: 30,
              ),
              ProfileTab(
                icon: Icons.logout,
                onPressed: () {
                  print('Clicked');
                },
                text: 'Sign Out   ',
                navIcon: Icons.arrow_forward_ios_sharp,
              ),
              SizedBox(
                height: 20,
              )
            ],
          ),
        ),
      ),
    );
  }
}
