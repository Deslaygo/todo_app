import 'package:get/get.dart';
import 'package:todo_app/controllers/app_controller.dart';
import 'package:todo_app/helpers/api_helper.dart';
import 'package:todo_app/models/category.dart';

class CategoryController extends GetxController {
  final _categories = RxList<Category>([]);

  List<Category> get categories => _categories;

  Future<void> getCategories(Map<String, dynamic> parameters) async {
    try {
      _categories.value = [];
      final appController = Get.find<AppController>();
      await appController.validateToken();

      final data = await ApiHelper.get('categories', parameters);

      if (data != null) {
        data.forEach((json) => _categories.add(Category.fromJson(json)));
      }
    } catch (e) {
      rethrow;
    }
  }

  Category? getCategoryById(String id) {
    return _categories.firstWhereOrNull((ct) => ct.documentId == id);
  }
}
