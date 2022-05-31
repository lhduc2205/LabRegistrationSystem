import 'package:flutter/material.dart';
import 'package:lab_registration_management/app/core/value/constants/app_constants.dart';

class SelectionButtonData {
  final IconData activeIcon;
  final IconData icon;
  final String label;
  final String navigationPath;

  SelectionButtonData({
    required this.activeIcon,
    required this.icon,
    required this.label,
    required this.navigationPath,
  });
}

class SelectionButton extends StatefulWidget {
  const SelectionButton({
    Key? key,
    required this.initialSelected,
    required this.data,
    required this.onSelected,
  }) : super(key: key);

  final int initialSelected;
  final List<SelectionButtonData> data;
  final Function(int index, SelectionButtonData value) onSelected;

  @override
  State<SelectionButton> createState() => _SelectionButtonState();
}

class _SelectionButtonState extends State<SelectionButton> {
  late int selected;

  @override
  void initState() {
    super.initState();
    selected = widget.initialSelected;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: widget.data.asMap().entries.map((e) {
        final index = e.key;
        final data = e.value;
        return _Button(
          selected: selected == index,
          data: data,
          onPressed: () {
            widget.onSelected(index, data);
            setState(() {
              selected = index;
            });
          },
        );
      }).toList(),
    );
  }
}

class _Button extends StatelessWidget {
  const _Button(
      {Key? key,
        required this.selected,
        required this.data,
        required this.onPressed})
      : super(key: key);

  final bool selected;
  final SelectionButtonData data;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: Material(
          color: (selected) ? kFontColorPallets[0].withOpacity(0.1) : Colors.transparent,
          child: InkWell(
            onTap: onPressed,
            highlightColor: kLightBlue.withOpacity(0.1),
            splashColor: kLightBlue.withOpacity(0.4),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: kSpacing, vertical: 15),
              child: Row(
                children: [
                  _icon((!selected) ? data.icon : data.activeIcon),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: _labelText(data.label),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _icon(IconData iconData) {
    return Icon(
      iconData,
      size: 20,
      color: !selected
          ? kFontColorPallets[2]
          : kFontColorPallets[0],
    );
  }

  Widget _labelText(String data) {
    return Text(
      data,
      style: TextStyle(
        color: !selected
            ? kFontColorPallets[2]
            : kFontColorPallets[0],
        letterSpacing: 0.8,
        fontSize: 13,
      ),
    );
  }

  Widget _notif(int total) {
    return (total <= 0)
        ? Container()
        : Container(
      padding: const EdgeInsets.all(5),
      decoration: const BoxDecoration(
        // borderRadius: BorderRadius.circular(15),
          color: kNotifColor,
          shape: BoxShape.circle
      ),
      alignment: Alignment.center,
      child: Text(
        (total >= 100) ? "99+" : "$total",
        style: const TextStyle(
            color: kWhite, fontSize: 11, fontWeight: FontWeight.w600),
        textAlign: TextAlign.center,
      ),
    );
  }
}
