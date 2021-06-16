import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:Covid_Tracker/datasource.dart';


class Search extends SearchDelegate{

  final List countryList;

  Search(this.countryList);


  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData(
      primaryColor: primaryBlack,
      brightness: Brightness.dark,
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
   return [
     IconButton(icon: Icon(Icons.clear), onPressed: (){
       query='';

     })
   ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(icon: Icon(Icons.arrow_back_ios),onPressed: (){
      Navigator.pop(context);
    },);
  }

  @override
  Widget buildResults(BuildContext context) {
return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context)
  {
    final suggestionList =  query.isEmpty? countryList
      : countryList.where((element) => element['country'].toString().toLowerCase().startsWith(query)).toList();

   return ListView.builder(
       itemCount: suggestionList.length,
       itemBuilder: (context,index){
     return Card(
       child: Container(
         height: 100,
         margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
         child: Row(
           children: <Widget>[
            Container(
               width: 150,
               //margin: EdgeInsets.symmetric(horizontal: 10),
               child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: <Widget>[
                   Text(
                     suggestionList[index]['country'],
                     style: TextStyle(fontWeight: FontWeight.bold),
                   ),
                   Image.network(
                     suggestionList[index]['countryInfo']['flag'],
                     height: 60,
                     width: 80,
                   ),
                 ],
               ),
            ),
             Expanded(
                 child: Container(
                   child: Column(
                     crossAxisAlignment: CrossAxisAlignment.center,
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      'CONFIRMED: ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.red),
                                    ),
                                    Text(
                                      suggestionList[index]['cases'].toString(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.red),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      'ACTIVE: ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.blue),
                                    ),
                                    Text(
                                      suggestionList[index]['active'].toString(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.blue),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      'RECOVERED: ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.green),
                                    ),
                                    Text(
                                      suggestionList[index]['recovered'].toString(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.green),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      'DEATHS: ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Theme.of(context).brightness==Brightness.dark?Colors.grey[100]:Colors.grey[900]),
                                    ),
                                    Text(
                                      suggestionList[index]['deaths'].toString(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Theme.of(context).brightness==Brightness.dark?Colors.grey[100]:Colors.grey[900]),
                                    ),
                                  ],
                                ),
                              ],
                   ),
                 ))
           ],
         ),
       ),
     );
   });
  }

}