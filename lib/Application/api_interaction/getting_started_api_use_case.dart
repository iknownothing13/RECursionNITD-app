// getting_started_use_case.dart
import '../../Domain/Model/getting_started_model.dart';
import '../../Infrastructure/data_sources/getting_started_api.dart';

class FetchDataUseCaseGetting_started {
  final Getting_startedApi remoteApi;

  FetchDataUseCaseGetting_started(this.remoteApi);

  Future<GettingStartedModel> execute() async {
    return remoteApi.fetchData();
  }
}