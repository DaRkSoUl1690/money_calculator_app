// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:money_calculator_app/model/transaction.dart';

class TransactionList extends StatelessWidget {
  List<Transaction> transactions;
  final Function delte_tran;
  TransactionList(this.transactions, this.delte_tran, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx, Constraints) {
      return Container(
        child: transactions.isEmpty
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Image.asset(
                    'assets/images/waiting.png',
                    width: Constraints.maxWidth * .6,
                    height: Constraints.maxHeight * .6,
                  ),
                ],
              )
            : ListView.builder(
                itemCount: transactions.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 5,
                    margin:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 30,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: FittedBox(
                            child: Text('\$${transactions[index].amount}'),
                          ),
                        ),
                      ),
                      title: Text(
                        transactions[index].title,
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                      subtitle: Text(
                        DateFormat.yMMMd().format(transactions[index].date),
                      ),
                      trailing: MediaQuery.of(context).size.width > 1000
                          ? IconButton(
                              onPressed: () =>
                                  delte_tran(transactions[index].id),
                              icon: const Icon(Icons.delete),
                              color: Colors.purple[300],
                            )
                          : FlatButton.icon(
                              onPressed: () =>
                                  delte_tran(transactions[index].id),
                              icon: const Icon(Icons.delete),
                              label: const Text('delete'),
                            ),
                    ),
                  );
                }),
      );
    });
  }
}
