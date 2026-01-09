import '../../domain/repositories/home_repository.dart';
import '../datasources/local/data_provider.dart';

class HomeRepositoryImpl implements HomeRepository {
  final DataProvider _dataProvider;

  HomeRepositoryImpl({required DataProvider dataProvider})
    : _dataProvider = dataProvider;

  // @override
  // Future<void> create(Map<String, dynamic> data) {
  //   // return _dataProvider.addJob(data);
  //   return _dataProvider.addHomeData(data);
  // }
}
