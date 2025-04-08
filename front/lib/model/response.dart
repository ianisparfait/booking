class EventResponse<T> {
  final String resultType;
  final String? resultError;
  final T? resultData;

  EventResponse({
    required this.resultType,
    this.resultError,
    this.resultData,
  });
}
