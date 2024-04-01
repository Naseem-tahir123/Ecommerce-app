import 'package:ecommerce_app/utils/app_constants.dart';
import 'package:ecommerce_app/views/widgets/My_button.dart';
import 'package:ecommerce_app/views/widgets/app_bar_widget.dart';
import 'package:ecommerce_app/views/widgets/banner_widget.dart';
import 'package:ecommerce_app/views/widgets/bottom_navigationBar_widget.dart';
import 'package:ecommerce_app/views/widgets/categories_widget.dart';
import 'package:ecommerce_app/views/widgets/heading_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/all_products_widget.dart';
import '../../widgets/flash_sale_widget.dart';
import 'categories_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppConstants.appBackgroundColor,
        appBar: const AppBarWidget(),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              const BannerWidget(),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: AppConstants.appTextColor,
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        children: [
                          HeadingWidget(
                            headingTitle: "Categorries",
                            headingSubtitle: "Inspired by your interest",
                            customButton: MyButton(
                              onTap: () {
                                Get.to(() => CategoriesScreen());
                              },
                              buttonText: "See more >",
                              borderColor: AppConstants.appScendoryColor,
                              textColor: AppConstants.appScendoryColor,
                            ),
                          ),
                          const CategoriesWidget()
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    Container(
                      decoration: BoxDecoration(color: Colors.amber.shade200),
                      child: HeadingWidget(
                        headingTitle: "Any 3 from Rs. 780",
                        headingSubtitle: "Free Delivery",
                        customButton: MyButton(
                          onTap: () {},
                          buttonText: "See More >",
                          borderColor: AppConstants.appScendoryColor,
                          textColor: AppConstants.appScendoryColor,
                        ),
                      ),
                    ),
                    Container(
                        decoration: const BoxDecoration(
                            color: AppConstants.appTextColor),
                        child: const FlashSaleWidget()),
                  ],
                ),
              ),
              Container(
                decoration:
                    const BoxDecoration(color: AppConstants.appTextColor),
                child: const HeadingWidget(
                  headingTitle: "All Products",
                ),
              ),
              const AllProductsWidget()
            ],
          ),
        ),
        bottomNavigationBar: const BottomNavigationBarWidget());
  }
}
