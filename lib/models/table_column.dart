class TableColumn{
  final String title;
  final String id;
  final bool isIdent;

  const TableColumn({required this.id, required this.title, this.isIdent = true});
}