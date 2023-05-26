class Drink {
  final int id;
  final String name;
  final String description;
  final double price;
  final String imageLink;
  final String category;
  Drink(
      {required this.id,
      required this.name,
      required this.description,
      required this.imageLink,
      required this.price,
      required this.category});
  factory Drink.fromJson(Map<String, dynamic> json) {
    return Drink(
        id: json["idRecette"],
        name: json["name"],
        description: json["description"],
        imageLink: json["imageLink"],
        price: json["price"],
        category: json["category"]);
  }
}
