import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:branch_repository/branch_repository.dart';
import 'package:equatable/equatable.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc({required BranchRepository branchRepository})
      : _branchRepository = branchRepository,
        super(DataLoading());

  final BranchRepository _branchRepository;
  StreamSubscription? _branchSubscription;

  @override
  Stream<HomeState> mapEventToState(
    HomeEvent event,
  ) async* {
    if (event is BranchLoadData) {
      yield* _mapBranchLoadState();
    }
    if (event is BrachDataUpdated) {
      yield* _mapBranchsUpdateToState(event);
    }
  }

  Stream<HomeState> _mapBranchLoadState() async* {
    _branchSubscription?.cancel();
    _branchSubscription = _branchRepository
        .branchData()
        .listen((branch) => add((BrachDataUpdated(branch))));
  }

  Stream<HomeState> _mapBranchsUpdateToState(BrachDataUpdated event) async* {
    yield BranchDataLoaded(event.branches);
  }

  @override
  Future<void> close() {
    _branchSubscription?.cancel();
    return super.close();
  }
}
