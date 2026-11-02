class AppRegEx {
  static isEmailValied(String email) {
    var emailPattern = r'^[a-zA-Z-0-9_]+@[a-zA-Z0-9]+\.[a-zA-Z]{2,}$';
    RegExp regex = RegExp(emailPattern);
    return regex.hasMatch(email);
  }

  static isPhoneValied(String phone) {
    var phonePattern = r'^01[0125][0-9]{8}$';
    RegExp regex = RegExp(phonePattern);
    return regex.hasMatch(phone);
  }
}
