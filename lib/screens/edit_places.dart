import 'package:f3_lugares/components/place_item.dart';
import 'package:f3_lugares/data/my_data.dart';
import 'package:f3_lugares/utils/app_routes.dart';
import 'package:flutter/material.dart';

import '../models/place.dart';

class EditPlaces extends StatefulWidget {
  @override
  State<EditPlaces> createState() => _EditPlacesState();
}

class _EditPlacesState extends State<EditPlaces> {
  final _titleController = TextEditingController();
  final _rateController = TextEditingController();

  late String title;
  late double rate;
  late String id;
  bool isUpdated = false;
  //late double avgCost;

  void _submitUpdate(Place oldPlace) {
    final newPlace = Place(
        id: oldPlace.id,
        paises: oldPlace.paises,
        titulo: title,
        imagemUrl: oldPlace.imagemUrl,
        recomendacoes: oldPlace.recomendacoes,
        avaliacao: rate,
        custoMedio: oldPlace.avaliacao);
    setState(() {
      if (isUpdated) {
        DUMMY_PLACES.removeWhere((place) => place.id == id);
        DUMMY_PLACES.add(newPlace);
      }
    });
    Navigator.pop(context);
  }

  void _editPlace(Place place) {
    title = place.titulo;
    rate = place.avaliacao;
    id = place.id;

    setState(() {
      _titleController.text = title;
      _rateController.text = rate.toString();
    });

    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: MediaQuery.of(context).size.height / 2,
            child: SingleChildScrollView(
              child: Form(
                child: Column(
                  children: [
                    TextField(
                      controller: _titleController,
                      onChanged: (_) => setState(() {
                        title = _titleController.text;
                      }),
                      decoration: InputDecoration(
                        labelText: 'Titulo',
                      ),
                    ),
                    TextField(
                      controller: _rateController,
                      onChanged: (_) => setState(() {
                        if (_rateController.text == place.avaliacao) {
                          isUpdated = false;
                        } else {
                          rate = double.parse(_rateController.text);
                          isUpdated = true;
                        }
                      }),
                      decoration: InputDecoration(
                        labelText: 'Titulo',
                      ),
                    ),
                    ElevatedButton(
                        onPressed: () => _submitUpdate(place),
                        child: Text('Atualizar'))
                  ],
                ),
              ),
            ),
          );
        });
  }

  void _deletePlace(String id) {
    setState(() {
      DUMMY_PLACES.removeWhere((place) => place.id == id);
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
                    child: Text(
                      DUMMY_PLACES[index].titulo,
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
