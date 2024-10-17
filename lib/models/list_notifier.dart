import 'package:flutter/material.dart';
import 'package:list_bloc_cubit/data/item_dao.dart';


enum ListState { loading, loaded, error }

class ListNotifier extends ValueNotifier<List<String>> {
  final ItemDao itemDao = ItemDao();
  ListState _state = ListState.loaded;

  ListNotifier() : super([]);

  ListState get state => _state;

  Future<void> loadItems() async {
    _state = ListState.loading;
    notifyListeners(); // Notifica os ouvintes que o estado mudou

    try {
      value = await itemDao.findAll();
      _state = ListState.loaded;
    } catch (e) {
      _state = ListState.error;
    }

    notifyListeners(); // Notifica novamente para atualizar a UI
  }

  Future<void> addItem(String item) async {
    try {
      await itemDao.insertItem(item);
      await loadItems(); // Recarrega a lista após a adição
    } catch (e) {
      throw Exception('Erro ao adicionar item: $e');
    }
  }

  Future<bool> itemExists(String name) async {
    try {
      return await itemDao.findItem(name);
    } catch (e) {
      throw Exception('Erro ao verificar item: $e');
    }
  }

  Future<void> deleteItem(String name) async {
    try {
      await itemDao.delete(name);
      await loadItems(); // Recarrega a lista após a exclusão
    } catch (e) {
      throw Exception('Erro ao deletar item: $e');
    }
  }
}
