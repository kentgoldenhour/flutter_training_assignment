import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:flutter_training_assignment/login_page.dart';
import 'package:flutter_training_assignment/category_page.dart';
import 'package:flutter_training_assignment/details_page.dart';
import 'package:flutter_training_assignment/database.dart';

import 'cart_page.dart';

class HomePage extends StatefulWidget {
  String username = '';

  HomePage({required this.username});

  @override
  State<HomePage> createState() => _HomePageState();
}

class Loading extends Widget {
  Widget(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: Colors.blue,
      ),
    );
  }

  @override
  Element createElement() {
    // TODO: implement createElement
    throw UnimplementedError();
  }
}

class _HomePageState extends State<HomePage> {
  bool isLoading = true;
  bool _APIConnected = false;
  Iterable data = {};
  List<Product> products = [];

  Future getProduct() async {
    try {
      // await Future.delayed(Duration(seconds: 5));
      Response response =
          await get(Uri.parse('https://fakestoreapi.com/products'));
      setState(() {
        data = jsonDecode(response.body);
        products = data.map((e) => Product.fromJson(e)).toList();
        _APIConnected = true;
        isLoading = false;
      });
    } catch (e) {
      print('caught error: $e');
    }
  }

  @override
  void initState() {
    getProduct();
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
                              child: TextButton(
                                  onPressed: () {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                      return CategoryPage(
                                          username: widget.username);
                                    }));
                                  },
                                  child: Text('Category',
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.grey,
                                      )))),
                          SizedBox(width: 20),
                          Container(
                              child: TextButton(
                                  onPressed: () {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                      return CartPage(
                                        username: widget.username,
                                      );
                                    }));
                                  },
                                  child: Text('Cart',
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.grey,
                                      )))),
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
            Center(
              child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Color(0xff0a8a2e),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  padding: EdgeInsets.all(30),
                  margin: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Container(
                        child: Text(
                          "30% OFF - Ramadhan Sale",
                          style: TextStyle(
                            fontSize: 37,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Container(
                        child: Text(
                          "*promotion is valid for regular-priced items, except for special collections.",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 10),
                        child: TextButton(
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.white,
                          ),
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return CategoryPage(
                                  username: '${widget.username}');
                            }));
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 12, horizontal: 50),
                            child: Text("BUY NOW",
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                )),
                          ),
                        ),
                      )
                    ],
                  )),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Container(
                child: Text('All Products',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    )),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Container(
                  child: Text('${products.length} Result',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 15,
                      ))),
            ),
            loadingScreen(context, isLoading),
          ],
        ),
      ),
    );
  }

  Widget loadingScreen(BuildContext context, bool isLoading) {
    if (isLoading) {
      return const Padding(
        padding: const EdgeInsets.all(30),
        child: const Center(
            child: CircularProgressIndicator(
          color: Colors.blue,
        )),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.all(20),
        child: _APIConnected == false
            ? Container(
                padding: EdgeInsets.all(100),
                child: Center(
                  child: Text("Oops, something went wrong :("),
                ),
              )
            : Container(
                width: double.infinity,
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 300,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                    childAspectRatio: MediaQuery.of(context).size.width /
                        (MediaQuery.of(context).size.height * 2.5),
                  ),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return ElevatedButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return DetailsPage(
                              username: '${widget.username}',
                              productId: products[index].id);
                        }));
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.white,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Center(
                                  child: Image.network(
                                    products[index].image,
                                    width: 150,
                                    height: 180,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                                SizedBox(height: 10),
                                SizedBox(
                                  height: 50,
                                  child: Text(
                                    products[index].title,
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text('\$${products[index].price.toString()}',
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.grey,
                                    )),
                              ]),
                        ),
                      ),
                    );
                  },
                  itemCount: products == null ? 0 : products.length,
                ),
              ),
      );
    }
  }
}
