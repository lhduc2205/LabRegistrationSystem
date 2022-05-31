import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:lab_registration_management/app/core/value/constants/app_constants.dart';
import 'package:lab_registration_management/app/core/value/theme/themes.dart';
import 'package:lab_registration_management/app/share_components/search_bar.dart';

import 'custom_outlined_button.dart';
import 'default_button.dart';

class ContentLayout extends StatelessWidget {
  const ContentLayout({
    Key? key,
    required this.child,
    required this.onRefresh,
    required this.isSelectedRow,
    required this.warningText,
    required this.searchBar,
    required this.onCreatedPressed,
    required this.onEditedPressed,
    required this.onDeletedPressed,
    this.title,
  }) : super(key: key);

  final Widget child;
  final Future<void> Function() onRefresh;
  final bool isSelectedRow;
  final String warningText;
  final Widget searchBar;
  final VoidCallback onCreatedPressed;
  final VoidCallback onEditedPressed;
  final VoidCallback onDeletedPressed;
  final String? title;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: Container(
        padding: const EdgeInsets.all(kSpacing),
        child: ListView(
          children: [
            _buildTitle(),
            const SizedBox(height: kSpacing),
            _buildSearchBar(),
            const SizedBox(height: kSpacing),
            child
          ],
        ),
      ),
    );
  }

  Row _buildTitle() {
    return Row(
      children: [
        _displayTitleOrButton(),
        const Spacer(),
        DefaultButton(
          child: const Text("Thêm"),
          onPressed: onCreatedPressed,
        ),
      ],
    );
  }

  Row _buildSearchBar() {
    return Row(
      children: [
        SizedBox(width: 250, child: searchBar),
      ],
    );
  }

  Widget _displayTitleOrButton() {
    if (!isSelectedRow) {
      return Text(title ?? "Title", style: headingStyle2);
    }
    return Row(
      children: [
        CustomOutlinedButton(
          icon: IconlyBold.edit,
          child: const Text("Sửa"),
          primaryColor: kGreen,
          onPressed: onEditedPressed,
        ),
        const SizedBox(width: 10),
        CustomOutlinedButton(
          icon: IconlyBold.delete,
          child: const Text("Xóa"),
          primaryColor: kRed,
          onPressed: onDeletedPressed,
        )
      ],
    );
  }
}
