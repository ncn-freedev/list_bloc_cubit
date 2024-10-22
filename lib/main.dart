import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:list_bloc_cubit/modules/lista/cubits/list_itens_cubit.dart';
import 'package:list_bloc_cubit/modules/lista/repository/item_dao.dart';
import 'package:list_bloc_cubit/modules/lista/screens/initial_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ListItensCubit(ItemDao())..loadItems(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Lista App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const InitialScreen(),
      ),
    );
  }
}
