import 'package:cv/src/blocs/bloc_provider.dart';
import 'package:cv/src/commons/values.dart';
import 'package:cv/src/models/api_models.dart';
import 'package:cv/src/models/profile_model.dart';
import 'package:cv/src/services/api_service.dart';
import 'package:cv/src/services/shared_preferences_service.dart';
import 'package:cv/src/utils/logger.dart';
import 'package:rxdart/rxdart.dart';

/// Business Logic Component for Profile List Fetch
class ProfileListBloc extends BlocBase {
  ProfileListBloc() {
    _isFetchingProfilesController.add(false);
    _profilePerPage.add(KCVItemsPerPageDefault);
  }

  ApiService apiService = ApiService();

  // Reactive variables
  final _isFetchingProfilesController = BehaviorSubject<bool>();
  final _profilesController = BehaviorSubject<List<ProfileModel>>();
  final _profilePerPage = BehaviorSubject<String>();

  // Streams
  Observable<bool> get isFetchingProfilesStream =>
      _isFetchingProfilesController.stream;

  Observable<List<ProfileModel>> get profilesStream =>
      _profilesController.stream;

  Observable<String> get profilePerPage => _profilePerPage.stream;

  // Human functions
  void setItemsPerPage(String partPerPage) async {
    _profilePerPage.add(partPerPage);
  }

  void fetchAccountProfiles() async {
    logger.info('fetchAccountProfiles');
    if (!_isFetchingProfilesController.value) {
      _isFetchingProfilesController.add(true);

      await SharedPreferencesService.getAuthToken()
          .then(apiService.fetchAccountProfiles)
          .then((ResponseModelWithArray<ProfileModel> response) {
        if (response.error == false) {
          return _profilesController.add(response.data);
        } else {
          throw Exception(response.message);
        }
      }).catchError(_profilesController.addError);

      _isFetchingProfilesController.add(false);
    }
  }

  void fetchProfiles(String profileTitle) async {
    print(profileTitle);
    if (!_isFetchingProfilesController.value) {
      _isFetchingProfilesController.add(true);

      await SharedPreferencesService.getAuthToken()
          .then((String token) => apiService.fetchProfiles(token, profileTitle))
          .then((ResponseModelWithArray<ProfileModel> response) {
        if (response.error == false) {
          _profilesController.add(response.data);
        } else {
          throw Exception(response.message);
        }
      }).catchError(_profilesController.addError);

      _isFetchingProfilesController.add(false);
    }
  }

  @override
  void dispose() {
    _isFetchingProfilesController.close();
    _profilesController.close();
    _profilePerPage.close();
  }
}
