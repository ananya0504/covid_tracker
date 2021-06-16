import 'dart:convert';
import 'package:Covid_Tracker/pages/countrypage.dart';
import 'package:Covid_Tracker/panels/info_panel.dart';
import 'package:Covid_Tracker/panels/mostaffectedcountries_panel.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
import './panels/worldwide_panel.dart';
import 'package:flutter/material.dart';
import './datasource.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Map worldData;
  fetchWorldWideData() async {
    http.Response response =
        await http.get('https://corona.lmao.ninja/v3/covid-19/all');
    setState(() {
      worldData = json.decode(response.body);
    });
  }

  List countryData;
  fetchCountryData() async {
    http.Response response = await http
        .get('https://corona.lmao.ninja/v3/covid-19/countries?sort=deaths');
    setState(() {
      countryData = json.decode(response.body);
    });
    // countryData.sort((right, left) {
    //   return left['deaths'].compareTo(right['deaths']);
    // });
  }

  Future fetchData() async {
    fetchWorldWideData();
    fetchCountryData();
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
              icon: Icon(Theme.of(context).brightness == Brightness.light
                  ? Icons.lightbulb_outline
                  : Icons.highlight),
              onPressed: () {
                DynamicTheme.of(context).setBrightness(
                    Theme.of(context).brightness == Brightness.light
                        ? Brightness.dark
                        : Brightness.light);
              })
        ],
        title: Text("COVID-19 TRACKER"),
      ),
      body: RefreshIndicator(
        onRefresh: fetchData,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 100,
                alignment: Alignment.center,
                padding: EdgeInsets.all(20),
                color: Colors.orange[100],
                child: Text(
                  DataSource.quote,
                  style: TextStyle(
                      color: Colors.orange[800],
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left:20.0, right: 20, top:20, bottom:10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Worldwide',
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CountryPage()));
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: primaryBlack,
                            borderRadius: BorderRadius.circular(10)),
                        child: Text(
                          'Regional',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              worldData == null
                ? Container(
                  alignment: Alignment.center,
                  child: CircularProgressIndicator())
                : WorldwidePanel(
                  worldData: worldData,
              ),
              Divider(),
              Padding(
                padding: const EdgeInsets.only(left:20.0, right: 20, top:10, bottom:10),
                child: Text(
                  'Most Affected',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ),
              countryData == null
                ? Container(
                  alignment: Alignment.center,
                  child: CircularProgressIndicator())
                : MostAffectedPanel(
                  countryData: countryData,
              ),
              Divider(),
              Padding(
                padding: EdgeInsets.only(left:20.0, right: 20, top:10, bottom:10),
                child: Text(
                  'More Information',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ),
              InfoPanel(),
              SizedBox(height: 50),
              Center(
                  child: Text(
                "WE ARE TOGETHER IN THIS FIGHT!",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              )),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
