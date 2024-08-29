import 'package:flutter/material.dart';
import 'package:flutter_training_assignment/home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String username = '';
  String password = '';
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff2f6799),
      body: Column(
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
                      child: Text('Login',
                          style: TextStyle(
                            fontSize: 15,
                            color: Color(0xfff18700),
                          ))),
                ],
              )),
          Expanded(
            child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.white,
                ),
                padding: EdgeInsets.all(30),
                margin: EdgeInsets.symmetric(vertical: 120, horizontal: 50),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                        child: Text('Login',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ))),
                    SizedBox(height: 15),
                    Form(
                        key: formKey,
                        child: Column(
                          children: [
                            Container(
                              child: SizedBox(
                                width: 300,
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: 'Username',
                                  ),
                                  style: TextStyle(
                                    fontSize: 15,
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Enter correct username";
                                    } else
                                      return null;
                                  },
                                  onChanged: (String value) {
                                    setState(() {
                                      username = value;
                                    });
                                  },
                                ),
                              ),
                            ),
                            SizedBox(height: 15),
                            Container(
                              child: SizedBox(
                                width: 300,
                                child: TextFormField(
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Enter correct password";
                                    } else
                                      return null;
                                  },
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: 'Password',
                                  ),
                                  style: TextStyle(
                                    fontSize: 15,
                                  ),
                                  onChanged: (String value) {
                                    setState(() {
                                      password = value;
                                    });
                                  },
                                ),
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            SizedBox(height: 15),
                            Container(
                              child: SizedBox(
                                width: 300,
                                height: 50,
                                child: DecoratedBox(
                                  decoration:
                                      BoxDecoration(color: Color(0xfff18700)),
                                  child: TextButton(
                                    onPressed: () {
                                      if (formKey.currentState!.validate()) {
                                        Navigator.push(context,
                                            MaterialPageRoute(
                                                builder: (context) {
                                          return HomePage(
                                              username: '$username');
                                        }));
                                      }
                                    },
                                    child: Text("Login",
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.white,
                                        )),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )),
                    SizedBox(height: 15),
                    Expanded(
                      child: Container(
                          alignment: Alignment.bottomCenter,
                          child: Text('2023 BINUSMART',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ))),
                    )
                  ],
                )),
          ),
        ],
      ),
    );
  }
}
