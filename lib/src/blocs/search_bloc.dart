import 'package:cv/src/blocs/bloc_provider.dart';
import 'package:cv/src/models/api_models.dart';
import 'package:cv/src/models/profile_model.dart';
import 'package:cv/src/services/api_service.dart';
import 'package:cv/src/services/shared_preferences_service.dart';
import 'package:rxdart/rxdart.dart';

class SearchBloc extends BlocBase {
  SearchBloc() {
    _isFetchingController.add(false);
  }

  ApiService apiService = ApiService();

  // Reactive variables
  final _isFetchingController = BehaviorSubject<bool>();
  final _profilesController = BehaviorSubject<List<ProfileModel>>();

  // Streams
  Observable<bool> get isFetchingStream => _isFetchingController.stream;
  Observable<List<ProfileModel>> get profilesStream =>
      _profilesController.stream;

  void fetchProfiles(String profileTitle) async {
    print(profileTitle);
    if (!_isFetchingController.value) {
      _isFetchingController.add(true);

      await SharedPreferencesService.getAuthToken()
          .then((String token) => apiService.fetchProfiles(token, profileTitle))
          .then((ResponseModelWithArray<ProfileModel> response) {
        if (response.error == true) {
          throw Exception(response.message);
        } else {
          return _profilesController.add(response.data);
        }
      }).catchError((error) {
        return _profilesController.addError(error);
      });

      _isFetchingController.add(false);
    }
  }

  @override
  void dispose() {
    _isFetchingController.close();
    _profilesController.close();
  }
}
