import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/employee_provider.dart';
import 'screens/employee_list_screen.dart';

void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => EmployeeProvider(),
      child: MaterialApp(
        title: 'Employees Catalogue',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: EmployeeListScreen(),
      ),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)..badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
  }
}