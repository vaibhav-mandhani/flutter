import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './Product.dart';
import './product_provider.dart';
import 'package:provider/provider.dart';

class EditProducts extends StatefulWidget {
  static const routeName = '/edit-products';
  @override
  _EditProductsState createState() => _EditProductsState();
}

class _EditProductsState extends State<EditProducts> {
  final priceFocus = FocusNode();
  final description = FocusNode();
  final imageController = TextEditingController();
  final form = GlobalKey<FormState>();
  final imageFocus = FocusNode();
  var editedProduct = Product(id: null, title: '', price: 0, description: '');
  var initValues = {
    'name': '',
    'address': '',
    'phone': '',
  };
  var isInit = true;
  var isLoading = false;

  @override
  void dispose() {
    imageFocus.removeListener(updateImage);
    priceFocus.dispose();
    description.dispose();
    imageController.dispose();
    imageFocus.dispose();

    super.dispose();
  }

  void updateImage() {
    if (!imageFocus.hasFocus) {
      setState(() {});
    }
  }

  void saveForm() {
    form.currentState.save();
    // setState(() {
    //   isLoading = true;
    // });
    // Navigator.of(context).pushReplacementNamed('/done');
    Provider.of<ProductProvider>(context, listen: false)
        .addProduct(editedProduct);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Easy Park',
          style: TextStyle(
            fontFamily: 'Lato',
            fontSize: 25,
          ),
        ),
        backgroundColor: Colors.deepOrange,
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: EdgeInsets.all(16),
              child: Form(
                key: form,
                child: ListView(
                  children: <Widget>[
                    Center(
                      child: Text(
                        'REGISTERATION',
                        style: TextStyle(fontFamily: 'Lato', fontSize: 30),
                      ),
                    ),
                    TextFormField(
                      initialValue: initValues['title'],
                      decoration: InputDecoration(labelText: 'Name'),
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(priceFocus);
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Enter Name';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        editedProduct = Product(
                            id: editedProduct.id,
                            title: value,
                            description: editedProduct.description,
                            price: editedProduct.price);
                      },
                    ),
                    TextFormField(
                        initialValue: initValues['price'],
                        decoration: InputDecoration(labelText: 'Phone Number'),
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                        focusNode: priceFocus,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Enter Phone Number';
                          } else if (value.toString() != '10') {
                            return 'Enter Valid Number';
                          }
                          return null;
                        },
                        onFieldSubmitted: (_) {
                          FocusScope.of(context).requestFocus(description);
                        },
                        onSaved: (value) {
                          editedProduct = Product(
                            id: editedProduct.id,
                            title: editedProduct.title,
                            description: editedProduct.description,
                            price: int.parse(value),
                          );
                        }),
                    TextFormField(
                      initialValue: initValues['description'],
                      decoration: InputDecoration(labelText: 'Address'),
                      textInputAction: TextInputAction.next,
                      focusNode: description,
                      onSaved: (value) {
                        editedProduct = Product(
                            id: editedProduct.id,
                            title: editedProduct.title,
                            description: value,
                            price: editedProduct.price);
                      },
                    ),
                    // Row(
                    //   crossAxisAlignment: CrossAxisAlignment.end,
                    //   children: <Widget>[
                    //     Container(
                    //       height: 100,
                    //       width: 100,
                    //       margin: EdgeInsets.only(
                    //         top: 8,
                    //         right: 10,
                    //       ),
                    //       decoration: BoxDecoration(
                    //         border: Border.all(width: 1, color: Colors.grey),
                    //       ),
                    //       child: imageController.text.isEmpty
                    //           ? Text('Enter a URL')
                    //           : FittedBox(
                    //               child: Image.network(imageController.text),
                    //               fit: BoxFit.cover,
                    //             ),
                    //     ),
                    //     Expanded(
                    //       child: TextFormField(
                    //         decoration: InputDecoration(labelText: 'Image URL'),
                    //         keyboardType: TextInputType.url,
                    //         textInputAction: TextInputAction.done,
                    //         controller: imageController,
                    //         focusNode: imageFocus,
                    //         onSaved: (value) {
                    //           editedProduct = Product(
                    //               id: editedProduct.id,
                    //               isFavorite: editedProduct.isFavorite,
                    //               title: editedProduct.title,
                    //               description: editedProduct.description,
                    //               imageUrl: value,
                    //               price: editedProduct.price);
                    //         },
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    RaisedButton(
                      onPressed: saveForm,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Text(
                        'SUBMIT',
                        style: TextStyle(
                            fontFamily: 'Lato',
                            fontSize: 20,
                            color: Colors.white),
                      ),
                      color: Colors.blue,
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
