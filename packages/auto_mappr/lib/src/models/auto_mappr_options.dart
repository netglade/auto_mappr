class AutoMapprOptions {
  final bool? ignoreNullableSourceField;
  final bool? safeMapping;

  const AutoMapprOptions({required this.ignoreNullableSourceField, required this.safeMapping});

  factory AutoMapprOptions.fromJson(Map<String, dynamic> json) {
    final ignoreNullableSourceField = json['ignoreNullableSourceField'] as bool? ?? false;
    final safeMapping = json['safeMapping'] as bool? ?? false;

    return AutoMapprOptions(ignoreNullableSourceField: ignoreNullableSourceField, safeMapping: safeMapping);
  }
}
