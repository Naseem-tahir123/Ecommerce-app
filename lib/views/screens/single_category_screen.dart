import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_app/controllers/single_category_controller.dart';
import 'package:ecommerce_app/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_card/image_card.dart';

class SingleCategoryScreen extends StatefulWidget {
  String categoryId;
  SingleCategoryScreen({super.key, required this.categoryId});

  @override
  State<SingleCategoryScreen> createState() => _SingleCategoryScreenState();
}

class _SingleCategoryScreenState extends State<SingleCategoryScreen> {
  late SingleCategoryController singleCategoryController;

  @override
  void initState() {
    super.initState();
    singleCategoryController =
        Get.put(SingleCategoryController(widget.categoryId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back,
              size: 18,
              color: Colors.grey,
            ),
          ),
          title: Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: Text(
              widget.categoryId,
              style: const TextStyle(
                color: Colors.grey,
              ),
            ),
          ),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.search_outlined),
              onPressed: () {
                // Add your search icon onPressed logic here
              },
              color: Colors.grey,
            ),
            IconButton(
              icon: const Icon(Icons.shopping_cart_checkout_outlined),
              onPressed: () {
                // Add your shopping cart icon onPressed logic here
              },
              color: Colors.grey,
            ),
            IconButton(
              icon: const Icon(Icons.more_vert),
              onPressed: () {
                // Add your more options icon onPressed logic here
              },
              color: Colors.grey,
            ),
          ],
        ),
      ),
      body: Row(
        children: [
          Expanded(
            child: GetBuilder<SingleCategoryController>(
              builder: (controller) {
                if (controller.isLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (controller.productsList.isEmpty) {
                  return const Center(
                    child: Text('No Products'),
                  );
                } else {
                  return GridView.builder(
                    itemCount: controller.productsList.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 1.2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 3,
                      crossAxisCount: 2,
                    ),
                    itemBuilder: (context, index) {
                      ProductModel product = controller.productsList[index];
                      return Padding(
                        padding: const EdgeInsets.all(2),
                        child: FillImageCard(
                          width: Get.width / 3,
                          heightImage: Get.height / 8,
                          imageProvider: CachedNetworkImageProvider(
                            product.productImages[0],
                          ),
                          description: Center(
                            child: Text(
                              product.productName,
                              style: const TextStyle(fontSize: 10),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
