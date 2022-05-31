part of teaching;

class _ImportButton extends StatelessWidget {
  const _ImportButton({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final TeachingController controller;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () async {
        final picked = await controller.pickExcelFile();
        print(picked);
        if (picked != null) {
          controller.setExcelFileName(picked.files.first.name);
          _showDialog();
        }
      },
      icon: const FaIcon(
        FontAwesomeIcons.solidFileExcel,
        size: 18,
      ),
      label: const Text("Import"),
      style: ElevatedButton.styleFrom(primary: kExcelColor),
    );
  }

  _showDialog() {
    Get.defaultDialog(
      backgroundColor: kWhite,
      contentPadding: const EdgeInsets.all(kSpacing),
      title: 'Import Excel File',
      titlePadding: const EdgeInsets.symmetric(vertical: 10),
      titleStyle: const TextStyle(color: kExcelColor),
      content: Column(
        children: [
          Row(
            children: [
              Image.asset(ImageRasterPath.excelLogo, width: 20),
              const SizedBox(width: 5),
              Expanded(
                child: Obx(
                      () =>
                      Text(
                        controller.excelFileName.value,
                        style: const TextStyle(
                            color: kBlack, overflow: TextOverflow.ellipsis),
                        maxLines: 1,
                        softWrap: false,
                      ),
                ),
              ),
              // const SizedBox(width: 10),
              const Spacer(),
              _buildChangeButton()
            ],
          ),
          const SizedBox(
            height: kSpacing,
          ),
        ],
      ),
      actions: [
        // TextButton(onPressed: () => Get.back(), child: Text('Hủy'), style: TextButton.styleFrom(primary: kRed),),
        // ElevatedButton(onPressed: (){}, child: Text('Import')),
        ColoredButton(
            widget: const Text('Import'),
            onPressed: () async {
              await controller.uploadExcel(controller.picked!);
              Get.back();
            }
        )
      ],
    );
  }

  Widget _buildChangeButton() {
    return TextButton(
      onPressed: () async {
        final _picked = await controller.pickExcelFile();
        controller.setExcelFileName(_picked.files.first.name);
      },
      child: Text('Thay đổi'),
    );
  }
}
