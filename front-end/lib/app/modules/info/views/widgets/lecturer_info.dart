part of info;

class _LecturerInfo extends StatelessWidget {
  const _LecturerInfo({
    Key? key,
    required this.lecturer,
  }) : super(key: key);

  final LecturerModel lecturer;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _Title(text: 'Thông tin cá nhân'),
            const SizedBox(height: 10),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    _Label(text: 'Mã GV: ', icon: IconlyLight.infoSquare),
                    _Label(text: 'Họ tên: ', icon: IconlyLight.profile),
                    _Label(text: 'Bộ môn: ', icon: IconlyLight.work),
                    _Label(text: 'Email: ', icon: IconlyLight.message),
                    _Label(text: 'Số điện thoại: ', icon: IconlyLight.call),
                    _Label(text: 'Ngày sinh: ', icon: IconlyLight.calendar),
                  ],
                ),
                const SizedBox(width: kSpacing),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _Content(text: lecturer.maGv),
                    _Content(text: lecturer.hoTen.capitalizeFirstOfEach),
                    _Content(text: lecturer.tenBoMon!.capitalizeFirst!),
                    _Content(text: lecturer.emailGV),
                    _Content(text: lecturer.sdt),
                    _Content(
                      text: DateFormat('dd-MM-yyyy').format(
                        lecturer.ngaySinh,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _Title extends StatelessWidget {
  const _Title({
    Key? key,
    required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.roboto(
        textStyle: const TextStyle(
          fontSize: 18,
          color: kPrimary,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _Label extends StatelessWidget {
  const _Label({
    Key? key,
    required this.text,
    required this.icon,
  }) : super(key: key);

  final String text;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 5),
      child: Row(
        children: [
          Icon(icon, size: 20, color: kDeepBlue),
          const SizedBox(width: 8),
          Text(
            text,
            style: const TextStyle(fontSize: 16, color: kDeepBlue),
          ),
        ],
      ),
    );
  }
}

class _Content extends StatelessWidget {
  const _Content({
    Key? key,
    required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 5),
      child: Text(
        text,
        style: const TextStyle(fontSize: 16),
      ),
    );
  }
}
