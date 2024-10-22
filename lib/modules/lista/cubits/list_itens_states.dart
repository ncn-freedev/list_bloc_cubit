import 'package:equatable/equatable.dart';

class ListItensStates extends Equatable {
  const ListItensStates({required this.items, this.isloading, this.error});

  final List<String> items;
  final bool? isloading;
  final String? error;

  factory ListItensStates.initial() =>
      const ListItensStates(items: [], isloading: true);

  ListItensStates copyWith(
      {List<String>? items, bool? isloading, String? error, String? message}) {
    return ListItensStates(
        items: items ?? this.items,
        isloading: isloading ?? this.isloading,
        error: error ?? this.error);
  }

  @override
  List<Object?> get props => [items, isloading, error];
}
