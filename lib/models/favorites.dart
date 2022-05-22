import 'dart:collection';

import 'package:flutter/cupertino.dart';

import './place.dart';

class Favorites with ChangeNotifier {
  List<Place> _favoritePlaces = [];

  UnmodifiableListView<Place> get favorites =>
      UnmodifiableListView(_favoritePlaces);

  favoritePlacesHandler(Place place) {
    if (!_favoritePlaces.contains(place)) {
      _favoritePlaces.add(place);
    } else {
      _favoritePlaces.remove(place);
    }
    notifyListeners();
  }
}
