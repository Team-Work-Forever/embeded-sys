enum FormFieldValues implements Comparable<FormFieldValues> {
  licensePlate(value: "licensePlate");

  final String value;
  const FormFieldValues({required this.value});

  @override
  int compareTo(FormFieldValues other) {
    throw UnimplementedError();
  }
}
