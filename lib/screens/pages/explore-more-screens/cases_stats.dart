// ignore_for_file: prefer_const_constructors

import 'package:com_policing_incident_app/utilities/global_variables.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class CasesStats extends StatefulWidget {
  const CasesStats({super.key});

  @override
  State<CasesStats> createState() => _CasesStatsState();
}

class _CasesStatsState extends State<CasesStats> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: PieChart(
              PieChartData(sections: [
                PieChartSectionData(
                  color: KprimaryColor,
                  value: 40,
                  title: 'Crime Status',
                  radius: 80,
                  titleStyle: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xffffffff),
                  ),
                ),
                PieChartSectionData(
                  color: Colors.green,
                  value: 30,
                  title: '30%',
                  radius: 80,
                  titleStyle: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xffffffff),
                  ),
                ),
                PieChartSectionData(
                  color: Colors.orange,
                  value: 20,
                  title: '20%',
                  radius: 80,
                  titleStyle: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xffffffff),
                  ),
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
