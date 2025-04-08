class ResponseError {
  final bool isHttpError; // MUST always be false

  final int code;
  final String status;
  final String title;
  final String message;
  final String request;

  ResponseError({
    required this.isHttpError,
    required this.code,
    required this.status,
    required this.title,
    required this.message,
    required this.request,
  });
}
