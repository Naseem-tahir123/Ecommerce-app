import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/models/product_model.dart';
import 'package:ecommerce_app/utils/app_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_card/image_card.dart';

class FlashSaleWidget extends StatelessWidget {
  const FlashSaleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: FirebaseFirestore.instance.collection("products").get(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text("Error"),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return SizedBox(
              height: Get.height / 5,
              child: const Center(
                child: CupertinoActivityIndicator(),
              ),
            );
          }
          if (snapshot.data!.docs.isEmpty) {
            return SizedBox(
              height: Get.height / 5,
              child: const Center(
                child: Text("No Categories"),
              ),
            );
          }
          if (snapshot.data != null) {
            return SizedBox(
              height: Get.height / 4.5,
              child: ListView.builder(
                itemCount: snapshot.data!.docs.length,
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  ProductModel productModel = ProductModel(
                      productId: snapshot.data!.docs[index]["productId"],
                      categoryId: snapshot.data!.docs[index]["categoryId"],
                      productName: snapshot.data!.docs[index]["productName"],
                      categoryName: snapshot.data!.docs[index]["categoryName"],
                      fullPrice: snapshot.data!.docs[index]["fullPrice"],
                      salePrice: snapshot.data!.docs[index]["salePrice"],
                      productImages: snapshot.data!.docs[index]
                          ["productImages"],
                      deliveryTime: snapshot.data!.docs[index]["deliveryTime"],
                      createdAt: snapshot.data!.docs[index]["createdAt"],
                      updatedAt: snapshot.data!.docs[index]["updatedAt"]);
                  return Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(2),
                        child: Expanded(
                          child: FillImageCard(
                            width: Get.width / 4,
                            heightImage: Get.height / 8,
                            imageProvider: CachedNetworkImageProvider(
                                productModel.productImages[0]),
                            title: Center(
                              child: Text(
                                productModel.categoryName,
                                style: const TextStyle(fontSize: 10),
                              ),
                            ),
                            footer: Row(
                              children: [
                                Text("Rs ${productModel.salePrice}",
                                    style: const TextStyle(fontSize: 10)),
                                const SizedBox(
                                  width: 2,
                                ),
                                Text(productModel.fullPrice,
                                    style: const TextStyle(
                                        fontSize: 10,
                                        decoration: TextDecoration.lineThrough,
                                        color: AppConstants.appScendoryColor)),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  );
                },
              ),
            );
          }
          return Container();
        });
  }
}
