import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:lab_registration_management/app/core/value/constants/app_constants.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({
    Key? key,
    required this.searchController,
    required this.isHideCloseBtn,
    required this.onChanged,
    required this.onTapCloseBtn,
    this.hintText,
  }) : super(key: key);

  final TextEditingController searchController;
  final bool isHideCloseBtn;
  final Function(String)? onChanged;
  final VoidCallback onTapCloseBtn;
  final String? hintText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: searchController,
      style: TextStyle(color: kFontColorPallets[0]),
      onChanged: onChanged,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.withOpacity(0.5)),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.withOpacity(0.5)),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: kPrimary),
        ),
        isDense: true,
        hintText: hintText ?? "Tìm kiếm...",
        hintStyle: TextStyle(color: kFontColorPallets[1], fontSize: 14),
        contentPadding: const EdgeInsets.all(10),
        suffixIcon: _buildSuffixIcon(isHideCloseBtn),
      ),
      cursorColor: kDeepBlue,
    );
  }

  _buildSuffixIcon(bool isHideCloseBtn) {
    if (isHideCloseBtn) {
      return const Icon(IconlyLight.search);
    } else {
      return InkWell(
        child: const Icon(
          Icons.clear,
          color: kRed,
        ),
        onTap: onTapCloseBtn,
      );
    }
  }
}
