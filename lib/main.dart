import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:money_calculator_app/Widgets/chart.dart';
import 'package:money_calculator_app/Widgets/transaction_list.dart';

import 'package:money_calculator_app/model/transaction.dart';

import 'Widgets/new_transaction.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations(
  //     [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'Quicksand',
        textTheme: const TextTheme(
          subtitle1: TextStyle(
            color: Colors.blue,
            fontFamily: 'OpenSans',
            fontSize: 18,
          ),
        ),
        appBarTheme: AppBarTheme(
          titleTextStyle: Theme.of(context).textTheme.headline6!.copyWith(
                color: Colors.white,
                fontFamily: 'OpenSans',
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
        ),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _usertransactions = [];

  bool _showChart = false;

  List<Transaction>? get _recentTransaction {
    return _usertransactions.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          const Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _addNewTransaction(
      String txtitle, double txamount, DateTime chosenDate) {
    final txnew = Transaction(
      id: DateTime.now().toString(),
      title: txtitle,
      amount: txamount,
      date: chosenDate,
    );

    setState(() {
      _usertransactions.add(txnew);
    });
  }

  void _startaddnewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return NewTransaction(
            addtx: _addNewTransaction,
          );
        });
  }

  void _deleteTran(String id) {
    setState(() {
      _usertransactions.removeWhere((tx) => tx.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final islandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    final appBar = AppBar(
      title: const Text('flutter app'),
    );
    final txlistwidget = SizedBox(
        height: (MediaQuery.of(context).size.height -
                MediaQuery.of(context).padding.top) *
            0.67,
        child: TransactionList(_usertransactions, _deleteTran));
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          children: [
            if (islandscape)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Show Chart'),
                  Switch.adaptive(
                      value: _showChart,
                      onChanged: (val) {
                        setState(() => _showChart = val);
                      }),
                ],
              ),
            if (islandscape)
              _showChart
                  ? SizedBox(
                      height: (MediaQuery.of(context).size.height -
                              MediaQuery.of(context).padding.top) *
                          .7,
                      child: chart(_recentTransaction!),
                    )
                  : txlistwidget,
            if (!islandscape)
              SizedBox(
                height: (MediaQuery.of(context).size.height -
                        MediaQuery.of(context).padding.top) *
                    .3,
                child: chart(_recentTransaction!),
              ),
            if (!islandscape) txlistwidget,
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => _startaddnewTransaction(context),
      ),
    );
  }
}
