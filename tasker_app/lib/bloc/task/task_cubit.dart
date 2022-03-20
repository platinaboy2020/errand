import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tasker_app/data/models/task.dart';
import 'package:tasker_app/data/services/task/repository.dart';

part 'task_state.dart';

class TaskCubit extends Cubit<TaskState> {
  final TaskRepository repository;
  TaskCubit({required this.repository}) : super(TaskInitial());

  void fetchTasks() {
    emit(TasksLoading());
    repository.get_all_tasks().then((response) {
      if (response.statusCode == 200) {
        var rawTasks = jsonDecode(response.body) as List;
        List<Task> tasks =
            rawTasks.map((task) => Task.fromJson((task))).toList();
        emit(TasksLoaded(tasks: tasks));
      } else {
        emit(TasksLoadingError());
      }
    });
  }

  void addTask(String title, DateTime? date, String? description, int status,
      int user_id, int project_id) {
    emit(TaskCreating());
    repository
        .addTask(title, date, description, status, user_id, project_id)
        .then((response) {
      if (response.statusCode == 200) {
        emit(TaskCreated());
        emit(TaskInitial());
      } else {
        emit(TasksCreatingError());
      }
    });
  }

  void update_task(int id, String title, DateTime date, String description,
      int status, int user_id, int project_id) {
    emit(TaskUpdating());
    repository
        .update_task(id, title, date, description, status, user_id, project_id)
        .then((response) {
      if (response.statusCode == 200) {
        emit(TaskUpdated());
        emit(TaskInitial());
      } else {
        emit(TaskUpdatingError());
      }
    });
  }

  void remove_task(int id) {
    emit(TaskRemoving());
    repository.delete_task(id).then((response) {
      if (response.statusCode == 200) {
        emit(TaskRemoved());
        emit(TaskInitial());
      } else {
        emit(TaskRemovingError());
      }
    });
  }
}
