part of 'pizza_bloc.dart';

abstract class PizzaEvent extends Equatable {
  const PizzaEvent();

  @override
  List<Object> get props => [];
}

class LoadPizzaCounter extends PizzaEvent {}

class AddPizza extends PizzaEvent {
  final Pizza pizza;

  const AddPizza({required this.pizza});

  @override // used to compare the state of the bloc
  List<Object> get props => [pizza];
}

class RemovePizza extends PizzaEvent {
  final Pizza pizza;

  const RemovePizza({required this.pizza});

  @override
  List<Object> get props => [pizza];
}

class ClearPizza extends PizzaEvent {
  const ClearPizza();

  @override
  List<Object> get props => [];
}
