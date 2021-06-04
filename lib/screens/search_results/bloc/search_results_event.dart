part of 'search_results_bloc.dart';

class SearchResultsEvent {
  SearchResultsEvent();
}

class LoadSearchResults extends SearchResultsEvent {
  final String searchtext;

  LoadSearchResults({this.searchtext});
}
