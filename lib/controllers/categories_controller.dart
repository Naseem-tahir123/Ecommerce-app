import 'package:ecommerce_app/services/services.dart';
import 'package:get/get.dart';

import '../models/categories_model.dart';

class CategoriesController extends GetxController {
  List<CategoriesModel> categoriesList = [];

  @override
  void onInit() {
    super.onInit();
    fetchCategories();
  }

  void fetchCategories() {
    Services.firestore.collection("categories").get().then((snapshot) {
      if (snapshot.docs.isNotEmpty) {
        categoriesList = snapshot.docs
            .map((doc) => CategoriesModel(
                  categoryId: doc["categoryId"],
                  categoryImg: doc["categoryImg"],
                  categoryName: doc["categoryName"],
                  createdAt: doc["createdAt"],
                  updatedAt: doc["updatedAt"],
                ))
            .toList();
        update(); // Manually trigger a rebuild
      }
    }).catchError((error) {
      print("Error fetching categories: $error");
    });
  }
}
