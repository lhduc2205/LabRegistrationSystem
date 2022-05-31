part of lab;

class _DataTableSource extends DataTableSource {
  _DataTableSource({
    required this.labs,
    required this.controller,
  });

  final List<LabModel> labs;
  final LabController controller;

  @override
  DataRow? getRow(int index) {
    final LabModel _data = labs[index];
    return DataRow(
      selected: _data.id == controller.selectedIndexRow.value,
      onSelectChanged: (value) {
        controller.onSelectedChanged(value!, _data.id!);
        notifyListeners();
      },
      cells: [
        DataCell(
          SizedBox(
              width: 70, child: Text(_data.tenPhong)),
        ),
        // DataCell(_buildTenBoMon(_data.boMonId)),
        DataCell(SizedBox(width: 50, child: Text(_data.soChoNgoi.toString()))),
        DataCell(_buildTenPhanMem(_data.phanMemId)),
        DataCell(
          SizedBox(
              width: 50,
              child: Text(TypeHelper.formatBytes(_data.dungLuongRam, 0))),
        ),
        DataCell(
          SizedBox(
              width: 60,
              child: Text(TypeHelper.formatBytes(_data.dungLuongOCung, 0))),
        ),
        DataCell(Text(_data.cpu.capitalizeFirst!)),
        DataCell(Text(_data.gpu.capitalizeFirst!)),
      ],
    );
  }

  Text _buildTenBoMon(int boMonId) {
    final departmentController = Get.find<DepartmentController>();
    String name = departmentController.getNameById(boMonId);
    return Text(name.capitalizeFirst!);
  }

  Widget _buildTenPhanMem(List softwareId) {
    final softwareController = Get.find<SoftwareController>();
    return Row(
      children: softwareId.asMap().entries.map(
        (entries) {
          final tenPhanMem =
              softwareController.findSoftware(entries.value).tenPhanMem;
          return Container(
            padding: EdgeInsets.only(left: entries.key == 0 ? 0 : 10),
            child: CustomChipWidget(
              label: tenPhanMem,
              primary: TypeHelper.softwareColor(entries.value),
            ),
          );
        },
      ).toList(),
    );
  }

  Widget showDeleteDialog(LabModel data) {
    return ConfirmDialog(
      title: "Cảnh báo",
      primaryColor: kRed,
      content: const Text(
        "Sẽ không thể hoàn tác nếu đã xóa phòng thực hành",
        style: TextStyle(
          color: kBlack,
        ),
      ),
      acceptBtnText: "xóa",
      onAcceptPressed: () async {
        await controller.deleteLab();
        Get.back();
      },
      onCancelPressed: () => Get.back(),
    );
  }

  Widget showEditDialog(int id) {
    return ConfirmDialog(
      title: "Cập nhật",
      primaryColor: kGreen,
      content: _LabForm(
        controller: controller,
        primaryColor: kGreen,
        isEditedMode: true,
      ),
      acceptBtnText: "cập nhật",
      onAcceptPressed: () => controller.handleSubmit(isEdited: true),
      onCancelPressed: () => {
        Get.back(),
        controller.clearTextCtrl(),
      },
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => labs.length;

  @override
  int get selectedRowCount => 0;
}
