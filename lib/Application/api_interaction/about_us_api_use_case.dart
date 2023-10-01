

import 'package:recursion/Infrastructure/data_sources/about_us_api.dart';

import '../../Domain/Model/about_us_model.dart';

class FetchDataUseCase {
  final AboutUsApi remoteApi;

  FetchDataUseCase(this.remoteApi);

  Future<AboutUs?> execute() async {
    return remoteApi.fetchData();
  }
}
