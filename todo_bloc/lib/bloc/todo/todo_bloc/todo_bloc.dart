import 'package:bloc/bloc.dart';
import 'package:todo_bloc/bloc/todo/todo_event/todo_event.dart';
import 'package:todo_bloc/bloc/todo/todo_state/todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  List<String> todos = [];
  TodoBloc() : super(const TodoState()) {
    on<AddTodoEvent>(_onAddTodo);
    on<UpdateTodoEvent>(_onUpdateTodo);
    on<DeleteTodoEvent>(_onDeleteTodo);
  }

  void _onAddTodo(AddTodoEvent event, Emitter<TodoState> emit) {
    todos.add(event.task);
    emit(state.copywith(value: List.from(todos)));
  }

  void _onDeleteTodo(DeleteTodoEvent event, Emitter<TodoState> emit) {
    todos.removeAt(event.index);
    emit(state.copywith(value: List.from(todos)));
  }

  void _onUpdateTodo(UpdateTodoEvent event, Emitter<TodoState> emit) {
    todos[event.index] = event.updatedTask;
    emit(state.copywith(value: List.from(todos)));
  }
}
