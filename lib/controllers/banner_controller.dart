import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class BannerController extends GetxController {
  RxList<String> bannerUrls = RxList<String>([]);
  @override
  void onInit() {
    super.onInit();
    fetchBannerUrls();
  }

  //fetch banner
  Future<void> fetchBannerUrls() async {
    try {
      QuerySnapshot bannerSnapShot =
          await FirebaseFirestore.instance.collection("banners").get();
      if (bannerSnapShot.docs.isNotEmpty) {
        bannerUrls.value = bannerSnapShot.docs
            .map((doc) => doc["imageUrl"] as String)
            .toList();
      }
    } catch (e) {
      print("Error $e");
    }
  }
}
