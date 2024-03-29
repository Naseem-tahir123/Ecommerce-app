import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/models/categories_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_card/image_card.dart';

class CategoriesWidget extends StatelessWidget {
  const CategoriesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: FirebaseFirestore.instance.collection("categories").get(),
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
              height: Get.height / 5,
              child: ListView.builder(
                itemCount: snapshot.data!.docs.length,
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  CategoriesModel categoriesModel = CategoriesModel(
                    categoryId: snapshot.data!.docs[index]["categoryId"],
                    categoryImg: snapshot.data!.docs[index]["categoryImg"],
                    categoryName: snapshot.data!.docs[index]["categoryName"],
                    createdAt: snapshot.data!.docs[index]["createdAt"],
                    updatedAt: snapshot.data!.docs[index]["updatedAt"],
                  );
                  return Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(2),
                        child: Expanded(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: FillImageCard(
                              width: Get.width / 4,
                              heightImage: Get.height / 8,
                              imageProvider: CachedNetworkImageProvider(
                                  categoriesModel.categoryImg),
                              description: Center(
                                child: Text(
                                  categoriesModel.categoryName,
                                  style: const TextStyle(fontSize: 10),
                                ),
                              ),
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
