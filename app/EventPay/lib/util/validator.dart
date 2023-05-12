/// Provides validation functions.
abstract class EPValidator {
  /// Validates [email].
  static bool isValidEmail(String email) {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
  }

  /// Validates [password].
  static bool isValidPassword(String password) {
    return !password.contains(' ') && password.length >= 8;
  }

  /// Validates [name].
  static bool isValidName(String name) {
    return name.isNotEmpty && RegExp(r'[a-zA-Z ]+').hasMatch(name);
  }

  /// Validates [integer].
  static bool isInteger(String number) {
    return RegExp(r"^[1-9]+[0-9]*$").hasMatch(number);
  }

  static bool isValidText(String text) {
    //return RegExp(r"^[A-Za-z0-9'\.\-\s\,]*$").hasMatch(text);
    return text.length > 0;
  }
}
