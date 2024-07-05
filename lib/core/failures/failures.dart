class Failure {
  final String message;
  final int? statusCode;

  Failure({required this.message, this.statusCode});

  String get props => message;
}
