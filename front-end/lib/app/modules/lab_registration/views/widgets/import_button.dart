part of lab_registration;

class _ImportButton extends StatelessWidget {
  const _ImportButton({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final LabRegistrationController controller;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () async {
        final picked = await controller.pickExcelFile();
        print(picked);
        if (picked != null) {
          controller.setExcelFileName(picked.files.first.name);
          _showImportDialog();
        }
      },
      label: const Text(
        'Import',
        style: TextStyle(fontSize: 14),
      ),
      icon: const Icon(
        Icons.file_upload,
        size: 18,
      ),
      style: ElevatedButton.styleFrom(primary: kExcelColor),
    );
  }

  _showImportDialog() {
    Get.defaultDialog(
      backgroundColor: kWhite,
      contentPadding: const EdgeInsets.all(kSpacing),
      title: 'Đăng kí lịch',
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
                  () => Text(
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
          const SizedBox(height: kSpacing),
          Lottie.asset(LottiePath.fileFolderBox, height: 100),
        ],
      ),
      actions: [
        ColoredButton(
          widget: const Text('Import'),
          onPressed: () async {
            Get.back();
            await controller.uploadExcel(controller.picked!);
          },
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
      child: const Text('Thay đổi'),
    );
  }
}
