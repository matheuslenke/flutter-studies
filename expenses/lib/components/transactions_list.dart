import 'package:expenses/components/transaction_card.dart';
import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';

class TransactionList extends StatelessWidget {
  const TransactionList(
      {Key? key, required this.transactions, required this.deleteTransaction})
      : super(key: key);

  final List<Transaction> transactions;
  final void Function(String) deleteTransaction;

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? LayoutBuilder(builder: ((context, constraints) {
            return Column(
              children: [
                SizedBox(height: 20),
                Text(
                  'Nenhuma transação cadastrada!',
                  style: Theme.of(context).textTheme.headline3,
                ),
                SizedBox(height: 20),
                SizedBox(
                  height: constraints.maxHeight * 0.6,
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.cover,
                  ),
                )
              ],
            );
          }))
        : ListView.builder(
            itemCount: transactions.length,
            itemBuilder: (context, index) {
              final tr = transactions[index];
              return TransactionCard(
                  tr: tr, deleteTransaction: deleteTransaction);
            },
          );
  }
}
