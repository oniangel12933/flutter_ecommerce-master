import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommers/ui/productDetails/productDetails.dart';

class Shoes extends StatefulWidget {
  @override
  _ShoesState createState() => _ShoesState();
}

class _ShoesState extends State<Shoes> {
  //
  Widget containerProduct(
    String nameProduct,
    String priceProduct,
    String imageUrl,
    String stockProduct,
    String productCondition,
  ) {
    return Container(
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
    final CollectionReference shoes = firestore.collection('Shoes');

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
                  text: 'Shoes',
                  style: TextStyle(
                      fontSize: 18,
                      color: Color(0xFF016DF7),
                      fontFamily: 'PoppinsBold')),
              TextSpan(
                  text: ' Categories',
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontFamily: 'PoppinsBold')),
            ],
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: StreamBuilder<QuerySnapshot>(
            stream: shoes.where('stock', isGreaterThan: '0').snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return GridView.builder(
                  gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.8,
                  ),
                  physics: ScrollPhysics(),
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, int index) {
                    DocumentSnapshot ds = snapshot.data.docs[index];

                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: GestureDetector(
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
                      ),
                    );
                  },
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      ),
    );
  }
}
