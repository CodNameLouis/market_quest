import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:market_quest/product_page/product_page_controller.dart';

import '../../constants/app_colors.dart';

class CustomProductCard extends StatelessWidget {
  const CustomProductCard({
    super.key,
    required this.name,
    required this.price,
    required this.id,
  });

  final String name;
  final double? price;
  final String id;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.primaryColor,
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Produto: $name',
                  style: const TextStyle(
                    fontSize: 18.0,
                    color: AppColors.titleColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8.0),
                Text(
                  'Preço: ${price!.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 18.0,
                    color: AppColors.titleColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            GetBuilder<ProductPageController>(
              builder: (control) {
                return IconButton(
                  onPressed: () {
                    Get.defaultDialog(
                      title: 'Excluir produto',
                      middleText:
                          'Tem certeza de que deseja excluir este produto?',
                      textConfirm: 'Sim',
                      textCancel: 'Cancelar',
                      confirmTextColor: AppColors.titleColor,
                      buttonColor: AppColors.primaryColor,
                      onConfirm: () {
                        control.deleteProduct(id);
                      },
                    );
                  },
                  icon: const Icon(
                    Icons.delete_rounded,
                    color: AppColors.cancelColor,
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
