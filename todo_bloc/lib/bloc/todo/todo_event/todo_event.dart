import 'package:equatable/equatable.dart';

abstract class TodoEvent extends Equatable {
  const TodoEvent();
}

class AddTodoEvent extends TodoEvent {
  String task;
  AddTodoEvent({required this.task});

  @override
  List<Object?> get props => [task];
}

class DeleteTodoEvent extends TodoEvent {
  int index;
  DeleteTodoEvent({required this.index});

  @override
  // TODO: implement props
  List<Object?> get props => [index];
}

class UpdateTodoEvent extends TodoEvent {
  int index;
  String updatedTask;
  UpdateTodoEvent({required this.index, required this.updatedTask});

  @override
  List<Object?> get props => [index, updatedTask];
}
