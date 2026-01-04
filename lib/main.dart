import 'package:flutter/material.dart';
import 'config/theme/appbar.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hand Counter',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<String> _items = [];
  final List<int> _counters = [];

  void _addItem() async {
    final controller = TextEditingController();
    final name = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Neues Item hinzufügen'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(hintText: 'Name eingeben'),
          autofocus: true,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Abbrechen'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, controller.text),
            child: const Text('Hinzufügen'),
          ),
        ],
      ),
    );
    if (name != null && name.isNotEmpty) {
      setState(() {
        _items.add(name);
        _counters.add(0);
      });
    }
  }

  void _showSnack(String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(
        context,
        onAdd: _addItem,
        onFilter: () => _showSnack('Filter gedrückt'),
        onSettings: () => _showSnack('Settings gedrückt'),
      ),

      body: ListView.builder(
        itemCount: _items.length,
        itemBuilder: (context, index) {
          // Synchronisiere Counter-Liste falls nötig
          while (_counters.length <= index) {
            _counters.add(0);
          }
          return ListTile(
            title: Text(_items[index]),
            trailing: Text(
              '${_counters[index]}',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            onTap: () {
              setState(() => _counters[index]++);
            },
            onLongPress: () => _showSnack("longpress"),
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: _addItem,
        tooltip: 'Add',
        child: const Icon(Icons.add),
      ),
    );
  }
}
