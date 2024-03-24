import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:shopingcart/Database/db_helper.dart';
import 'package:shopingcart/Model/cart_model.dart';
import 'package:shopingcart/screen/cart_provider.dart';
import 'package:shopingcart/screen/cart_screen.dart';

class ShopCart extends StatefulWidget {
  const ShopCart({super.key});

  @override
  State<ShopCart> createState() => _ShopCartState();
}

DBHelper? dbHelper = DBHelper();

class _ShopCartState extends State<ShopCart> {
  List<String> productName = [
    'Mango',
    'Orange',
    'Banana',
    'Cherry',
    'Grapes',
    'Guava'
  ];
  List<String> productUnit = ['kg', 'dozen', 'dozen', 'kg', 'kg', 'kg'];
  List<int> productPrice = [10, 20, 30, 10, 40, 70];
  List<String> productImage = [
    'https://pngimg.com/uploads/mango/small/mango_PNG9180.png',
    'https://pngimg.com/uploads/orange/small/orange_PNG810.png',
    'https://pngimg.com/uploads/banana/small/banana_PNG104271.png',
    'https://pngimg.com/uploads/cherry/small/cherry_PNG3091.png',
    'https://pngimg.com/uploads/grape/small/grape_PNG2996.png',
    'https://pngimg.com/uploads/guava/small/guava_PNG50.png'
  ];

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyanAccent,
        shadowColor: Colors.cyan,
        elevation: 10,
        title: Text('Shopping Cart'),
        centerTitle: true,
        actions: [
          InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => CartScreen()));
            },
            child: Badge(
              label: Container(
                child: Consumer<CartProvider>(
                  builder: (context, value , child){
                    return Text(value.getCounter().toString());
                  },
                )
              ),
              child: Icon(Icons.shopping_bag_outlined),
            ),
          ),
          SizedBox(
            width: 20,
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
                itemCount: productName.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Container(
                                height: 100,
                                width: 100,
                                child: Image(
                                    image: NetworkImage(
                                        productImage[index].toString())),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      productName[index].toString(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Text(
                                      productUnit[index].toString() +
                                          ' ' +
                                          r'$' +
                                          productPrice[index].toString(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: InkWell(
                                        onTap: () {
                                          dbHelper?.insert(
                                            Cart(
                                              id: index,
                                              productId: index.toString(),
                                              productName: productName[index].toString(),
                                              initialPrice: productPrice[index],
                                              productPrice: productPrice[index],
                                              quantity: 1,
                                              unitTag: productUnit[index],
                                              image: productImage[index].toString(),
                                            ),
                                          ).then((value){
                                            print('Product is added to cart');
                                            cart.addTotalPrice(double.parse(productPrice[index].toString()));
                                            cart.addCounter();
                                          }).onError((error, stackTrace){
                                            print(error);
                                          });
                                        },
                                        child: Container(
                                          height: 35,
                                          width: 100,
                                          decoration: BoxDecoration(
                                              color: Colors.green,
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          child: Center(
                                            child: Text('Add to Cart'),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}
