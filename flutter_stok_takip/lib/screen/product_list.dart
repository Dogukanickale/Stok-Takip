import 'package:flutter/material.dart';
import 'package:flutter_stok_takip/models/product.dart';
import 'package:flutter_stok_takip/screen/Add_product.dart';
import 'package:flutter_stok_takip/utils/dbhelper.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ProductList extends StatefulWidget {
  const ProductList({Key? key}) : super(key: key);

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  final DatabaseHelper _databaseHelper = DatabaseHelper();
  List<Product> allProducts = [];

  void getProduct() async {
    var productFuture = _databaseHelper.getAllProduct();
    await productFuture.then((data) {
      setState(() {
        allProducts = data;
      });
    });
  }

  @override
  void initState() {
    getProduct();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("ÜRÜN LİSTESİ")),
      body: (allProducts != null) && (allProducts.length > 0)
          ? buildListView()
          : buildNoItem(),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AddProduct()))
                .then((value) {
              getProduct();
            });
          }),
    );
  }

  Widget buildListView() {
    return ListView.builder(
        itemCount: allProducts.length,
        itemBuilder: (context, index) {
          return Slidable(
            actionPane: const SlidableDrawerActionPane(),
            actions: <Widget>[
              IconSlideAction(
                caption: 'Delete',
                color: Colors.red,
                icon: Icons.delete,
                onTap: () {
                  _productSlidableDelete(allProducts[index].id!);
                  setState(() {
                    
                  });
                },
              )
            ],
            child: Card(
              //color: Colors.orange.shade100,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: ListTile(
                title: Row(
                  children: [
                    const Text("ÜRÜN ADI : "),
                    Text(allProducts[index].name ?? ''),
                  ],
                ),
                subtitle: Row(
                  children: [
                    const Text("STOK ADEDİ : "),
                    Text('${allProducts[index].stok}'),
                  ],
                ),
                trailing: Column(mainAxisSize: MainAxisSize.min, children: [
                  GestureDetector(
                    onTap: () {
                      _deleteProduct(allProducts[index]);
                    },
                    child: const Icon(Icons.remove),
                  ),
                  GestureDetector(
                    onTap: () {
                      _addProduct(allProducts[index]);
                    },
                    child: const Icon(Icons.add),
                  )
                ]),
              ),
            ),
          );
        });
  }

  void _deleteProduct(Product model) async {
    await _databaseHelper.productIncrementStatus(model, false);
    setState(() {
      getProduct();
    });
  }

  void _addProduct(Product model) async {
    await _databaseHelper.productIncrementStatus(model, true);
    setState(() {
      getProduct();
    });
  }

  void _productSlidableDelete(int id) async {
    await _databaseHelper.delete(id);
    setState(() {
      getProduct();
    });
  }

  buildNoItem() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: const [
        Center(
            child: Text(
          "HENÜZ ÜRÜN YOK",
          style: TextStyle(fontSize: 18),
        )),
      ],
    );
  }
}
