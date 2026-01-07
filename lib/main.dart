import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'config/theme/appbar.dart';
import 'pages/edit_counter.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

void main() {
  // debugPaintSizeEnabled = false;
  //debugPaintBaselinesEnabled = false;

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hand Counter',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 143, 25, 25),
        ),
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
        title: const Text('Neuer Zähler'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(hintText: 'Zählername'),
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
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        itemCount: _items.length,
        itemBuilder: (context, index) {
          while (_counters.length <= index) {
            _counters.add(0);
          }

          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Material(
              color: Colors.green,
              borderRadius: BorderRadius.circular(14),
              clipBehavior: Clip.antiAlias,
              child: ListTile(
                title: Text(
                  _items[index],
                  style: const TextStyle(color: Colors.white),
                ),
                trailing: Text(
                  '${_counters[index]}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () => setState(() => _counters[index]++),
                onLongPress: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditCounter(
                      initialName: _items[index],
                      initialValue: _counters[index],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: _addItem,
        tooltip: 'Add',
        child: const Icon(CupertinoIcons.add_circled_solid),
      ),
    );
  }
}
