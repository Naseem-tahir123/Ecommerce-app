import 'package:ecommerce_app/models/product_model.dart';
import 'package:ecommerce_app/services/services.dart';
import 'package:get/get.dart';

class SingleCategoryController extends GetxController {
  final String categoryId;
  List<ProductModel> productsList = [];
  bool isLoading = true;

  SingleCategoryController(this.categoryId);

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
  }

  void fetchProducts() {
    Services.firestore
        .collection("products")
        .where("categoryId", isEqualTo: categoryId)
        .get()
        .then((snapshot) {
      if (snapshot.docs.isNotEmpty) {
        productsList = snapshot.docs
            .map((doc) => ProductModel(
                  productId: doc["productId"],
                  categoryId: doc["categoryId"],
                  productName: doc["productName"],
                  categoryName: doc["categoryName"],
                  salePrice: doc["salePrice"],
                  fullPrice: doc["fullPrice"],
                  productImages: List<String>.from(doc["productImages"]),
                  deliveryTime: doc["deliveryTime"],
                  isSale: doc["isSale"],
                  productDescription: doc["productDescription"],
                  createdAt: doc["createdAt"],
                  updatedAt: doc["updatedAt"],
                ))
            .toList();
        isLoading = false;
        update(); // Manually trigger a rebuild
      }
    }).catchError((error) {
      print("Error fetching products: $error");
      isLoading = false;
      update();
    });
  }
}
