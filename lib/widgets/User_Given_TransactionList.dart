import 'package:homeexpensesapp/models/Model_For_transaction_List.dart';
import 'package:flutter/material.dart';
import './TransactionItem.dart';

//List created  Manually
class UserGivenTransactionList extends StatelessWidget {
  final Function delete;
  final List<Transaction> userProvidedTransaction;

  UserGivenTransactionList({this.delete, this.userProvidedTransaction});

  Widget build(BuildContext context) {
    print('User Given Transaction Called');

    return userProvidedTransaction.isEmpty
        ? LayoutBuilder(
            builder: (context, constraints) {
              return Column(
                children: <Widget>[
                  Text(
                    'Nothing yet Added',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                      width: double.infinity,
                      height: constraints.maxHeight * 0.70,
                      child: Image.asset('images/waiting.png')),
                ],
              );
            },
          )
        : ListView(
            children: userProvidedTransaction
                .map((tx) => TransactionItem(
                      key: ValueKey(tx.id),
                      transactionItem: tx,
                      delete: delete,
                    ))
                .toList());
  }
}
