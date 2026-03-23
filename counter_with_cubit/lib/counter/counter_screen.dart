import 'package:counter_with_cubit/bloc/counter_bloc.dart';
import 'package:counter_with_cubit/bloc/counter_event.dart';
import 'package:counter_with_cubit/bloc/counter_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterScreen extends StatelessWidget {
  const CounterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.menu),
        title: const Text('Counter Screen'),
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.menu))],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BlocConsumer<CounterBloc, CounterState>(
            listener: (context, state) {
              if (state is CounterUpdatedState && state.isIncrement) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    backgroundColor: Colors.green,
                    content: Text('Increment'),
                    duration: Duration(milliseconds: 300),
                  ),
                );
              } else if (state is CounterUpdatedState && !state.isIncrement) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Decrement'),
                    duration: Duration(milliseconds: 300),
                  ),
                );
              }
            },
            builder: (context, state) {
              if (state is CounterUpdatedState ||
                  state is CounterInitialState) {
                return Text(
                  state.counter.toString(),
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                  ),
                );
              } else {
                return const CircularProgressIndicator();
              }
            },
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                style: IconButton.styleFrom(backgroundColor: Colors.black),
                onPressed: () {
                  context.read<CounterBloc>().add(DecrementEvent());
                },
                icon: const Icon(Icons.remove, color: Colors.white),
              ),
              IconButton(
                style: IconButton.styleFrom(backgroundColor: Colors.black),
                onPressed: () {
                  context.read<CounterBloc>().add(IncrementEvent());
                },
                icon: const Icon(Icons.add, color: Colors.white),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
