class ApiRoutes {
  static const String baseurl = 'https://recnitdgp.pythonanywhere.com/';

  static const String aboutusurl = '${baseurl}api/?format=json';
  static const String teamurl = '${baseurl}api/team/?format=json';
  static const String eventurl = '${baseurl}api/events/?format=json';
  static const String signupurl = '${baseurl}api/users/register/?format=json';
  static const String signinurl = '${baseurl}/api/token/';
  static const String gettingstartedurl = '${baseurl}api/getting_started/contents/';
}
