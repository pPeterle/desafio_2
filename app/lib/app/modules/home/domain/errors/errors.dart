abstract class Failure implements Exception {
  final String message;

  Failure(this.message);
}

class DataSourceError extends Failure {
  DataSourceError() : super('Internal Error');
}

class InternetConnectionError extends Failure {
  InternetConnectionError() : super('No internet connection');
}

class InvalidUrlError extends Failure {
  InvalidUrlError() : super('Invalid url');
}

class InvalidQueryError extends Failure {
  InvalidQueryError() : super('Empty text on search');
}
