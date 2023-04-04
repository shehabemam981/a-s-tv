import 'package:flutter/material.dart';
import 'package:tv/shared/styles/constants.dart';

class themes{
  static ThemeData darktheme=ThemeData(
    scaffoldBackgroundColor:blackcolor,
    bottomNavigationBarTheme:BottomNavigationBarThemeData(
      unselectedItemColor:graycolor ,
      selectedItemColor: selectedcolor,
      elevation: 1.0,
      type: BottomNavigationBarType.fixed,
      showSelectedLabels:true,
      unselectedLabelStyle: TextStyle(color: graycolor),
      backgroundColor: blackcolor,
    ),
  );
}