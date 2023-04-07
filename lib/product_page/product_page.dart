import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:market_quest/constants/app_colors.dart';

import '../widgets/custom_appbar.dart';
import '../widgets/custom_bottomappbar.dart';
import 'product_page_controller.dart';

class ProductPage extends StatelessWidget {
  ProductPage({Key? key}) : super(key: key);

  final ProductPageController productController =
      Get.put(ProductPageController());
  static const route = '/productPage';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      bottomNavigationBar: GetBuilder<ProductPageController>(
        builder: (control) {
          return TotalBar(
            total: control.getTotal(),
          );
        },
      ),
      body: RefreshIndicator(
        onRefresh: () {
          productController.refreshProductList();
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
                        control.searchProductList[index]['price'].toString(),
                      );
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Produto: $name',
                            style: const TextStyle(
                              fontSize: 18.0,
                              color: AppColors.titleColor,
                            ),
                          ),
                          const SizedBox(height: 8.0),
                          Text(
                            'Preço: ${price!.toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontSize: 18.0,
                              color: AppColors.titleColor,
                            ),
                          ),
                        ],
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
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Produto: $name',
                          style: const TextStyle(
                            fontSize: 18.0,
                            color: AppColors.titleColor,
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        Text(
                          'Preço: ${price!.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontSize: 18.0,
                            color: AppColors.titleColor,
                          ),
                        ),
                      ],
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
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primaryColor,
        onPressed: () {
          showAddProductDialog(context);
        },
        child: const Icon(
          Icons.add,
          color: AppColors.titleColor,
        ),
      ),
    );
  }

  void showAddProductDialog(BuildContext context) async {
    var nameController = TextEditingController();
    var priceController = TextEditingController();

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Adicionar produto'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Nome do produto',
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: priceController,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(
                  labelText: 'Preço',
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                'Cancelar',
                style: TextStyle(color: AppColors.titleColor),
              ),
            ),
            GetBuilder<ProductPageController>(
              builder: (control) {
                return ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        AppColors.secondaryColor),
                  ),
                  onPressed: () {
                    var name = nameController.text;
                    var price = double.tryParse(priceController.text) ?? 0.0;
                    if (name.isNotEmpty && price > 0) {
                      control.addProduct(name, price);
                    }
                  },
                  child: const Text(
                    'Adicionar',
                    style: TextStyle(color: AppColors.titleColor),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
