import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/app_colors.dart';
import '../product_page/product_page_controller.dart';

class CustomBottomAppBar extends StatelessWidget {
  final double total;

  const CustomBottomAppBar({Key? key, required this.total}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      elevation: 0,
      color: AppColors.primaryColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Total: R\$ ${total.toStringAsFixed(2)}',
              style: const TextStyle(
                color: AppColors.titleColor,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            InkWell(
              child: const Padding(
                padding: EdgeInsets.only(right: 8.0),
                child: Material(
                  elevation: 4,
                  shape: CircleBorder(),
                  child: CircleAvatar(
                    backgroundColor: AppColors.secondaryColor,
                    foregroundColor: AppColors.cancelColor,
                    radius: 28,
                    child: Icon(
                      Icons.add,
                      color: AppColors.titleColor,
                    ),
                  ),
                ),
              ),
              onTap: () {
                showAddProductDialog(context);
              },
            ),
          ],
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
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
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
                style: TextStyle(
                  color: AppColors.titleColor,
                ),
              ),
            ),
            GetBuilder<ProductPageController>(
              builder: (control) {
                return ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                      AppColors.secondaryColor,
                    ),
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
                    style: TextStyle(
                      color: AppColors.titleColor,
                    ),
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
