import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
            TextFormField(
                decoration: InputDecoration(labelText: 'Nota'),
                onEditingComplete: _validateRate,
                controller: _rateController,
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(
                      (RegExp('r^[.0-5][.][0-9]{2}')))
                ]),
            TextField(
              controller: _averageCostController,
              decoration: InputDecoration(labelText: 'Custo medio'),
              keyboardType: TextInputType.number,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('Selecione o pais'),
                SizedBox(
                  width: 20,
                ),
                DropdownButton(
                    value: countrySelected,
                    items: DUMMY_COUNTRIES
                        .map((country) => buildMenuItem(country.title))
                        .toList(),
                    onChanged: (value) => setState(() {
                          countrySelected = value.toString();
                        })),
              ],
            ),
          ],
        )),
      ),
    );
  }
}
