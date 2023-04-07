import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:market_quest/product_page/product_page_controller.dart';

import '../constants/app_colors.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryColor.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: AppBar(
        title: const Text(
          "Market Quest",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColors.titleColor,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: GetBuilder<ProductPageController>(
          builder: (control) {
            return PopupMenuButton(
              icon: const Icon(
                Icons.align_horizontal_right_outlined,
                color: AppColors.titleColor,
              ),
              color: AppColors.secondaryColor,
              onSelected: (selectedOption) {
                switch (selectedOption) {
                  case 'preco':
                    control.sortProductListByPrice();
                    break;
                  case 'nome':
                    control.sortProductListByName();
                    break;
                }
              },
              itemBuilder: (BuildContext context) => [
                 const PopupMenuItem(
                  enabled: false,
                  child: Text(
                    'Ordenar por',
                    style: TextStyle(
                      color: AppColors.titleColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const PopupMenuItem(
                  value: 'preco',
                  child: Text('Preço'),
                ),
                const PopupMenuItem(
                  value: 'nome',
                  child: Text('Nome'),
                ),
              ],
            );
          },
        ),
        actions: [
          GetBuilder<ProductPageController>(
            builder: (control) {
              return IconButton(
                icon: const Icon(
                  Icons.search,
                  color: AppColors.titleColor,
                ),
                onPressed: () {
                  _showSearchDialog(context);
                },
              );
            },
          ),
        ],
      ),
    );
  }

  Future<void> _showSearchDialog(BuildContext context) async {
    String searchText = '';
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: TextField(
            autofocus: true,
            decoration: const InputDecoration(
              labelText: 'Pesquisar produto',
              hintText: 'Digite o nome do produto',
            ),
            onChanged: (value) {
              searchText = value;
            },
          ),
          actions: [
            GetBuilder<ProductPageController>(
              builder: (control) {
                return TextButton(
                  onPressed: () {
                    control.filterProductListByName(searchText);
                    Navigator.of(context).pop();
                  },
                  child: const Text('Pesquisar'),
                );
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
