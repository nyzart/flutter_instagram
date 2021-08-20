import 'package:flutter/foundation.dart';

class UserData with ChangeNotifier {
  dynamic _name = 'Romain Floriani';
  dynamic _bio =
      "Salut a tous les amis c'est David Lafarge Pokemon opening adaiofa aofafna angagiapagn oagnaogangoa agoaonga";
  dynamic _username = 'Nyzart';
  dynamic _publicationsNumber = 4;
  dynamic _likedPostedPicturesNumber = 0;
  dynamic _likedPicturesNumber = 0;

  String get name => _name;
  String get username => _username;
  String get bio => _bio;
  int get publicationsNumber => _publicationsNumber;
  int get likedPostedPicturesNumber => _likedPostedPicturesNumber;
  int get likedPicturesNumber => _likedPicturesNumber;

  set name(String name) {
    _name = name;
    notifyListeners();
  }

  set username(String username) {
    _username = username;
    notifyListeners();
  }

  set bio(String bio) {
    _bio = bio;
    notifyListeners();
  }

  set publicationsNumber(int publicationsNumber) {
    _publicationsNumber = publicationsNumber;
    notifyListeners();
  }

  set likedPostedPicturesNumber(int number) {
    _likedPostedPicturesNumber = number;
    notifyListeners();
  }

  set likedPicturesNumber(int number) {
    _likedPicturesNumber = number;
    notifyListeners();
  }
}
