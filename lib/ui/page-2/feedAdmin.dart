import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommers/ui/productDetails/productDetails.dart';

class FeedsAdmin extends StatefulWidget {
  @override
  _FeedsAdminState createState() => _FeedsAdminState();
}

class _FeedsAdminState extends State<FeedsAdmin> {
  final db = FirebaseFirestore.instance;

  Widget containerFeed(
      String name, DateTime date, String url, String description) {
    return Container(
      width: MediaQuery.of(context).size.width / 2.3,
      height: MediaQuery.of(context).size.height / 2.5,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'PoppinsMed',
                      fontSize: 24.0)),
              Text(date.toIso8601String(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: Colors.grey,
                      fontFamily: 'PoppinsReg',
                      fontSize: 14.0)),
              SizedBox(height: 5.0),
              Center(
                child: Image.network(
                  url,
                  width: 150,
                  height: 150,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 5.0),
              Text(description,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                  style: TextStyle(
                      color: Colors.grey,
                      fontFamily: 'PoppinsReg',
                      fontSize: 12.0)),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    final CollectionReference feedAdmin = firestore.collection('Feed Admin');
    final db = FirebaseFirestore.instance.collection('Feed Admin');

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
                  text: 'Feed',
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontFamily: 'PoppinsBold')),
              TextSpan(
                  text: ' Product',
                  style: TextStyle(
                      fontSize: 18,
                      color: Color(0xFF016DF7),
                      fontFamily: 'PoppinsBold')),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: StreamBuilder<QuerySnapshot>(
          stream: feedAdmin.orderBy('date', descending: true).snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, int index) {
                    DocumentSnapshot ds = snapshot.data.docs[index];

                    // Date Time Formatter
                    DateTime formattedDate = ds['date'].toDate();

                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(new MaterialPageRoute(
                            builder: (context) => new ProductDetails(
                              productName: ds['name'],
                              price: ds['price'],
                              stock: ds['stock'],
                              imageUrl: ds['url'],
                              details: ds['description'],
                              productCondition: ds['condition'],
                            ),
                          ));
                        },
                        child: containerFeed(ds['name'], formattedDate,
                            ds['url'], ds['description']),
                      ),
                    );
                  },
                ),
              );
            } else {
              return Text("");
            }
          },
        ),
      ),
    );
  }
}
