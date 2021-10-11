import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:racipi/models/failure.dart';
import 'package:racipi/models/search_result_model.dart';
import 'package:racipi/repo/search_repo.dart';

part 'search_results_event.dart';
part 'search_results_state.dart';

class SearchResultsBloc extends Bloc<SearchResultsEvent, SearchResultsState> {
  SearchResultsBloc() : super(SearchResultsInitial());
  final repo = SearchRepo();
  @override
  Stream<SearchResultsState> mapEventToState(
    SearchResultsEvent event,
  ) async* {
    if (event is LoadSearchResults) {
      try {
        yield SearchResultsLoading();
        final mealplan = await repo.getSearchList(event.searchtext, 100);
        yield SearchResultsSuccess(
          mealPlan: mealplan.list,
        );
      } on Failure catch (e) {
        yield SearchFailureState(error: e);
      } catch (e) {
        print(e.toString());
        yield SearchResultsError();
      }
    }
  }
}
