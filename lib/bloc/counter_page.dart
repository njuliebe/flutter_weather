import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'counter_bloc.dart';
// import 'counter_event.dart';
// import 'counter_state.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CounterBloc(),
      child: MaterialApp(
        title: 'Flutter Bloc Example',
        home: CounterScreen(),
      ),
    );
  }
}

class CounterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final CounterBloc counterBloc = BlocProvider.of<CounterBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Bloc Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocBuilder<CounterBloc, CounterState>(
              builder: (context, state) {
                return Text(
                  'Count: ${state.count}',
                  style: TextStyle(fontSize: 24),
                );
              },
            ),
            BlocListener<CounterBloc, CounterState>(
              listener: (context, state) {
                print('Current State: ${state.count}');
              },
              child: Container(),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                counterBloc.add(IncrementEvent());
              },
              child: Text('Increment'),
            ),
            SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                counterBloc.add(DecrementEvent());
              },
              child: Text('Decrement'),
            ),
          ],
        ),
      ),
    );
  }
}
