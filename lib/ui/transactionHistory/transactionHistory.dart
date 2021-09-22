import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TransactionHistory extends StatefulWidget {
  @override
  _TransactionHistoryState createState() => _TransactionHistoryState();
}

class _TransactionHistoryState extends State<TransactionHistory> {
  final db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    final CollectionReference feedAdmin =
        firestore.collection('Product Purchases');

// containertransactionHistory
    Widget containerTransactionHistory(String nameProduct, String priceProduct,
        String imageUrl, String productCondition, DateTime date) {
      return Container(
        width: MediaQuery.of(context).size.width / 2.3,
        height: MediaQuery.of(context).size.height / 2,
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
                  height: MediaQuery.of(context).size.height / 8,
                  fit: BoxFit.cover),
              Padding(
                padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                child: Text(nameProduct,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'PoppinsBold',
                        fontSize: 16.0)),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                child: Text(date.toIso8601String(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'PoppinsMed',
                        fontSize: 14.0)),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                child: Text(
                    '€' +
                        priceProduct +
                        ' - ' +
                        productCondition +
                        ' - ' +
                        '1 Item',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: Colors.grey,
                        fontFamily: 'PoppinsReg',
                        fontSize: 12.0)),
              ),
            ],
          ),
        ),
      );
    }

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
                  text: 'Transaction',
                  style: TextStyle(
                      fontSize: 18,
                      color: Color(0xFF016DF7),
                      fontFamily: 'PoppinsBold')),
              TextSpan(
                  text: ' History',
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
        child: StreamBuilder<QuerySnapshot>(
          stream: feedAdmin.orderBy('date', descending: true).snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return GridView.builder(
                gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                physics: ScrollPhysics(),
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, int index) {
                  DocumentSnapshot ds = snapshot.data.docs[index];

                  // Date Time Formatter
                  DateTime formattedDate = ds['date'].toDate();

                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: containerTransactionHistory(ds['name'], ds['price'],
                        ds['url'], ds['condition'], formattedDate),
                  );
                },
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
