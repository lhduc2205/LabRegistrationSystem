part of lab_registration;

class _SchedulingButton extends StatelessWidget {
  const _SchedulingButton({Key? key, required this.controller})
      : super(key: key);

  final LabRegistrationController controller;

  @override
  Widget build(BuildContext context) {
    var _navigationController = NavigationController.instance;

    return OutlinedButton(
      onPressed: () async {
        _showProcessingDialog();
        await controller.scheduling().then(
          (timetable) async {
            if (timetable.isNotEmpty) {
              Get.back();
              _navigationController.navigateTo(timetableClonePageRoute);
            } else {
              Get.back();
              _showNotifDialog();
            }
          },
        ).catchError((err) {
          Get.back();
          Utils.showNotification('Lỗi ' + err);
        });
      },
      child: const Text('Hỗ trợ xếp lịch thực hành'),
      style: OutlinedButton.styleFrom(
          primary: kPrimary, side: const BorderSide(color: kPrimary)),
    );
  }

  _showProcessingDialog() {
    return Get.defaultDialog(
      barrierDismissible: false,
      title: '',
      titleStyle: titleRobotoStyle,
      content: Column(
        children: [
          SizedBox(
            width: 200,
            height: 200,
            child: Lottie.asset(LottiePath.arrange, height: 10, width: 10),
          ),
          Lottie.asset(LottiePath.progressIndicator, height: 70)
        ],
      ),
    );
  }

  _showNotifDialog() {
    Get.defaultDialog(
      title: 'Không có lịch nào được xếp',
      titleStyle: const TextStyle(
          fontSize: 18,
          color: kPrimary,
      ),
      content: Container(
        color: kWhite,
        child: Column(
          children: [
            Image.asset(
              ImageRasterPath.noData,
              width: 300,
            ),
            Column(
              children: const [
                _CustomErrTile(
                  text: 'Không đáp ứng đủ số lượng máy',
                  icon: Icons.close,
                  iconColor: kRed,
                ),
                _CustomErrTile(
                  text: 'Đáp ứng đủ phần mềm yêu cầu',
                  icon: Icons.close,
                  iconColor: kRed,
                ),
              ],
            ),
            const SizedBox(
              height: kSpacing,
            ),
            Text(
              'Oops!!!',
              style: GoogleFonts.lato(
                textStyle: const TextStyle(
                  color: kRed,
                  fontSize: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CustomErrTile extends StatelessWidget {
  const _CustomErrTile({
    Key? key,
    required this.text,
    this.icon,
    this.iconColor,
    this.crossAxisAlignment,
  }) : super(key: key);

  final String text;
  final IconData? icon;
  final Color? iconColor;
  final CrossAxisAlignment? crossAxisAlignment;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon ?? Icons.close,
          color: iconColor ?? kRed,
          size: 13,
        ),
        const SizedBox(width: 5),
        Text(
          text,
          style: const TextStyle(color: kBlack),
        ),
      ],
    );
  }
}
