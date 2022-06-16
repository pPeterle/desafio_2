abstract class RequestResult {
  final int totalResults;
  final int page;
  final int perPage;
  final String? nextPage;

  RequestResult({
    required this.totalResults,
    required this.page,
    required this.perPage,
    this.nextPage,
  });
}
