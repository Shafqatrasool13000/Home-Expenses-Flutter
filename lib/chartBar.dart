import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChartBarLogic extends StatelessWidget {
  final double amount;
  final String label;
  final double percentage;
  ChartBarLogic(this.amount, this.label, this.percentage);
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          children: <Widget>[
            //This is Amount on Chart Bars
            Container(
                height: constraints.maxHeight * 0.15,
                child:
                    FittedBox(child: Text("\$${amount.toStringAsFixed(0)}"))),
            SizedBox(
              height: constraints.maxHeight * 0.05,
            ),
            Container(
              height: constraints.maxHeight * 0.6,
              width: 10,
              child: Stack(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(220, 220, 220, 1),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.purple,
                        width: 1,
                      ),
                    ),
                  ),
                  FractionallySizedBox(
                    heightFactor: percentage,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: constraints.maxHeight * 0.05,
            ),
            Container(
              height: constraints.maxHeight * 0.15,
              child: FittedBox(
                child: Text(label),
              ),
            ),
          ],
        );
      },
    );
  }
}
