import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addtx;
  const NewTransaction({
    Key? key,
    required this.addtx,
  }) : super(key: key);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();

  DateTime? _selectedDate;

  void _submitdata() {
    final enteredtitle = _titleController.text;
    final enteredamount = double.parse(_amountController.text);

    if (enteredtitle.isEmpty || enteredamount <= 0 || _selectedDate == null) {
      return;
    }

    widget.addtx(enteredtitle, enteredamount, _selectedDate);

    Navigator.of(context).pop();
  }

  void _presentdatepicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2021),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        child: Container(
          padding: EdgeInsets.only(
              top: 10,
              left: 10,
              right: 10,
              bottom: MediaQuery.of(context).viewInsets.bottom + 10),
          child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
          
            TextField(
              decoration: const InputDecoration(labelText: 'Title'),
              controller: _titleController,
              onSubmitted: (_) => _submitdata(),
            ),
          
            TextField(
              decoration: const InputDecoration(labelText: 'Amount'),
              controller: _amountController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => _submitdata(),
            ),
         
            SizedBox(
              height: 70,
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      _selectedDate == null
                          ? 'No Date Chosen'
                          : 'Picked date : ${DateFormat.yMd().format(_selectedDate!)}',
                    ),
                  ),
                  // ignore: deprecated_member_use
                  FlatButton(
                    textColor: Colors.purple,
                    child: const Text(
                      'choose date',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    onPressed: _presentdatepicker,
                  )
                ],
              ),
            ),
            // ignore: deprecated_member_use
            RaisedButton(
              onPressed: _submitdata,
              child: const Text(
                'Add Transaction',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              textColor: Colors.white,
              color: Colors.purple,
            ),
          ]),
        ),
      ),
    );
  }
}
