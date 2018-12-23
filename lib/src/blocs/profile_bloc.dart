import 'package:cv/src/blocs/bloc_provider.dart';
import 'package:cv/src/models/api_models.dart';
import 'package:cv/src/models/profile_model.dart';
import 'package:cv/src/services/api_service.dart';
import 'package:cv/src/services/shared_preferences_service.dart';
import 'package:cv/src/utils/logger.dart';
import 'package:rxdart/rxdart.dart';

/// Business Logic Component for Profile Fetch
class ProfileBloc extends BlocBase {
  ProfileBloc() {
    _isFetchingProfileController.add(false);
  }

  ApiService apiService = ApiService();

  // Reactive variables
  final _isFetchingProfileController = BehaviorSubject<bool>();
  final _profileController = BehaviorSubject<ProfileModel>();

  // Streams
  Observable<bool> get isFetchingProfileStream =>
      _isFetchingProfileController.stream;

  Observable<ProfileModel> get profileStream => _profileController.stream;

  void fetchProfileDetails(String profileId) async {
    logger.info('fetchProfileDetails');
    if (!_isFetchingProfileController.value) {
      _isFetchingProfileController.add(true);

      await SharedPreferencesService.getAuthToken()
          .then((String token) =>
              apiService.fetchProfileDetails(token, profileId))
          .then((ResponseModel<ProfileModel> response) {
        if (response.error == false) {
          _profileController.add(response.data);
        } else {
          throw Exception(response.message);
        }
      }).catchError(_profileController.addError);

      _isFetchingProfileController.add(false);
    }
  }

  @override
  void dispose() {
    _isFetchingProfileController.close();
    _profileController.close();
  }
}
