import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../models/pizza_model.dart';

part 'pizza_event.dart';
part 'pizza_state.dart';

class PizzaBloc extends Bloc<PizzaEvent, PizzaState> {
  PizzaBloc() : super(PizzaInitial()) {
    // the 3 events that the bloc will handle
    on<LoadPizzaCounter>((event, emit) async {
      await Future<void>.delayed(
          const Duration(seconds: 1)); // simulate a delay
      emit(const PizzaLoaded(pizzas: <Pizza>[])); // init a new state
    });

    on<AddPizza>((event, emit) {
      if (state is PizzaLoaded) {
        final state = this.state as PizzaLoaded;
        // create a new state, with the new pizza added to the list
        emit(
          PizzaLoaded(
            pizzas: List<Pizza>.from(state.pizzas)..add(event.pizza),
          ),
        );
      }
    });
    on<RemovePizza>((event, emit) {
      if (state is PizzaLoaded) {
        final state = this.state as PizzaLoaded;
        emit(
          PizzaLoaded(
            pizzas: List<Pizza>.from(state.pizzas)..remove(event.pizza),
          ),
        );
      }
    });
    on<ClearPizza>((event, emit) {
      if (state is PizzaLoaded) {
        emit(const PizzaLoaded(pizzas: <Pizza>[]));
      }
    });
  }
}
