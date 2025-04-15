enum FormFieldValues implements Comparable<FormFieldValues> {
  licensePlate(value: "licensePlate"),
  language(value: "language");

  final String value;
  const FormFieldValues({required this.value});

  @override
  int compareTo(FormFieldValues other) {
    throw UnimplementedError();
  }
}
