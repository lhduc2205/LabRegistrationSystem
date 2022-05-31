import 'package:flutter/material.dart';
import 'package:lab_registration_management/app/core/value/constants/app_constants.dart';
import 'package:lab_registration_management/app/core/value/theme/themes.dart';

class CustomBottomSheet extends StatelessWidget {
  const CustomBottomSheet({
    Key? key,
    required this.header,
    required this.body,
    this.resetFunction,
    this.doneFunction,
    this.resetText,
    this.doneText,
  }) : super(key: key);

  final Widget header;
  final Widget body;
  final VoidCallback? resetFunction;
  final VoidCallback? doneFunction;
  final String? resetText;
  final String? doneText;

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 500,
      decoration: const BoxDecoration(
        color: kWhite,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(kBorderRadius),
          topRight: Radius.circular(kBorderRadius),
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Center(child: _CrossBar()),
            const SizedBox(height: kSpacing),
            _buildHeader(context),
            Divider(color: kBgColorPallets[2]),
            Expanded(child: _buildBody()),
          ],
        ),
      ),
    );
  }

  Container _buildBody() {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: kSpacing,
      ),
      child: ListView(
        children: [
          body,
        ],
      ),
    );
  }

  Container _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: kSpacing),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          header,
          Row(
            children: [
              TextButton(
                onPressed: resetFunction ?? () => Navigator.pop(context),
                child: Text(
                  resetText ?? 'Làm lại',
                ),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: doneFunction ?? () => Navigator.pop(context),
                child: Text(
                  doneText ?? 'Xong',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _CrossBar extends StatelessWidget {
  const _CrossBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 5,
      width: 50,
      margin: const EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        color: kScaffoldColor,
        borderRadius: BorderRadius.circular(kBorderRadius),
      ),
    );
  }
}
