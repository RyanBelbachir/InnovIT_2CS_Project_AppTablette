import "package:flutter/material.dart";
import '../bussiness/drink.dart';
import '../widgets/card.dart';
import '../styles/theme.dart';

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
        TabBar(
            splashBorderRadius: Borders.borderRadius,
            labelColor: CustomColors.expressoColor,
            labelStyle: const TextStyle(fontSize: 24),
            unselectedLabelColor: Colors.black,
            indicator: const BoxDecoration(),
            tabs: widget.categories.map((cat) => Tab(text: cat)).toList()),
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
