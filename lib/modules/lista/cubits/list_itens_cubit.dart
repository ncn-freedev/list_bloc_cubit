import 'package:bloc/bloc.dart';
import 'package:list_bloc_cubit/modules/lista/cubits/list_itens_states.dart';
import 'package:list_bloc_cubit/modules/lista/repository/item_dao.dart';
import 'package:dartz/dartz.dart';

class ListItensCubit extends Cubit<ListItensStates> {
  final ItemDao dataConnection;

  ListItensCubit(this.dataConnection) : super(ListItensStates.initial());

  Future<void> loadItems() async {
    
    Either<String, List<String>> result = Right(await dataConnection.getAll());
    result.fold(
        (l) =>
            emit(state.copyWith(error: "Não foi possível carregar os itens.")),
        (r) => emit(state.copyWith(items: r, isloading: false)));
  }

  Future<void> addItem(String item) async {
    Either<String, bool> result = Right(await dataConnection.insertItem(item));
    result.fold(
        (l) =>
            emit(state.copyWith(error: "Não foi possível adicionar o item.")),
        (r) => loadItems());
  }

  Future<bool> itemExists(String name) async {
    Either<String, bool> result = Right(await dataConnection.findItem(name));
    return result.fold((l) => false, (r) => r);
  }

  Future<void> deleteItem(String name) async {
    Either<String, bool> result = Right(await dataConnection.delete(name));
    result.fold(
        (l) => emit(state.copyWith(error: "Não foi possível deletar o item.")),
        (r) => loadItems());
  }
}
