import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:list_bloc_cubit/core/list_itens_cubit.dart';
import 'package:list_bloc_cubit/core/list_itens_states.dart';
import 'package:list_bloc_cubit/screens/form_screen.dart';


class InitialScreen extends StatelessWidget {
  

  const InitialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista'),
      ),
      body: BlocBuilder<ListItensCubit, ListItensStates>(
        builder: (context, state) {
          if (state is ListLoading){
            return const Center(child: CircularProgressIndicator(),);
          } else if (state is ListError){
            return Center(child: Text(state.message));
          }else if (state is ListLoaded){
            return state.items.isEmpty ?
            const Center(child: Text('Lista vazia')) : 
            ListView.builder(
              itemCount: state.items.length,
              itemBuilder: (context, index){
                return ListTile(
                  title: Text(state.items[index]),
                );
              });
          }else{
            return Container();
          }
        }
          
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => FormScreen(),
            ),
          );
        },
        child: const Icon(Icons.menu),
      ),
    );
  }
}