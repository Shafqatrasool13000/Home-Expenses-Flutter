import 'package:homeexpensesapp/chartBar.dart';
import 'package:homeexpensesapp/models/Model_For_transaction_List.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'models/Model_For_transaction_List.dart';

class ChartLogic extends StatelessWidget {
  final List<Transaction> userCreatedList;
  ChartLogic(this.userCreatedList);
  List<Map<String, Object>> get _userTransactions {
    return List.generate(7, (index) {
      final weekday = DateTime.now().subtract(
        Duration(days: index),
      );
      var totalSum = 0.0;
      for (var i = 0; i < userCreatedList.length; i++) {
        if (userCreatedList[i].date.day == weekday.day &&
            userCreatedList[i].date.month == weekday.month &&
            userCreatedList[i].date.year == weekday.year) {
          totalSum += userCreatedList[i].amount;
        }
      }
      return {'day': DateFormat.E().format(weekday), 'amount': totalSum};
    }).reversed.toList();
  }

  double get totalSpending {
    return _userTransactions.fold(0.0, (sum, item) {
      return sum + item['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    print('Adaptive Field Called');
    return Padding(
      padding: EdgeInsets.all(10),
      child: Card(
        margin: EdgeInsets.all(10),
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: _userTransactions.map((e) {
              return Flexible(
                fit: FlexFit.tight,
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: ChartBarLogic(
                      e['amount'],
                      e['day'],
                      totalSpending == 0.0
                          ? 0.0
                          : (e['amount'] as double) / totalSpending),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
