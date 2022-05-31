part of app_helpers;

class StringHelper {
  static String toAbbreviation(String name, bool isFemale) {
    final splitter = name.split(' ');
    String result = '';

    for (int i = 0; i < splitter.length; i++) {
      if (i < splitter.length - 1) {
        result += splitter[i][0];
      } else {
        result += ' ' + splitter[i];
      }
    }

    switch (isFemale) {
      case true:
        result = 'Cô ' + result;
        break;
      case false:
        result = 'Thầy ' + result;
        break;
    }

    return result;
  }
}
