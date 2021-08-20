import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Classes/pageContent.dart';

class NavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var pageContent = Provider.of<PageContent>(context);

    void onClick(int index) {
      pageContent.currentIndex = index;
    }

    return BottomNavigationBar(
      fixedColor: Colors.white,
      onTap: onClick,
      currentIndex: pageContent.currentIndex,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: 'Search',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.camera),
          label: 'Photo',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite),
          label: 'Favorites',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
    );
  }
}
