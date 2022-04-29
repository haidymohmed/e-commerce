import 'dart:io';
import 'package:e_commerce/Contraller/ProductFB.dart';
import 'package:e_commerce/Models/ClothesModel1.dart';
import 'package:e_commerce/Provider/Hub.dart';
import 'package:e_commerce/Widget/DisplayDialogMessage.dart';
import 'package:e_commerce/Widget/TextFormField.dart';
import 'package:e_commerce/Widget/customer_button.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
class AddProduct extends StatefulWidget {
  static String id = 'AddProduct';
  const AddProduct({Key? key}) : super(key: key);

  @override
  _AddProductState createState() => _AddProductState();
}
class _AddProductState extends State<AddProduct> {
  File? pickedImage;
  GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  Clothes product = new Clothes.modelSave(name: "", price: "", description: "", id: "", image: "", category: "");
  ProductFB authProduct = new ProductFB();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: Provider.of<ModelHud>(context).inAsyncCall,
        progressIndicator: SpinKitFadingCircle(color: Colors.purple.shade900,),
        child: ListView(
          children: [
            SizedBox(height: 30,),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Icon(FontAwesomeIcons.shopify , size: 150,color: Colors.purple.shade700,),
            ),
            Form(
              key: formKey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomerTextField(
                      hint: 'Product Name',
                      suffixIcon: false,
                      scure: false,
                      onSaved: (v){
                        product.name = v.toString();
                      },
                      validator: (v){
                        if(v.toString().length > 0){
                          product.name = v.toString();
                        }
                        else return "Enter Product Name ";
                      },
                    ),

                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomerTextField(
                      hint: 'Product Price',
                      suffixIcon: false,
                      scure: false,
                      onSaved: (v){
                        product.price = v.toString();
                      },
                      validator: (v){
                        if(v.toString().length > 0){
                          product.price = v.toString();
                        }
                        else return "Enter Product Price ";
                      },
                    ),

                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: InkWell(
                      onTap: (){
                        showDialog(
                            context: context,
                            builder: (context){
                              return SimpleDialog(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Row(
                                      mainAxisAlignment : MainAxisAlignment.spaceAround,
                                      children: [
                                        SimpleDialogOption(
                                          onPressed: ()async{
                                            await pickFromGallery();
                                            Navigator.of(context).pop(context);
                                          },
                                          child: Column(
                                            children :[
                                              Padding(
                                                padding: const EdgeInsets.only(bottom: 10),
                                                child: Icon(Icons.photo, color: Colors.purple.shade900,size: 30,),
                                              ),
                                              Text("Open Gallery")
                                            ]
                                          ),
                                        ),
                                        SimpleDialogOption(
                                          onPressed: ()async{
                                            await pickFromCamera();
                                            Navigator.of(context).pop(context);
                                          },
                                          child: Column(
                                              children :[
                                                Padding(
                                                  padding: const EdgeInsets.only(bottom: 10),
                                                  child: Icon(Icons.camera_alt, color: Colors.purple.shade900,size: 30,),
                                                ),
                                                Text("Open Camera")
                                              ]
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              );
                            }
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.purple.shade900 , width: 1.5)
                        ),
                        height: MediaQuery.of(context).size.height * .2,
                        width: MediaQuery.of(context).size.width,
                        // ignore: unnecessary_null_comparison
                        child: pickedImage == null ?
                        Center(child: Icon(Icons.camera_alt , color: Colors.purple.shade900,size: 30,)) :
                        Image.file(pickedImage!),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomerTextField(
                      hint: 'Product Description',
                      suffixIcon: false,
                      scure: false,
                      onSaved: (v){
                        product.description = v.toString();
                      },
                      validator: (v){
                        if(v.toString().length > 0){
                          product.description = v.toString();
                        }
                        else return "Enter Product Description ";
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomerTextField(
                      hint: 'Product Id',
                      suffixIcon: false,
                      scure: false,
                      onSaved: (v){
                        product.id = v.toString();
                      },
                      validator: (v){
                        if(v.toString().length > 0){
                          product.id = v.toString();
                        }
                        else return "Enter Product Id ";
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomerTextField(
                      hint: 'Product Category',
                      suffixIcon: false,
                      scure: false,
                      onSaved: (v){
                        product.category = v.toString();
                      },
                      validator: (v){
                        if(v.toString().length > 0){
                          product.category = v.toString();
                        }
                        else return "Enter Product Category ";
                      },
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(50),
              child: UserButton(
                title: 'Add Product',
                color: Colors.purple,
                method: ()async{
                  Provider.of<ModelHud>(context , listen: false).changeAsyncCall(true);
                  if(formKey.currentState!.validate()){
                    try{
                      await uploadImageToFirebase(product.id);
                      setState((){
                        formKey.currentState!.save();
                      });
                      await authProduct.addProduct(product);
                      DisplayDialogMessage(context, "Product has been added");
                    }catch(e){
                      DisplayDialogMessage(context, e.toString());
                    }
                    Provider.of<ModelHud>(context , listen: false).changeAsyncCall(false);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
  pickFromCamera()async{
    var image = await ImagePicker().pickImage(source: ImageSource.camera);
    setState(() {
      pickedImage = File(image!.path);
    });
  }
  pickFromGallery()async{
    var image  = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      pickedImage = File(image!.path);
    });
  }
  uploadImageToFirebase(var id)async{
    FirebaseStorage firebaseStorage = FirebaseStorage.instanceFor(bucket: 'gs://ecommerce-fbe70.appspot.com');
    Reference reference = firebaseStorage.ref().child('ProductsImage').child(id);
    await reference.putFile(pickedImage!).whenComplete(() => null);
    String url = await reference.getDownloadURL();
    setState(() {
      product.image = url.toString();
    });
  }
}
