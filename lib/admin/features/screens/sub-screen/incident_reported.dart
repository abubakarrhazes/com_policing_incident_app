import 'package:com_policing_incident_app/admin/features/screens/sub-screen/admin_detail_page.dart';
import 'package:com_policing_incident_app/models/get-models/crime_report.dart';
import 'package:com_policing_incident_app/providers/admin-providers/admin_provider.dart';
import 'package:com_policing_incident_app/utilities/global_variables.dart';
import 'package:flutter/material.dart';

class IncidentReported extends StatefulWidget {
  const IncidentReported({super.key});

  @override
  State<IncidentReported> createState() => _IncidentReportedState();
}

final AdminProvider adminProvider = AdminProvider();

class _IncidentReportedState extends State<IncidentReported> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder<CrimeReport>(
          future: adminProvider.adminGetAllReportedIncident(),
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
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AdminDetailPage(
                                    crimeData: snapshot.data!.data![index]),
                              ),
                            );
                          },
                          title: Text(
                            'Category: ${snapshot.data!.data![index].category} ',
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          ),
                          subtitle: Text(
                            'Reference Number: ${snapshot.data!.data![index].ref}',
                            style: TextStyle(color: Colors.white, fontSize: 15),
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
    );
  }
}
