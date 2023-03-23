import "package:flutter/material.dart";
import 'package:innovit_2cs_project_apptablette/helpers/extentions.dart';
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
    return Padding(
      padding: Paddings.paddingTop16,
      child: DefaultTabController(
        length: 3,
        child: Column(children: [
          TabBar(
              splashBorderRadius: Borders.borderRadius20,
              labelColor: CustomColors.expressoColor,
              labelStyle: Fonts.bold24,
              unselectedLabelStyle: Fonts.medium24,
              unselectedLabelColor: Colors.black,
              indicator: const BoxDecoration(),
              tabs: widget.categories
                  .map((cat) => Tab(text: cat.toTitleCase()))
                  .toList()),
          Expanded(
            child: Container(
              color: Colors.white,
              child: TabBarView(
                  physics: const NeverScrollableScrollPhysics(),
                  children: widget.categories
                      .map(
                        (cat) => Container(
                          padding: Paddings.padding16,
                          child: ListView.separated(
                              itemCount: widget.drinks
                                  .where((it) => it.category == cat)
                                  .toList()
                                  .length,
                              itemBuilder: (BuildContext context, int index) {
                                Drink drink = widget.drinks
                                    .where((it) => it.category == cat)
                                    .toList()[index];
                                return DrinkCard(drink: drink);
                              },
                              separatorBuilder:
                                  (BuildContext context, int index) =>
                                      Gaps.gapV16),
                        ),
                      )
                      .toList()),
            ),
          )
        ]),
      ),
    );
  }
}
