import 'package:base_1/core/config/app_constatns.dart';
import 'package:base_1/core/extensions/string_extension.dart';

class ValidatorUtils {
  static String? productNameValidator(String? value) {
    if (value.isNullOrEmpty() ||
        value!.length > Constants.productNameMaxLength) {
      return 'Invalid product name';
    }
    return null;
  }

  static String? skuValidator(String? value) {
    if (value.isNullOrEmpty() || value!.length > Constants.skuMaxLength) {
      return 'Invalid sku';
    }
    return null;
  }
}
