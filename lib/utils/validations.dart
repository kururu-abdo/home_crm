

String? emailValidation(String email){
  if (email.length<1) {
    return 'you should fill this';
  }
  else {
    var reg =RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

    if (reg.hasMatch(email)) {
      return null;
    } else {
return 'Invalid Email';
    }
  }
}

String? isNotEnotyValidation(String email){
  if (email.length<1) {
    return 'this field is required';
  }
  else {
    return null;
  }
}