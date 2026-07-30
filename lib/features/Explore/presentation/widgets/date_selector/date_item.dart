class DateItem {
  const DateItem({
    required this.date,
    required this.isSelected,
  });

  final DateTime date;
  final bool isSelected;

  DateItem copyWith({
    DateTime? date,
    bool? isSelected,
  }) {
    return DateItem(
      date: date ?? this.date,
      isSelected: isSelected ?? this.isSelected,
    );
  }
}
