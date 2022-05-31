part of timetable;

class ScheduleWaitingBar extends StatelessWidget {
  const ScheduleWaitingBar({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final TimetableController controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Column(
          children: [
            _ScheduleContainer(
              bgColor: kWhite,
              borderColor: kRed,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Lịch chưa xếp',
                    style: labelText,
                  ),
                  Obx(
                    () => Text(
                      '(${controller.registrationFiltered.length.toString()})',
                      style: labelText,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(
          width: kSpacing,
        ),
        Obx(
          () => Row(
            children: controller.registrationFiltered.value.map((regis) {
              CellData data = CellData(null, null, regis.nhomThId);
              return _ScheduleWaiting(
                data: data,
                textRowFirst: '${regis.maMonHoc!} - ${regis.vietTat}',
                textRowSecond: StringHelper.toAbbreviation(
                  regis.hoTenGV!.capitalizeFirstOfEach,
                  regis.gioiTinhGV!,
                ),
                textRowThird: 'N${regis.maLopHocPhan} - 0${regis.maNhom} ',
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  TextStyle get labelText => const TextStyle(color: kRed, fontSize: 16);
}

class _ScheduleWaiting extends StatelessWidget {
  const _ScheduleWaiting({
    Key? key,
    required this.textRowFirst,
    required this.textRowSecond,
    required this.textRowThird,
    required this.data,
    this.textColor,
  }) : super(key: key);

  final String textRowFirst;
  final String textRowSecond;
  final String textRowThird;
  final CellData data;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return Draggable(
      data: data,
      childWhenDragging: _ScheduleContainer(
        bgColor: Colors.grey,
        borderColor: Colors.grey,
        child: _buildTextColumn(
          textColor: kWhite,
        ),
      ),
      feedback: _ScheduleContainer(
        bgColor: kPrimary,
        child: _buildTextColumn(textColor: kWhite),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: _ScheduleContainer(child: _buildTextColumn()),
      ),
    );
  }

  TextStyle textStyle(Color textColor) {
    return TextStyle(
      color: textColor,
      fontSize: 13,
    );
  }

  Column _buildTextColumn({Color textColor = kPrimary}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(textRowFirst, style: textStyle(textColor)),
        Text(textRowSecond, style: textStyle(textColor)),
        Text(textRowThird, style: textStyle(textColor)),
      ],
    );
  }
}

class _ScheduleContainer extends StatelessWidget {
  const _ScheduleContainer({
    Key? key,
    required this.child,
    this.width,
    this.bgColor,
    this.borderColor,
  }) : super(key: key);

  final Widget child;
  final double? width;
  final Color? bgColor;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? 150,
      height: 75,
      decoration: BoxDecoration(
        color: bgColor ?? kWhite,
        border: Border.all(
          color: borderColor ?? kPrimary,
          width: 0.5,
        ),
      ),
      child: child,
    );
  }
}
