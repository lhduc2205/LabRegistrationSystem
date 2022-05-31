import 'package:lab_registration_management/app/core/value/helpers/app_helpers.dart';

class CapacityProvider {
  static final List<CapacityData> ramCapacityList = [
    CapacityData(id: 1, capacity: 2048),
    CapacityData(id: 2, capacity: 4096),
    CapacityData(id: 3, capacity: 6144),
    CapacityData(id: 4, capacity: 8192),
    CapacityData(id: 5, capacity: 10240),
    CapacityData(id: 6, capacity: 12288),
    CapacityData(id: 7, capacity: 14336),
    CapacityData(id: 8, capacity: 16384),
  ];
  static final List<CapacityData> diskCapacityList = [
    CapacityData(id: 1, capacity: 131072),
    CapacityData(id: 2, capacity: 262144),
    CapacityData(id: 3, capacity: 524288),
    CapacityData(id: 4, capacity: 1048576),
    CapacityData(id: 5, capacity: 2097152),
    CapacityData(id: 6, capacity: 4194304),
  ];
  static CapacityData findRAMCapacity(int id) {
    return ramCapacityList.firstWhere((ram) => ram.id == id);
  }

  static CapacityData findDiskCapacity(int id) {
    return diskCapacityList.firstWhere((disk) => disk.id == id);
  }

  static CapacityData findRAMByCapacity(int capacity) {
    return ramCapacityList.firstWhere((ram) => ram.capacity == capacity);
  }

  static CapacityData findDiskByCapacity(int capacity) {
    return diskCapacityList.firstWhere((disk) => disk.capacity == capacity);
  }

}

class CapacityData {
  final int id;
  final int capacity;
  CapacityData({required this.id, required this.capacity});
}