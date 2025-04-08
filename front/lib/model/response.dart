class Response {
  final String resultType;
  final String? resultError;
  final dynamic resultData;

  Response({
    required this.resultType,
    this.resultError,
    required this.resultData,
  });
}
