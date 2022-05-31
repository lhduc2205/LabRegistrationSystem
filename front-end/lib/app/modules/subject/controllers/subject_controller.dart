import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:lab_registration_management/app/data/models/subject_model.dart';
import 'package:lab_registration_management/app/data/services/api/subject_api_service.dart';

class SubjectController extends GetxController {
  List<SubjectModel> subjectsList = [];
  List<SubjectModel> subjectsSoftList = [];

  var subjectFiltered = <SubjectModel>[].obs;
  var searchResult = ''.obs;
  var isLoading = false.obs;

  var searchCtrl = TextEditingController();

  @override
  void onInit() {
    fetch();
    fetchSubjectSoftware();
    super.onInit();
  }

  Future<List<SubjectModel>> fetch() async {
    isLoading.value = true;
    try {
      final response = await SubjectAPIService.fetch();
      List subjectJson = response.data as List;
      subjectsList = convertToListSubject(subjectJson);
      // addSingleSubject();
      return subjectsList;
    } on Exception catch (e) {
      print(e);
      throw Exception(e);
      // return null;
    }
  }

  Future<List<SubjectModel>> fetchSubjectSoftware() async {
    try {
      final response = await SubjectAPIService.fetchSubjectSoftware();
      List subjectSoftJson = response.data as List;
      subjectsSoftList = convertToListSubject(subjectSoftJson);
      subjectFiltered.value = subjectsSoftList;
      // addSingleSubject();
      isLoading.value = false;
      return subjectFiltered;
    } on Exception catch (e) {
      print(e);
      throw Exception(e);
      // return null;
    }
  }

  addSingleSubject() {
    SubjectModel subject = SubjectModel(
      id: 0,
      maMonHoc: 'Tất cả',
      tenMonHoc: 'Tất cả',
      soTinChi: 0,
      vietTat: 'tc',
    );
    subjectsList.add(subject);
  }

  onChangedSearch(String value) {
    searchResult.value = value.trim();
    subjectFiltered.value = subjectsSoftList.where(
      (subject) =>
          subject.maMonHoc.contains(searchResult) ||
          subject.tenMonHoc.contains(searchResult) ||
          subject.vietTat.contains(searchResult),
    ).toList();
  }

  onDeleteSearchResult() {
    searchCtrl.clear();
    searchResult.value = '';
    subjectFiltered.value = subjectsSoftList;
  }

  SubjectModel findSubject(int id) {
    return subjectsList.firstWhere((subject) => subject.id == id);
  }

  List<SubjectModel> convertToListSubject(List list) {
    return list.map((subject) => SubjectModel.fromJson(subject)).toList();
  }
}
