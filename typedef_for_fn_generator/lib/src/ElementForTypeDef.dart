class ElementForTypeDef {
  final String documentationComment;
  final String returnType;
  final String displayName;
  final List<String> typeParameters;
  final List<String> parameters;

  ElementForTypeDef(
    this.documentationComment,
    this.returnType,
    this.displayName,
    this.typeParameters,
    this.parameters,
  );
}
