part of teaching;

class _FilteredBar extends StatelessWidget {
  const _FilteredBar({Key? key, required this.controller}) : super(key: key);
  final TeachingController controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        DefaultIconButton(
          icon: IconlyBold.filter,
          onPressed: () => _showBottomSheet(),
        ),
        _displayFilteredChip(),
        Obx(
          () => controller.subjectSelectionById.value == 0
              ? const SizedBox()
              : Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: DefaultChipWidget(
                    label: Text(
                      controller
                          .findSubject(controller.subjectSelectionById.value)
                          .maMonHoc,
                    ),
                  ),
                ),
        ),
        Obx(
          () => controller.subjectSelectionByName.value == 0
              ? const SizedBox()
              : Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: DefaultChipWidget(
                    label: Text(
                      controller
                          .findSubject(controller.subjectSelectionByName.value)
                          .tenMonHoc
                          .capitalizeFirst!,
                    ),
                  ),
                ),
        ),
        Obx(
          () => controller.sessionSelection.value == 0
              ? const SizedBox()
              : Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: DefaultChipWidget(
                    label: Text(
                      controller
                          .findSession(controller.sessionSelection.value)
                          .tenBuoiHoc
                          .capitalizeFirst!,
                    ),
                  ),
                ),
        ),
        Obx(
          () => controller.daySelection.value == 0
              ? const SizedBox()
              : Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: DefaultChipWidget(
                    label: Text(
                      _getLabelDay() +
                          controller
                              .findDay(
                                controller.daySelection.value,
                              )
                              .tenThu,
                    ),
                  ),
                ),
        ),
        // Obx(
        //   () => controller.lecturerSelection.value == 0
        //       ? const SizedBox()
        //       : Padding(
        //           padding: const EdgeInsets.only(left: 10),
        //           child: DefaultChipWidget(
        //             label: Text(
        //               controller
        //                   .findLecturer(controller.lecturerSelection.value)
        //                   .hoTen
        //                   .capitalizeFirstOfEach,
        //             ),
        //           ),
        //         ),
        // ),
        const SizedBox(width: kSpacing),
      ],
    );
  }

  String _getLabelDay() {
    return controller.findDay(controller.daySelection.value).maThu == 'cn'
        ? ''
        : 'Thứ ';
  }

  Widget _displayFilteredChip() {
    return Obx(
      () => controller.sessionSelection.value == 0 &&
              controller.subjectSelectionById.value == 0 &&
              controller.subjectSelectionByName.value == 0
          ? const Padding(
              padding: EdgeInsets.only(left: 10),
              child: DefaultChipWidget(
                label: Text('Tất cả'),
              ),
            )
          : const SizedBox(),
    );
  }

  _showBottomSheet() {
    return Get.bottomSheet(
      CustomBottomSheet(
        header: Text(
          'Bộ lọc',
          style: subHeadingStyle,
        ),
        resetText: "Reset",
        resetFunction: () => controller.resetFiltered(),
        body: Column(
          children: [
            // _ContentLayout(
            //   label: Row(
            //     children: [
            //       Obx(
            //         () => Checkbox(
            //           value: controller.isCheckFilteredLecturer.value,
            //           onChanged: (value) =>
            //               controller.onCheckFilterLecturer(value!),
            //           fillColor: MaterialStateProperty.all(kPrimary),
            //         ),
            //       ),
            //       GestureDetector(
            //         onTap: () => controller.onCheckFilterLecturer(
            //             !controller.isCheckFilteredLecturer.value),
            //         child: const Text('Lọc theo giảng viên'),
            //       ),
            //     ],
            //   ),
            //   child: Obx(
            //     () => Visibility(
            //       visible: controller.isCheckFilteredLecturer.value,
            //       child: _LecturerDropdown(
            //         lecturers: controller.lecturerList,
            //         controller: controller,
            //       ),
            //     ),
            //   ),
            // ),
            // const SizedBox(height: 10),
            _ContentLayout(
              label: const Text('Mã môn học'),
              child: Obx(
                () => _SubjectDropdown(
                  subjects: controller.getSubjects(),
                  controller: controller,
                  value: controller.subjectSelectionById.value.toString(),
                  width: 110,
                  maHPLabel: true,
                ),
              ),
            ),
            const SizedBox(height: 10),
            _ContentLayout(
              label: const Text('Tên môn học'),
              child: Obx(
                    () => _SubjectDropdown(
                  subjects: controller.getSubjects(sortById: false),
                  value: controller.subjectSelectionByName.value.toString(),
                  controller: controller,
                ),
              ),
            ),
            const SizedBox(height: 10),
            _ContentLayout(
              label: const Text('Buổi học'),
              child: Obx(
                () => _PeriodDropdown(
                  value: controller.sessionSelection.value.toString(),
                  sessions: controller.getSessions(),
                  controller: controller,
                ),
              ),
            ),
            const SizedBox(height: 10),
            _ContentLayout(
              label: const Text('Thứ'),
              child: Obx(
                () => _DayDropdown(
                  value: controller.daySelection.value.toString(),
                  days: controller.getDays(),
                  controller: controller,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ContentLayout extends StatelessWidget {
  const _ContentLayout({
    Key? key,
    required this.label,
    required this.child,
    this.header,
  }) : super(key: key);

  final Widget label;
  final Widget child;
  final Widget? header;

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget.isSmallScreen(context)
        ? SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [label, const SizedBox(width: 10), child],
            ),
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [label, const SizedBox(width: 10), child],
          );
  }
}
