part of 'search_page_cubit.dart';

enum Status { loading, initial, success }

class SearchPageState extends Equatable {
  final Status status;
  final String searchText;
  final List<SearchAutoComplete> searchList;
  const SearchPageState({
    required this.status,
    required this.searchText,
    required this.searchList,
  });
  factory SearchPageState.initial() {
    return const SearchPageState(
      status: Status.initial,
      searchText: '',
      searchList: [],
    );
  }
  @override
  List<Object> get props => [
        status,
        searchText,
        searchList,
      ];

  SearchPageState copyWith({
    Status? status,
    String? searchText,
    List<SearchAutoComplete>? searchList,
  }) {
    return SearchPageState(
      status: status ?? this.status,
      searchText: searchText ?? this.searchText,
      searchList: searchList ?? this.searchList,
    );
  }
}
