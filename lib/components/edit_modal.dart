import 'package:f3_lugares/models/place.dart';
import 'package:flutter/material.dart';
import '../data/my_data.dart';

class EditModal extends StatefulWidget {
  final Place place;

  EditModal(this.place);
  @override
  State<EditModal> createState() => _EditModalState();
}

class _EditModalState extends State<EditModal> {
  final _titleController = TextEditingController();
  final _rateController = TextEditingController();
  final _imgUrlController = TextEditingController();
  final _avgCostController = TextEditingController();

  late final Place oldPlace;
  List<String> countries = [];
  late String id;
  String title = '';
  late double rate;
  late double avgCost;
  String imageUrl = '';
  bool isRateValid = false;
  bool isAvgCostValid = false;
  bool isTitleValid = false;
  bool isPlaceAdded = false;
  bool isUrlEmpty = true;
  List<String> recommendations = [];

  late FocusNode titleNode;
  late FocusNode avgCostNode;
  late FocusNode rateNode;
  late FocusNode imgUrlNode;

  @override
  void initState() {
    title = widget.place.titulo;
    rate = widget.place.avaliacao;
    id = widget.place.id;
    countries = widget.place.paises;
    recommendations = widget.place.recomendacoes;
    imageUrl = widget.place.imagemUrl;
    avgCost = widget.place.custoMedio;
    _titleController.text = title;
    _rateController.text = rate.toString();
    _imgUrlController.text = imageUrl;
    _avgCostController.text = avgCost.toString();
    titleNode = FocusNode();
    avgCostNode = FocusNode();
    rateNode = FocusNode();
    imgUrlNode = FocusNode();
    super.initState();
  }

  void _submitUpdate() {
    oldPlace = widget.place;
    final newPlace = Place(
        id: oldPlace.id,
        paises: countries,
        titulo: title,
        imagemUrl: imageUrl,
        recomendacoes: recommendations,
        avaliacao: rate,
        custoMedio: rate);
    if (newPlace.titulo != oldPlace.titulo ||
        newPlace.avaliacao != oldPlace.avaliacao ||
        newPlace.custoMedio != oldPlace.custoMedio ||
        newPlace.paises != oldPlace.paises ||
        newPlace.imagemUrl != oldPlace.imagemUrl ||
        newPlace.recomendacoes != oldPlace.recomendacoes) {
      setState(() {
        DUMMY_PLACES.removeWhere((place) => place.id == id);
        DUMMY_PLACES.add(newPlace);
      });
    }
    Navigator.pop(context);
  }

  void _countriesHandler(String id) {
    setState(() {
      if (countries.contains(id)) {
        countries.remove(id);
      } else {
        countries.add(id);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom + 20),
        child: SingleChildScrollView(
          child: Form(
            child: Column(children: [
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
                  rate = double.parse(_rateController.text);
                }),
                decoration: InputDecoration(
                  labelText: 'Nota',
                ),
              ),
              TextField(
                controller: _avgCostController,
                onChanged: (_) => setState(() {
                  avgCost = double.parse(_avgCostController.text);
                }),
                decoration: InputDecoration(
                  labelText: 'Custo',
                ),
              ),
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
                  ElevatedButton(
                      onPressed: () => _submitUpdate(),
                      child: Text('Atualizar'))
                ],
              ),
            ]),
          ),
        ));
  }
}
