import 'package:flutter/cupertino.dart';

class MainProvider extends ChangeNotifier {
  int _pageIndex = 0;
  int get pageIndex => _pageIndex;
  set setPageIndex(int value) {
    _pageIndex = value;
    notifyListeners();
  }
}
