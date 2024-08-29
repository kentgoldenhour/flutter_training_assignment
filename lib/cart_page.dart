import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:flutter_training_assignment/login_page.dart';
import 'package:flutter_training_assignment/database.dart';

class CartPage extends StatefulWidget {
  String username = '';

  CartPage({required this.username});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  bool _APIConnected = false;
  Iterable data = {};
  Map dataCart = {};
  List<Product> products = [];
  int subtotal = 0;

  int id = 0;
  int userid = 0;
  int productId = 0;
  List<UserProduct> listOfProducts = [];
  DateTime date = DateTime.now();

  Future getProduct() async {
    try {
      Response response =
          await get(Uri.parse('https://fakestoreapi.com/products'));
      setState(() {
        data = jsonDecode(response.body);
        products = data.map((e) => Product.fromJson(e)).toList();
        _APIConnected = true;
      });
    } catch (e) {
      print('caught error: $e');
    }
  }

  // Future getCart() async {
  //   try {
  //     Response response =
  //         await get(Uri.parse('https://fakestoreapi.com/carts/1'));
  //     setState(() {
  //       dataCart = jsonDecode(response.body);
  //       id = dataCart['id'];
  //       userid = dataCart['userid'];
  //       date = DateTime.now();
  //       listOfProducts =
  //           dataCart['products'].map((e) => UserProduct.fromJson(e)).toList();
  //       _APIConnected = true;
  //     });
  //     print(listOfProducts);
  //   } catch (e) {
  //     print('caught error: $e');
  //   }
  // }

  double getSubtotal(List<UserProduct> lists) {
    double total = 0;
    int productIdTemp = 0;
    for (int i = 0; i < listOfProducts.length; i++) {
      productIdTemp = listOfProducts[i].productId;
      total += listOfProducts[i].quantity * products[productIdTemp].price;
    }
    return total;
  }

  @override
  void initState() {
    getProduct();
    // getCart();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                color: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Row(
                        children: [
                          Container(
                              child: Text('BINUS',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ))),
                          Container(
                              child: Text('MART',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xfff18700),
                                  ))),
                          SizedBox(width: 20),
                          Container(
                              child: Text('Category',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.grey,
                                  ))),
                          SizedBox(width: 20),
                          Container(
                              child: Text('Cart',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.grey,
                                  ))),
                          SizedBox(width: 20),
                        ],
                      ),
                    ),
                    Container(
                        child: TextButton(
                      child: Text(
                          '${widget.username}' != ''
                              ? 'Hi, ${widget.username}'
                              : 'Login',
                          style: TextStyle(
                            fontSize: 15,
                            color: Color(0xfff18700),
                          )),
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return LoginPage();
                        }));
                      },
                    )),
                  ],
                )),
            Container(
                padding: EdgeInsets.all(20),
                child: Text('Carts', style: TextStyle(fontSize: 20))),
            Container(
                padding: EdgeInsets.all(20),
                child: Text('1 Result',
                    style: TextStyle(fontSize: 15, color: Colors.grey))),
            Container(
              width: double.infinity,
              child: ListView.builder(
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Container(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        children: [
                          Text('Cart 1'),
                          Text(date.toString()),
                          ListView.builder(
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return Row(
                                children: [
                                  Image.network(
                                    products[index].image,
                                    width: 100,
                                    height: 120,
                                    fit: BoxFit.contain,
                                  ),
                                  Text(products[listOfProducts[index].productId]
                                      .title),
                                  SizedBox(
                                    width: 30,
                                  ),
                                  Text(listOfProducts[index]
                                      .quantity
                                      .toString()),
                                  Text(
                                      '\$${products[listOfProducts[index].productId].price.toString()}'),
                                ],
                              );
                            },
                          ),
                          Row(
                            children: [
                              Text(
                                'Subtotal',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                width: 30,
                              ),
                              Text(
                                '\$${getSubtotal(listOfProducts).toString()}',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          )
                        ],
                      ));
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
