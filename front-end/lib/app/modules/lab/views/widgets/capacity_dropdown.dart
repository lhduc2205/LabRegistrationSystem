part of lab;


class _CapacityDropdown extends StatelessWidget {
  const _CapacityDropdown({
    Key? key,
    required this.listData,
    required this.value,
    required this.onChanged,
    this.primaryColor = kPrimary,
  }) : super(key: key);

  final List<CapacityData> listData;
  final String value;
  final Function(String?)? onChanged;
  final Color primaryColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      // padding: const EdgeInsets.symmetric(horizontal: 16),
      // decoration: BoxDecoration(
      //   border: Border.all(color: kFontColorPallets[2]),
      //   borderRadius: BorderRadius.circular(5),
      // ),
      child: ClipRRect(
        child: DropdownButton<String>(
          style: const TextStyle(
            overflow: TextOverflow.ellipsis,
          ),
          value: value,
          icon: const Icon(Icons.arrow_drop_down_outlined),
          iconEnabledColor: primaryColor,
          elevation: 16,
          isExpanded: true,
          underline: Container(
            height: 1,
            color: kFontColorPallets[2],
          ),
          onChanged: onChanged,
          items:
              listData.map<DropdownMenuItem<String>>((element) {
            return DropdownMenuItem<String>(
              value: element.id.toString(),
              child: Text(
                TypeHelper.formatBytes(element.capacity, 0).toString(),
                overflow: TextOverflow.fade,
                softWrap: false,
                maxLines: 1,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
