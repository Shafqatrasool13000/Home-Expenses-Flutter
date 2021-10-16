import './Chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import './models/Model_For_transaction_List.dart';
import './List_of_All_transactions.dart';
import './widgets/User_Given_TransactionList.dart';

import 'dart:io';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  //List of Transactions
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    print('main file Called');
    return Platform.isIOS
        ? CupertinoApp(
            title: 'Hey Expenses App',
            theme: CupertinoThemeData(
              primaryColor: Colors.purpleAccent,
            ),
            home: MyHomePage(),
          )
        : MaterialApp(
            theme: ThemeData(
              primarySwatch: Platform.isAndroid ? Colors.orange : Colors.purple,
              fontFamily: 'OpenSans',
              textTheme: ThemeData.light().textTheme.copyWith(
                    headline6: TextStyle(
                        color: Colors.red,
                        fontFamily: 'QuickSand',
                        fontSize: 18),
                  ),
              primaryTextTheme: ThemeData.light()
                  .textTheme
                  .copyWith(caption: TextStyle(color: Colors.white)),
              buttonTheme: ThemeData.light()
                  .buttonTheme
                  .copyWith(buttonColor: Colors.red),
              appBarTheme: AppBarTheme(
                textTheme: ThemeData.light().textTheme.copyWith(
                      headline6: TextStyle(
                          fontFamily: 'OpenSans',
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
              ),
            ),
            debugShowCheckedModeBanner: false,
            title: 'Expense App',
            home: MyHomePage(),
          );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  //Method to Delete Item From the List
  void deleteItem(String id) {
    setState(() {
      _userTransactions.removeWhere((element) => element.id == id);
    });
  }

  //List of Transactions
  final List<Transaction> _userTransactions = [];
  //Method for Adding Transaction to List
  void _addTransactionToList(
      String userTitle, double userAmount, DateTime choseDate) {
    var newTransaction = Transaction(
      title: userTitle,
      amount: userAmount,
      date: choseDate,
      id: DateTime.now().toString(),
    );
    setState(() {
      _userTransactions.add(newTransaction);
    });
  }

//This is week Amount calculation List
  List<Transaction> get _getLastWeekTransactions {
    return _userTransactions.where(
      (element) {
        return element.date.isAfter(
          DateTime.now().subtract(
            Duration(days: 7),
          ),
        );
      },
    ).toList();
  }

  void _showModelBottomSheet(BuildContext context) {
    //This is the bottom sheet where user enters all the Inputs
    showModalBottomSheet(
      isScrollControlled: true,
      context: (context),
      builder: (builder) => ListOfAllTransactions(
        userInput: _addTransactionToList,
      ),
    );
  }

  bool _checkStatus = false;
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print(state);
  }

  List<Widget> _isLandScapeBuilder(
      MediaQueryData mediaQuery, var appBar, var _expenseList) {
    return [
      Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
        Text('Click to Change'),
        Switch.adaptive(
            value: _checkStatus,
            onChanged: (value) {
              setState(() {
                _checkStatus = value;
              });
            }),
      ]),
      _checkStatus
          ? Container(
              height: (mediaQuery.size.height -
                      mediaQuery.padding.top -
                      appBar.preferredSize.height) *
                  0.70,
              child: ChartLogic(_getLastWeekTransactions),
            )
          : _expenseList,
    ];
  }

  List<Widget> _isPortraitBuilder(
      MediaQueryData mediaQuery, var appBar, var _expenseList) {
    return [
      Container(
        height: (mediaQuery.size.height -
                mediaQuery.padding.top -
                appBar.preferredSize.height) *
            0.30,
        child: ChartLogic(_getLastWeekTransactions),
      ),
      _expenseList
    ];
  }

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    //This is the Logic which Check that in which orientation our device is
    final _isLandScape = mediaQuery.orientation == Orientation.landscape;
    final PreferredSizeWidget appBar = Platform.isAndroid
        ? CupertinoNavigationBar(
            backgroundColor: Colors.red,
            middle: Text('Home Expenses'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                GestureDetector(
                  child: Icon(CupertinoIcons.add),
                  onTap: () {
                    _showModelBottomSheet(context);
                  },
                ),
              ],
            ),
          )
        : AppBar(
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.add),
                // Here We are Getting user Input e.g title & Amount
                onPressed: () {
                  _showModelBottomSheet(context);
                },
              )
            ],
            title: Text(
              'Home Expenses',
            ),
            centerTitle: true,
          );

    //This is List of which is Stored In variable
    final _expenseList = Container(
      height: (mediaQuery.size.height -
              appBar.preferredSize.height -
              MediaQuery.of(context).padding.top) *
          0.70,
      child: UserGivenTransactionList(
        userProvidedTransaction: _userTransactions,
        delete: deleteItem,
      ),
    );
    final appFullBody = SafeArea(
        child: SingleChildScrollView(
      child: Column(
        children: <Widget>[
          //This is Switch to show one even ChartBars/List OF expenses

          //here we provide list to chart e.g week List
          //We have used that if Device is not in Landscape
          //then Both Things Chart logic and List of Expenses
          if (!_isLandScape)
            ..._isPortraitBuilder(mediaQuery, appBar, _expenseList),

          // we are Transfer the List of Transactions
          if (_isLandScape)
            ..._isLandScapeBuilder(mediaQuery, appBar, _expenseList),
        ],
      ),
    ));
    return Scaffold(
        // This is the Floating Action Button
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Platform.isIOS
            ? Container(
                child: Text('Hey I am Android Device'),
              )
            : FloatingActionButton(
                child: Icon(Icons.add),
                // Here We are Getting user Input e.g title & Amount
                onPressed: () {
                  _showModelBottomSheet(context);
                }),
        appBar: appBar,
        body: Platform.isAndroid
            ? CupertinoPageScaffold(child: appFullBody)
            : appFullBody);
  }
}
