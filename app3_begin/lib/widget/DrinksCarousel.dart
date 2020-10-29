import 'package:coffee_store_app/widget/DrinksCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:scoped_model/scoped_model.dart';

import 'DrinksList.dart';

class DrinksCarousel extends StatefulWidget {
  @override
  DrinksCarouselState createState() => DrinksCarouselState();
}

class DrinksCarouselState extends State<DrinksCarousel>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: coffeeTypes.length, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  void _changeImage({int delta}) {
    var newTabIndex = _tabController.index + delta;
    if (newTabIndex >= coffeeTypes.length) {
      newTabIndex = 0;
    } else if (newTabIndex < 0) {
      newTabIndex = coffeeTypes.length - 1;
    }
    _tabController.animateTo(newTabIndex);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250.0,
      width: double.infinity,
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border.all(
            width: 4.0,
            color: Colors.black,
          ),
        ),
        child: Stack(
          children: <Widget>[
            ScopedModelDescendant<DrinkModel>(
              rebuildOnChange: false,
              builder: (context, child, drinkModel) {
                return TabBarView(
                  controller: _tabController,
                  children: mainTypes.map((drinkType) {
                    return GestureDetector(
                      onTap: () {
                        var type;
                        switch (drinkType.title) {
                          case 'Coffee':
                            type = coffeeTypes;
                            break;
                          case 'Tea':
                            type = teaTypes;
                            break;
                          case 'Juice':
                            type = juiceTypes;
                            break;
                          case 'Smoothie':
                            type = smoothieTypes;
                            break;
                          default:
                            throw '${drinkType.title} type not recognized';
                        }
                        drinkModel.chosenDrink = type;
                      },
                      child: DrinksCard(
                        drinkType: drinkType,
                      ),
                    );
                  }).toList(),
                );
              },
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TabPageSelector(
                  controller: _tabController,
                  color: Colors.white,
                  indicatorSize: 20.0,
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                  size: 36.0,
                ),
                onPressed: () {
                  _changeImage(delta: -1);
                },
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                icon: Icon(
                  Icons.arrow_forward,
                  color: Colors.white,
                  size: 36.0,
                ),
                onPressed: () {
                  _changeImage(delta: 1);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
