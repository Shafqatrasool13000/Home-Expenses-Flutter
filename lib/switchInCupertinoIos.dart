import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SwitchInCupertinoIosPractice extends StatefulWidget {
  @override
  _SwitchInCupertinoIosPracticeState createState() =>
      _SwitchInCupertinoIosPracticeState();
}

class _SwitchInCupertinoIosPracticeState
    extends State<SwitchInCupertinoIosPractice> {
  DateTime _dateTime = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Hello'),
      ),
      child: Center(
        child: SizedBox(
          height: 100,
          child: CupertinoDatePicker(
              initialDateTime: _dateTime,
              onDateTimeChanged: (newDate) {
                _dateTime = newDate;
              }),
        ),
      ),
    );
  }
}
