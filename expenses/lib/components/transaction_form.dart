import 'package:expenses/components/adaptative_button.dart';
import 'package:expenses/components/adaptative_date_picker.dart';
import 'package:expenses/components/adaptative_text_field.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionForm extends StatefulWidget {
  TransactionForm({Key? key, required this.onSubmit}) : super(key: key) {
    print("Constructor Transaction Form");
  }

  final void Function(String, double, DateTime) onSubmit;

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final _titleController = TextEditingController();
  final _valueController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  _TransactionFormState() {
    print("Constructor TransactionFormState");
  }

  @override
  void initState() {
    super.initState();
    print("InitState() _TransactionFormState");
  }

  @override
  void didUpdateWidget(TransactionForm oldWidget) {
    super.didUpdateWidget(oldWidget);
    print("didUpdateWidget() _TransactionFormState");
  }

  _submitForm() {
    final title = _titleController.text;
    final value = double.tryParse(_valueController.text) ?? 0.0;

    if (title.isEmpty || value <= 0) {
      AlertDialog(title: Text("Error"));
      return;
    }

    widget.onSubmit(title, value, _selectedDate);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Padding(
          padding: EdgeInsets.only(
            top: 10.0,
            right: 10,
            left: 10,
            bottom: 10 + MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
            children: [
              AdaptativeTextField(
                  label: "Título",
                  controller: _titleController,
                  keyboardType: TextInputType.name,
                  submit: _submitForm),
              AdaptativeTextField(
                label: "Valor (R\$)",
                controller: _valueController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                submit: _submitForm,
              ),
              AdaptativeDatePicker(
                  selectedDate: _selectedDate,
                  onDateChanged: (newDate) {
                    setState(() {
                      _selectedDate = newDate;
                    });
                  }),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  AdaptativeButton(
                      label: "Nova transação", onPressed: _submitForm),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
