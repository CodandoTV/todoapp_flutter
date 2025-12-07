import 'package:flutter/material.dart';
import 'package:todoapp/data/model/checklist.dart';
import 'package:todoapp/data/model/task.dart';
import 'package:todoapp/ui/components/widgets/checklist/checklist_item_widget.dart';
import 'package:todoapp/ui/components/widgets/task/taskslist/tasks_list_widget.dart';
import 'package:todoapp/ui/components/widgets/task/taskslist/tasks_viewmodel.dart';
import 'package:todoapp/ui/l10n/app_localizations.dart';
import 'package:todoapp/ui/todo_app_router_config.gr.dart';
import 'package:todoapp/util/di/dependency_startup_launcher.dart';
import 'package:todoapp/util/navigation_provider.dart';

class ChecklistsListFullWidget extends StatefulWidget {
  final List<Checklist> checklists;
  final Function(Checklist) onRemoveChecklist;
  final NavigatorProvider navigatorProvider;

  const ChecklistsListFullWidget({
    super.key,
    required this.checklists,
    required this.onRemoveChecklist,
    required this.navigatorProvider,
  });

  @override
  State<ChecklistsListFullWidget> createState() =>
      ChecklistsListFullWidgetState();
}

class ChecklistsListFullWidgetState extends State<ChecklistsListFullWidget> {
  Checklist? selected;
  List<Task>? tasks;
  late TasksViewModel _tasksViewModel;

  @override
  void initState() {
    super.initState();
    final getIt = GetItStartupHandlerWrapper.getIt;
    _tasksViewModel = TasksViewModel(
      repository: getIt.get(),
      shareMessageHandler: getIt.get(),
      shouldShowShareButtonUseCase: getIt.get(),
      formatTaskListMessageUseCase: getIt.get(),
      tasksSorterUseCase: getIt.get(),
      tasksComparatorUseCase: getIt.get(),
      progressCounterUseCase: getIt.get(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildTaskList(context);
  }

  void onSelectCheckList(Checklist checklist) {
    setState(() {
      selected = checklist;

      _tasksViewModel.updateTasks(checklist.id);

      _tasksViewModel.stream.listen((state) {
        setState(() {
          tasks = state.tasks;
        });
      });
    });
  }

  Future<void> addNewTaskToExistingChecklist(BuildContext context) async {
    if (selected?.id != null) {
      await _navigateToTaskScreen(
          context,
          checklistId: selected!.id,
      );
    }
  }

  Widget _buildTaskList(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    return Row(
      children: [
        Expanded(
          flex: 4,
          child: ListView.builder(
            padding: const EdgeInsets.only(top: 12, bottom: 120),
            itemBuilder: (context, index) => ChecklistItemWidget(
              isSelected: widget.checklists[index].id == selected?.id,
              onRemoveChecklist: widget.onRemoveChecklist,
              onSelectChecklist: (checklist) => onSelectCheckList(checklist),
              checklist: widget.checklists[index],
            ),
            itemCount: widget.checklists.length,
          ),
        ),
        Expanded(
            flex: 6,
            child: TasksListWidget(
              tasks: tasks == null ? [] : tasks!,
              emptyTasksMessage: localizations.empty_tasks,
              onCompleteTask: _tasksViewModel.onCompleteTask,
              onRemoveTask: _tasksViewModel.onRemoveTask,
              onReorder: _tasksViewModel.reorder,
              onTap: (task) => _navigateToTaskScreen(
                  context,
                  checklistId: selected?.id,
                  task: task,
              ),
            )),
      ],
    );
  }

  Future<void> _navigateToTaskScreen(
    BuildContext context, {
    required int? checklistId,
    Task? task,
  }) async {
    final localizations = AppLocalizations.of(context)!;

    bool? result = await widget.navigatorProvider.push(
      context,
      TaskRoute(
        checklistId: checklistId,
        task: task,
      ),
    );
    if (result == true) {
      await _tasksViewModel.updateTasks(selected?.id);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              localizations.tasks_refresh,
            ),
          ),
        );
      }
    }
  }
}
