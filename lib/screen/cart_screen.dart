// import 'dart:js_interop';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopingcart/Database/db_helper.dart';

import '../Model/cart_model.dart';
import 'cart_provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  DBHelper? dbHelper = DBHelper();
  @override
  Widget build(BuildContext context) {

    final cart = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyanAccent,
        shadowColor: Colors.cyan,
        elevation: 10,
        title: Text('My Shopping Cart'),
        centerTitle: true,
        actions: [
          Badge(
            label: Container(
                child: Consumer<CartProvider>(
                  builder: (context, value , child){
                    return Text(value.getCounter().toString());
                  },
                )
            ),
            child: Icon(Icons.shopping_bag_outlined),
          ),
          SizedBox(
            width: 20,
          )
        ],
      ),
      body: Column(
        children: [
          FutureBuilder(
              future: cart.getData(),
              builder: (context , AsyncSnapshot<List<Cart>> snapshot){
            if(snapshot.hasData){

              if(snapshot.data!.isEmpty){

                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image(image: NetworkImage('https://img.freepik.com/free-vector/shopping-cart_23-2147503155.jpg?size=626&ext=jpg')),
                    SizedBox(
                      height: 20,
                    ),
                    Text('The Cart is Empty', style: Theme.of(context).textTheme.headlineMedium,)
                  ],
                );
              }else{
                return Expanded(
                  child: ListView.builder(
                      itemCount: snapshot.data!.length,
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
                                              snapshot.data![index].image.toString())),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                snapshot.data![index].productName.toString(),
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w500),
                                              ),
                                              InkWell(
                                                  onTap: (){
                                                    dbHelper!.delete(snapshot.data![index].id!);
                                                    cart.removeCounter();
                                                    cart.removeTotalPrice(double.parse( snapshot.data![index].productPrice.toString()));
                                                  },
                                                  child: Icon(Icons.delete))
                                            ],
                                          ),

                                          Text(
                                            snapshot.data![index].unitTag.toString() +
                                                ' ' +
                                                r'$' +
                                                snapshot.data![index].productPrice.toString(),
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Align(
                                            alignment: Alignment.centerRight,
                                            child: Container(
                                              height: 35,
                                              width: 100,
                                              decoration: BoxDecoration(
                                                  color: Colors.green,
                                                  borderRadius:
                                                  BorderRadius.circular(5)),
                                              child: Padding(
                                                padding: const EdgeInsets.all(4.0),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    InkWell(
                                                        onTap: (){
                                                          int quantity = snapshot.data![index].quantity!;
                                                          int price = snapshot.data![index].initialPrice!;
                                                          quantity--;
                                                          int newPrice = price * quantity;
                                                          if( quantity > 0){
                                                            dbHelper!.updateQuantity(
                                                                Cart(
                                                                    id: snapshot.data![index].id!,
                                                                    productId: snapshot.data![index].id.toString(),
                                                                    productName: snapshot.data![index].productName!,
                                                                    initialPrice: snapshot.data![index].initialPrice!,
                                                                    productPrice: newPrice,
                                                                    quantity: quantity,
                                                                    unitTag: snapshot.data![index].unitTag.toString(),
                                                                    image: snapshot.data![index].image.toString())
                                                            ).then((value){
                                                              newPrice = 0;
                                                              quantity = 0;
                                                              cart.removeTotalPrice(double.parse(snapshot.data![index].initialPrice.toString()));
                                                            }).onError((error, stackTrace){
                                                              print(error.toString());
                                                            });
                                                          }

                                                        },
                                                        child: Icon(Icons.remove , color: Colors.white,)),
                                                    Text(snapshot.data![index].quantity.toString() , style: TextStyle(color: Colors.white),),
                                                    InkWell(
                                                        onTap: (){
                                                          int quantity = snapshot.data![index].quantity!;
                                                          int price = snapshot.data![index].initialPrice!;
                                                          quantity++;
                                                          int newPrice = price * quantity;

                                                          dbHelper!.updateQuantity(
                                                              Cart(
                                                                  id: snapshot.data![index].id!,
                                                                  productId: snapshot.data![index].id.toString(),
                                                                  productName: snapshot.data![index].productName!,
                                                                  initialPrice: snapshot.data![index].initialPrice!,
                                                                  productPrice: newPrice,
                                                                  quantity: quantity,
                                                                  unitTag: snapshot.data![index].unitTag.toString(),
                                                                  image: snapshot.data![index].image.toString())
                                                          ).then((value){
                                                            newPrice = 0;
                                                            quantity = 0;
                                                            cart.addTotalPrice(double.parse(snapshot.data![index].initialPrice.toString()));
                                                          }).onError((error, stackTrace){
                                                            print(error.toString());
                                                          });

                                                        },
                                                        child: Icon(Icons.add , color:  Colors.white,)),
                                                  ],
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
                );
              }


            }
            return Text('Error');
              }),
          Consumer<CartProvider>(builder: (context , value , child){
            return Visibility(
              visible: value.getTotalPrice().toStringAsFixed(2) == 0.00 ? true : false,
              child: Column(
                children: [
                  ReUsableRow(title: 'SubTotal', value: r'$'+value.getTotalPrice().toStringAsFixed(2)),
                  ReUsableRow(title: 'Discount 5%', value: r'$'+'20'),
                  ReUsableRow(title: 'Total', value: r'$'+value.getTotalPrice().toStringAsFixed(2))
                ],
              ),
            );
          })
        ],
      ),
    );
  }
}

class ReUsableRow extends StatelessWidget {
  final String title , value;
  const ReUsableRow({required this.title , required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title , style: Theme.of(context).textTheme.bodyLarge),
        Text(value , style:  Theme.of(context).textTheme.bodyLarge,)
      ],
    );
  }
}

