import 'package:flutter/material.dart';
import 'package:tv/base/basenavigator.dart';

class BaseViewModel<nav extends BaseNavigator> extends ChangeNotifier{
  nav? navigator=null;
}