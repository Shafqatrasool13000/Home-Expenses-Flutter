import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/Model_For_transaction_List.dart';

class TransactionItem extends StatefulWidget {
  const TransactionItem({
    Key key,
    @required this.transactionItem,
    @required this.delete,
  }) : super(key: key);

  final Transaction transactionItem;
  final Function delete;

  @override
  _TransactionItemState createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {
  Color _bgColor;
  @override
  void initState() {
    super.initState();
    const colours = [
      Colors.red,
      Colors.black,
      Colors.orange,
    ];
    _bgColor = colours[Random().nextInt(3)];
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          backgroundColor: _bgColor,
          child: Padding(
            padding: EdgeInsets.all(7),
            child: FittedBox(
              child: Text(
                '\$${widget.transactionItem.amount}',
              ),
            ),
          ),
        ),
        title: Text('${widget.transactionItem.title}'),
        subtitle:
            Text('${DateFormat.yMMMMd().format(widget.transactionItem.date)}'),
        trailing: MediaQuery.of(context).size.width > 440
            ? FlatButton.icon(
                onPressed: () {},
                icon: Icon(Icons.delete),
                textColor: Colors.red,
                label: Text('Delete'))
            : IconButton(
                icon: Icon(
                  Icons.delete,
                ),
                onPressed: () {
                  widget.delete(widget.transactionItem.id);
                }),
      ),
    );
  }
}
