import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class AdaptiveAddTransactionButton extends StatelessWidget {
  final Function submittedData;
  AdaptiveAddTransactionButton(this.submittedData);
  @override
  Widget build(BuildContext context) {
    print('Adaptive Button Called');
    return Platform.isAndroid
        ? Center(
            child: CupertinoButton(
              child: Text('Add Transaction'),
              color: Colors.red,
              onPressed: submittedData,
            ),
          )
        : FlatButton(
            color: Colors.purple,
            onPressed: submittedData,
            child:
                Text('Add Transaction', style: TextStyle(color: Colors.white)),
          );
  }
}
