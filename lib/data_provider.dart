import 'package:flutter/cupertino.dart';
import 'package:sqfliteExample/amount_model.dart';
import 'package:sqfliteExample/db_helper.dart';

class DataProvider with ChangeNotifier {
  List<AmountModel> _amountList;

  DataProvider() {
    someFunction();
  }

  //getter
  List<AmountModel> get amountList => _amountList;

  //this will set the list to be equal to the values inside our db
  // void initiateAmountList() async {
  //   _amountList = await DbHelper.instance.getAmountList();
  //   print('data from db initiated');
  // }

  // void refreshData() async {
  //   _amountList = await DbHelper.instance.getAmountList();
  //   print('data from db initiated');
  // }

  void someFunction() async {
    var x = await DbHelper.instance.getAmountList();
    _amountList = x;
    notifyListeners();
  }
}
