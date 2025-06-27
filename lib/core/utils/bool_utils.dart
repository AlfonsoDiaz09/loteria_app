class BoolUtils {
  const BoolUtils();

  bool fromJson(dynamic json) {
    if (json is bool) {
      return json;
    } else if (json is String) {
      return json.toLowerCase() == 'true';
    } else if (json is int) {
      return json == 1;
    } else {
      return false;
    }
  }

  dynamic toJson(bool? value) {
    return value;
  }

  bool isValidNumber(String value){
    RegExp regex = RegExp(r'^[0-9]+$');

    return regex.hasMatch(value);
  }
}
