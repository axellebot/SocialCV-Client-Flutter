import 'package:cv/src/errors/base_errors.dart';

/// ---------------------------------
/// ------------- Login -------------
/// ---------------------------------

class ApiErrorWrongPasswordError extends BaseError {
  ApiErrorWrongPasswordError() : super("Wrong Password");
}

class ApiErrorUserNotFoundError extends BaseError {
  ApiErrorUserNotFoundError() : super("User Not Found");
}
