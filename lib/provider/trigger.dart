import 'package:newJoyo/models/supplier.dart';
import 'package:flutter/cupertino.dart';

import '../models/customer.dart';
import '../models/stock.dart';

class Trigger extends ChangeNotifier {
  List<Stock> listSelectedStock = [];
  List<Supplier> listSelectedSupplier = [];
  List<Customer> listSelectedCustomer = [];
  late Stock selectedStock;
  late Supplier selectedSupplier;
  late Customer selectedCustomer;
  
  selectCustomer(Customer customer, bool listen) {
    selectedCustomer = customer;
    if (listen) notifyListeners();
  }

  selectListCustomer(List<Customer> customers, bool listen) {
    listSelectedCustomer = customers;
    if (listen) notifyListeners();
  }

  selectSupplier(Supplier supplier, bool listen) {
    selectedSupplier = supplier;

    if (listen) notifyListeners();
  }

  selectListSupplier(List<Supplier> suppliers, bool listen) {
    listSelectedSupplier = suppliers;
    if (listen) notifyListeners();
  }

  selectStock(Stock stock, bool listen) {
    selectedStock = stock;
    if (listen) notifyListeners();
  }

  selectListStock(List<Stock> stocks, bool listen) {
    listSelectedStock = stocks;
    if (listen) notifyListeners();
  }
}
