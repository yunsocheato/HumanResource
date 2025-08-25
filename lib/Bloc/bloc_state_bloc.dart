import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'bloc_state_event.dart';
part 'bloc_state_state.dart';

class StateBloc extends Bloc<StateEvent, StateState> {
  StateBloc() : super(StateInitial()) {
    on<StateEvent>((event, emit) {
    });
  }
}
