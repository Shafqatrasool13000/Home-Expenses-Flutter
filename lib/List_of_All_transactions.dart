import 'package:homeexpensesapp/adaptiveaddtransactionbutton.dart';
import 'dart:io';
import 'adaptive_date_ios_android.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import './adaptive_date_ios_android.dart';
import 'package:intl/intl.dart';

import './AdativeTextFields.dart';

// get User Input Class for Transactions
class ListOfAllTransactions extends StatefulWidget {
  final Function userInput;

  ListOfAllTransactions({this.userInput}) {
    print("Constructor Called");
  }

  @override
  _ListOfAllTransactionsState createState() {
    print('Create State Called');
    return _ListOfAllTransactionsState();
  }
}

class _ListOfAllTransactionsState extends State<ListOfAllTransactions> {
  _ListOfAllTransactionsState() {
    print('State Called');
  }

  DateTime selectedDate = DateTime.now();
  final _titleController = TextEditingController();

  final _amountController = TextEditingController();

  void _submittedData() {
    if (_amountController.text.isEmpty) {
      return;
    }
    final _titleInput = _titleController.text;
    final _amountInput = double.parse(_amountController.text);

    if (_titleInput.isEmpty || _amountInput <= 0 || selectedDate == null) {
      return;
    }

    widget.userInput(_titleInput, _amountInput, selectedDate);
    Navigator.of(context).pop();
  }

  @override
  void initState() {
    print('init Sate()');
    super.initState();
  }

  @override
  void didUpdateWidget(ListOfAllTransactions oldWidget) {
    print('did update ()');
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    print('dispose()');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('Build Called');
    return SingleChildScrollView(
      child: Card(
        elevation: 5.0,
        child: Container(
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              AdaptiveTextFields(
                titleController: _titleController,
                amountController: _amountController,
                submittedData: _submittedData,
              ),
              Row(
                children: <Widget>[
                  Platform.isAndroid
                      ? Container()
                      : Expanded(
                          child: selectedDate == null
                              ? Text(
                                  'Date not selected yet',
                                  style: Theme.of(context).textTheme.headline6,
                                )
                              : Text(
                                  '${DateFormat.yMMMMd().format(selectedDate)}'),
                        ),
                  //Here We Check Date for Android And Ios
                  AdaptiveDate(selectedDate),
                ],
              ),
              AdaptiveAddTransactionButton(_submittedData),
            ],
          ),
        ),
      ),
    );
  }
}
