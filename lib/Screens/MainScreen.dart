import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../main.dart';


class mainScreen  extends StatelessWidget {
  static const Color backgroundTextColor = Color(0xffeff8f8);
  static const Color callToAction = Color(0xffffd642);
  static const Color buttonColor = Color(0xfffebf00);
  final List<charts.Series<SalesData, String>> data = [
    charts.Series<SalesData, String>(
      id: 'Sales',
      data: [
        SalesData('Jan', 25000),
        SalesData('Feb', 30000),
        SalesData('Mar', 40000),
        SalesData('Apr', 20000),
        SalesData('May', 35000),
        SalesData('Jun', 50000),
      ],
      domainFn: (SalesData sales, _) => sales.month,
      measureFn: (SalesData sales, _) => sales.sales,
      colorFn: (_, __) => charts.ColorUtil.fromDartColor(callToAction),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(icon: const Icon(Icons.arrow_back),onPressed: (){
          Get.off(const MyHomePage());

        },),
        title: Text('Admin Dashboard'),
        backgroundColor: callToAction,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Sales',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16.0),
              Container(
                height: 200.0,
                child: charts.BarChart(
                  data,
                  animate: true,
                  domainAxis: const charts.OrdinalAxisSpec(
                    renderSpec: charts.SmallTickRendererSpec(
                      labelStyle: charts.TextStyleSpec(
                        fontSize: 14,
                        color: charts.MaterialPalette.black,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 32.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  SalesCard(
                    label: 'Today',
                    sales: 15000,
                  ),
                  SalesCard(
                    label: 'This Week',
                    sales: 75000,
                  ),
                  SalesCard(
                    label: 'This Month',
                    sales: 250000,
                  ),
                ],
              ),
              SizedBox(height: 32.0),
              Text(
                'Users',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16.0),
              Container(
                height: 200.0,
                child: Placeholder(),
              ),
              SizedBox(height: 32.0),
              Text(
                'Orders',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16.0),
              Container(
                height: 200.0,
                child: Placeholder(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SalesData {
  final String month;
  final int sales;

  SalesData(this.month, this.sales);
}
class SalesCard extends StatelessWidget {
  final String label;
  final int sales;

  const SalesCard({required this.label, required this.sales});

  static const Color backgroundTextColor = Color(0xffeff8f8);
  static const Color callToAction = Color(0xffffd642);
  static const Color buttonColor = Color(0xfffebf00);
@override
Widget build(BuildContext context) {
  return Card(
    color: backgroundTextColor,
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            '${sales.toString()}',
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              color: callToAction,
            ),
          ),
        ],
      ),
    ),
  );
}
}