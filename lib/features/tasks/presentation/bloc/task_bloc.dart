import 'package:bloc/bloc.dart';
import '../../data/models/task.dart';
import '../../data/repositories/task_repository.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final TaskRepository repository;

  TaskBloc(this.repository) : super(TaskInitial()) {
    on<FetchTasks>(_onLoadTasks);
    on<CreateTask>(_onAddTask);
    on<UpdateTaskStatus>(_onUpdateTask);
    on<DeleteTask>(_onDeleteTask);
  }

  Future<void> _onLoadTasks(FetchTasks event, Emitter<TaskState> emit) async {
    emit(TaskLoading());
    try {
      final tasks = await repository.fetchTasks();
      emit(TaskLoaded(tasks));
    } catch (e) {
      emit(TaskError('Failed to fetch tasks'));
    }
  }

  Future<void> _onAddTask(CreateTask event, Emitter<TaskState> emit) async {
    final message = await repository.addTask(event.task);
    if (message != null) {
      emit(TaskError(message));
    } else {
      add(FetchTasks());
    }
  }

  Future<void> _onUpdateTask(
      UpdateTaskStatus event, Emitter<TaskState> emit) async {
    final message = await repository.updateTask(event.task);
    if (message != null) {
      emit(TaskError(message));
    } else {
      add(FetchTasks());
    }
  }

  Future<void> _onDeleteTask(DeleteTask event, Emitter<TaskState> emit) async {
    final message = await repository.deleteTask(event.id);
    if (message != null) {
      emit(TaskError(message));
    } else {
      add(FetchTasks());
    }
  }
}
