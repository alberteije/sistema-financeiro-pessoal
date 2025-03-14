import 'package:email_validator/email_validator.dart';
import 'package:get/get.dart';

class ValidateFormField {
  ValidateFormField._();

  /// mandatory field
  static String? validateMandatory(String? value) {
    if (value == null || value.isEmpty) return 'validator_mandatory'.tr;
    return null;
  }

  /// mandatory field
  static String? validateMandatoryDynamic(dynamic value) {
    if (value == null || value.isEmpty) return 'validator_mandatory'.tr;
    return null;
  }

  /// Email
  static String? validateEmail(String? value) {
    if (value != "" && value != null) {
      final goodEmail = EmailValidator.validate(value);
      if (!goodEmail) {
        return 'validator_email'.tr;
      }
      return null;
    } else {
      return null;
    }
  }

  /// Email and mandatory
  static String? validateMandatoryEmail(String? value) {
    var mandatoryField = validateMandatory(value);
    if (mandatoryField == null) {
      return validateEmail(value);
    } else {
      return mandatoryField;
    }
  }

}
