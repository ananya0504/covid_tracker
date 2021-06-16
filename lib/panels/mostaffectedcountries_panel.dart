import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class MostAffectedPanel extends StatelessWidget {
  final List countryData;
  const MostAffectedPanel({Key key, this.countryData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        children: [
          Container(
            child: ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        //alignment: Alignment.centerLeft,
                        width: MediaQuery.of(context).size.width/6,
                        child: Text(
                          countryData[index]['country'],
                          style: TextStyle(fontSize:14,fontWeight: FontWeight.bold),
                        ),
                      ),
                      //  SizedBox(
                      //   width: 10,
                      // ),
                      Container(
                        alignment: Alignment.centerLeft,
                        width: 2*MediaQuery.of(context).size.width/6,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Total Cases: ',
                              style:
                                  TextStyle(color: Colors.red, fontSize:14, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              countryData[index]['cases'].toString(),
                              style:
                                  TextStyle(color: Colors.red, fontSize:14, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      // SizedBox(
                      //   width: 10,
                      // ),
                      Container(
                        alignment: Alignment.centerLeft,
                        width: 2*MediaQuery.of(context).size.width/6,
                        child: Text(
                          'Deaths: ' + countryData[index]['deaths'].toString(),
                          style:
                              TextStyle(color: Colors.grey[700], fontSize:14, fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                );
              },
              itemCount: 5,
            ),
          ),
          Container(
            decoration: BoxDecoration(border: Border.all()),
            margin: EdgeInsets.only(top:10),
            padding: EdgeInsets.all(10),
            width: 5*MediaQuery.of(context).size.width/6,
            child: PieChart(
              dataMap: {
              '${countryData[0]['country']}': countryData[0]['deaths'].toDouble(),
              '${countryData[1]['country']}': countryData[1]['deaths'].toDouble(),
              '${countryData[2]['country']}': countryData[2]['deaths'].toDouble(),
              '${countryData[3]['country']}': countryData[3]['deaths'].toDouble(),
              '${countryData[4]['country']}': countryData[4]['deaths'].toDouble()
              },
              colorList: [Colors.red, Colors.orange[400], Colors.green, Colors.blue[900], Colors.yellow[200]],
            ),
          )
        ],
      ),
    );
  }
}