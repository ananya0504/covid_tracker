import 'package:dynamic_theme/dynamic_theme.dart';
import './datasource.dart';
import './homepage.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(
    MyApp() // so that we have the context with us to change the themes
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DynamicTheme(
      data: (brightness){ //this method will be called whenever we want to change the mode of the app
        return ThemeData(
          primaryColor: primaryBlack,
          fontFamily: 'Circular',
          brightness: brightness==Brightness.light?Brightness.light:Brightness.dark,
          scaffoldBackgroundColor: brightness==Brightness.dark?Colors.blueGrey[900]:Colors.white,
        );
      },
      themedWidgetBuilder: (context,theme){
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: theme,
          // theme: ThemeData(
          //   fontFamily: 'Circular',
          //   primaryColor: primaryBlack,
          //   //brightness: Brightness.dark,
          // ),
          home: HomePage(),
        );
      },
         
    );
  }
}