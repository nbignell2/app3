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
              return DrinksCard(
                drinkType: e,
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
