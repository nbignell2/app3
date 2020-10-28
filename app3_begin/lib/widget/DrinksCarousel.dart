import 'package:coffee_store_app/widget/DrinksCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class DrinksCarouselState extends State<DrinksCarousel>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  Timer _carouselTimer;
}

class DrinksCarousel extends StatelessWidget {
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
        child: DrinksCard(
          drinkType: mainTypes[0],
        ),
      ),
    );
  }

  @override
  _DrinksCarouselState createState() => _DrinksCarouselState();
}
