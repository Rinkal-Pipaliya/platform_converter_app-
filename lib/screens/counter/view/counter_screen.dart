import 'package:contact_app/screens/counter/provider/counter_provider.dart';
import 'package:contact_app/utils/extension.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CounterScreen extends StatefulWidget {
  const CounterScreen({super.key});

  @override
  State<CounterScreen> createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Counter"),
      ),
      body: Column(
        children: [
          const Spacer(),
          Text(
            context.watch<CounterProvider>().i.toString(),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  FloatingActionButton(
                    onPressed: () {
                      context.read<CounterProvider>().increment();
                    },
                    child: const Text("+"),
                  ),
                  8.w,
                  FloatingActionButton(
                    onPressed: () {
                      context.read<CounterProvider>().decrement();
                    },
                    child: const Text("-"),
                  ),
                  8.w,
                  FloatingActionButton(
                    onPressed: () {
                      context.read<CounterProvider>().x2();
                    },
                    child: const Text("2x"),
                  ),
                  8.w,
                  FloatingActionButton(
                    onPressed: () {
                      context.read<CounterProvider>().x3();
                    },
                    child: const Text("3x"),
                  ),
                  8.w,
                  FloatingActionButton(
                    onPressed: () {
                      context.read<CounterProvider>().x4();
                    },
                    child: const Text("4x"),
                  ),
                  8.w,
                  FloatingActionButton(
                    onPressed: () {
                      context.read<CounterProvider>().reset();
                    },
                    child: const Text("Reset"),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
