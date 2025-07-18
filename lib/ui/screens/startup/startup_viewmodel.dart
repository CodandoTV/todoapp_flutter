import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:todoapp/main.dart';

@injectable
class StartupViewmodel extends Cubit<bool> {

  StartupViewmodel() : super(true) {

    _loadDependencies();
  }

  _loadDependencies() async {
    await configureDependencies();
    await Future.delayed(const Duration(milliseconds: 500));
    emit(false);
  }
}
