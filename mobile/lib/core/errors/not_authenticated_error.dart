final class NotAuthenticatedError implements Exception {
  @override
  String toString() => "You are not authorized!";
}
