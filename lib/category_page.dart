import 'dart:convert';
import 'dart:js_util';
import 'package:flutter/material.dart';
import 'package:flutter_training_assignment/login_page.dart';
import 'package:flutter_training_assignment/home_page.dart';
import 'package:http/http.dart';
import 'database.dart';
import 'details_page.dart';

class CategoryPage extends StatefulWidget {
  String username = '';
  CategoryPage({required this.username});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  bool isLoading = true;
  String username = '';
  String categoryName = 'electronics';
  bool _electronics = true;
  bool _jewelery = false;
  bool _men = false;
  bool _women = false;

  bool _APIConnected = false;
  Iterable data = {};
  List<Product> products = [];
  // List<Categories> categories = [];

  Future getProduct() async {
    try {
      Response response = await get(Uri.parse(
          'https://fakestoreapi.com/products/category/$categoryName'));
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

  // Future getCategory() async {
  //   try {
  //     Response response =
  //         await get(Uri.parse('https://fakestoreapi.com/products/category'));
  //     setState(() {
  //       data = jsonDecode(response.body);
  //       categories = data.map((e) => Categories(category: e)).toList();
  //       _APIConnected = true;
  //     });
  //     print(categories);
  //   } catch (e) {
  //     print('caught error: $e');
  //   }
  // }

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
            Stack(
              children: [
                Container(
                    decoration: BoxDecoration(
                        color: Color(0xff2f6799),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    width: double.infinity,
                    margin: EdgeInsets.all(20),
                    padding: EdgeInsets.fromLTRB(30, 25, 30, 35),
                    child: Center(
                        child: Text('Category',
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            )))),
                Container(
                    margin: EdgeInsets.only(top: 85),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: _electronics
                                  ? Color(0xfff18700)
                                  : Colors.white,
                            ),
                            onPressed: () {
                              setState(() {
                                categoryName = 'electronics';
                                _electronics = true;
                                _jewelery = false;
                                _men = false;
                                _women = false;
                                getProduct();
                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 20, horizontal: 10),
                              child: Text('Electronics',
                                  style: TextStyle(
                                      color: _electronics
                                          ? Colors.white
                                          : Colors.black)),
                            )),
                        SizedBox(width: 10),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  _jewelery ? Color(0xfff18700) : Colors.white,
                            ),
                            onPressed: () {
                              setState(() {
                                categoryName = 'jewelery';
                                _electronics = false;
                                _jewelery = true;
                                _men = false;
                                _women = false;
                                getProduct();
                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 20, horizontal: 10),
                              child: Text('Jewelery',
                                  style: TextStyle(
                                      color: _jewelery
                                          ? Colors.white
                                          : Colors.black)),
                            )),
                        SizedBox(width: 10),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  _men ? Color(0xfff18700) : Colors.white,
                            ),
                            onPressed: () {
                              setState(() {
                                categoryName = "men's clothing";
                                _electronics = false;
                                _jewelery = false;
                                _men = true;
                                _women = false;
                                getProduct();
                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 20, horizontal: 10),
                              child: Text("Men's Clothing",
                                  style: TextStyle(
                                      color:
                                          _men ? Colors.white : Colors.black)),
                            )),
                        SizedBox(width: 10),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  _women ? Color(0xfff18700) : Colors.white,
                            ),
                            onPressed: () {
                              setState(() {
                                categoryName = "women's clothing";
                                _electronics = false;
                                _jewelery = false;
                                _men = false;
                                _women = true;
                                getProduct();
                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 20, horizontal: 10),
                              child: Text("Women's Clothing",
                                  style: TextStyle(
                                      color: _women
                                          ? Colors.white
                                          : Colors.black)),
                            )),
                      ],
                    )),
              ],
            ),
            Container(
                margin: EdgeInsets.only(left: 20),
                child: Text(
                  '$categoryName',
                  style: TextStyle(fontWeight: FontWeight.bold),
                )),
            Container(
              padding: const EdgeInsets.only(left: 20),
              child: Text('${products.length} Result',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 15,
                  )),
            ),
            loadingScreen(context, isLoading),
          ],
        ),
      ),
    );
  }

  Padding loadingScreen(BuildContext context, bool isLoading) {
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
                  child: Text("Oops, something went wrong :')"),
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
