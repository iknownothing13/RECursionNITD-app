import 'package:recursion/Infrastructure/data_sources/Events_api.dart';

import '../../Domain/Model/events_model.dart';



class FetchDataUseCaseEvent {
  final EventApi remoteApi;

  FetchDataUseCaseEvent(this.remoteApi);

  Future<List<Results?>> execute() async {
    return remoteApi.fetchData();
  }
}
