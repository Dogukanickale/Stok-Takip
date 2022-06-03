import 'package:flutter/material.dart';
import 'package:flutter_stok_takip/screen/product_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "STOK TAKİP",
      theme: ThemeData(
        primaryColor: Colors.amber.shade900,
      



        
      ),
      home:const ProductList(),
      debugShowCheckedModeBanner: false,
      
    );
  }
}

  