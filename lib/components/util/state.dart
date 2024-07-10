enum WidgetState { idle, loading, disable }

abstract class ResponseState {}

class ResponseSuccess<T> extends ResponseState {
  final T data;

  ResponseSuccess(this.data);
}

class ResponseFailed extends ResponseState {
  final Exception? exception;
  final String message;

  ResponseFailed(this.exception, this.message);

}

class ResponseHandler<T> {
  Function(T) onSuccess;
  Function onFailed;
  Function onDone;

  ResponseHandler({required this.onSuccess, required this.onFailed, required this.onDone});
}
