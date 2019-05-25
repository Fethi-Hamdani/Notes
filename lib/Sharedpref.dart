import 'package:flutter/material.dart';
import 'package:notes/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesTest{

  final String ky1 = "DarkTheme";
  final String ky2 = "Darkprimary";
  final String ky3 = "Darksecondry";
  final String ky4 = "Lightprimary";
  final String ky5 = "LightSecondry";

  final String ky6 = "notetxtsize";
  final String ky7 = "notetxtthikness";

  final String ky8 = "titlesize";
  final String ky9 = "titlethikness";

  final String ky10 = 'notecolor';




  Future<bool> getDarkThemeStatu() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getBool(ky1) ?? false;
  }

  Future<bool> setDarkThemeStatu(bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setBool(ky1, value);
  }


/*


  Future<String> getDarkThemePrimary() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString(ky2) ?? Colors.blue[900].toString();
  }

  void setDarkThemePrimary(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

     prefs.setString(ky2, value);
  }





  Future<String> getDarkThemeSecondry() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString(ky3) ?? Colors.white.toString();
  }

  void setDarkThemeSecondry(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

     prefs.setString(ky3, value);
  }





  Future<String> getLightThemePrimary() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString(ky4) ?? Colors.blue[300].toString();
  }

  void setLightThemePrimary(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

     prefs.setString(ky4, value);
  }

*/

/*

  Future<String> getLightThemeSecondry() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString(ky5) ?? Colors.black54.toString();
  }

  void setLightThemeSecondry(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString(ky5, value);
  }

*/


  Future<double> getNoteSize() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getDouble(ky6) ?? 16;
  }

  Future<bool> setNoteSize(double value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

     return prefs.setDouble(ky6, value);
  }


  Future<double> getNoteThikness() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getDouble(ky7) ?? 2;
  }

  Future<bool> setNoteThikness(double value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setDouble(ky7, value);
  }





  Future<double> getTitleSize() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getDouble(ky8) ?? 17;
  }

  Future<bool> setTitleSize(double value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

     return prefs.setDouble(ky8, value);
  }



  Future<double> getTitleThikness() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getDouble(ky9) ?? 3;
  }

  Future<bool> setTitleThikness(double value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

   return prefs.setDouble(ky9, value);
  }




  Future<String> getDefaultNoteColor() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString(ky10) ?? Colors.white.toString();
  }

  Future<bool> setDefaultNoteColor(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

   return prefs.setString(ky10, value);
  }

}

/*     prim = await SharedPreferencesTest().getDarkThemePrimary(); new Color(int.parse(prim.split('(0x')[1].split(')')[0], radix: 16));*/


