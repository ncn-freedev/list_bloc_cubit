import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:list_bloc_cubit/modules/lista/cubits/list_itens_cubit.dart';
import 'package:list_bloc_cubit/modules/lista/cubits/list_itens_states.dart';
import 'package:list_bloc_cubit/modules/lista/screens/form_screen.dart';


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
          if (state.isloading!) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state.error != null) {
            return Center(
              child: Text(state.error!),
            );
          } else {
            return ListView.builder(
              itemCount: state.items.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(state.items[index]),
                  onTap: () {
                    context.read<ListItensCubit>().deleteItem(state.items[index]);
                  },
                );
              },
            );
          }
        }, 
          
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