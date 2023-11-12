import 'package:com_policing_incident_app/admin/features/widgets/drawer_header_tiles.dart';
import 'package:com_policing_incident_app/screens/onboard_screen/onboard.dart';
import 'package:flutter/material.dart';

class SideMenu extends StatelessWidget {
  SideMenu({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      DrawerHeader(
        child: Image.asset('assets/images/com_5.png'),
      ),
      DrawerHeaderTiles(
        onTap: () => {},
        icon: Icons.dashboard,
        text: 'Dashboard',
      ),
      DrawerHeaderTiles(
        onTap: () => {},
        icon: Icons.emergency,
        text: 'Emergency Request',
      ),
      DrawerHeaderTiles(
        onTap: () => {},
        icon: Icons.report,
        text: 'Incident Reported',
      ),
      DrawerHeaderTiles(
        onTap: () => {},
        icon: Icons.report,
        text: 'Crime Reported',
      ),
      DrawerHeaderTiles(
        onTap: () => {Navigator.pushNamed(context, routes.addPoliceStations)},
        icon: Icons.local_police,
        text: 'Add Police Station',
      ),
      DrawerHeaderTiles(
        onTap: () => {},
        icon: Icons.local_police,
        text: 'Create a blog post',
      ),
    ]);
  }
}
