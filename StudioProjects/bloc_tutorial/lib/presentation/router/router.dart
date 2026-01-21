import 'package:bloc_tutorial/presentation/screens/home_screen.dart';
import 'package:bloc_tutorial/presentation/screens/settings_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../screens/third_screen.dart';

class AppRoute{
  Route onGeneratedRoute(RouteSettings route){
    switch(route.name){
      case HomeScreen.kHomeScreen:
        return MaterialPageRoute(builder: (_) => HomeScreen(title: 'Home', backgroundColor: Colors.blueAccent),);
      case SettingsScreen.kSettingsScreen:
        return MaterialPageRoute(builder: (_) => SettingsScreen(title: 'Settings', backgroundColor: Colors.blueAccent),);
      case ThirdScreen.kThirdScreen:
        return MaterialPageRoute(builder: (_) => ThirdScreen(title: 'Third', backgroundColor: Colors.blueAccent),);
      default:
        return MaterialPageRoute(builder: (_) => Center());
    }
  }
}