import 'package:flutter/material.dart';

class chartbar extends StatelessWidget {
  final String label;
  final double Spendingamount;
  final double spendingpctoftotal;

  chartbar(this.label, this.Spendingamount, this.spendingpctoftotal);
  
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx, constraint) {
      return Column(
        children: [
          SizedBox(
            height: constraint.maxHeight * .17,
            child: FittedBox(
              child: Text(label),
            ),
          ),
          SizedBox(
            height: constraint.maxHeight * .06,
          ),
          SizedBox(
            height: constraint.maxHeight * .59,
            width: 10,
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1.0),
                    color: const Color.fromRGBO(220, 220, 220, 1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                FractionallySizedBox(
                  heightFactor: spendingpctoftotal,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.purple,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: constraint.maxHeight * .05,
          ),
          SizedBox(
            height: constraint.maxHeight * .12,
            child: FittedBox(
              child: Text('\$${Spendingamount.toStringAsFixed(0)}'),
            ),
          ),
        ],
      );
    });
  }
}
