import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import '../data/my_data.dart';
import '../models/place.dart';

class PlaceForm extends StatefulWidget {
  @override
  State<PlaceForm> createState() => _PlaceFormState();
}

class _PlaceFormState extends State<PlaceForm> {
  List<Place> placesList = DUMMY_PLACES;
  final _titleController = TextEditingController();
  final _rateController = TextEditingController();
  final _averageCostController = TextEditingController();

  late String title;
  late String rate;
  late String avgCost;
  String countrySelected = DUMMY_COUNTRIES[0].title;

  void _validateRate() {
    if (_rateController != null) {
      setState(() {
        rate = _rateController.text;
      });
    }
    print(rate);
  }

  DropdownMenuItem<String> buildMenuItem(String item) {
    return DropdownMenuItem(
      child: Text(item),
      value: item,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        'New Place',
      )),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Form(
            child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Titulo'),
              onEditingComplete: () {
                setState(() {
                  if (_titleController.text != '')
                    title = _titleController.text;
                });
              },
            ),
            TextField(
              controller: _rateController,
              decoration: InputDecoration(labelText: 'Nota'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _averageCostController,
              decoration: InputDecoration(labelText: 'Custo medio'),
              keyboardType: TextInputType.number,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Selecione o pais'),

                // required for min/max child size

                MultiSelectChipDisplay(
                  items: DUMMY_COUNTRIES
                      .map((country) =>
                          MultiSelectItem(country.title, country.title))
                      .toList(),
                  scroll: true,
                ),
                SizedBox(
                  width: 20,
                ),
              ],
            ),
          ],
        )),
      ),
    );
  }
}
