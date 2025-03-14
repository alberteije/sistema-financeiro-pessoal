import 'dart:convert';

class Filter {
  String? field;
  String? value;
  String? initialDate;
  String? finalDate;
  String? condition;
  String? where; // will be used when the Filter is multiple, that is, when more than one Filter is sent to the server

  Filter({this.field, this.value, this.initialDate, this.finalDate, this.condition, this.where});

  Filter.fromJson(Map<String, dynamic> jsonData) {
    field = jsonData['field'];
    value = jsonData['value'];
    initialDate = jsonData['initialDate'];
    finalDate = jsonData['finalDate'];
  }

  Map<String, dynamic> get toJson {
    Map<String, dynamic> jsonData = <String, dynamic>{};
    jsonData['field'] = field;
    jsonData['value'] = value;
    jsonData['initialDate'] = initialDate;
    jsonData['finalDate'] = finalDate;
    return jsonData;
  }

	String objectEncodeJson() {
	  final jsonData = toJson;
	  return json.encode(jsonData);
	}  
}