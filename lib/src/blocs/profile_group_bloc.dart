import 'package:cv/src/blocs/bloc_provider.dart';
import 'package:cv/src/models/api_models.dart';
import 'package:cv/src/models/profile_group_model.dart';
import 'package:cv/src/services/api_service.dart';
import 'package:cv/src/services/shared_preferences_service.dart';
import 'package:rxdart/rxdart.dart';

/// Business Logic Component for Profile Group Fetch
class ProfileGroupBloc extends BlocBase {
  ProfileGroupBloc() {
    _isFetchingController.add(false);
  }

  // Reactive variables
  final _profileGroupController = BehaviorSubject<ProfileGroupModel>();
  final _isFetchingController = BehaviorSubject<bool>();

  ApiService apiService = ApiService();

  // Streams
  Observable<ProfileGroupModel> get profileGroupStream =>
      _profileGroupController.stream;

  Observable<bool> get isFetchingStream => _isFetchingController.stream;

  void fetchProfileGroup(String profileGroupId) async {
    if (!_isFetchingController.value) {
      _isFetchingController.add(true);

      await SharedPreferencesService.getAuthToken()
          .then((String token) =>
              apiService.fetchProfileGroup(token, profileGroupId))
          .then((ResponseModel<ProfileGroupModel> response) {
        if (response.error == false) {
          return _profileGroupController.add(response.data);
        } else {
          throw Exception(response.message);
        }
      }).catchError(_profileGroupController.addError);

      _isFetchingController.add(false);
    }
  }

  @override
  void dispose() {
    _profileGroupController.close();
  }
}
