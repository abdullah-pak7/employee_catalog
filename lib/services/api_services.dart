import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/employee_model.dart';

class ApiService {
  static const String baseUrl = 'https://hub.dummyapis.com/employee?noofRecords=25&idStarts=1001';

  static Future<List<Employee>> getEmployees() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      Iterable employeeList = jsonDecode(response.body);
      return employeeList.map((e) => Employee.fromJson(e)).toList();
    } else {
      throw Exception(response.statusCode);
    }
  }
}
