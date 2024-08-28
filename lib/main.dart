import 'dart:math';

import 'package:flutter/material.dart';

import 'picker_editing_controller.dart';
import 'picker_text_form_field.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final list = [
    Country(id: 'MY', name: 'Malaysia'),
    Country(id: 'ID', name: 'Indonesia'),
    Country(id: 'PH', name: 'Philippines'),
  ];

  final _controller = CountryEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextFormField(),
            const SizedBox(height: 8),
            PickerTextFieldForm<Country>(
              initialValue: list.first,
              stringFormatter: (country) => country?.name ?? '',
              onTap: (_) async {
                var rng = Random();
                return list[rng.nextInt(3)];
              },
            ),
            const SizedBox(height: 8),
            PickerTextFieldForm<Country>(
              controller: _controller,
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () => _controller.setData(list[0]),
              child: Text(list[0].name),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () => _controller.setData(list[1]),
              child: Text(list[1].name),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () => _controller.setData(list[2]),
              child: Text(list[2].name),
            ),
          ],
        ),
      ),
    );
  }
}

class CountryEditingController extends PickerEditingController<Country> {
  CountryEditingController({
    super.data,
  }) : super(stringFormatter: (country) => country?.name ?? '');
}

class Country {
  final String name;
  final String id;

  Country({required this.name, required this.id});
}
