import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionCard extends StatelessWidget {
  const TransactionCard({
    Key? key,
    required this.tr,
    required this.deleteTransaction,
  }) : super(key: key);

  final Transaction tr;
  final void Function(String p1) deleteTransaction;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: FittedBox(
              child: Text('R\$${tr.value}'),
            ),
          ),
        ),
        title: Text(tr.title, style: Theme.of(context).textTheme.headline3),
        subtitle: Text(
          DateFormat('d MMM y').format(tr.date),
        ),
        trailing: MediaQuery.of(context).size.width > 480
            ? ElevatedButton.icon(
                onPressed: () => deleteTransaction(tr.id),
                icon: Icon(Icons.delete),
                style: ElevatedButton.styleFrom(
                  primary: Theme.of(context).errorColor,
                ),
                label: Text(
                  "Excluir",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              )
            : IconButton(
                icon: Icon(Icons.delete),
                color: Theme.of(context).errorColor,
                onPressed: () => deleteTransaction(tr.id),
              ),
      ),
    );
  }
}
