part of teaching;

class _TeachingCard extends StatelessWidget {
  const _TeachingCard({
    Key? key,
    required this.teaching,
    required this.controller,
  }) : super(key: key);

  final List<CourseModel> teaching;
  final TeachingController controller;

  @override
  Widget build(BuildContext context) {
    return teaching.isEmpty
        ? const Center(
            child: Text(
              'Không tìm thấy kết quả phù hợp!',
              style: TextStyle(color: kRed),
            ),
          )
        : ListView.separated(
            itemCount: teaching.length,
            separatorBuilder: (_, __) => const SizedBox(height: 15),
            itemBuilder: (context, index) {
              return CardLayout(
                title: _buildTitle(index),
                subTitle: getSubject(teaching[index].monHocId)
                    .tenMonHoc
                    .capitalizeFirst,
                action: _buildAction(index),
                content: _buildContent(index),
              );
            },
          );
  }

  Column _buildContent(int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _CustomContentText(
          label: 'Buổi học: ',
          content: getSession(
            teaching[index].buoiHocId,
          ).capitalizeFirst!,
        ),
        const SizedBox(height: 3),
        _CustomContentText(
          label: 'Số lượng sinh viên: ',
          content: teaching[index].soLuongSinhVien.toString(),
        ),
        const SizedBox(height: 3),
        _CustomContentText(
          label: 'Cán bộ giảng dạy: ',
          content: teaching[index].giangVienId != null
              ? getNameLecturer(teaching[index].giangVienId!)
                  .capitalizeFirstOfEach
              : 'null',
        ),
        const SizedBox(height: 3),
      ],
    );
  }

  Row _buildTitle(int index) {
    return Row(
      children: [
        RichText(
          text: TextSpan(
            style: _headingStyle,
            children: [
              TextSpan(
                text: getSubject(teaching[index].monHocId).maMonHoc,
              ),
              const TextSpan(text: '  -  '),
              TextSpan(
                text: teaching[index].maLopHocPhan,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Row _buildAction(int index) {
    return Row(
      children: [
        RichText(
          text: TextSpan(
            style: TextStyle(color: kFontColorPallets[1]),
            children: [
              TextSpan(
                text: 'Thứ ' + getDay(teaching[index].thuId).capitalizeFirst!,
              ),
            ],
          ),
        ),
        const SizedBox(width: 5),
        Icon(
          IconlyLight.calendar,
          size: 18,
          color: kFontColorPallets[1],
        ),
      ],
    );
  }

  SubjectModel getSubject(int id) {
    return controller.findSubject(id);
  }

  String getNameLecturer(int id) {
    return controller.findLecturer(id).hoTen;
  }

  String getDay(int id) {
    return controller.findDay(id).tenThu;
  }

  String getSession(int id) {
    return controller.findSession(id).tenBuoiHoc;
  }

  TextStyle get _headingStyle {
    return GoogleFonts.openSans(
      textStyle: const TextStyle(
        fontSize: 16,
        color: kRed,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  TextStyle get _actionStyle {
    return normalStyle;
  }
}

class _CustomContentText extends StatelessWidget {
  const _CustomContentText({
    Key? key,
    required this.label,
    required this.content,
  }) : super(key: key);

  final String label;
  final String content;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: label,
            style: normalStyle,
          ),
          TextSpan(
              text: content, style: TextStyle(color: kFontColorPallets[1])),
        ],
      ),
    );
  }
}
