import 'package:flutter/material.dart';

class RecommendationModal extends StatefulWidget {
  List<String> recommendations;

  RecommendationModal(this.recommendations);
  @override
  State<RecommendationModal> createState() => _RecommendationModalState();
}

class _RecommendationModalState extends State<RecommendationModal> {
  final _recommendationController = TextEditingController();

  String recommendation = '';
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      height: MediaQuery.of(context).size.height * 0.45,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextField(
            controller: _recommendationController,
            decoration: InputDecoration(labelText: 'Recomendacao'),
          ),
          Container(
              height: 200,
              child: widget.recommendations.isEmpty
                  ? null
                  : ListView.builder(
                      itemCount: widget.recommendations.length,
                      itemBuilder: (context, index) {
                        return Card(
                          elevation: 4,
                          margin: EdgeInsets.all(10),
                          child: ListTile(
                              title: Text(widget.recommendations[index]),
                              trailing: IconButton(
                                onPressed: () {
                                  setState(() {
                                    widget.recommendations.removeAt(index);
                                  });
                                },
                                icon: Icon(Icons.delete),
                              )),
                        );
                      })),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              ElevatedButton(
                  onPressed: () {
                    setState(() {
                      widget.recommendations
                          .add(_recommendationController.text);
                    });
                  },
                  child: Text('Adicionar mais recomendacoes')),
              ElevatedButton(
                  onPressed: () {
                    if (_recommendationController.text.isNotEmpty) {
                      setState(() {
                        widget.recommendations
                            .add(_recommendationController.text);
                      });
                    }
                    Navigator.of(context).pop();
                  },
                  child: Text('Confirmar')),
            ],
          )
        ],
      ),
    );
  }
}
