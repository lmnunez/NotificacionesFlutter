import 'package:flutter/material.dart';
import 'package:pushflutter/src/providers/PushProvider.dart';
import 'package:pushflutter/src/pages/HomePage.dart';
import 'package:pushflutter/src/pages/MensajePage.dart';

 
void main() => runApp(MyApp());
 
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final provider = PushProvider();
    provider.initNotifications();
    provider.messages.listen((String data){
      print("Argumento push: " + data);
     navigatorKey.currentState.pushNamed("mensaje", arguments: data);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      title: 'Notifications',
      initialRoute: "home",
      routes: {
        "home": (BuildContext context) => HomePage(),
        "mensaje": (BuildContext context) => MensajePage(),
      },
    );
  }
}