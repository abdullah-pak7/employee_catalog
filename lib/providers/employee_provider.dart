import 'package:flutter/material.dart';

import '../models/employee_model.dart';
import '../services/api_services.dart';


class EmployeeProvider extends ChangeNotifier {
  List<Employee> _response = [];
  List<Employee> _employees = [];
  bool gettingData = false;
  bool isData = false;
  bool internetConnection = true;

  List<Employee> get employees => _employees;
  List<Employee> get response => _response;

  void setIsGettingDataFalse() {
    gettingData = false;
  }

  void setIsGettingDataTrue() {
    gettingData = true;
  }

  Future<void> fetchEmployees() async {
    _employees = [];
    try {
      _response = await ApiService.getEmployees();
      _response.forEach((element) {
        _employees.add(element);
      });
      setIsGettingDataFalse();
      isData = true;
      notifyListeners();
    } catch (e) {
      setIsGettingDataFalse();
      notifyListeners();
      print('Error fetching employees: $e');
      // Handle error
    }
  }

  void getFiltered(String name) {
    _employees = [];
    _response.forEach((element) {
      if(element.age > 35 && element.contact.contains('74') && element.name.trim().toLowerCase().contains(name)){
        _employees.add(element);
      }
    });
    notifyListeners();
  }

  void getUnfiltered() {
    _employees = [];
    _response.forEach((element) {
      _employees.add(element);
    });
    notifyListeners();
  }
}