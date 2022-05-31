part of lab_registration;

class _LabRegistrationTabByExcel extends StatelessWidget {
  const _LabRegistrationTabByExcel({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final LabRegistrationController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildGuideRegistration(),
        const Divider(),
        const SizedBox(height: 10),
        _buildSampleDownload(),
        const SizedBox(height: 10),
        const Divider(),
        const SizedBox(height: 10),
        _buildFileImport(),
      ],
    );
  }

  Widget _buildFileImport() {
    return Flexible(
      child: Column(
        children: [
          const _CustomTitle(
            icon: Icons.event_available,
            title: 'Đăng kí lịch thực hành',
          ),
          const SizedBox(height: 10),
          Column(
            children: [
              Lottie.asset(LottiePath.fileFolderBox, height: 100),
              _ImportButton(controller: controller)
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSampleDownload() {
    return _RowLayout(
      label: const _CustomTitle(
        icon: Icons.archive_outlined,
        title: 'Mẫu quản lý thực hành',
      ),
      content: ElevatedButton.icon(
        onPressed: () async {
          await controller.downloadSample();
        },
        label: const Text(
          'Tải xuống',
          style: TextStyle(fontSize: 14),
        ),
        icon: const Icon(
          Icons.download,
          size: 18,
        ),
        // style: ElevatedButton.styleFrom(
        //     padding: const EdgeInsets.all(11)),
      ),
    );
  }

  Widget _buildGuideRegistration() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          _CustomTitle(
            icon: Icons.library_books_outlined,
            title: 'Hướng dẫn quy trình tạo yêu cầu đăng kí',
          ),
          SizedBox(height: 15),
          // const Text('Bước 1: Tải mẫu quản lý thực hành.'),
          _StepText(
            step: 'Bước 1: ',
            content: 'Tải mẫu quản lý thực hành.',
          ),
          SizedBox(height: 10),
          _StepText(
            step: 'Bước 2: ',
            content:
                'Giảng viên điền tuần thực hành của mỗi lớp học phần vào mẫu đã tải.',
          ),
          SizedBox(height: 10),
          _StepText(
            step: 'Bước 3: ',
            content:
                'Import mẫu sau khi chỉnh sửa để hoàn tất quy trình đăng kí.',
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }

}

class _RowLayout extends StatelessWidget {
  const _RowLayout({
    Key? key,
    required this.label,
    required this.content,
  }) : super(key: key);

  final Widget label;
  final Widget content;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(child: label),
        const SizedBox(width: kSpacing),
        content
      ],
    );
  }
}

class _StepText extends StatelessWidget {
  const _StepText({
    Key? key,
    required this.step,
    required this.content,
  }) : super(key: key);

  final String step;
  final String content;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: TextStyle(color: kFontColorPallets[1]),
        children: [
          TextSpan(text: step, style: const TextStyle(color: kBlack)),
          TextSpan(
            text: content,
          ),
        ],
      ),
    );
  }
}

class _CustomTitle extends StatelessWidget {
  const _CustomTitle({
    Key? key,
    required this.title,
    required this.icon,
    this.iconColor,
    this.style,
  }) : super(key: key);

  final String title;
  final IconData icon;
  final Color? iconColor;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: iconColor ?? kFontColorPallets[0],
        ),
        const SizedBox(width: 5),
        Text(
          title,
          style: style ?? headerTitleRobotoStyle,
        ),
      ],
    );
  }
}


