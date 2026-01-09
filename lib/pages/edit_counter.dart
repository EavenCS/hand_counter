import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

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
  Color? _selectedColor;

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
        actions: [
          IconButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Löschen gedrückt'),
                  duration: Duration(seconds: 2),
                ),
              );
            },
            icon: const Icon(CupertinoIcons.trash),
          ),
        ],
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
            Container(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      final screenWidth = MediaQuery.of(context).size.width;
                      final columnWidth = (screenWidth - 64) / 5;
                      final effectiveWidth =
                          (columnWidth > 120 ? columnWidth : 80.0) / 2;

                      return Row(
                        children: [
                          _buildColumnButton(
                            effectiveWidth,
                            Colors.blue,
                            _selectedColor == Colors.blue,
                          ),
                          _buildColumnButton(
                            effectiveWidth,
                            Colors.green,
                            _selectedColor == Colors.green,
                          ),
                          _buildColumnButton(
                            effectiveWidth,
                            Colors.orange,
                            _selectedColor == Colors.orange,
                          ),
                          _buildColumnButton(
                            effectiveWidth,
                            Colors.purple,
                            _selectedColor == Colors.purple,
                          ),
                          _buildColumnButton(
                            effectiveWidth,
                            Colors.red,
                            _selectedColor == Colors.red,
                          ),
                          _buildColumnButton(
                            effectiveWidth,
                            Colors.yellow,
                            _selectedColor == Colors.yellow,
                          ),
                          _buildColumnButton(
                            effectiveWidth,
                            Colors.pink,
                            _selectedColor == Colors.pink,
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),

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

  Widget _buildColumnButton(double width, Color color, bool isSelected) {
    return Container(
      width: width,
      height: width,
      margin: const EdgeInsets.symmetric(horizontal: 3),
      child: OutlinedButton(
        onPressed: () {
          setState(() {
            _selectedColor = color;
          });
        },
        style: OutlinedButton.styleFrom(
          backgroundColor: color,
          padding: EdgeInsets.zero,
          side: BorderSide(color: isSelected ? Colors.white : color),
          shape: const CircleBorder(),
        ),
        child: isSelected
            ? const Icon(CupertinoIcons.check_mark, color: Colors.white, size: 20)
            : const SizedBox(),
      ),
    );
  }
}
