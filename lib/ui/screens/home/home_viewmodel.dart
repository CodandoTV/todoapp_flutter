import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:todoapp/data/model/checklist.dart';
import 'package:todoapp/data/todo_repository.dart';

import 'home_screen_state.dart';

@injectable
class HomeViewModel extends Cubit<HomeScreenState> {
  late TodoRepository _repository;

  HomeViewModel(
    TodoRepository repository,
  ) : super(
          const HomeScreenState(
            checklists: [],
            isLoading: true,
          ),
        ) {
    _repository = repository;
  }

  void _onLoad() {
    emit(
      state.copyWith(isLoading: true),
    );
  }

  Future<void> updateChecklists() async {
    _onLoad();

    var checklists = await _repository.getChecklists();
    emit(
      HomeScreenState(
        isLoading: false,
        checklists: checklists,
      ),
    );
  }

  Future<void> onRemoveChecklist(Checklist checklist) async {
    _onLoad();

    var result = await _repository.deleteChecklists([checklist]);

    if (result) {
      List<Checklist> checklists = List.from(state.checklists);
      checklists.remove(checklist);
      emit(
        HomeScreenState(
          isLoading: false,
          checklists: checklists,
        ),
      );
    }
  }
}
