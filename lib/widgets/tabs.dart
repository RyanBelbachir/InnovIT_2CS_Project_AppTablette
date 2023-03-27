import 'dart:convert';
import "package:flutter/material.dart";
import 'package:innovit_2cs_project_apptablette/helpers/extentions.dart';
import '/bussiness/drink.dart';
import '/bussiness/category.dart';
import '/widgets/card.dart';
import '/styles/theme.dart';
import 'package:http/http.dart' as http;

Future<List<Category>> fetchCategories() async {
  final url = Uri.parse(
      'https://daf1-105-101-134-89.eu.ngrok.io/Distributeur/categories');
  final response = await http.get(url);
  // final response = await Client().send(request);
  if (response.statusCode == 200) {
    List myList = jsonDecode(response.body);
    return myList.map((e) => Category.fromJson(e)).toList();
  } else {
    throw Exception(
        'failed to load categories,error code: ${response.statusCode}');
  }
}

class Tabs extends StatefulWidget {
  final List<Drink> drinks;

  const Tabs({super.key, required this.drinks});

  @override
  State<Tabs> createState() => _TabsState();
}

class _TabsState extends State<Tabs> {
  late Future<List<Category>> categories;
  @override
  void initState() {
    super.initState();
    categories = fetchCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Paddings.paddingWrap,
      child: DefaultTabController(
          length: 3,
          child: FutureBuilder(
              future: categories,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(children: [
                    TabBar(
                        splashBorderRadius: Borders.borderRadius20,
                        labelColor: CustomColors.expressoColor,
                        labelStyle: Fonts.bold24,
                        unselectedLabelStyle: Fonts.medium24,
                        unselectedLabelColor: Colors.black,
                        indicator: const BoxDecoration(),
                        tabs: snapshot.data!
                            .map((cat) => Tab(text: cat.name.toTitleCase()))
                            .toList()),
                    Expanded(
                      child: Container(
                        color: Colors.white,
                        child: TabBarView(
                            physics: const BouncingScrollPhysics(),
                            children: snapshot.data!
                                .map(
                                  (cat) => Container(
                                    padding: const EdgeInsets.all(4),
                                    decoration: Decorations.bodyDecoration,
                                    child: ListView.separated(
                                        itemCount: widget.drinks
                                            .where(
                                                (it) => it.category == cat.name)
                                            .toList()
                                            .length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          Drink drink = widget.drinks
                                              .where((it) =>
                                                  it.category == cat.name)
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
                  ]);
                } else if (snapshot.hasError) {
                  return SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Center(
                        child: Text(
                      "${snapshot.error}",
                      style: Fonts.bold24Red,
                    )),
                  );
                  ;
                }
                return SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: const Center(
                      child: CircularProgressIndicator(
                    color: CustomColors.darkCoffeeColor,
                  )),
                );
              })),
    );
  }
}
