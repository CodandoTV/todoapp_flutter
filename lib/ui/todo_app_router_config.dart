import 'package:auto_route/auto_route.dart';
import 'package:todoapp/ui/todo_app_router_config.gr.dart';

@AutoRouterConfig()
class TodoAppRouterConfig extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: StartupRoute.page, initial: true),
        AutoRoute(page: TasksRoute.page),
        AutoRoute(page: TaskRoute.page),
        AutoRoute(page: ChecklistsRoute.page),
        AutoRoute(page: ChecklistRoute.page)
      ];
}
