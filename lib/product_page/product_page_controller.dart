import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class ProductPageController extends GetxController {
  final firestoreInstance = FirebaseFirestore.instance;
  // var productList = <Map<String, dynamic>>[].obs;
  RxList<Map<String, dynamic>> productList = RxList<Map<String, dynamic>>([]);

  RxList<Map<String, dynamic>> searchProductList =
      RxList<Map<String, dynamic>>([]);

  @override
  void onInit() {
    super.onInit();
    loadProductList();
    update();
  }

  void addProduct(String name, double price) async {
    try {
      await firestoreInstance.collection('products').add({
        'name': name,
        'price': price,
      });
      loadProductList();
      update();
      Get.snackbar('Sucesso', 'Produto adicionado com sucesso!');
    } catch (e) {
      Get.snackbar('Erro', 'Erro ao adicionar produto.');
    }
  }

  Future<void> loadProductList() async {
    try {
      QuerySnapshot<Map<String, dynamic>> products =
          await FirebaseFirestore.instance.collection('products').get();
      productList.assignAll(products.docs.map((doc) => doc.data()).toList());
      update();
    } catch (e) {
      Get.snackbar('Erro', 'Erro ao carregar lista de produtos.');
    }
  }

  void filterProductListByName(String name) {
    searchProductList.clear();
    searchProductList.addAll(productList.where((product) =>
        product['name'].toString().toLowerCase().contains(name.toLowerCase())));
    searchProductList.assignAll(searchProductList.toList());
    update();
  }

  void sortProductListByPrice() {
    productList.sort((a, b) => b['price'].compareTo(a['price']));
    update();
  }

  void sortProductListByName() {
    productList.sort((a, b) => a['name'].compareTo(b['name']));
    update();
  }

void refreshProductList() {
  searchProductList.clear();
  update();
}

  double getTotal() {
    var total = 0.0;
    for (var product in productList) {
      total += product['price'];
    }
    return total;
  }
}
