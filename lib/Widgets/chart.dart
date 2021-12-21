import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money_calculator_app/Widgets/chart_bar.dart';
import 'package:money_calculator_app/model/transaction.dart';

class chart extends StatelessWidget {
  final List<Transaction> recentTransaction;
  chart(this.recentTransaction);

  List<Map<String, Object>> get groupedtransactionvalues {
    return List.generate(7, (index) {
      final weekday = DateTime.now().subtract(
        Duration(days: index),
      );
      var totalSum = 0.0;

      for (var i = 0; i < recentTransaction.length; i++) {
        if (recentTransaction[i].date.day == weekday.day &&
            recentTransaction[i].date.month == weekday.month &&
            recentTransaction[i].date.year == weekday.year) {
          totalSum += recentTransaction[i].amount;
        }
      }
      // print(DateFormat.E().format(weekday));
      // print(totalSum);

      return {
        'DAY': DateFormat.E().format(weekday).substring(0, 2),
        'amount': totalSum
      };
    }).reversed.toList();
  }

  double get totalspending {
    return groupedtransactionvalues.fold(0.0, (sum, item) {
      // print(sum + (item['amount'] as num));
      return sum + (item['amount'] as num);
    });
  }

  @override
  Widget build(BuildContext context) {
    // print(groupedtransactionvalues);
    return Card(
      elevation: 6,
      margin: const EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedtransactionvalues.map((data) {
            print((data['amount'] as double));
            print(totalspending);
            print((data['amount'] as double) / totalspending);
            return Flexible(
              fit: FlexFit.tight,
              child: chartbar(
                  data['DAY'].toString(),
                  data['amount'] as double,
                  totalspending == 0.0
                      ? 0.0
                      : (data['amount'] as double) / totalspending),
            );
          }).toList(),
        ),
      ),
    );
  }
}
