import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/employee_provider.dart';

class EmployeeListScreen extends StatefulWidget {
   EmployeeListScreen();

  @override
  State<EmployeeListScreen> createState() => _EmployeeListScreenState();
}

class _EmployeeListScreenState extends State<EmployeeListScreen> {
  late EmployeeProvider employeeProvider;
  TextEditingController searchName = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    employeeProvider = Provider.of<EmployeeProvider>(context, listen: false);
    employeeProvider.setIsGettingDataTrue();
    employeeProvider.fetchEmployees();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    EmployeeProvider providerWatcher = (context).watch<EmployeeProvider>();
    return Scaffold(
      appBar: AppBar(
        title: Text('Employees Catalogue'),
        centerTitle: true,
      ),
      body: providerWatcher.gettingData ? Center(
        child: CircularProgressIndicator(),
      ) :
      !providerWatcher.isData ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Something went wrong'),
            Text('Check Your Internet'),
            SizedBox(height: 5,),
            TextButton(
              onPressed: (){
                employeeProvider.setIsGettingDataTrue();
                employeeProvider.fetchEmployees();
                setState(() {});
              },
              child: Text('Try Again'),
            ),
          ],
        ),
      ) :
      Column(
        children: [
          Row(
            children: [
              SizedBox(width: 10),
              Expanded(
                child: TextFormField(
                  controller: searchName,
                  onChanged: (value) {
                    print(searchName.text);
                    if(searchName.text.isNotEmpty){
                      employeeProvider.getFiltered(searchName.text.toLowerCase());
                    }
                    else{
                      employeeProvider.getUnfiltered();
                    }
                  },
                  decoration: InputDecoration(
                    hintText: 'Search employee name',
                  ),
                ),
              ),
              SizedBox(width: 20),
            ],
          ),
          SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: employeeProvider.employees.length,
              itemBuilder: (context, index) {
                final employee = employeeProvider.employees[index];
                return ListTile(
                  title: Text(employee.name),
                  subtitle: Text(
                    'Contact: ${employee.contact}, Age: ${employee.age}',
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
