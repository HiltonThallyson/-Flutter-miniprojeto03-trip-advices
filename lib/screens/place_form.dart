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
  final _titleController = TextEditingController();
  final _rateController = TextEditingController();
  final _averageCostController = TextEditingController();
  final _imgURLController = TextEditingController();

  List<String> countries = [];
  String title = '';
  String rate = '';
  String avgCost = '';
  String imageURL = '';

  void _validateForm() {
    print(title);
    print(rate);
    print(avgCost);
  }

  void _validateTitle() {
    print('why?');
    if (_titleController.text != '') {
      setState(() {
        title = _titleController.text;
      });
    }
  }

  void _validateRate() {
    if (_rateController.text != '') {
      setState(() {
        rate = _rateController.text;
      });
    }
  }

  void _validateCost() {
    if (_averageCostController.text != '') {
      setState(() {
        avgCost = _averageCostController.text;
      });
    }
  }

  void _countriesHandler(String id) {
    if (countries.contains(id)) {
      setState(() {
        countries.remove(id);
      });
    } else {
      setState(() {
        countries.add(id);
      });
    }
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
        padding: EdgeInsets.all(25),
        child: SingleChildScrollView(
          child: Form(
              child: Column(
            children: [
              TextField(
                controller: _titleController,
                decoration: InputDecoration(labelText: 'Titulo'),
                onChanged: (_) => _validateTitle,
                onSubmitted: (value) => _validateTitle,
              ),
              TextField(
                controller: _rateController,
                decoration: InputDecoration(labelText: 'Nota'),
                keyboardType: TextInputType.number,
                onChanged: (_) => _validateRate(),
                onSubmitted: (_) => _validateRate(),
              ),
              TextField(
                controller: _averageCostController,
                decoration: InputDecoration(labelText: 'Custo medio'),
                keyboardType: TextInputType.number,
                onChanged: (_) => _validateCost(),
                onSubmitted: (_) => _validateCost(),
              ),
              SizedBox(
                height: 20,
              ),
              Divider(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Selecione o pais'),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    child: Wrap(
                        spacing: 5,
                        runSpacing: 5,
                        children: DUMMY_COUNTRIES
                            .map(
                              (country) => FilterChip(
                                label: Text(country.title),
                                onSelected: (_) =>
                                    _countriesHandler(country.id),
                                backgroundColor:
                                    Theme.of(context).colorScheme.tertiary,
                                selectedColor:
                                    Theme.of(context).colorScheme.primary,
                                selected: countries.contains(country.id),
                              ),
                            )
                            .toList()),
                  ),
                  Divider(),
                  SizedBox(
                    width: 20,
                  ),
                  TextField(
                      controller: _imgURLController,
                      decoration: InputDecoration(labelText: 'Link da imagem'),
                      onEditingComplete: () => setState(() {
                            imageURL = _imgURLController.text;
                          })),
                ],
              ),
            ],
          )),
        ),
      ),
      floatingActionButton: ElevatedButton(
        child: Text('Confirmar'),
        onPressed: _validateForm,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
