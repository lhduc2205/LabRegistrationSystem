part of app_helpers;

class TypeHelper {

  static String genderToString(bool isFemale) {
    switch (isFemale) {
      case true: return "nữ";
      case false: return "nam";
      default: return "nam";
    }
  }

  static Color softwareColor(int id) {
    switch (id) {
      case 1: return Colors.orange;
      case 2: return Colors.green;
      case 3: return Colors.blue;
      case 4: return Colors.pinkAccent;
      case 5: return Colors.grey;
      case 6: return Colors.red;
      case 7: return Colors.yellow;
      default: return Colors.blue;
    }
  }


  static String formatBytes(int bytes, int decimals) {
    if (bytes <= 0) return "0 B";
    const suffixes = ["MB", "GB", "TB", "PB", "EB", "ZB", "YB"];
    var i = (log(bytes) / log(1024)).floor();
    return ((bytes / pow(1024, i)).toStringAsFixed(decimals)) +
        ' ' +
        suffixes[i];
  }

  static bool isNumeric(String s) {
    return double.tryParse(s) != null;
  }

  static Color tabBarIndicator(int index) {
    switch (index) {
      case 1: return Colors.green;
      case 2: return Colors.orange;
      default: return kPrimary;
    }
  }
}

