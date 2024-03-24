import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopingcart/screen/cart_provider.dart';
import 'package:shopingcart/screen/shopping_cart.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // return ChangeNotifierProvider(create: (_) => CartProvider(),
    // child: Builder(builder: (BuildContext context){
    //    return MaterialApp(
    //     debugShowCheckedModeBanner: false,
    //     home: ShopCart(),
    //   );
    // },),
    // );
    return ChangeNotifierProvider(create: (_) => CartProvider(),
    child: Builder(builder: (BuildContext context){
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: ShopCart(),
      );
    },),
    );

  }
}
