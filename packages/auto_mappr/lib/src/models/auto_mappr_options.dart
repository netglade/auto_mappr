class AutoMapprOptions {
  final bool? ignoreNullableSourceField;

  const AutoMapprOptions({required this.ignoreNullableSourceField});

  factory AutoMapprOptions.fromJson(Map<String, dynamic> json) {
    final ignoreNullableSourceField = json['ignoreNullableSourceField'] as bool? ?? false;

    return AutoMapprOptions(ignoreNullableSourceField: ignoreNullableSourceField);
  }
}
