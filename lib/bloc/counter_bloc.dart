import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

part 'counter_event.dart';
part 'counter_state.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(const InitialState(0)) {
    on<CounterEvent>((event, emit) {
      // TODO: implement event handler
      if (event is IncrementEvent) {
        emit(UpdatedState(state.count + 1));
      } else if (event is DecrementEvent) {
        emit(UpdatedState(state.count - 1));
      }
    });
  }
}
