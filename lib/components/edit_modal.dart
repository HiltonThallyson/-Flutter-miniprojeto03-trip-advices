import 'package:f3_lugares/models/place.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../data/my_data.dart';
import 'recommendation_modal.dart';

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
  String rate = '';
  String avgCost = '';
  String imageUrl = '';
  bool isRateValid = true;
  bool isAvgCostValid = true;
  bool isTitleValid = true;
  bool isPlaceAdded = true;
  bool isUrlEmpty = false;
  List<String> recommendations = [];

  late FocusNode titleNode;
  late FocusNode avgCostNode;
  late FocusNode rateNode;
  late FocusNode imgUrlNode;

  @override
  void initState() {
    title = widget.place.titulo;
    rate = widget.place.avaliacao.toString();
    id = widget.place.id;
    countries = widget.place.paises;
    recommendations = widget.place.recomendacoes;
    imageUrl = widget.place.imagemUrl;
    avgCost = widget.place.custoMedio.toString();
    _titleController.text = title;
    _rateController.text = rate.toString();
    _imgUrlController.text = imageUrl;
    _avgCostController.text = avgCost.toString();
    titleNode = FocusNode();
    avgCostNode = FocusNode();
    rateNode = FocusNode();
    imgUrlNode = FocusNode();
    oldPlace = widget.place;
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    super.initState();
  }

  void _submitUpdate() {
    if (countries.isEmpty) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return Dialog(
              child: Container(
                height: 150,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text('Selecione pelo menos 1 país'),
                    ElevatedButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: Text('Ok')),
                  ],
                ),
              ),
              elevation: 4,
            );
          });
      return;
    }
    if (recommendations.isEmpty) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return Dialog(
              child: Container(
                height: 150,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text('Cadastre pelo menos 1 recomendação'),
                    ElevatedButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: Text('Ok')),
                  ],
                ),
              ),
              elevation: 4,
            );
          });
      return;
    }
    if (!isTitleValid) {
      FocusScope.of(context).requestFocus(titleNode);
      return;
    } else if (!isRateValid) {
      FocusScope.of(context).requestFocus(rateNode);
      return;
    } else if (!isAvgCostValid) {
      FocusScope.of(context).requestFocus(avgCostNode);
      return;
    } else if (isUrlEmpty) {
      FocusScope.of(context).requestFocus(imgUrlNode);
      return;
    } else {
      final newPlace = Place(
          id: oldPlace.id,
          paises: countries,
          titulo: title,
          imagemUrl: imageUrl,
          recomendacoes: recommendations,
          avaliacao: double.parse(rate),
          custoMedio: double.parse(avgCost));
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
  }

  String? get _titleErrorText {
    if (_titleController.text == '') {
      return 'Insira um valor';
    }
    return null;
  }

  String? get _rateErrorText {
    double? rateDouble = double.tryParse(_rateController.text);
    if (_rateController.text.isEmpty) {
      return 'Insira um valor';
    }
    if (rateDouble != null) {
      if (rateDouble < 0 || rateDouble > 5) {
        return 'Valor inválido';
      }
    }
    return null;
  }

  String? get _avgCostErrorText {
    double? avgCostDouble = double.tryParse(_avgCostController.text);
    if (_avgCostController.text.isEmpty) {
      return 'Insira um valor';
    }
    if (avgCostDouble != null) {
      if (avgCostDouble < 0) {
        return 'Valor inválido';
      }
    }
    return null;
  }

  String? get _imgErrorText {
    if (_imgUrlController.text.isEmpty) {
      return 'Insira uma url da imagem';
    }
    return null;
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

  void _validateRate() {
    setState(() {
      rate = _rateController.text;
      if (_rateErrorText == null) {
        isRateValid = true;
      } else {
        isRateValid = false;
      }
    });
  }

  void _validateCost() {
    setState(() {
      avgCost = _avgCostController.text;
      if (_avgCostErrorText == null) {
        isAvgCostValid = true;
      } else {
        isAvgCostValid = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom, left: 10),
        child: SingleChildScrollView(
          child: Form(
            child: Column(children: [
              TextField(
                controller: _titleController,
                focusNode: titleNode,
                onChanged: (_) => setState(() {
                  title = _titleController.text;
                  if (_titleErrorText == null) {
                    isTitleValid = true;
                  } else {
                    isTitleValid = false;
                  }
                }),
                decoration: InputDecoration(
                  labelText: 'Título',
                  errorText: _titleErrorText,
                ),
              ),
              TextField(
                controller: _rateController,
                focusNode: rateNode,
                onChanged: (_) => _validateRate(),
                decoration: InputDecoration(
                  labelText: 'Nota',
                  errorText: _rateErrorText,
                  hintText: 'Insira uma nota entre 0 e 5. Ex.: 3.5',
                ),
              ),
              TextField(
                controller: _avgCostController,
                focusNode: avgCostNode,
                onChanged: (_) => _validateCost(),
                decoration: InputDecoration(
                  labelText: 'Custo',
                  errorText: _avgCostErrorText,
                  hintText: 'Insira um valor em reais',
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Selecione o país'),
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
                    TextField(
                        enableInteractiveSelection: true,
                        controller: _imgUrlController,
                        focusNode: imgUrlNode,
                        decoration: InputDecoration(
                            labelText: 'Link da imagem',
                            errorText: _imgErrorText),
                        onChanged: (_) => setState(() {
                              if (_imgErrorText == null) {
                                isUrlEmpty = false;
                                imageUrl = _imgUrlController.text;
                              } else {
                                isUrlEmpty = true;
                              }
                            })),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(child: Text('Recomendações')),
                        TextButton(
                            onPressed: () {
                              showModalBottomSheet(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return RecommendationModal(recommendations);
                                  });
                            },
                            child: Text('Gerenciar recomendação'))
                      ],
                    ),
                    ElevatedButton(
                        onPressed: () => _submitUpdate(),
                        child: Text('Atualizar'))
                  ],
                ),
              ),
            ]),
          ),
        ));
  }
}
