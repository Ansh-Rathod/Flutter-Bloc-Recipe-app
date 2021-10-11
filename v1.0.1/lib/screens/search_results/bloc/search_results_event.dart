part of 'search_results_bloc.dart';

abstract class SearchResultsEvent extends Equatable {
  const SearchResultsEvent();

  @override
  List<Object> get props => [];
}

class LoadSearchResults extends SearchResultsEvent {
  final String name;
  const LoadSearchResults({
    required this.name,
  });
}
