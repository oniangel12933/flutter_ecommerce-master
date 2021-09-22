import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddProduct extends StatefulWidget {
  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final TextEditingController nameProductController = TextEditingController();
  final TextEditingController descriptionProductController =
      TextEditingController();

  final TextEditingController stockProductController = TextEditingController();
  final TextEditingController priceProductController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  // drop down bottom
  String selectedProducts = 'Clothes';
  List listCategoryProducts = [
    'Clothes',
    'Book',
    'Shoes',
    'Electronics',
    'Other'
  ];

  String selectedProductCondition = 'New';
  List listProductCondition = ['New', 'Used', 'Renewed'];

  // get local image
  File image;
  Future getImage(ImageSource sourceImage) async {
    // Get image from gallery.
    File imageFile = await ImagePicker.pickImage(source: sourceImage);

    if (imageFile != null) {
      setState(() {
        image = imageFile;
      });
    }
  }

  _showImage() {
    if (image == null) {
      return SizedBox(height: 0);
    } else if (image != null) {
      return Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: <Widget>[
          Image.file(
            image,
            fit: BoxFit.cover,
            height: 250,
          ),
          FlatButton(
            padding: EdgeInsets.all(16),
            color: Colors.black54,
            child: Text(
              'Change Image',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w400),
            ),
            onPressed: () => getImage(ImageSource.gallery),
          )
        ],
      );
    } else {
      return Text('EROR');
    }
  }

  String imageLocation;
  Future<void> _uploadImageToFirebase() async {
    try {
      // Make random image name.
      int randomNumber = Random().nextInt(100000);
      imageLocation = 'images/image${randomNumber}.jpg';

      // Upload image to firebase.
      final Reference storageReference =
          FirebaseStorage.instance.ref().child(imageLocation);
      final UploadTask uploadTask = storageReference.putFile(image);
      TaskSnapshot taskSnapshot = await uploadTask;

      _addPathToDatabase(imageLocation, taskSnapshot, uploadTask);
    } catch (e) {
      print(e.message);
    }
  }

  Future<void> _addPathToDatabase(
      String text, TaskSnapshot a, UploadTask uploadTask) async {
    // Get image URL from firebase
    final ref = FirebaseStorage.instance.ref().child(text);
    final String imageURL = await ref.getDownloadURL();

    //
    String url = (await a.ref.getDownloadURL());
    print('URL Is $url');
    print('product controller ${nameProductController.text}');

    //search Index Function
    List<String> splitList = nameProductController.text.split(' ');
    List<String> indexList = [];

    for (int i = 0; i < splitList.length; i++) {
      for (int j = 0; j < splitList[i].length + i; j++) {
        indexList.add(splitList[i].substring(0, j).toLowerCase());
        indexList.add(splitList[i].substring(0, j).toUpperCase());
      }
    }

    // search
    for (int i = 0; i < 2; i++) {
      indexList.add(nameProductController.text.toLowerCase());
      indexList.add(nameProductController.text.toUpperCase());
      indexList.add(nameProductController.text);
    }

    // dateTime now
    DateTime now = DateTime.now();
    var currentTime =
        new DateTime(now.year, now.month, now.day, now.hour, now.minute);

    //
    if (url != null) {
      await FirebaseFirestore.instance.collection('${selectedProducts}').add({
        'name': nameProductController.text,
        'stock': stockProductController.text ?? 1,
        'description': descriptionProductController.text,
        'price': priceProductController.text,
        'url': url,
        'condition': selectedProductCondition,
        'date': currentTime,
      });

      await FirebaseFirestore.instance.collection('allProduct').add({
        'name': nameProductController.text,
        'stock': stockProductController.text ?? 1,
        'description': descriptionProductController.text,
        'price': priceProductController.text,
        'url': url,
        'searchIndex': indexList,
        'condition': selectedProductCondition,
        'date': currentTime,
      });

      await FirebaseFirestore.instance.collection('myProduct').add({
        'name': nameProductController.text,
        'stock': stockProductController.text ?? 1,
        'description': descriptionProductController.text,
        'price': priceProductController.text,
        'url': url,
        'condition': selectedProductCondition,
        'date': currentTime,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: RichText(
          text: TextSpan(
            children: <TextSpan>[
              TextSpan(
                  text: 'Add',
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontFamily: 'PoppinsBold')),
              TextSpan(
                  text: 'Product',
                  style: TextStyle(
                      fontSize: 18,
                      color: Color(0xFF016DF7),
                      fontFamily: 'PoppinsBold')),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                verticalDirection: VerticalDirection.down,
                children: [
                  //TODO: Input Name
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        _showImage(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            (image == null)
                                ? FlatButton(
                                    height: 45,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0)),
                                    color: Color(0xFF016DF7),
                                    onPressed: () =>
                                        getImage(ImageSource.gallery),
                                    child: Text('Add Image',
                                        style: TextStyle(
                                            fontFamily: 'PoppinsBold',
                                            color: Colors.white,
                                            fontSize: 16)),
                                  )
                                : SizedBox(height: 0),
                            (image == null)
                                ? FlatButton(
                                    height: 45,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0)),
                                    color: Color(0xFF016DF7),
                                    onPressed: () =>
                                        getImage(ImageSource.camera),
                                    child: Text('Take a picture',
                                        style: TextStyle(
                                            fontFamily: 'PoppinsBold',
                                            color: Colors.white,
                                            fontSize: 16)),
                                  )
                                : SizedBox(height: 0),
                          ],
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          keyboardType: TextInputType.text,
                          style: TextStyle(
                              fontFamily: 'PoppinsReg', color: Colors.black),

                          // add controller
                          controller: nameProductController,

                          decoration: InputDecoration(
                            labelText: 'Product',
                            labelStyle: TextStyle(
                                fontFamily: 'PoppinsBold', color: Colors.black),
                          ),
                          validator: (val) {
                            if (val.isEmpty) {
                              return 'Cant be a Empty!';
                            }
                            if (val.length < 5) {
                              return 'Product name must more than 5';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          keyboardType: TextInputType.text,
                          style: TextStyle(
                              fontFamily: 'PoppinsReg', color: Colors.black),
                          minLines: 4,
                          maxLines: 30,

                          // add controller
                          controller: descriptionProductController,

                          decoration: InputDecoration(
                            labelText: 'Description',
                            labelStyle: TextStyle(
                                fontFamily: 'PoppinsBold', color: Colors.black),
                          ),
                          validator: (val) {
                            if (val.isEmpty) {
                              return 'Cant be a Empty!';
                            }
                            if (val.length < 10) {
                              return 'Description product must more than 10';
                            }
                            if (val.length > 200) {
                              return 'Description product must less than 200';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          keyboardType: TextInputType.number,
                          style: TextStyle(
                              fontFamily: 'PoppinsReg', color: Colors.black),

                          // add controller
                          controller: stockProductController,

                          decoration: InputDecoration(
                            labelText: 'Stock',
                            labelStyle: TextStyle(
                                fontFamily: 'PoppinsBold', color: Colors.black),
                          ),
                          validator: (val) {
                            if (val.isEmpty) {
                              return 'Cant be a Empty!';
                            }
                            if (val == '0') {
                              return 'Stock cant be 0';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          keyboardType: TextInputType.number,
                          style: TextStyle(
                              fontFamily: 'PoppinsReg', color: Colors.black),

                          // add controller
                          controller: priceProductController,

                          decoration: InputDecoration(
                            labelText: 'Price',
                            labelStyle: TextStyle(
                                fontFamily: 'PoppinsBold', color: Colors.black),
                          ),
                          validator: (val) {
                            if (val.isEmpty) {
                              return 'Cant be a Empty!';
                            }
                            if (val == '0') {
                              return 'Price cant be 0';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 10),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Product Category',
                          style: TextStyle(
                              fontFamily: 'PoppinsBold',
                              color: Colors.black,
                              fontSize: 16)),
                      Text('Product Condition',
                          style: TextStyle(
                              fontFamily: 'PoppinsBold',
                              color: Colors.black,
                              fontSize: 16)),
                    ],
                  ),
                  //TODO: Watch THis fking code
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      DropdownButtonHideUnderline(
                        child: DropdownButton(
                          items: listCategoryProducts
                              .map<DropdownMenuItem>((value) {
                            return DropdownMenuItem(
                                child: Text(value), value: value);
                          }).toList(),

                          // text
                          value: selectedProducts,
                          style: TextStyle(
                              fontFamily: 'PoppinsReg', color: Colors.black),
                          onChanged: (value) {
                            setState(() {
                              selectedProducts = value;
                            });
                          },
                        ),
                      ),
                      DropdownButtonHideUnderline(
                        child: DropdownButton(
                          items: listProductCondition
                              .map<DropdownMenuItem>((value) {
                            return DropdownMenuItem(
                                child: Text(value), value: value);
                          }).toList(),

                          // text
                          value: selectedProductCondition,
                          style: TextStyle(
                              fontFamily: 'PoppinsReg', color: Colors.black),
                          onChanged: (value) {
                            setState(() {
                              selectedProductCondition = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 10),

                  Center(
                    child: FlatButton(
                      height: 50,
                      minWidth: double.infinity,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      color: Colors.black,
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          //Add Image Data
                          _uploadImageToFirebase();
                          Navigator.of(context).pop();
                        }
                      },
                      child: Text("Add Products",
                          style: TextStyle(
                              fontFamily: 'PoppinsBold',
                              color: Colors.white,
                              fontSize: 16)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
