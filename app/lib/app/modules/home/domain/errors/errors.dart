abstract class Failure implements Exception {}

class DataSourceError extends Failure {}

class InternetConnectionError extends Failure {}

class InvalidUrlError extends Failure {}

class InvalidQueryError extends Failure {}
