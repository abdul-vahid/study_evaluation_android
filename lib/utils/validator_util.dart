String? validateName(String? value) {
  value = value!.trim();
  if (value == '') return 'Required';
  return null;
}

String? validateUserName(String? value) {
  value = value!.trim();
  if (value == '') return 'Required';
  if (value.contains(' ')) return 'Invalid Password';
  if (value.length < 10) return 'User Name need to be 10 Character long.';
  return null;
}

String? validatePassword(String? value) {
  value = value!.trim();
  if (value == '') return 'Required';
  if (value.contains(' ')) return 'Invalid Password';
  if (value.length < 8) return 'Password need to be 8 Character long.';
  return null;
}

bool isNumeric(value) {
  try {
    int.parse(value);
    return true;
  } catch (e) {
    return false;
  }
}

String? validatePhone(String? value) {
  value = value!.trim();
  if (value == '') return 'Required';
  if (value.contains(' ') || !isNumeric(value)) return 'Invalid Mobile Number';
  //  if (value.length < 8) return 'Mobile need to be 8 digit long.';
  return null;
}

String? validateRole(String? value) {
  value = value!.trim();
  if (value == '') return 'Required';
  return null;
}