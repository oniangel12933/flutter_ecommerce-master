import 'package:flutter/material.dart';
import 'package:flutter_ecommers/ui/addProduct/addProduct.dart';
import 'package:flutter_ecommers/ui/addProduct/addProductAdmin.dart';
import 'package:flutter_ecommers/ui/page-3/myproduct.dart';
import 'package:flutter_ecommers/ui/transactionHistory/transactionHistory.dart';

class UserProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: RichText(
          text: TextSpan(
            children: <TextSpan>[
              TextSpan(
                  text: 'User',
                  style: TextStyle(
                      fontSize: 18,
                      color: Color(0xFF016DF7),
                      fontFamily: 'PoppinsBold')),
              TextSpan(
                  text: ' Profile',
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontFamily: 'PoppinsBold')),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height / 4.5,
                decoration: BoxDecoration(
                    color: Color(0xFF016DF7),
                    borderRadius: BorderRadius.circular(20.0)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Center(
                            child: Icon(Icons.account_circle_rounded,
                                size: 124, color: Colors.white)),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0, top: 20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Achmad Rizki',
                              style: TextStyle(
                                  fontFamily: 'PoppinsBold',
                                  fontSize: 24,
                                  color: Colors.white)),
                          Text('€ 5000',
                              style: TextStyle(
                                  fontFamily: 'PoppinsMed',
                                  fontSize: 16,
                                  color: Colors.white)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),

              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => AddProduct()));
                },
                child: Card(
                  child: ListTile(
                      title: Text('Add Product',
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'PoppinsBold',
                              fontSize: 18)),
                      leading: Icon(Icons.add_shopping_cart,
                          color: Colors.black, size: 24)),
                ),
              ),

              //
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => AddProductAdmin()));
                },
                child: Card(
                  child: ListTile(
                      title: Text('Add Product(Admin Only)',
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'PoppinsBold',
                              fontSize: 18)),
                      leading: Icon(Icons.add_shopping_cart,
                          color: Colors.black, size: 24)),
                ),
              ),

              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => TransactionHistory()));
                },
                child: Card(
                  child: ListTile(
                      title: Text('Transaction History',
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'PoppinsBold',
                              fontSize: 18)),
                      leading:
                          Icon(Icons.history, color: Colors.black, size: 24)),
                ),
              ),

              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => MyProduct()));
                },
                child: Card(
                  child: ListTile(
                      title: Text('My Product',
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'PoppinsBold',
                              fontSize: 18)),
                      leading: Icon(Icons.storage_rounded,
                          color: Colors.black, size: 24)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
