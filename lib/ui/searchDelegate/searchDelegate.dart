import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommers/ui/productDetails/productDetails.dart';

class ProductSearch extends SearchDelegate<String> {
  final CollectionReference allProductFood =
      FirebaseFirestore.instance.collection('allProduct');

  // db
  final db = FirebaseFirestore.instance.collection('allProduct');

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.clear, color: Colors.black),
          onPressed: () {
            query = ''.toLowerCase();
          }),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.arrow_back_ios, color: Colors.black),
        onPressed: () {
          close(context, null);
          // Navigator.of(context).pop();
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: (query.trim().toLowerCase() == '')
          ? allProductFood.snapshots()
          : allProductFood
              .where('searchIndex', arrayContains: query.toLowerCase())
              .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Container(
            width: MediaQuery.of(context).size.width * 1,
            height: MediaQuery.of(context).size.height * 1,
            child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, int index) {
                  DocumentSnapshot ds = snapshot.data.docs[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
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
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Card(
                        child: ListTile(
                          title: Text('${ds['name']}',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'PoppinsMed',
                                  fontSize: 16.0)),
                          subtitle: Text(
                              '€${ds['price']} • Stock: ${ds['stock']}',
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontFamily: 'PoppinsReg',
                                  fontSize: 12)),
                          leading: ConstrainedBox(
                              constraints: BoxConstraints(
                                minWidth: 44,
                                minHeight: 44,
                                maxWidth: 64,
                                maxHeight: 64,
                              ),
                              child: Center(
                                child:
                                    Image.network(ds['url'], fit: BoxFit.cover),
                              )),
                        ),
                      ),
                    ),
                  );
                }),
          );
        } else {
          return Text('');
        }
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: (query.trim().toLowerCase() == '')
          ? allProductFood.snapshots()
          : allProductFood
              .where('searchIndex', arrayContains: query.toLowerCase())
              .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Container(
            width: MediaQuery.of(context).size.width * 1,
            height: MediaQuery.of(context).size.height * 1,
            child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, int index) {
                  DocumentSnapshot ds = snapshot.data.docs[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
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
                      );
                    },
                    child: Card(
                      child: ListTile(
                        title: Text('${ds['name']}',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'PoppinsMed',
                                fontSize: 16.0)),
                        subtitle: Text(
                            '€${ds['price']} • Stock: ${ds['stock']}',
                            style: TextStyle(
                                color: Colors.grey,
                                fontFamily: 'PoppinsReg',
                                fontSize: 12)),
                        leading: ConstrainedBox(
                            constraints: BoxConstraints(
                              minWidth: 44,
                              minHeight: 44,
                              maxWidth: 64,
                              maxHeight: 64,
                            ),
                            child: Center(
                              child:
                                  Image.network(ds['url'], fit: BoxFit.cover),
                            )),
                      ),
                    ),
                  );
                }),
          );
        } else {
          return Text('');
        }
      },
    );
  }
}
