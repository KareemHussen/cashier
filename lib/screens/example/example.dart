// import 'dart:math';
//
// import 'package:cashier/data/model/Product.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:syncfusion_flutter_datagrid/datagrid.dart';
//
// class HomeScreen extends StatelessWidget {
//   const HomeScreen({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final _scrollController = ScrollController();
//
//     //String? name;
//     //   String? price;
//     //   int? quantity;
//     //   int? boxQuantity;
//     //   int? buyPrice;
//     //   int? sellPrice;
//     //   int? id;
//     List<Product> _items = [
//       Product(
//           name: 'كرتونه بيض احمر',
//           quantity: 1,
//           boxQuantity: 10,
//           buyPrice: 12,
//           sellPrice: 14,
//           id: 1),
//       Product(
//           name: 'طماطم حمرا',
//           quantity: 2,
//           boxQuantity: 10,
//           buyPrice: 12,
//           sellPrice: 14,
//           id: 1),
//       Product(
//           name: 'فلفل احمر',
//           quantity: 3,
//           boxQuantity: 10,
//           buyPrice: 12,
//           sellPrice: 14,
//           id: 1),
//       Product(
//           name: 'كرتونه بيض احمر',
//           quantity: 1,
//           boxQuantity: 10,
//           buyPrice: 12,
//           sellPrice: 14,
//           id: 1),
//       Product(
//           name: 'طماطم حمرا',
//           quantity: 2,
//           boxQuantity: 10,
//           buyPrice: 12,
//           sellPrice: 14,
//           id: 1),
//       Product(
//           name: 'فلفل احمر',
//           quantity: 3,
//           boxQuantity: 10,
//           buyPrice: 12,
//           sellPrice: 14,
//           id: 1),
//       Product(
//           name: 'كرتونه بيض احمر',
//           quantity: 1,
//           boxQuantity: 10,
//           buyPrice: 12,
//           sellPrice: 14,
//           id: 1),
//       Product(
//           name: 'طماطم حمرا',
//           quantity: 2,
//           boxQuantity: 10,
//           buyPrice: 12,
//           sellPrice: 14,
//           id: 1),
//       Product(
//           name: 'فلفل احمر',
//           quantity: 3,
//           boxQuantity: 10,
//           buyPrice: 12,
//           sellPrice: 14,
//           id: 1),
//       Product(
//           name: 'كرتونه بيض احمر',
//           quantity: 1,
//           boxQuantity: 10,
//           buyPrice: 12,
//           sellPrice: 14,
//           id: 1),
//       Product(
//           name: 'طماطم حمرا',
//           quantity: 2,
//           boxQuantity: 10,
//           buyPrice: 12,
//           sellPrice: 14,
//           id: 1),
//       Product(
//           name: 'فلفل احمر',
//           quantity: 3,
//           boxQuantity: 10,
//           buyPrice: 12,
//           sellPrice: 14,
//           id: 1),
//     ];
//     List<String> emptyList = [
//       "",
//       "",
//       "",
//       "",
//       "",
//       "",
//       "",
//       "",
//       "",
//       "",
//       "",
//       "",
//       "",
//       "",
//       "",
//       "",
//     ];
//
//     List<Product> _items1 = [
//       // Product(
//       //     name: 'كرتونه بيض احمر',
//       //     quantity: 1,
//       //     boxQuantity: 10,
//       //     buyPrice: 12,
//       //     sellPrice: 14,
//       //     id: 1),
//       // Product(
//       //     name: 'طماطم حمرا',
//       //     quantity: 2,
//       //     boxQuantity: 10,
//       //     buyPrice: 12,
//       //     sellPrice: 14,
//       //     id: 1),
//       // Product(
//       //     name: 'فلفل احمر',
//       //     quantity: 3,
//       //     boxQuantity: 10,
//       //     buyPrice: 12,
//       //     sellPrice: 14,
//       //     id: 1),
//       // Product(
//       //     name: 'كرتونه بيض احمر',
//       //     quantity: 1,
//       //     boxQuantity: 10,
//       //     buyPrice: 12,
//       //     sellPrice: 14,
//       //     id: 1),
//       // Product(
//       //     name: 'طماطم حمرا',
//       //     quantity: 2,
//       //     boxQuantity: 10,
//       //     buyPrice: 12,
//       //     sellPrice: 14,
//       //     id: 1),
//       // Product(
//       //     name: 'فلفل احمر',
//       //     quantity: 3,
//       //     boxQuantity: 10,
//       //     buyPrice: 12,
//       //     sellPrice: 14,
//       //     id: 1),
//       // Product(
//       //     name: 'كرتونه بيض احمر',
//       //     quantity: 1,
//       //     boxQuantity: 10,
//       //     buyPrice: 12,
//       //     sellPrice: 14,
//       //     id: 1),
//       // Product(
//       //     name: 'طماطم حمرا',
//       //     quantity: 2,
//       //     boxQuantity: 10,
//       //     buyPrice: 12,
//       //     sellPrice: 14,
//       //     id: 1),
//       // Product(
//       //     name: 'فلفل احمر',
//       //     quantity: 3,
//       //     boxQuantity: 10,
//       //     buyPrice: 12,
//       //     sellPrice: 14,
//       //     id: 1),
//     ];
//
//     DataSource dataSource = DataSource(_items);
//
//     return Scaffold(
//         body: SfDataGrid(
//           allowSorting: true,
//           selectionMode: SelectionMode.multiple,
//           source: dataSource,
//           columns: [
//             GridTextColumn(
//                 columnName: 'id',
//                 label: Container(
//                   padding: EdgeInsets.symmetric(horizontal: 16.0),
//                   alignment: Alignment.centerRight,
//                   child: Text(
//                     'ID',
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                 )),
//             GridTextColumn(
//                 columnName: 'name',
//                 label: Container(
//                     padding: EdgeInsets.symmetric(horizontal: 16.0),
//                     alignment: Alignment.centerLeft,
//                     child: Text(
//                       'Name',
//                       overflow: TextOverflow.ellipsis,
//                     ))),
//             GridTextColumn(
//                 columnName: 'designation',
//                 label: Container(
//                     padding: EdgeInsets.symmetric(horizontal: 16.0),
//                     alignment: Alignment.centerLeft,
//                     child: Text(
//                       'Designation',
//                       overflow: TextOverflow.ellipsis,
//                     ))),
//             GridTextColumn(
//                 columnName: 'salary',
//                 label: Container(
//                     padding: EdgeInsets.symmetric(horizontal: 16.0),
//                     alignment: Alignment.centerRight,
//                     child: Text(
//                       'Salary',
//                       overflow: TextOverflow.ellipsis,
//                     ))),
//           ],
//         ),
//
//     );
//   }
//
// }
//
//
// class DataSource extends DataGridSource {
//   DataSource(List<Product> products) {
//     dataGridRows = products
//         .map<DataGridRow>((dataGridRow) => DataGridRow(cells: [
//       DataGridCell<int>(columnName: 'id', value: dataGridRow.id),
//       DataGridCell<String>(columnName: 'name', value: dataGridRow.name),
//       DataGridCell<String>(
//           columnName: 'price', value: dataGridRow.sellPrice.toString()),
//       DataGridCell<int>(
//           columnName: 'quantity', value: dataGridRow.quantity),
//     ]))
//         .toList();
//   }
//
//   late List<DataGridRow> dataGridRows;
//   @override
//   List<DataGridRow> get rows => dataGridRows;
//   @override
//   DataGridRowAdapter? buildRow(DataGridRow row) {
//     return DataGridRowAdapter(
//         cells: row.getCells().map<Widget>((dataGridCell) {
//           return Container(
//               padding: EdgeInsets.symmetric(horizontal: 16.0),
//               alignment: (dataGridCell.columnName == 'id' ||
//                   dataGridCell.columnName == 'salary')
//                   ? Alignment.centerRight
//                   : Alignment.centerLeft,
//               child: Text(
//                 dataGridCell.value.toString(),
//                 overflow: TextOverflow.ellipsis,
//               ));
//         }).toList());
//   }
// }
