String getTimeStampFromDate(int index) {
  final currentDate = DateTime.now();
  switch(index) {
    case 0: {
      return '';
    }
    case 1: {
      final date = currentDate.subtract(const Duration(days: 30));
      return date.toIso8601String();
    }
    case 2: {
      final date = currentDate.subtract(const Duration(days: 14));
      return date.toIso8601String();
    }
    case 3: {
      final date = currentDate.subtract(const Duration(days: 7));
      return date.toIso8601String();
    }
    case 4: {
      final date = currentDate.subtract(const Duration(days: 5));
      return date.toIso8601String();
    }
  }
  return '';
}