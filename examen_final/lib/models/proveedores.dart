import 'dart:convert';

class Proveedor {
  Proveedor({
    required this.proveedorList,
  });

  List<ProveedorItem> proveedorList;

  factory Proveedor.fromJson(String str) => Proveedor.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Proveedor.fromMap(Map<String, dynamic> json) => Proveedor(
        proveedorList: List<ProveedorItem>.from(
            json["Proveedores Listado"].map((x) => ProveedorItem.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "Proveedores Listado":
            List<dynamic>.from(proveedorList.map((x) => x.toMap())),
      };
}

class ProveedorItem {
  ProveedorItem({
    required this.providerId,
    required this.providerName,
    required this.providerLastName,
    required this.providerMail,
    required this.providerState,
  });
  int providerId;
  String providerName;
  String providerLastName;
  String providerMail;
  String providerState;

  factory ProveedorItem.fromJson(String str) =>
      ProveedorItem.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ProveedorItem.fromMap(Map<String, dynamic> json) => ProveedorItem(
        providerId: json["providerid"],
        providerName: json["provider_name"],
        providerLastName: json["provider_last_name"],
        providerMail: json["provider_mail"],
        providerState: json["provider_state"],
      );

  Map<String, dynamic> toMap() => {
        "providerid": providerId,
        "provider_name": providerName,
        "provider_last_name": providerLastName,
        "provider_mail": providerMail,
        "provider_state": providerState,
      };
  ProveedorItem copy() => ProveedorItem(
        providerId: providerId,
        providerName: providerName,
        providerLastName: providerLastName,
        providerMail: providerMail,
        providerState: providerState,
      );
}
