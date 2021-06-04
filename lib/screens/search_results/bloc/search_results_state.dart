part of 'search_results_bloc.dart';

abstract class SearchResultsState extends Equatable {
  const SearchResultsState();

  @override
  List<Object> get props => [];
}

class SearchResultsInitial extends SearchResultsState {}

class SearchResultsLoading extends SearchResultsState {}

class SearchResultsSuccess extends SearchResultsState {
  final List<SearchResult> mealPlan;

  SearchResultsSuccess({this.mealPlan});
}

class SearchResultsError extends SearchResultsState {}

class SearchFailureState extends SearchResultsState {
  final Failure error;

  SearchFailureState({this.error});
}
