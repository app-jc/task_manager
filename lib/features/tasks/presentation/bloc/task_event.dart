part of 'task_bloc.dart';

abstract class TaskEvent {}

class FetchTasks extends TaskEvent {}

class CreateTask extends TaskEvent {
  final Task task;
  CreateTask(this.task);
}

class UpdateTaskStatus extends TaskEvent {
  final Task task;
  UpdateTaskStatus(this.task);
}

class DeleteTask extends TaskEvent {
  final int id;
  DeleteTask(this.id);
}
