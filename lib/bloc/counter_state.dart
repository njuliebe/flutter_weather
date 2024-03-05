part of 'counter_bloc.dart';

@immutable
sealed class CounterState extends Equatable {
  final int count;

  const CounterState(this.count);

  @override
  List<Object> get props => [count];
}

final class InitialState extends CounterState {
  const InitialState(int count) : super(count);
}

class UpdatedState extends CounterState {
  const UpdatedState(int count) : super(count);
}
