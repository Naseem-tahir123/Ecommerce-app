import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_card/image_card.dart';

import '../../models/categories_model.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            onPressed: () {},
            icon: Column(
              children: [
                InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: const Icon(
                    Icons.arrow_back,
                    size: 18,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          title: const Padding(
            padding: EdgeInsets.only(bottom: 12.0),
            child: Text(
              "Just for you",
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
          ),
          actions: <Widget>[
            IconButton(
              icon: const Column(
                children: [
                  Icon(Icons.search_outlined),
                ],
              ),
              onPressed: () {
                // Add your wallet icon onPressed logic here
              },
              color: Colors.grey,
            ),
            IconButton(
              icon: const Column(
                children: [
                  Icon(Icons.shopping_cart_checkout_outlined),
                ],
              ),
              onPressed: () {
                // Add your coins icon onPressed logic here
              },
              color: Colors.grey,
            ),
            IconButton(
              icon: const Column(
                children: [
                  Icon(Icons.more_vert),
                ],
              ),
              onPressed: () {
                // Add your wallet icon onPressed logic here
              },
              color: Colors.grey,
            ),
          ],
        ),
      ),
      body: Row(
        children: [
          Expanded(
              flex: 1,
              child: Container(
                decoration: BoxDecoration(color: Colors.grey.shade200),
                child: ListView.builder(
                  itemCount: 15, // Set the number of items in your list
                  itemBuilder: (context, index) {
                    return const ListTile(
                      title: Column(
                        children: [
                          Icon(Icons.category), // Use your icon here
                          Text(
                            'Category  ',
                            style: TextStyle(fontSize: 10),
                          ), // Use your category name here
                        ],
                      ),
                    );
                  },
                ),
              )),
          Expanded(
              flex: 3,
              child: FutureBuilder(
                  future:
                      FirebaseFirestore.instance.collection("categories").get(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
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
                      return GridView.builder(
                          itemCount: snapshot.data!.docs.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  childAspectRatio: 1.2,
                                  mainAxisSpacing: 10,
                                  crossAxisSpacing: 3,
                                  crossAxisCount: 2),
                          itemBuilder: (context, index) {
                            CategoriesModel categoriesModel = CategoriesModel(
                              categoryId: snapshot.data!.docs[index]
                                  ["categoryId"],
                              categoryImg: snapshot.data!.docs[index]
                                  ["categoryImg"],
                              categoryName: snapshot.data!.docs[index]
                                  ["categoryName"],
                              createdAt: snapshot.data!.docs[index]
                                  ["createdAt"],
                              updatedAt: snapshot.data!.docs[index]
                                  ["updatedAt"],
                            );
                            return Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(2),
                                  child: Expanded(
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.vertical,
                                      child: FillImageCard(
                                        width: Get.width / 3,
                                        heightImage: Get.height / 8,
                                        imageProvider:
                                            CachedNetworkImageProvider(
                                                categoriesModel.categoryImg),
                                        description: Center(
                                          child: Text(
                                            categoriesModel.categoryName,
                                            style:
                                                const TextStyle(fontSize: 10),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            );
                          });
                    }
                    return Container();
                  }))
        ],
      ),
    );
  }
}
