import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

ValueNotifier valueNotifier = ValueNotifier(0);

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              width: double.infinity,
            ),
            ValueListenableBuilder(
              valueListenable: valueNotifier,
              builder: (context, value, child) {
                return Text(
                  '$value',
                  style: const TextStyle(
                    fontSize: 25,
                  ),
                );
              },
            ),
            ElevatedButton(
              onPressed: (() {
                valueNotifier.value++;
              }),
              child: const Text('Add'),
            ),
          ],
        ),
      ),
    );
  }
}
