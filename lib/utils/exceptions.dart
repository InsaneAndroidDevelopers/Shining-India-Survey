class AppExceptionDio implements Exception {
  final String message;
  AppExceptionDio(this.message);
}

class BadRequestExceptionDio extends AppExceptionDio {
  BadRequestExceptionDio(super.message);
}

class InternalServerErrorDio extends AppExceptionDio {
  InternalServerErrorDio(super.message);
}

class UnauthorisedExceptionDio extends AppExceptionDio {
  UnauthorisedExceptionDio(super.message);
}

class ConflictExceptionDio extends AppExceptionDio {
  ConflictExceptionDio(super.message);
}

class InvalidInputExceptionDio extends AppExceptionDio {
  InvalidInputExceptionDio(super.message);
}

class UnexpectedExceptionDio extends AppExceptionDio {
  UnexpectedExceptionDio(super.message);
}