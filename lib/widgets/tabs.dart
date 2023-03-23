import "package:flutter/material.dart";
import '../bussiness/drink.dart';
import '../widgets/card.dart';

class Tabs extends StatefulWidget {
  final List<Drink> drinks;
  final List<String> categories = ["coffee", "milk", "tea"];
  Tabs({super.key, required this.drinks});

  @override
  State<Tabs> createState() => _TabsState();
}

class _TabsState extends State<Tabs> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Column(children: [
        const TabBar(
          splashBorderRadius: BorderRadius.all(Radius.circular(20)),
          labelColor: Colors.amber,
          labelStyle: TextStyle(fontSize: 23),
          unselectedLabelColor: Colors.black,
          indicator: BoxDecoration(),
          tabs: [
            Tab(text: "Coffee"),
            Tab(text: "Milk"),
            Tab(text: "Tea"),
          ],
        ),
        Expanded(
          child: Container(
            color: Colors.white,
            child: TabBarView(
                physics: const NeverScrollableScrollPhysics(),
                children: widget.categories
                    .map(
                      (cat) => Container(
                        padding: const EdgeInsets.all(16.0),
                        child: ListView.separated(
                          itemCount: widget.drinks
                              .where((it) => it.category == cat)
                              .toList()
                              .length,
                          itemBuilder: (BuildContext context, int index) {
                            Drink drink = widget.drinks
                                .where((it) => it.category == cat)
                                .toList()[index];
                            return DrinkCard(
                                name: drink.name,
                                imageLink: drink.imageLink,
                                description: drink.description,
                                price: drink.price.toString());
                          },
                          separatorBuilder: (BuildContext context, int index) =>
                              const SizedBox(
                            height: 16,
                          ),
                        ),
                      ),
                    )
                    .toList()),
          ),
        )
      ]),
    );
  }
}
