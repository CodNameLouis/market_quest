import 'package:flutter/material.dart';
import 'package:market_quest/constants/app_colors.dart';

class TotalBar extends StatelessWidget {
  final double total;

  const TotalBar({Key? key, required this.total}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      elevation: 0,
      color: Theme.of(context).primaryColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
          ],
        ),
      ),
    );
  }
}
