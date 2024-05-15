import 'dart:convert';

class Categoria {
  Categoria({
    required this.categoriaList,
  });

  List<CategoriaItem> categoriaList;

  factory Categoria.fromJson(String str) => Categoria.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Categoria.fromMap(Map<String, dynamic> json) => Categoria(
        categoriaList: List<CategoriaItem>.from(
            json["CategoriaList"].map((x) => CategoriaItem.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "CategoriaList":
            List<dynamic>.from(categoriaList.map((x) => x.toMap())),
      };
}

class CategoriaItem {
  CategoriaItem({
    required this.categoryId,
    required this.categoryName,
    required this.categoryState,
  });

  int categoryId;
  String categoryName;
  String categoryState;

  factory CategoriaItem.fromJson(String str) =>
      CategoriaItem.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CategoriaItem.fromMap(Map<String, dynamic> json) => CategoriaItem(
        categoryId: json["category_id"],
        categoryName: json["category_name"],
        categoryState: json["category_state"],
      );

  Map<String, dynamic> toMap() => {
        "category_id": categoryId,
        "category_name": categoryName,
        "category_state": categoryState,
      };

  CategoriaItem copy() => CategoriaItem(
        categoryId: categoryId,
        categoryName: categoryName,
        categoryState: categoryState,
      );
}
