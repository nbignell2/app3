import 'package:coffee_store_app/model/DrinkType.dart';
import 'package:coffee_store_app/widget/DrinksCard.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class DrinkModel extends Model {
  List<DrinkType> _drinkType = coffeeTypes;

  List<DrinkType> get drinkType => _drinkType;

  set chosenDrink(List<DrinkType> type) {
    _drinkType = type;
    notifyListeners();
  }
}

class DrinksList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<DrinkModel>(
      builder: (context, child, drinkModel) {
        return Expanded(
          //GridView children must be a list of widgets.
          child: GridView.count(
            crossAxisCount: 2,
            padding: EdgeInsets.all(6.0),
            //coffeeTypes is a list of DrinkType objects.
            //DrinkType is a class with properties, title, image file name, price.
            //We transform the coffeTypes list into a new
            //list of DrinksCards using each of coffeTypes DrinkType
            //object data.
            //We use the List.map().toList()
            //method calls from the List class to do this.
            children: drinkModel.drinkType.map((e) {
              return GestureDetector(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext dialogContext) {
                        return AlertDialog(
                          title: Text(
                            'Order',
                          ),
                          content: DecoratedBox(
                            decoration: BoxDecoration(
                              color: Colors.lime,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Image.asset(
                                  e.image,
                                  height: 100.0,
                                  width: 100.0,
                                  fit: BoxFit.cover,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        e.title,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        'Price: \$${e.price}',
                                        key: Key('${e.title}_order'),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          actions: <Widget>[
                            FlatButton(
                              child: Text(
                                'Cancel',
                                style: TextStyle(
                                  fontSize: 18.0,
                                ),
                              ),
                              onPressed: () {
                                Navigator.pop(dialogContext);
                              },
                            ),
                            FlatButton(
                              child: Text(
                                'Send Order',
                                style: TextStyle(
                                  fontSize: 18.0,
                                ),
                              ),
                              onPressed: () {
                                Navigator.pop(dialogContext);
                                final snackBar = SnackBar(
                                  backgroundColor: Colors.white,
                                  duration: Duration(
                                    seconds: 2,
                                  ),
                                  content: Text(
                                    '${e.title} order confirmed',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18.0,
                                    ),
                                  ),
                                );
                                Scaffold.of(context).showSnackBar(snackBar);
                              },
                            ),
                          ],
                        );
                      });
                },
                child: DrinksCard(
                  drinkType: e,
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
