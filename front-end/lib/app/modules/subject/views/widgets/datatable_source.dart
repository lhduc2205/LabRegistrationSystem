part of subject;

class _DatatableSource extends DataTableSource {
  _DatatableSource({
    required this.subjects,
  });

  final List<SubjectModel> subjects;

  @override
  DataRow? getRow(int index) {
    final SubjectModel _data = subjects[index];
    return DataRow(
      cells: [
        DataCell(Text(_data.maMonHoc)),
        DataCell(Text(_data.tenMonHoc)),
        DataCell(SizedBox(width: 100, child: Text(_data.vietTat))),
        DataCell(SizedBox(width: 50, child: Text(_data.soTinChi.toString()))),
        DataCell(_buildTenPhanMem(_data.phanMemID!)),
      ],
    );
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



  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => subjects.length;

  @override
  int get selectedRowCount => 0;
}
