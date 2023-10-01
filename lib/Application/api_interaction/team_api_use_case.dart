import 'package:recursion/Infrastructure/data_sources/team_api.dart';

import '../../Domain/Model/team_model.dart';



class FetchDataUseCaseTeam {
  final TeamApi remoteApi;

  FetchDataUseCaseTeam(this.remoteApi);

  Future<List<Team?>> execute() async {
    return remoteApi.fetchData();
  }
}
