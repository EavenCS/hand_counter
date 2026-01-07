import 'package:flutter/material.dart';

class EditCounter extends StatefulWidget {
  final String initialName;
  final int initialValue;

  const EditCounter({
    super.key,
    required this.initialName,
    required this.initialValue,
  });

  @override
  State<EditCounter> createState() => _EditCounterState();
}

class _EditCounterState extends State<EditCounter> {
  late final TextEditingController _nameController;
  late final TextEditingController _valueController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.initialName);
    _valueController = TextEditingController(
      text: widget.initialValue.toString(),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _valueController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Edit",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _valueController,
              decoration: const InputDecoration(
                labelText: 'Wert',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Speichern'),
            ),
          ],
        ),
      ),
    );
  }
}
