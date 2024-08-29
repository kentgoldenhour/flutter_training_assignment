import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:flutter_training_assignment/login_page.dart';
import 'package:flutter_training_assignment/home_page.dart';
import 'package:flutter_training_assignment/category_page.dart';
import 'package:flutter_training_assignment/database.dart';

class DetailsPage extends StatefulWidget {
  String username = '';
  int productId = 0;

  DetailsPage({required this.username, required this.productId});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  bool isLoading = true;
  bool _APIConnected = false;
  Map data = {};
  int id = 0;
  String title = '';
  double price = 0.0;
  String category = '';
  String description = '';
  String image = '';

  Future getProduct() async {
    try {
      id = widget.productId;
      Response response =
          await get(Uri.parse('https://fakestoreapi.com/products/$id'));
      setState(() {
        data = jsonDecode(response.body);
        category = data['category'];
        description = data['description'];
        title = data['title'];
        price = data['price'];
        image = data['image'];
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
                          TextButton(
                              onPressed: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return HomePage(username: widget.username);
                                }));
                              },
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
                                ],
                              )),
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
            loadingScreen(context, isLoading)
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
    } else
      return Container(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextButton(
                  onPressed: () {},
                  child: Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            // return back page
                            Navigator.of(context).pop();
                          },
                          icon: Icon(Icons.arrow_back_ios)),
                      Text('Back', style: TextStyle(color: Colors.black)),
                    ],
                  )),
              SizedBox(height: 30),
              Container(
                  child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(30),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            spreadRadius: 2,
                            blurRadius: 7,
                          )
                        ],
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    width: 200,
                    height: 280,
                    child: Image.network(
                      image,
                      width: 200,
                      fit: BoxFit.contain,
                    ),
                  ),
                  SizedBox(width: 30),
                  Expanded(
                    child: Container(
                      height: 250,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Text(category,
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 15,
                                  )),
                            ),
                            Expanded(
                              flex: 1,
                              child: Container(
                                child: Text(
                                  title,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 25,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Container(
                                alignment: Alignment.centerLeft,
                                child: Text('\$${price.toString()}',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 35,
                                    )),
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Container(
                                alignment: Alignment.bottomLeft,
                                child: Text(description,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                    )),
                              ),
                            ),
                          ]),
                    ),
                  )
                ],
              ))
            ],
          ));
  }
}
