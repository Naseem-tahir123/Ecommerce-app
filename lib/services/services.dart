import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Services {
  static FirebaseAuth auth = FirebaseAuth.instance;
  static FirebaseFirestore firestore = FirebaseFirestore.instance;

  // for adding products
  // static Future<void> addProduct() async {
  //   final productModel = ProductModel(
  //       productId: productId,
  //       categoryId: categoryId,
  //       productName: productName,
  //       categoryName: categoryName,
  //       fullPrice: fullPrice,
  //       productImages: productImages,
  //       deliveryTime: deliveryTime,
  //       createdAt: createdAt,
  //       updatedAt: updatedAt);
  //       await firestore.collection('products').add(productModel.toMap());
  // }
}
