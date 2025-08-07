
bool isValidEmail(String input) {
  return RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$").hasMatch(input);
}

bool isValidPhone(String input){
  return RegExp(r"^(?:08|09|07|02)\d{8,9}$").hasMatch(input);
}

bool hasCapitalLetter(String input) {
  return RegExp(r'[A-Z]').hasMatch(input);
}

bool hasSmallLetter(String input) {
  return RegExp(r'[a-z]').hasMatch(input);
}

bool hasNumber(String input) {
  return RegExp(r'[0-9]').hasMatch(input);
}

bool hasSpecialCharacter(String input) {
  return RegExp(r'[!@#$&*()[]').hasMatch(input);
}
