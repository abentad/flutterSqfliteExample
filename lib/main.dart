import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqfliteExample/add_screen.dart';
import 'package:sqfliteExample/amount_model.dart';
import 'package:sqfliteExample/data_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (BuildContext context) => DataProvider(),
        )
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<DataProvider>(context);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).pushReplacement(CupertinoPageRoute(
            builder: (context) => AddScreen(),
          ));
        },
      ),
      body: SafeArea(
        child: provider.amountList == null
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: provider.amountList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(provider.amountList[index].amount.toString()),
                    subtitle: Text(provider.amountList[index].date.toString()),
                    trailing: Text(provider.amountList[index].id.toString()),
                  );
                },
              ),
      ),
    );
  }
}
