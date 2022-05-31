import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class LabCalendarController extends GetxController {
  List<Employee> employees = <Employee>[];

  List headerTable = [
    "Phòng",
    "Thứ 2",
    "Thứ 3",
    "Thứ 4",
    "Thứ 5",
    "Thứ 6",
    "Thứ 7",
    "Chủ nhật"
  ];

  late EmployeeDataSource employeeDataSource;

  @override
  void onInit() {
    employees = getEmployees();
    employeeDataSource = EmployeeDataSource(employees: employees);
    super.onInit();
  }

  List<Employee> getEmployees() {
    return [
      Employee(100011, 'TCAddasdasdas1231asd', 'Project Lead', 20000),
      Employee(100021, 'Kathryn', 'Manager', 30000),
      Employee(100031, 'Lara', 'Developer', 15000),
      Employee(100041, 'Michael', 'Designer', 15000),
      Employee(100051, 'Martin', 'Developer', 15000),
      Employee(100061, 'Newberry', 'Developer', 15000),
      Employee(100071, 'Balnc', 'Developer', 15000),
      Employee(100081, 'Perry', 'Developer', 15000),
      Employee(100091, 'Gable', 'Developer', 15000),
      Employee(100101, 'Grimes', 'Developer', 15000),
      Employee(100101, 'Grimes', 'Developer', 15000),
      Employee(100101, 'Grimes', 'Developer', 15000),
      Employee(100101, 'Grimes', 'Developer', 15000),
      Employee(100101, 'Grimes', 'Developer', 15000),
      Employee(100101, 'Grimes', 'Developer', 15000),
    ];
  }
}

class EmployeeDataSource extends DataGridSource {
  EmployeeDataSource({required List<Employee> employees}) {
    _employees = employees
        .map<DataGridRow>(
          (e) => DataGridRow(
            cells: [
              DataGridCell<int>(columnName: 'Phong', value: e.id),
              DataGridCell<String>(columnName: 't2', value: e.name),
              DataGridCell<String>(columnName: 't3', value: e.name),
              DataGridCell<String>(columnName: 't4', value: e.name),
              DataGridCell<String>(columnName: 't5', value: e.name),
              DataGridCell<String>(columnName: 't6', value: e.name),
              DataGridCell<String>(columnName: 't7', value: e.name),
              DataGridCell<String>(columnName: 'cn', value: e.name),
            ],
          ),
        )
        .toList();
  }

  List<DataGridRow> _employees = [];

  @override
  List<DataGridRow> get rows => _employees;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((dataGridCell) {
      return Container(
        // alignment: (dataGridCell.columnName == 'id' ||
        //         dataGridCell.columnName == 'salary')
        //     ? Alignment.centerRight
        //     : Alignment.centerLeft,
        alignment: Alignment.center,
        padding: EdgeInsets.all(16.0),
        child: Text(dataGridCell.value.toString(), textAlign: TextAlign.center,),
      );
    }).toList());
  }
}

class Employee {
  Employee(this.id, this.name, this.designation, this.salary);

  final int id;
  final String name;
  final String designation;
  final int salary;
}
