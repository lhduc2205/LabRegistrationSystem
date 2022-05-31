part of lab;

class _LabForm extends StatelessWidget {
  const _LabForm({
    Key? key,
    required this.controller,
    this.primaryColor = kPrimary,
    this.isEditedMode = false,
  }) : super(key: key);

  final LabController controller;
  final Color primaryColor;
  final bool isEditedMode;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildNameAndSlotField(),
          const SizedBox(height: 15),
          _buildCPUAndGPURowField(),
          const SizedBox(height: 15),
          _buildRAMCapacityDropdown(),
          const SizedBox(height: 15),
          _buildDiskCapacityDropdown(),
          // const SizedBox(height: 15),
          // _buildDepartmentDropdown(),
          const SizedBox(height: 20),
          const _CustomText(text: "Phần mềm hỗ trợ"),
          const SizedBox(height: 10),
          _buildSoftwareChoiceChip(),
        ],
      ),
    );
  }

  Row _buildNameAndSlotField() {
    return Row(
      children: [
        Flexible(
          flex: 2,
          child: CustomTextFormField(
            labelText: "Tên phòng",
            controller: controller.tenPhongCtrl,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Vui lòng nhập tên phòng';
              }
              return null;
            },
          ),
        ),
        const SizedBox(width: 15),
        Flexible(
          child: CustomTextFormField(
            labelText: "Số chỗ ngồi",
            controller: controller.soChoNgoiCtrl,
            textInputType: TextInputType.number,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Nhập chỗ ngồi';
              } else if (!TypeHelper.isNumeric(value)) {
                return 'Nhập số nguyên';
              }
              return null;
            },
          ),
        )
      ],
    );
  }

  Row _buildRAMCapacityDropdown() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const _CustomText(
          text: 'Dung lượng RAM',
        ),
        const SizedBox(width: 15),
        Flexible(
          child: Obx(
            () => _CapacityDropdown(
              listData: controller.ramCapacityList,
              value: controller.ramCapacitySelection.value.toString(),
              onChanged: (String? id) => controller.setRAMCapacity(id!),
            ),
          ),
        ),
      ],
    );
  }

  Row _buildDiskCapacityDropdown() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const _CustomText(
          text: 'Dung lượng ổ cứng',
        ),
        const SizedBox(width: 15),
        Flexible(
          child: Obx(
            () => _CapacityDropdown(
              listData: controller.diskCapacityList,
              value: controller.diskCapacitySelection.value.toString(),
              onChanged: (String? id) => controller.setDiskCapacity(id!),
            ),
          ),
        ),
      ],
    );
  }

  Row _buildDepartmentDropdown() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const _CustomText(
          text: 'Thuộc bộ môn',
        ),
        const SizedBox(width: 15),
        Flexible(
          child: Obx(
            () => DefaultDropdown(
              items: controller.departmentsList
                  .map<DropdownMenuItem<String>>((element) {
                return DropdownMenuItem<String>(
                  value: element.id.toString(),
                  child: Text(
                    element.tenBoMon.capitalizeFirst!,
                    overflow: TextOverflow.fade,
                    softWrap: false,
                    maxLines: 1,
                  ),
                );
              }).toList(),
              value: controller.departmentSelection.value.toString(),
              onChanged: (String? id) => controller.setDepartment(id!),
            ),
          ),
        ),
      ],
    );
  }

  Row _buildCPUAndGPURowField() {
    return Row(
      children: [
        Flexible(
          child: CustomTextFormField(
            labelText: "Tên CPU",
            controller: controller.cpuCtrl,
          ),
        ),
        const SizedBox(width: 15),
        Flexible(
          child: CustomTextFormField(
            labelText: "Tên GPU",
            controller: controller.gpuCtrl,
          ),
        ),
      ],
    );
  }

  Widget _buildSoftwareChoiceChip() {
    final softwareController = Get.find<SoftwareController>();
    return Obx(
      () => Wrap(
        children: softwareController.softwareList
            .map(
              (software) => Container(
                padding: const EdgeInsets.all(5),
                child: DefaultChoiceChip(
                  text: software.tenPhanMem.capitalizeFirst!,
                  primaryColor: primaryColor,
                  isSelected: controller.isSoftwareSelected(software.id),
                  onSelected: (selected) =>
                      controller.setSoftwareSelected(software.id),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

class _CustomText extends StatelessWidget {
  const _CustomText({Key? key, required this.text}) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(text, style: const TextStyle(fontSize: 14));
  }
}
