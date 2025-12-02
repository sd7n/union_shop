import '../models/app_data.dart';

class DataService {
  static final DataService instance = DataService._();
  DataService._();

  late final AppData appData;
}