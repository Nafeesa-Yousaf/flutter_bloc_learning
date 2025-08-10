import 'package:equatable/equatable.dart';

class TodoState extends Equatable {
  final List<String> todos;

  const TodoState({this.todos = const []});

  TodoState copywith({List<String>? value}) {
    return TodoState(todos: value ?? todos);
  }

  @override
  List<Object?> get props => [todos];
}
