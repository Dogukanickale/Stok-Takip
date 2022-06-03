//ignore: file_names
import 'package:flutter/material.dart';
import 'package:flutter_stok_takip/models/product.dart';
import 'package:flutter_stok_takip/utils/dbhelper.dart';

class AddProduct extends StatefulWidget {
  AddProduct({Key? key}) : super(key: key);

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  final _formKey = GlobalKey<FormState>();
  final _controllerName = TextEditingController();
  final _controllerStok = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: const Text("ÜRÜNLER")),
      body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Image.network(
                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTZZZOASBtbeD4B88Lenfe7C8-VfyymuPagvaW3O_Hnx3Mt0KyUncMb3Q7D3BNt7ZFZKtI&usqp=CAU",
                  width: 300,
                  height: 200,
                ),
                const SizedBox(
                  height: 20,
                ),
                buildTextformfield(_controllerName, "ÜRÜN ADI"),
                buildTextformfield(_controllerStok, "STOK ADETİ"),
                buildButton(
                  str: "LİSTEYE EKLE",
                  onPressed: () {
                    if (_controllerName == null || _controllerStok == null) {
                      AlertDialog(
                        title: const Text("UYARI !!"),
                        content: const Text("Ürün Adı veya Stok Adeti Giriniz."),
                        actions: <Widget>[
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text("Tamam"))
                        ],
                      );
                    } else {
                      debugPrint(_controllerName.text + 'ürün adı');
                      debugPrint(_controllerStok.text + 'stok adı');
                      Product model = Product(
                          _controllerName.text, int.parse(_controllerStok.text));
                      addProduct(model);
                    }
                  },
                )
              ],
            ),
          )),
    );
  }

  Widget buildTextformfield(TextEditingController txtController, String str) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextFormField(
            autofocus: false,
            controller: txtController,
            decoration: InputDecoration(
                labelText: str, border: const OutlineInputBorder())));
  }

  Widget buildButton({required String str, Function()? onPressed}) {
    return TextButton(
      child: Text(str),
      onPressed: onPressed,
    );
  }

  void addProduct(Product product) async {
    await _databaseHelper.insert(product);
    setState(() {
      _controllerName.text = "";
      _controllerStok.text = "";
    });
    Navigator.pop(context);
  }
}
