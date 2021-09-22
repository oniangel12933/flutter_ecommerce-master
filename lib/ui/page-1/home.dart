import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommers/ui/page-1/shoppingCart.dart';
import 'package:flutter_ecommers/ui/productCategory/book.dart';
import 'package:flutter_ecommers/ui/productCategory/clothes.dart';
import 'package:flutter_ecommers/ui/productCategory/electronics.dart';
import 'package:flutter_ecommers/ui/productCategory/shoes.dart';
import 'package:flutter_ecommers/ui/productDetails/productDetails.dart';
import 'package:flutter_ecommers/ui/searchDelegate/searchDelegate.dart';
import 'package:flutter_ecommers/ui/showAllProduct/bestProduct.dart';
import 'package:flutter_ecommers/ui/showAllProduct/flashSale.dart';
import 'package:flutter_ecommers/ui/showAllProduct/specialDiscount.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController searchProductController = TextEditingController();

  Widget containerProduct(
    String nameProduct,
    String priceProduct,
    String imageUrl,
    String stockProduct,
    String productCondition,
  ) {
    return Container(
      width: MediaQuery.of(context).size.width / 2.3,
      height: MediaQuery.of(context).size.height / 2.5,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(imageUrl,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 6,
                fit: BoxFit.cover),
            Padding(
              padding: const EdgeInsets.only(left: 5.0, right: 5.0),
              child: Text(nameProduct,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'PoppinsMed',
                      fontSize: 16.0)),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5.0, right: 5.0),
              child: Text(
                  'Stock: ' +
                      stockProduct +
                      '  •  ' +
                      'Condition: ' +
                      productCondition,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: Colors.grey,
                      fontFamily: 'PoppinsReg',
                      fontSize: 10.0)),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5.0, right: 5.0),
              child: Text(
                '€ ' + priceProduct,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: Colors.red,
                    fontFamily: 'PoppinsBold',
                    fontSize: 20.0),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    final CollectionReference productFFlashSale =
        firestore.collection('Flash Sale');
    final CollectionReference productSpecialDiscount =
        firestore.collection('Special Discount');
    final CollectionReference productBest =
        firestore.collection('Best Product');

    final CollectionReference otherProduct = firestore.collection('Other');

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
                  text: 'V6',
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontFamily: 'PoppinsBold')),
              TextSpan(
                  text: ' Store',
                  style: TextStyle(
                      fontSize: 18,
                      color: Color(0xFF016DF7),
                      fontFamily: 'PoppinsBold')),
            ],
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {
                showSearch(context: context, delegate: ProductSearch());
              },
              icon: Icon(Icons.search, color: Colors.black)),
          IconButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => ShoppingCart()));
              },
              icon: Icon(Icons.shopping_cart_rounded, color: Colors.black)),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height / 6,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: Color(0xFF016DF7),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.white,
                        ),
                        child: Center(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => Clothes()));
                            },
                            child: Image.asset(
                                'images/212-2122762_possible-reward-shirt-clothing-icon.png',
                                width: 25,
                                height: 25,
                                fit: BoxFit.cover),
                          ),
                        ),
                      ),
                      SizedBox(width: 10.0),
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.white,
                        ),
                        child: Center(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => Book()));
                            },
                            child: Center(
                              child: Image.asset(
                                  'images/114-1145878_book-icon-png-transparent-png-download-book-icon.png',
                                  width: 25,
                                  height: 25,
                                  fit: BoxFit.cover),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10.0),
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.white,
                        ),
                        child: Center(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => Electronic()));
                            },
                            child: Image.asset('images/electronics.png',
                                width: 25, height: 25, fit: BoxFit.cover),
                          ),
                        ),
                      ),
                      SizedBox(width: 10.0),
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.white,
                        ),
                        child: Center(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => Shoes()));
                            },
                            child: Image.asset('images/running-shoes-3.png',
                                width: 25, height: 25, fit: BoxFit.cover),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Flash Sale",
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                              fontFamily: 'PoppinsMed')),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => FlashSale()));
                        },
                        child: Text("Show All Product",
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                                fontFamily: 'PoppinsMed')),
                      ),
                    ],
                  ),
                ),
                StreamBuilder<QuerySnapshot>(
                  stream: productFFlashSale
                      .where('stock', isGreaterThan: '0')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Container(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height / 3,
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: snapshot.data.docs.length,
                          itemBuilder: (context, int index) {
                            DocumentSnapshot ds = snapshot.data.docs[index];

                            return GestureDetector(
                              onTap: () => Navigator.of(context).push(
                                new MaterialPageRoute(
                                  builder: (context) => new ProductDetails(
                                    productName: ds['name'],
                                    price: ds['price'],
                                    stock: ds['stock'],
                                    imageUrl: ds['url'],
                                    details: ds['description'],
                                    productCondition: ds['condition'],
                                  ),
                                ),
                              ),
                              child: containerProduct(
                                '${ds['name']}',
                                '${ds['price']}',
                                ds['url'],
                                ds['stock'],
                                ds['condition'],
                              ),
                            );
                          },
                        ),
                      );
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  },
                ),
                SizedBox(
                  height: 10.0,
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Special Discount",
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                              fontFamily: 'PoppinsMed')),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => SpecialDiscount()));
                        },
                        child: Text("Show All Product",
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                                fontFamily: 'PoppinsMed')),
                      ),
                    ],
                  ),
                ),
                StreamBuilder<QuerySnapshot>(
                  stream: productSpecialDiscount
                      .where('stock', isGreaterThan: '0')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Container(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height / 3,
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: snapshot.data.docs.length,
                          itemBuilder: (context, int index) {
                            DocumentSnapshot ds = snapshot.data.docs[index];

                            return GestureDetector(
                              onTap: () => Navigator.of(context).push(
                                new MaterialPageRoute(
                                  builder: (context) => new ProductDetails(
                                    productName: ds['name'],
                                    price: ds['price'],
                                    stock: ds['stock'],
                                    imageUrl: ds['url'],
                                    details: ds['description'],
                                    productCondition: ds['condition'],
                                  ),
                                ),
                              ),
                              child: containerProduct(
                                '${ds['name']}',
                                '${ds['price']}',
                                ds['url'],
                                ds['stock'],
                                ds['condition'],
                              ),
                            );
                          },
                        ),
                      );
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  },
                ),
                SizedBox(
                  height: 10.0,
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Best Product",
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                              fontFamily: 'PoppinsMed')),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => BestProduct()));
                        },
                        child: Text("Show All Product",
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                                fontFamily: 'PoppinsMed')),
                      ),
                    ],
                  ),
                ),
                StreamBuilder<QuerySnapshot>(
                  stream: otherProduct
                      .where('stock', isGreaterThan: '0')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Container(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height / 3,
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: snapshot.data.docs.length,
                          itemBuilder: (context, int index) {
                            DocumentSnapshot ds = snapshot.data.docs[index];

                            return GestureDetector(
                              onTap: () => Navigator.of(context).push(
                                new MaterialPageRoute(
                                  builder: (context) => new ProductDetails(
                                    productName: ds['name'],
                                    price: ds['price'],
                                    stock: ds['stock'],
                                    imageUrl: ds['url'],
                                    details: ds['description'],
                                    productCondition: ds['condition'],
                                  ),
                                ),
                              ),
                              child: containerProduct(
                                '${ds['name']}',
                                '${ds['price']}',
                                ds['url'],
                                ds['stock'],
                                ds['condition'],
                              ),
                            );
                          },
                        ),
                      );
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  },
                ),
                SizedBox(
                  height: 10.0,
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Other Product",
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                              fontFamily: 'PoppinsMed')),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => BestProduct()));
                        },
                        child: Text("Show All Product",
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                                fontFamily: 'PoppinsMed')),
                      ),
                    ],
                  ),
                ),
                StreamBuilder<QuerySnapshot>(
                  stream: productBest
                      .where('stock', isGreaterThan: '0')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Container(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height / 3,
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: snapshot.data.docs.length,
                          itemBuilder: (context, int index) {
                            DocumentSnapshot ds = snapshot.data.docs[index];

                            return GestureDetector(
                              onTap: () => Navigator.of(context).push(
                                new MaterialPageRoute(
                                  builder: (context) => new ProductDetails(
                                    productName: ds['name'],
                                    price: ds['price'],
                                    stock: ds['stock'],
                                    imageUrl: ds['url'],
                                    details: ds['description'],
                                    productCondition: ds['condition'],
                                  ),
                                ),
                              ),
                              child: containerProduct(
                                '${ds['name']}',
                                '${ds['price']}',
                                ds['url'],
                                ds['stock'],
                                ds['condition'],
                              ),
                            );
                          },
                        ),
                      );
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
