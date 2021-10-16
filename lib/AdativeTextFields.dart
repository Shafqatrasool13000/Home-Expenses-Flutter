import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class AdaptiveTextFields extends StatelessWidget {
  final TextEditingController titleController;
  final TextEditingController amountController;
  final Function submittedData;
  AdaptiveTextFields(
      {this.amountController, this.submittedData, this.titleController});

  @override
  Widget build(BuildContext context) {
    print('Adaptive Field Called');
    return Column(
      children: <Widget>[
        Platform.isAndroid
            ? CupertinoTextField(
                onSubmitted: (val) => submittedData,
                controller: titleController,
                placeholder: 'Title',
                decoration: BoxDecoration(color: Colors.red),
              )
            : TextField(
                onSubmitted: (val) => submittedData,
                controller: titleController,
                decoration: InputDecoration(labelText: 'Title'),
              ),
        Platform.isAndroid
            ? CupertinoTextField(
                keyboardType: TextInputType.number,
                controller: amountController,
                placeholder: 'Amount',
                decoration: BoxDecoration(color: Colors.yellow),
                onSubmitted: (_) => submittedData(),
              )
            : TextField(
                keyboardType: TextInputType.number,
                controller: amountController,
                decoration: InputDecoration(labelText: 'Amount'),
                onSubmitted: (_) => submittedData(),
              ),
      ],
    );
  }
}
