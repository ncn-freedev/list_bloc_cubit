

import 'package:bloc/bloc.dart';
import 'package:list_bloc_cubit/core/list_itens_states.dart';
import 'package:list_bloc_cubit/data/item_dao.dart';

class ListItensCubit extends Cubit<ListItensStates>{
  
  final ItemDao bdconection;

  ListItensCubit(this.bdconection) : super(ListInitial());

  Future<void> loadItems() async {
    emit(ListLoading());
    try {
      final itens = await bdconection.findAll();
      emit(ListLoaded(itens));
    } catch (e) {
      emit(ListError('Erro ao carregar a lista.'));      
    }
  }

   Future<void> addItem(String item) async {
    try {
      await bdconection.insertItem(item);
      await loadItems(); 
    } catch (e) {
      emit(ListError('Erro ao adicionar item.'));
    }
  }

  Future<bool> itemExists(String name) async {
    try {
      return await bdconection.findItem(name);
    } catch (e) {
      emit(ListError('Erro ao verificar item.'));
      return false;
    }
  }

  Future<void> deleteItem(String name) async {
    try {
      await bdconection.delete(name);
      await loadItems(); 
    } catch (e) {
      emit(ListError('Erro ao deletar item.'));
    }
  }

}