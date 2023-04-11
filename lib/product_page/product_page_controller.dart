import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class ProductPageController extends GetxController {
  final firestoreInstance = FirebaseFirestore.instance;

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

  void deleteProduct(String id) async {
    try {
      await firestoreInstance.collection('products').doc(id).delete();
      productList.removeWhere((product) => product['id'] == id);
      update();
      Get.snackbar('Sucesso', 'Produto excluído com sucesso!');
    } catch (e) {
      Get.snackbar('Erro', 'Erro ao excluir produto.');
    }
  }

  void loadProductList() {
    try {
      firestoreInstance.collection('products').snapshots().listen((snapshot) {
        productList.assignAll(snapshot.docs.map((doc) {
          Map<String, dynamic> data = doc.data();
          data['id'] = doc.id;
          return data;
        }).toList());
        update();
      });
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
