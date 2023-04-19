import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';
import 'package:travelappui/constants/colors.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({Key key}) : super(key: key);

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  List<_SalesData> _chartData;

  @override
  void initState() {
    _chartData = getChartData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ThemeData appTheme = Theme.of(context);
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                Color.fromRGBO(63, 63, 156, 1),
                Color.fromRGBO(99, 70, 170, 1),
              ])),
              width: double.infinity,
              height: size.height * 0.4,
            ),
            SafeArea(
              child: Container(
                margin: EdgeInsets.only(top: 30.0),
                width: double.infinity,
                child: Icon(
                  Icons.admin_panel_settings,
                  color: Colors.white,
                  size: 100.0,
                ),
              ),
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 220,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    width: double.infinity,
                    //height: 500,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 15,
                            offset: Offset(0, 5),
                          )
                        ]),
                    child: Column(
                      children: [
                        SizedBox(height: 20,),
                        Text("Top 5 paises con mas paquetes", style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 18,
                        ),),
                        SfCircularChart(
                          series: <CircularSeries<_SalesData, String>>[
                            PieSeries<_SalesData, String>(
                              dataSource: _chartData,
                              xValueMapper: (_SalesData data, _) =>
                                  data.salesPerson,
                              yValueMapper: (_SalesData data, _) => data.sales,
                              explode: true,
                              explodeIndex: 0,
                              explodeOffset: '10%',
                              dataLabelMapper: (_SalesData data, _) =>
                                  '${data.salesPerson}: ${data.sales}',
                              dataLabelSettings:
                                  DataLabelSettings(isVisible: true),
                            )
                          ],
                        ),
                        SizedBox(height: 30,),
                        //ElevatedButton(onPressed: null, child: Text("Pollo"),)
                        MaterialButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                            disabledColor: Colors.grey,
                            color: Colors.deepPurple.shade700,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 40, vertical:15 
                              ),
                              child: Text("Agregar un paquete",style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                            ),
                          onPressed: () {},
                          ),
                          
                        SizedBox(height: 30,),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  List<_SalesData> getChartData() {
    final List<_SalesData> chartData = [
      _SalesData('Alemania', 3),
      _SalesData('Brasil', 5),
      _SalesData('Chile', 4),
      _SalesData('Estados Unidos', 3),
      _SalesData('Francia', 3),
    ];
    return chartData;
  }
}

class _SalesData {
  _SalesData(this.salesPerson, this.sales);
  final String salesPerson;
  final int sales;
}


// SfCircularChart(
//           series: <CircularSeries<_SalesData, String>>[
//             PieSeries<_SalesData, String>(
//               dataSource: _chartData,
//               xValueMapper: (_SalesData data, _) => data.salesPerson,
//               yValueMapper: (_SalesData data, _) => data.sales,
//               explode: true,
//               explodeIndex: 0,
//               explodeOffset: '10%',
//               dataLabelMapper: (_SalesData data, _) => '${data.salesPerson}: ${data.sales}',
//               dataLabelSettings: DataLabelSettings(isVisible: true),
//             )
//           ],
//         ),






// backgroundColor: kAccentColor,
//       body: ListView(
//         children: [
//           Container(
//             height: size.height * 0.40,
//             width: size.width * 0.50,
//             decoration: BoxDecoration(
//                 color: kPrimaryColor,
                
//                 borderRadius: BorderRadius.only(
//                     bottomLeft: Radius.circular(20),
//                     bottomRight: Radius.circular(20))),
//             child: ClipRRect(
//               borderRadius: BorderRadius.only(
//                   bottomLeft: Radius.circular(36),
//                   bottomRight: Radius.circular(36)),
//               child: SfCircularChart(
//            series: <CircularSeries<_SalesData, String>>[
//              PieSeries<_SalesData, String>(
//                dataSource: _chartData,
//                xValueMapper: (_SalesData data, _) => data.salesPerson,
//                yValueMapper: (_SalesData data, _) => data.sales,
//                explode: true,
//                explodeIndex: 0,
//                explodeOffset: '10%',
//                dataLabelMapper: (_SalesData data, _) => '${data.salesPerson}: ${data.sales}',
//                dataLabelSettings: DataLabelSettings(isVisible: true),
//              )
//            ],
//          ),
//             ),
//           ),
//         ],
//       ),