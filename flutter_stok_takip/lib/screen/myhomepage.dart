// import 'package:flutter/material.dart';

// import 'package:flutter_stok_takip/utils/dbhelper.dart';
// import 'package:path/path.dart';

// import '../models/product.dart';

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({Key? key}) : super(key: key);

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   final DatabaseHelper _databaseHelper = DatabaseHelper();
//   List<Product> allProducts = [];
//   bool aktiflik = false;
//   final _formKey = GlobalKey<FormState>();
//   final _controllerName = TextEditingController();
//   final _controllerStok = TextEditingController();
//   int? clickedId;

//   void getProduct() async {
//     var notesFuture = _databaseHelper.getAllNotes();
//     await notesFuture.then((data) {
//       setState(() {
//         allProducts = data;
//       });
//     });
//   }

//   @override
//   void initState() {
//     super.initState();
//     getProduct();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(title: const Text("ÜRÜNLER")),
//         body: Column(children: <Widget>[
//           Form(
//               key: _formKey,
//               child: Column(
//                 children: <Widget>[
//                   buildForm(_controllerName, "ÜRÜN ADI GİRİNİZ"),
//                   buildForm(_controllerStok, "STOK ADETİ GİRİNİZ"),
//                 ],
//               )),
//           Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: <Widget>[
//                 buildButton("Kaydet", saveObject),
//               ]),
//           if (allProducts != null && allProducts.length > 0) ...[
//             Expanded(child: ProductListe()),
//           ],
//         ]));
//   }

//   ListView ProductListe() {
//     return ListView.builder(
//         itemCount: allProducts.length,
//         itemBuilder: (context, index) {
//           return Card(
//             child: ListTile(
//               onTap: () {
//                 setState(() {
//                   _controllerName.text = allProducts[index].name.toString();
//                   _controllerStok.text = allProducts[index].stok.toString();
//                   clickedId = allProducts[index].id;
//                 });
//               },
//               title: Text(allProducts[index].name.toString()),
//               subtitle: Text(allProducts[index].stok.toString()),
//               trailing: Row(children: [
//                 GestureDetector(
//                   onTap: () {
//                     _deleteProduct(allProducts[index].id, index);
//                   },
//                   child: Icon(Icons.delete),
//                 ),
//                 GestureDetector(
//                   onTap: () {},
//                   child: Icon(Icons.add),
//                 )
//               ]),
//             ),
//           );
//         });
//   }

//   void _deleteProduct(int? id, int index) async {
//     await _databaseHelper.delete(id!);
//     setState(() {
//       getProduct();
//     });
//   }

//   void saveObject() {
//     if (_formKey.currentState!.validate()) {
//       _AddNote(Product(_controllerName.text, _controllerStok.text));
//     }
//   }

//   void _AddNote(Product product) async {
//     await _databaseHelper.insert(product);
//     setState(() {
//       getProduct();
//       _controllerName.text = "";
//       _controllerStok.text = "";
//     });
//   }

//   Widget buildForm(TextEditingController txtController, String str) {
//     return Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: TextFormField(
//             autofocus: false,
//             controller: txtController,
//             decoration: InputDecoration(
//                 labelText: str, border: const OutlineInputBorder())));
//   }

//   Widget buildButton(String str, Function eventFunc) {
//     return TextButton(
//       child: Text(str),
//       onPressed: () {
//         debugPrint(_controllerName.text + 'ürün adı');
//         debugPrint(_controllerStok.text + 'stok adı');

//         // eventFunc();
//       },
//     );
//   }
// }
