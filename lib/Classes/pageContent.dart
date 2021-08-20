import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_instagram/Views/takePicture.dart';

import '../Views/favorites.dart';
import '../Views/homepage.dart';
import '../Views/profile.dart';
import '../Views/userSearch.dart';

class  PageContent with ChangeNotifier {
  int _currentIndex = 0;
  final List<Widget> _pageContent = [
    HomepageContent(),
    UserSearch(),
    TakePicture(),
    Favorites(),
    Profile(),
  ];

  int get currentIndex => _currentIndex;
  List<Widget> get pageContent => _pageContent;

  set currentIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }
}
