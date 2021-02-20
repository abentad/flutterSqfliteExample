import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqfliteExample/amount_model.dart';
import 'package:sqfliteExample/data_provider.dart';
import 'package:sqfliteExample/db_helper.dart';
import 'package:sqfliteExample/main.dart';

class AddScreen extends StatefulWidget {
  @override
  _AddScreenState createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  TextEditingController _amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<DataProvider>(context);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.of(context).pushReplacement(CupertinoPageRoute(
            builder: (context) => HomeScreen(),
          ));
        },
      ),
      body: Container(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              keyboardType: TextInputType.number,
              controller: _amountController,
            ),
            SizedBox(height: 20.0),
            MaterialButton(
              onPressed: () {
                AmountModel newAmount = AmountModel(
                  amount: int.parse(_amountController.text),
                  date: DateTime.now(),
                );
                DbHelper.instance.insertAmount(newAmount);
                provider.someFunction();
                print('new Amount added');
              },
              child: Text('Add'),
              color: Colors.teal,
              minWidth: double.infinity,
              height: 50.0,
            ),
          ],
        ),
      ),
    );
  }
}
