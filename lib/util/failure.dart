abstract class Failure {
  const Failure();
}

class InitialFailure extends Failure {
  const InitialFailure();
}

class RefreshFailure extends Failure {
  const RefreshFailure();
}

class BackendFailure extends Failure {
  const BackendFailure();
}

class ArrivaApiFailure extends Failure {
  const ArrivaApiFailure();
}

class LoadStationsFailure extends Failure {
  const LoadStationsFailure();
}

class NoRidesFailure extends Failure {
  const NoRidesFailure();
}
