class Commande {
  final int id;
  final int idRecette;
  final int idIngredient;
  final String quantity;
  const Commande(
      {required this.id,
      required this.idIngredient,
      required this.idRecette,
      required this.quantity});
  factory Commande.fromJson(Map<String, dynamic> json) {
    return Commande(
      id: json["id"],
      idRecette: json["idRecette"],
      idIngredient: json["idIngredient"],
      quantity: json["quantity"],
    );
  }
}
