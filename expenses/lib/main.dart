import 'dart:math';
import 'dart:io';

import 'package:expenses/components/chart.dart';
import 'package:expenses/components/transaction_form.dart';
import 'package:expenses/components/transactions_list.dart';
import 'package:expenses/models/transaction.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

main() => runApp(const ExpensesApp());

class ExpensesApp extends StatelessWidget {
  const ExpensesApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
      theme: ThemeData(
        textTheme: ThemeData.light().textTheme.copyWith(
              headline3: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              button: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
        fontFamily: 'Quicksand',
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.purple)
            .copyWith(secondary: Colors.amber),
        appBarTheme: AppBarTheme(
          toolbarTextStyle: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  final List<Transaction> _transactions = [];
  bool _showChart = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print(state);
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance!.removeObserver(this);
  }

  List<Transaction> get _recentTransactions {
    return _transactions.where((tr) {
      return tr.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  _openTransactionFormModal(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return TransactionForm(onSubmit: _addTransaction);
        });
  }

  _addTransaction(String title, double value, DateTime date) {
    final newTransaction = Transaction(
      id: Random().nextDouble().toString(),
      title: title,
      value: value,
      date: date,
    );

    setState(() {
      _transactions.add(newTransaction);
    });

    Navigator.of(context).pop();
  }

  _deleteTransaction(String id) {
    setState(() {
      _transactions.removeWhere((element) => element.id == id);
    });
  }

  Widget _getIconButton(IconData icon, Function() fn) {
    return Container(
      width: 50,
      child: Platform.isIOS
          ? GestureDetector(onTap: fn, child: Icon(icon))
          : IconButton(
              icon: Icon(icon),
              onPressed: fn,
            ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft
    ]);

    final mediaQuery = MediaQuery.of(context);
    bool isLandscape = mediaQuery.orientation == Orientation.landscape;
    final iconList = Platform.isIOS ? CupertinoIcons.square_list : Icons.list;
    final iconChart =
        Platform.isIOS ? CupertinoIcons.chart_bar : Icons.show_chart;

    final actions = [
      if (isLandscape)
        Container(
            width: 50,
            child: _getIconButton(_showChart ? iconList : iconChart, () {
              setState(() {
                _showChart = !_showChart;
              });
            })),
      Container(
        child: _getIconButton(
          Platform.isIOS ? CupertinoIcons.add : Icons.add,
          () => _openTransactionFormModal(context),
        ),
      )
    ];

    final availableHeight = mediaQuery.size.height -
        AppBar().preferredSize.height -
        mediaQuery.padding.top;

    final bodyPage = SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (_showChart || !isLandscape)
              Container(
                height: availableHeight * (isLandscape ? 0.7 : 0.3),
                child: ChartWidget(recentTransactions: _recentTransactions),
              ),
            if (!_showChart || !isLandscape)
              Container(
                height: availableHeight * (isLandscape ? 1 : 0.7),
                child: TransactionList(
                    transactions: _transactions,
                    deleteTransaction: _deleteTransaction),
              ),
          ],
        ),
      ),
    );

    return Platform.isIOS
        ? CupertinoPageScaffold(
            navigationBar: CupertinoNavigationBar(
              middle: Text("Despesas pessoais"),
              trailing: Container(
                width: 100,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: actions,
                ),
              ),
            ),
            child: bodyPage)
        : Scaffold(
            appBar: AppBar(
              title: Text("Despesas Pessoais",
                  style: TextStyle(
                    fontSize: 20 * mediaQuery.textScaleFactor,
                  )),
              actions: actions,
            ),
            body: Padding(
                padding: EdgeInsets.symmetric(vertical: 10), child: bodyPage),
            floatingActionButton: Platform.isIOS
                ? Container()
                : FloatingActionButton(
                    child: Icon(Icons.add),
                    onPressed: () => _openTransactionFormModal(context),
                  ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
          );
  }
}
