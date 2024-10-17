import 'package:equatable/equatable.dart';

abstract class ListItensStates extends Equatable{}

class ListInitial extends ListItensStates{
  @override
  List<Object?> get props => [];
}

class ListLoading extends ListItensStates{
 @override
  List<Object?> get props => [];
}

class ListLoaded extends ListItensStates{

  final List<String> items;

  ListLoaded(this.items);


 @override
  List<Object?> get props => [items];

   ListLoaded copyWith({List<String>? items}) {
    return ListLoaded(items ?? this.items);
  }
}

class ListError extends ListItensStates{
  final String message;

  ListError(this.message);

 @override
  List<Object?> get props => [message];

  ListError copyWith({String? message}) {
    return ListError(message ?? this.message);
  }
}
