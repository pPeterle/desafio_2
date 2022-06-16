abstract class Failure implements Exception {}

class DataSourceError extends Failure {}

class InternetConnectionError extends Failure {}
