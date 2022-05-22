import 'package:f3_lugares/components/place_item.dart';
import 'package:flutter/material.dart';

import '../models/place.dart';
import '../models/favorites.dart';
import 'package:provider/provider.dart';

class FavoritosScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<Place> favoritesList =
        context.select<Favorites, List<Place>>((place) => place.favorites);
    return ListView.builder(
        itemCount: favoritesList.length,
        itemBuilder: (BuildContext ctx, int i) {
          return PlaceItem(favoritesList[i]);
        });
  }
}
