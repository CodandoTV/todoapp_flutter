import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/data/model/task.dart';
import 'package:todoapp/ui/components/form_validator.dart';
import 'package:todoapp/ui/components/widgets/custom_app_bar_widget.dart';
import 'package:todoapp/ui/components/widgets/task/task_form_widget.dart';
import 'package:todoapp/ui/l10n/app_localizations.dart';
import 'package:todoapp/ui/screens/task/task_viewmodel.dart';
import 'package:todoapp/util/di/dependency_startup_launcher.dart';
import 'package:todoapp/util/navigation_provider.dart';

@RoutePage()
class TaskScreen extends StatelessWidget {
  final int? checklistId;
  final Task? task;

  const TaskScreen({
    super.key,
    required this.checklistId,
    this.task,
  });

  @override
  Widget build(BuildContext context) {
    final viewModel = TaskViewModel(
      GetItStartupHandlerWrapper.getIt.get(),
      checklistId: checklistId,
      task: task,
    );
    final NavigatorProvider navigatorProvider =
        GetItStartupHandlerWrapper.getIt.get();

    return TaskScreenScaffold(
      taskTitle: task?.title,
      addTaskOrUpdate: (title) => viewModel.addTaskOrUpdate(
        title: title,
      ),
      floatingActionIcon: viewModel.getFloatingActionButtonIcon(),
      formScreenValidator: GetItStartupHandlerWrapper.getIt.get(),
      navigatorProvider: navigatorProvider,
    );
  }
}

class TaskScreenScaffold extends StatefulWidget {
  final Future<bool> Function(String) addTaskOrUpdate;
  final FormScreenValidator formScreenValidator;
  final NavigatorProvider navigatorProvider;
  final IconData floatingActionIcon;
  final String? taskTitle;

  const TaskScreenScaffold({
    super.key,
    this.taskTitle,
    required this.floatingActionIcon,
    required this.addTaskOrUpdate,
    required this.formScreenValidator,
    required this.navigatorProvider,
  });

  @override
  State<TaskScreenScaffold> createState() => _TaskScreenScaffoldState();
}

class _TaskScreenScaffoldState extends State<TaskScreenScaffold> {
  late TextEditingController _taskEditingController;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    _taskEditingController = TextEditingController(
        text: widget.taskTitle ?? ''
    );
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: CustomAppBarWidget(
        title: localizations.task,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (!_formKey.currentState!.validate()) {
            return;
          }

          final result = await widget.addTaskOrUpdate(
            _taskEditingController.text,
          );
          if (context.mounted) {
            widget.navigatorProvider.onPop(context, result);
          }
        },
        child: Icon(widget.floatingActionIcon),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: TaskFormWidget(
          formKey: _formKey,
          taskLabel: localizations.task,
          taskErrorMessage: localizations.task_name_required,
          taskEditingController: _taskEditingController,
          formScreenValidator: widget.formScreenValidator,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _taskEditingController.dispose();

    super.dispose();
  }
}
