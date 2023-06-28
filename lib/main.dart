import 'dart:math';

import 'package:bloc_pizza_app/bloc/pizza_bloc.dart';
import 'package:bloc_pizza_app/models/pizza_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => PizzaBloc()..add(LoadPizzaCounter()),
        ),
      ],
      child: const MaterialApp(
        title: 'Flutter Demo',
        home: HomeScreen(),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Random random = Random();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pizza App'),
        centerTitle: true,
        backgroundColor: Colors.purple[900],
      ),
      body: Center(
        child: BlocBuilder<PizzaBloc, PizzaState>(
          builder: (context, state) {
            if (state is PizzaInitial) {
              return const CircularProgressIndicator(color: Colors.purple);
            }
            if (state is PizzaLoaded) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${state.pizzas.length}',
                    style: const TextStyle(
                        fontSize: 60, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: MediaQuery.of(context).size.height /
                        1.5, // 50% of screen
                    width: MediaQuery.of(context).size.width, // 100% of screen
                    child: Stack(
                      alignment: Alignment.center,
                      clipBehavior: Clip.none,
                      children: [
                        for (int i = 0; i < state.pizzas.length; i++)
                          Positioned(
                            left: random
                                .nextInt(
                                    MediaQuery.of(context).size.width.toInt())
                                .toDouble(),
                            top: random
                                .nextInt(
                                    MediaQuery.of(context).size.height.toInt())
                                .toDouble(),
                            child: SizedBox(
                                height: 150,
                                width: 150,
                                child: state.pizzas[i].image),
                          )
                      ],
                    ),
                  ),
                ],
              );
            } else {
              return const Text('Something went wrong');
            }
          },
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            backgroundColor: Colors.purple[900],
            child: const Icon(Icons.local_pizza_outlined),
            onPressed: () {
              context.read<PizzaBloc>().add(AddPizza(pizza: Pizza.pizzas[0]));
            },
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            backgroundColor: Colors.purple[900],
            child: const Icon(Icons.remove),
            onPressed: () {
              context
                  .read<PizzaBloc>()
                  .add(RemovePizza(pizza: Pizza.pizzas[0]));
            },
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            backgroundColor: Colors.purple[900],
            child: const Icon(Icons.local_pizza),
            onPressed: () {
              context.read<PizzaBloc>().add(AddPizza(pizza: Pizza.pizzas[1]));
            },
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            backgroundColor: Colors.purple[900],
            child: const Icon(Icons.remove),
            onPressed: () {
              context
                  .read<PizzaBloc>()
                  .add(RemovePizza(pizza: Pizza.pizzas[1]));
            },
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            backgroundColor: Colors.purple[900],
            child: const Icon(Icons.clear),
            onPressed: () {
              context.read<PizzaBloc>().add(const ClearPizza());
            },
          ),
        ],
      ),
    );
  }
}
