import 'package:cv/src/blocs/bloc_provider.dart';
import 'package:cv/src/models/api_models.dart';
import 'package:cv/src/models/profile_model.dart';
import 'package:cv/src/services/api_service.dart';
import 'package:cv/src/services/shared_preferences_service.dart';
import 'package:rxdart/rxdart.dart';

/// Business Logic Component for Profile Fetch
class ProfileBloc extends BlocBase {
  // Reactive variables
  final _profileDetailsController = BehaviorSubject<ProfileModel>();
  final _isFetchingController = BehaviorSubject<bool>();

  ApiService apiService = ApiService();

  // Streams
  Observable<ProfileModel> get profileStream =>
      _profileDetailsController.stream;

  Observable<bool> get isFetchingStream => _isFetchingController.stream;

  void fetchProfileDetails(String profileId) async {
    if (!_isFetchingController.value) {
      _isFetchingController.add(true);

      await SharedPreferencesService.getAuthToken()
          .then((String token) =>
              apiService.fetchProfileDetails(token, profileId))
          .then((ResponseModel<ProfileModel> response) {
        if (response.error == false) {
          return _profileDetailsController.add(response.data);
        } else {
          throw Exception(response.message);
        }
      }).catchError(_profileDetailsController.addError);

      _isFetchingController.add(false);
    }
  }

  @override
  void dispose() {
    _profileDetailsController.close();
  }
}
