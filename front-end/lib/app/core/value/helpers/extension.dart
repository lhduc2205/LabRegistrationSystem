part of app_helpers;

extension StringExtension on String {
  String get capitalize =>
      "${this[0].toUpperCase()}${substring(1).toLowerCase()}";

  String get capitalizeFirstOfEach =>
      split(" ").map((str) => str.capitalize).join(" ");
}
