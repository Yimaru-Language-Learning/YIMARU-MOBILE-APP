Map<String, String> splitFullName(String fullName) {
  final parts = fullName.trim().split(RegExp(r'\s+'));

  if (parts.length == 1) {
    return {
      'last_name': '',
      'nick_name': parts[0],
      'first_name': parts[0],
    };
  }

  return {
    'nick_name': parts.first,
    'first_name': parts.first,
    'last_name': parts.sublist(1).join(' '),
  };
}
