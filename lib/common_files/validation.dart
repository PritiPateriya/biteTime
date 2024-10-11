userNameValidation(val, field) {
  final RegExp nameExp = new RegExp(r'^[A-z0-9.]+$');
  if (!nameExp.hasMatch(val)) return 'Please enter valid Name';
}

validEmailField(val, field) {
  final RegExp nameExp =
      new RegExp(r'^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$');
  if (!nameExp.hasMatch(val)) return 'Please enter valid email address.';
}

validPasswordField(val, field) {
  final RegExp nameExp = new RegExp(r'^(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,15}$');
  if (!nameExp.hasMatch(val))
    return "Password is not secure.\nMust contain 1 uppercase, 1 lowercase, 1 number";
}

validPhoneNumber(val, field) {
  final RegExp phoneExp =
      RegExp(r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$');
  if (!phoneExp.hasMatch(val)) return "Please enter valid Phone number";
}
