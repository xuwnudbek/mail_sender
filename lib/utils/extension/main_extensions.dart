extension MainExtensions on String {
  // name = "Xushnudbek"
  // ${name} => Xushnudbek

  String insertPropertiesToString({
    String? email,
    String? fio,
    String? passport,
  }) {
    String result = this;

    if (email != null) {
      result = result.replaceAll("{email}", email);
    }

    if (fio != null) {
      result = result.replaceAll("{fio}", fio);
    }

    if (passport != null) {
      result = result.replaceAll("{passport}", passport);
    }

    return result;
  }
}
