import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/app_colors.dart';
import '../widgets/custom_appbar.dart';
import '../widgets/custom_bottom_appbar.dart';
import 'product_page_controller.dart';
import 'widgets/custom_product_card.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({Key? key}) : super(key: key);

  static const route = '/productPage';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      bottomNavigationBar: GetBuilder<ProductPageController>(
        builder: (control) {
          return CustomBottomAppBar(
            total: control.getTotal(),
          );
        },
      ),
      body: GetBuilder<ProductPageController>(
        builder: (control) {
          return RefreshIndicator(
            onRefresh: () {
              control.refreshProductList();
              return Future.value();
            },
            child: Container(
              padding: const EdgeInsets.all(16.0),
              child: GetBuilder<ProductPageController>(
                builder: (control) {
                  if (control.productList.isNotEmpty) {
                    if (control.searchProductList.isNotEmpty) {
                      return ListView.builder(
                        itemCount: control.searchProductList.length,
                        itemBuilder: (context, index) {
                          var name = control.searchProductList[index]['name'];
                          var price = double.tryParse(
                            control.searchProductList[index]['price']
                                .toString(),
                          );
                          var id = control.productList[index]['id'];
                          return CustomProductCard(
                            name: name,
                            price: price,
                            id: id,
                          );
                        },
                      );
                    }
                    return ListView.builder(
                      itemCount: control.productList.length,
                      itemBuilder: (context, index) {
                        var name = control.productList[index]['name'];
                        var price = double.tryParse(
                          control.productList[index]['price'].toString(),
                        );
                        var id = control.productList[index]['id'];
                        return CustomProductCard(
                          name: name,
                          price: price,
                          id: id,
                        );
                      },
                    );
                  } else {
                    return const Center(
                      child: Text(
                        'Nenhum produto foi adicionado',
                        style: TextStyle(
                          color: AppColors.titleColor,
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
