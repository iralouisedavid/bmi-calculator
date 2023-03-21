//Weight validator
String? validateWeight(String? value) {
  if (value!.isEmpty) {
    return 'Enter your weight in kilograms';
  }
  double? weight = double.tryParse(value);
  if (weight == null || weight < 2 || weight > 650) {
    return 'Please enter a valid weight';
  }
  return null;
}

//Height validator
String? validateHeight(String? value) {
  if (value!.isEmpty) {
    return 'Enter your height in centimeters';
  }
  double? height = double.tryParse(value);
  if (height == null || height < 50 || height > 280) {
    return 'Please enter a valid height';
  }
  return null;
}

//Age validator
String? validateAge(String? value) {
  if (value!.isEmpty) {
    return 'Please enter your age';
  }
  int? age = int.tryParse(value);
  if (age == null || age < 1 || age > 110) {
    return 'Please enter a valid age';
  }
  return null;
}
