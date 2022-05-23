class Either<E, T> {
  final E? _error;
  final T? _value;

  const Either._(this._error, this._value);

  E get error => _error!;
  T get value => _value!;

  bool isError() => _error != null;
  // This is not the opposite of isError() !
  bool hasValue() => _value != null;
}

Either<E, T> error<E, T>(E e) => Either._(e, null);
Either<E, T> value<E, T>(T r) => Either<E, T>._(null, r);
