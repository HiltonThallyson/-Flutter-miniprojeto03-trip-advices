import 'package:f3_lugares/components/edit_modal.dart';
import 'package:f3_lugares/components/place_item.dart';
import 'package:f3_lugares/data/my_data.dart';
import 'package:f3_lugares/models/country.dart';
import 'package:f3_lugares/utils/app_routes.dart';
import 'package:flutter/material.dart';

import '../models/place.dart';

class EditPlaces extends StatefulWidget {
  @override
  State<EditPlaces> createState() => _EditPlacesState();
}

class _EditPlacesState extends State<EditPlaces> {
  void _editPlace(Place place) {
    Future isUpdated = showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return EditModal(place);
        }).then((_) => setState(
          () {},
        ));
  }

  void _deletePlace(String id) {
    setState(() {
      DUMMY_PLACES.removeWhere((place) => place.id == id);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Lugar removido com sucesso!'),
        duration: Duration(seconds: 2),
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('Place Managment'),
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () =>
                  Navigator.popAndPushNamed(context, AppRoutes.HOME),
            )),
        body: Container(
          child: ListView.builder(
            itemCount: DUMMY_PLACES.length,
            itemBuilder: ((context, index) {
              return Card(
                elevation: 5,
                child: ListTile(
                  title: Padding(
                    padding: const EdgeInsets.all(15),
                    child: InkWell(
                      onTap: () => Navigator.of(context).pushNamed(
                          AppRoutes.PLACES_DETAIL,
                          arguments: DUMMY_PLACES[index]),
                      child: Text(
                        DUMMY_PLACES[index].titulo,
                      ),
                    ),
                  ),
                  trailing: Container(
                    width: 200,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                              onPressed: () => _editPlace(
                                  DUMMY_PLACES.firstWhere((place) =>
                                      place.id == DUMMY_PLACES[index].id)),
                              icon: Icon(Icons.edit)),
                          IconButton(
                              onPressed: () => _deletePlace(DUMMY_PLACES
                                  .firstWhere((place) =>
                                      place.id == DUMMY_PLACES[index].id)
                                  .id),
                              icon: Icon(Icons.delete))
                        ]),
                  ),
                ),
              );
            }),
          ),
        ));
  }
}
