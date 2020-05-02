import 'package:buildadroid/Expenses/helpers/ensure_visible.dart';
import 'package:buildadroid/StateManagement/FeatureProviders/provider.dart';
import 'package:buildadroid/StateManagement/Models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FormRegister extends StatefulWidget {
  @override
  _FormRegisterState createState() => _FormRegisterState();
}

class _FormRegisterState extends State<FormRegister> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FocusNode _titleFocus = FocusNode();
  final FocusNode _descriptionFocus = FocusNode();
  final FocusNode _priceFocus = FocusNode();
  final FocusNode _imageUrlFocus = FocusNode();

  final _imageUrlController = TextEditingController();


  var _editedProduct = Product(
    id: null,
    title: '',
    price: 0,
    description: '',
    imageUrl: '',
  );

  var _initValues = {
    'title': '',
    'description': '',
    'price': '',
    'imageUrl': '',
  };

  var _isInit = true;

  void _updateImageUrl() {
    if (!_imageUrlFocus.hasFocus) {
      // if ((!_imageUrlController.text.startsWith('http') && !_imageUrlController.text.startsWith('https')) || (!_imageUrlController.text.endsWith('.png') &&  !_imageUrlController.text.endsWith('.jpg') &&
      //         !_imageUrlController.text.endsWith('.jpeg'))) {
      //   return;
      // }
      setState(() {});
    }
  }

  void _saveForm() {
    final isValid = _formKey.currentState.validate();
    if (!isValid) {
      return;
    }
    _formKey.currentState.save();
    if (_editedProduct.id != null) {
      print('/////////////---- SUCCESS EDIT ----/////');
      Provider.of<Products>(context, listen: false).updateItem(_editedProduct.id, _editedProduct);
    } else {
      Provider.of<Products>(context, listen: false).addItem(_editedProduct);
      print('/////////////---- SUCCESS REGISTER ----/////');
      print(_editedProduct);
    }
    Navigator.of(context).pop();
  }

  @override
  void initState() {
    _imageUrlFocus.addListener(_updateImageUrl);
    super.initState();
  }

@override
  void didChangeDependencies() {
     print("didChangeDepencies");
     if (_isInit) {
        final productId = ModalRoute.of(context).settings.arguments as String;
        print(productId);
        if(productId != null){
          _editedProduct = Provider.of<Products>(context, listen: false).findById(id: productId);
          _initValues = {
            'title': _editedProduct.title,
            'description': _editedProduct.description,
            'price': _editedProduct.price.toString(),
            'imageUrl': '',
          };
          _imageUrlController.text = _editedProduct.imageUrl;
        }
     }
     _isInit = false;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _imageUrlFocus.removeListener(_updateImageUrl);
    _titleFocus.dispose();
    _descriptionFocus.dispose();
    _priceFocus.dispose();
    _imageUrlController.dispose();
    _imageUrlFocus.dispose(); 
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    print("begin");

    Widget _buildTitleTextFiled() {
      return EnsureVisibleWhenFocused(
        focusNode: _titleFocus,
        child: TextFormField(
          initialValue: _initValues['title'],
          enableInteractiveSelection: true,
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.next,
          onFieldSubmitted: (_) {
            FocusScope.of(context).requestFocus(_priceFocus);
          },
          validator: (value) {
            if (value.isEmpty) {
              return 'Please provide a value.';
            }
            return null;
          },
          onSaved: (value) {
            _editedProduct = Product(
                title: value,
                price: _editedProduct.price,
                description: _editedProduct.description,
                imageUrl: _editedProduct.imageUrl,
                id: _editedProduct.id,
                isfavorite: _editedProduct.isfavorite
                );
          },
          decoration: InputDecoration(
              labelText: "Title",
              labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
        ),
      );

    }

    Widget _buildPriceTextFiled() {
      return EnsureVisibleWhenFocused(
        focusNode: _priceFocus,
        child: TextFormField(
          initialValue: _initValues['price'],
          focusNode: _priceFocus,
          enableInteractiveSelection: true,
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.next,
          onFieldSubmitted: (_) {
            FocusScope.of(context).requestFocus(_descriptionFocus);
          },
          validator: (value) {
            if (value.isEmpty) {
                return 'Please enter a price.';
              }
              if (double.tryParse(value) == null) {
                return 'Please enter a valid number.';
              }
              if (double.parse(value) <= 0) {
                return 'Please enter a number greater than zero.';
              }
              return null;
            },
          onSaved: (value) {
            _editedProduct = Product(
                title: _editedProduct.title,
                price: double.parse(value),
                description: _editedProduct.description,
                imageUrl: _editedProduct.imageUrl,
                id: _editedProduct.id,
                isfavorite: _editedProduct.isfavorite
                );
          },
          decoration: InputDecoration(
              labelText: "Price",
              labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
        ),
      );

    }

    Widget _buildDescTextFiled() {
      return EnsureVisibleWhenFocused(
        focusNode: _descriptionFocus,
        child: TextFormField(
          initialValue: _initValues['description'],
          enableInteractiveSelection: true,
          keyboardType: TextInputType.multiline,
          focusNode: _descriptionFocus,
          // textInputAction: TextInputAction.next,
          maxLines: 3,
          validator: (value) {
          if (value.isEmpty) {
              return 'Please enter a description.';
            }
            if (value.length < 10) {
              return 'Should be at least 10 characters long.';
            }
            return null;
            },
          onSaved: (value) {
            _editedProduct = Product(
                title: _editedProduct.title,
                price: _editedProduct.price,
                description: value,
                imageUrl: _editedProduct.imageUrl,
                id: _editedProduct.id,
                isfavorite: _editedProduct.isfavorite
                );
          },
          decoration: InputDecoration(
              labelText: "Description",
              labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
        ),
      );

    }

    _buildImageTextField(){
      return   Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width /4,
            height: MediaQuery.of(context).size.width /4,
            margin: EdgeInsets.only(
              top: 8,
              right: 10,
            ),
            decoration: BoxDecoration(
              border: Border.all(
                width: 1,
                color: Colors.grey,
              ),
            ),
            child: _imageUrlController.text.isEmpty
                ? Container(alignment: Alignment.center, child: Text('Enter a URL', style: TextStyle(fontSize: 12),))
                : FittedBox(
                    child: Image.network(
                      _imageUrlController.text,
                      fit: BoxFit.cover,
                    ),
                  ),
          ),
          Expanded(
            child: TextFormField(
              decoration: InputDecoration(labelText: 'Image URL'),
              keyboardType: TextInputType.url,
              textInputAction: TextInputAction.done,
              controller: _imageUrlController,
              focusNode: _imageUrlFocus,
              onFieldSubmitted: (_) {
              _saveForm();
              },
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter an image URL.';
                }
                // if (!value.startsWith('http') &&
                //     !value.startsWith('https')) {
                //   return 'Please enter a valid URL.';
                // }
                if (!value.endsWith('.png') &&
                    !value.endsWith('.jpg') &&
                    !value.endsWith('.jpeg')) {
                  return 'Please enter a valid image URL.';
                }
                return null;
              },
              onSaved: (value) {
                _editedProduct = Product(
                  title: _editedProduct.title,
                  price: _editedProduct.price,
                  description: _editedProduct.description,
                  imageUrl: value,
                  id: _editedProduct.id,
                  isfavorite: _editedProduct.isfavorite,
                );
              },
            ),
          ),
        ],
      );
    }
    return Form(
      key: _formKey,
      child: ListView(
        children: <Widget>[
          ListTile(title: _buildTitleTextFiled()),
          ListTile(title: _buildPriceTextFiled()),
          ListTile(title: _buildDescTextFiled()),
          ListTile(title: _buildImageTextField()),

        ]
      ),
      
    );

    
  }
}