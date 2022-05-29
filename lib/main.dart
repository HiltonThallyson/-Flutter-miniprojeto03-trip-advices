import 'package:f3_lugares/models/favorites.dart';
import 'package:f3_lugares/screens/edit_places.dart';
import 'package:f3_lugares/screens/place_form.dart';
import 'package:flutter/material.dart';

import 'package:f3_lugares/screens/countries_places_screen.dart';
import 'package:f3_lugares/screens/place_detail_screen.dart';
import 'package:f3_lugares/screens/settings_screen.dart';
import 'package:f3_lugares/screens/tabs_screen.dart';
import 'package:f3_lugares/utils/app_routes.dart';
import 'package:provider/provider.dart';

void main() => runApp(ChangeNotifierProvider<Favorites>(
    create: (context) => Favorites(), child: MyApp()));

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PlacesToGo',
      theme: ThemeData(
          colorScheme: ThemeData().colorScheme.copyWith(
              primary: Colors.purple,
              secondary: Colors.amber,
              tertiary: Colors.grey),
          //primarySwatch: Colors.purple,
          //accentColor: Colors.amber,
          fontFamily: 'Raleway',
          canvasColor: Color.fromRGBO(255, 254, 229, 1),
          textTheme: ThemeData.light().textTheme.copyWith(
                  headline6: TextStyle(
                fontSize: 20,
                fontFamily: 'RobotoCondensed',
              ))),
      initialRoute: '/',
      routes: {
        AppRoutes.HOME: (ctx) => TabsScreen(),
        AppRoutes.COUNTRY_PLACES: (ctx) => CountryPlacesScreen(),
        AppRoutes.PLACES_DETAIL: (ctx) => PlaceDetailScreen(),
        AppRoutes.SETTINGS: (ctx) => SettingsScreen(),
        AppRoutes.NEW_PLACE: (ctx) => PlaceForm(),
        AppRoutes.EDIT_PLACE: (ctx) => EditPlaces(),
      },
    );
  }
}
