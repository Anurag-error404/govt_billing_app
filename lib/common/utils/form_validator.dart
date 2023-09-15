// ignore_for_file: unnecessary_string_escapes

class FormValidator {
  String? validateEmail([String? value]) {
    if (value != null) {
      if (value.isEmpty) {
        return 'Email field cannot be empty!';
      }
      // Regex for email validation
      String p =
          "[a-zA-Z0-9\+\.\_\%\-\+]{1,256}\\@[a-zA-Z0-9][a-zA-Z0-9\\-]{0,64}(\\.[a-zA-Z0-9][a-zA-Z0-9\\-]{0,25})+";
      RegExp regExp = RegExp(p);
      if (regExp.hasMatch(value)) {
        return null;
      }
      return 'Email provided is invalid';
    }
    return null;
  }

  String? validateNumberInput([String? value]) {
    if (value != null) {
      if (value.isEmpty) {
        return 'Input number cannot be empty';
      }
      // regex pattern to veify postive decimal and whole numbers
      String p = r'^?\d+(\.\d+)?$';
      RegExp regExp = RegExp(p);
      if (regExp.hasMatch(value)) {
        return null;
      }
      return 'Invalid Number';
    }
    return null;
  }

  String? validateContactNumberInput([String? value]) {
    if (value != null) {
      // if (value.isEmpty) {
      //   return 'Input number cannot be empty';
      // }
      // regex pattern to verify contact numbers
      String p = r'^\+?[1-9][0-9]{7,14}$';
      RegExp regExp = RegExp(p);
      if (regExp.hasMatch(value)) {
        return null;
      }
      return 'Invalid Number';
    }
    return null;
  }

  String? validatePercentage([String? value]) {
    if (value != null) {
      if (value.isEmpty) {
        return 'Input number cannot be empty';
      }
      // regex pattern to verify contact numbers
      double? perc = double.tryParse(value);
      if (perc != null && perc <= 100 && perc >= 1) {
        return null;
      }
      return 'Percentage should be in range 1-100';
    }
    return null;
  }

  String? validatePassword([String? value]) {
    if (value != null) {
      if (value.isEmpty) {
        return 'Password field cannot be empty';
      }

      if (value.length < 6) {
        return 'Password length must be greater than 6';
      }
      return null;
    }
    return null;
  }

  String? mandatoryFieldValidator([String? value]) {
    if (value != null) {
      if (value.isEmpty) {
        return 'This field cannot be empty!';
      }
      return null;
    }
    return null;
  }
}
