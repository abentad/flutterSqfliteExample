import 'package:flutter/cupertino.dart';
import 'package:sqfliteExample/amount_model.dart';
import 'package:sqfliteExample/db_helper.dart';

class DataProvider with ChangeNotifier {
  Future<List<AmountModel>> _amountList;

  DataProvider() {
    initiateAmountList();
  }

  //getter
  Future<List<AmountModel>> get amountList => _amountList;

  //this will set the list to be equal to the values inside our db
  void initiateAmountList() {
    _amountList = DbHelper.instance.getAmountList();
    print('data from db initiated');
  }

  void refreshList() {
    _amountList = DbHelper.instance.getAmountList();
    print('data refreshed');
  }
}
