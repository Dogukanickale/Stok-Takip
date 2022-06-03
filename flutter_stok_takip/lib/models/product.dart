import 'package:flutter_stok_takip/utils/dbhelper.dart';

class Product {
  int? id;
  String? name;
  int? stok;
  Product( this.name, this.stok);
  Product.withID(this.id, this.name, this.stok);

  Product.fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.name = map['name'];
    this.stok = map['stok'];
  }


  Map<String, dynamic> toMap() {
     var map = Map<String, dynamic>();
     map["id"] =id;
     map["name"] =name;
     map["stok"] = stok;
     return map;
    }
  }

