String? validateName(String? value) {
  value = value!.trim();
  if (value == '') return 'Required';
  return null;
}

String? validateDate(String? value) {
  // String currentDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
  value = value!.trim();
  if (value == '') return 'Required';
  if (value.contains(' ')) return 'Invalid Password';
  if (value.length < 10) return 'User Name need to be 10 Character long.';
  return null;
}

String? validateUserName(String? value) {
  value = value!.trim();
  if (value == '') return 'Required';
  if (value.contains(' ')) return 'Invalid Password';
  if (value.length < 10) return 'User Name need to be 10 Character long.';
  return null;
}

String? validateFeedbackForm(String? value) {
  value = value!.trim();
  if (value == '') return 'Required';

  if (value.length == 250) return 'User Name can insert 250 Character long.';
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
  if (value.contains(' ') || !isNumeric(value))
    return 'Please enter valid Phone number';
  if (!(value.length == 10)) return 'Please enter valid Phone number';

  return null;
}

String? validateOTP(String? value) {
  value = value!.trim();
  if (value == '') return 'Required';
  if (!isNumeric(value)) return 'Invalid OTP';
  if (value.length != 4) return '4 Digit OTP is required.';
  return null;
}

String? validateRole(String? value) {
  value = value!.trim();
  if (value == '') return 'Required';
  return null;
}
