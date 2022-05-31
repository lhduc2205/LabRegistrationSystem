
class DataTableService {
  static int getRowsPerPage(int length, {int defaultLength = 8}) {
    if(length == 0) {
      return 1;
    }
    return length > defaultLength ? defaultLength : length;
  }
}