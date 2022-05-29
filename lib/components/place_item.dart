import 'package:f3_lugares/models/place.dart';
import 'package:f3_lugares/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/favorites.dart';

class PlaceItem extends StatelessWidget {
  final Place place;

  const PlaceItem(this.place);

  void _selectPlace(BuildContext context) {
    Navigator.of(context)
        .pushNamed(
          AppRoutes.PLACES_DETAIL,
          arguments:
              place, //passar um map com chave valor para passar mais de um argumento
        )
        .then((value) => {
              if (value == null) {} else {print(value)}
            });
  }

  @override
  Widget build(BuildContext context) {
    var favoritesList = context.watch<Favorites>();

    return InkWell(
      onTap: () => _selectPlace(context),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 4,
        margin: const EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            Stack(children: <Widget>[
              ClipRRect(
                //bordas na imagem
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
                child: Image.network(
                  place.imagemUrl,
                  errorBuilder: ((context, error, stackTrace) => Row(
                        children: [
                          Container(
                            padding: EdgeInsets.only(
                              left: 65,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.error,
                                  size: 250,
                                ),
                                Text(
                                  'Imagem não encontrada!',
                                  style: TextStyle(fontSize: 27),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )),
                  height: 250,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                //só funciona no contexto do Stack - posso posicionar o elemento
                right: 10,
                bottom: 20,
                child: Container(
                  width: 300,
                  color: Colors.black54,
                  padding: EdgeInsets.symmetric(
                    vertical: 5,
                    horizontal: 20,
                  ),
                  child: Text(
                    place.titulo,
                    style: TextStyle(fontSize: 26, color: Colors.white),
                    softWrap: true, //quebra de lina
                    overflow: TextOverflow.fade, //case de overflow
                  ),
                ),
              )
            ]),
            //Text(place.titulo),
            Padding(
              padding: EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  IconButton(
                      onPressed: () {
                        favoritesList.favoritePlacesHandler(place);
                      },
                      icon: favoritesList.favorites.contains(place)
                          ? Icon(Icons.favorite)
                          : Icon(Icons.favorite_border)),
                  Row(
                    children: <Widget>[
                      Icon(Icons.star),
                      SizedBox(
                        width: 6,
                      ),
                      Text('${place.avaliacao}/5')
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Icon(Icons.attach_money),
                      SizedBox(
                        width: 6,
                      ),
                      Text('custo: R\$${place.custoMedio}')
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
