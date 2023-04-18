import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';




class ChartsPage extends StatefulWidget {
  const ChartsPage({Key key}) : super(key: key);

  @override
  State<ChartsPage> createState() => _ChartsPageState();
}

class _ChartsPageState extends State<ChartsPage> {
  List<_SalesData> _chartData;

  @override
  void initState() {
    _chartData = getChartData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Graficas",
        style: TextStyle(color: Colors.black),
        ),
      ),
      body:Center(
        child: SfCircularChart(
          series: <CircularSeries<_SalesData, String>>[
            PieSeries<_SalesData, String>(
              dataSource: _chartData,
              xValueMapper: (_SalesData data, _) => data.salesPerson,
              yValueMapper: (_SalesData data, _) => data.sales,
              explode: true,
              explodeIndex: 0,
              explodeOffset: '10%',
              dataLabelMapper: (_SalesData data, _) => '${data.salesPerson}: ${data.sales}',
              dataLabelSettings: DataLabelSettings(isVisible: true),
            )
          ],
        ),
      ),
    );
  } 
  List<_SalesData> getChartData() {
    final List<_SalesData> chartData = [
      _SalesData('John', 100),
      _SalesData('Jake', 200),
      _SalesData('Peter', 75),
      _SalesData('James', 50),
      _SalesData('Mary', 125),
      _SalesData('David', 250),
    ];
    return chartData;
  }
}



 


class _SalesData {
  _SalesData(this.salesPerson, this.sales);
  final String salesPerson;
  final int sales;
}