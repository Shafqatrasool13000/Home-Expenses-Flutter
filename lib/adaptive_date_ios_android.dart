import 'package:flutter/cupertino.dart';
import 'dart:io';
import 'package:flutter/material.dart';

class AdaptiveDate extends StatefulWidget {
  DateTime dateTime;
  AdaptiveDate(this.dateTime);

  @override
  _AdaptiveDateState createState() => _AdaptiveDateState();
}

class _AdaptiveDateState extends State<AdaptiveDate> {
  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? Expanded(
            child: SizedBox(
              height: MediaQuery.of(context).size.width,
              width: MediaQuery.of(context).size.width,
              child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.time,
                  initialDateTime: widget.dateTime,
                  onDateTimeChanged: (newDate) {
                    widget.dateTime = newDate;
                  }),
            ),
          )
        : FlatButton(
            color: Theme.of(context).primaryColor,
            onPressed: () {
              showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2020),
                      lastDate: DateTime.now())
                  .then(
                (value) {
                  setState(
                    () {
                      widget.dateTime = value;
                    },
                  );
                },
              );
            },
            child: Text('Select your Date'),
          );
  }
}
