import 'package:cv/src/blocs/bloc_provider.dart';
import 'package:cv/src/models/api_models.dart';
import 'package:cv/src/models/profile_group_model.dart';
import 'package:cv/src/services/api_service.dart';
import 'package:cv/src/services/shared_preferences_service.dart';
import 'package:rxdart/rxdart.dart';

/// Business Logic Component for Profile Group Fetch
class ProfileGroupBloc extends BlocBase {
  ProfileGroupBloc() {
    _isFetchingGroupController.add(false);
  }

  ApiService apiService = ApiService();

  // Reactive variables
  final _isFetchingGroupController = BehaviorSubject<bool>();
  final _profileGroupController = BehaviorSubject<ProfileGroupModel>();

  // Streams
  Observable<bool> get isFetchingGroupStream =>
      _isFetchingGroupController.stream;
  Observable<ProfileGroupModel> get profileGroupStream =>
      _profileGroupController.stream;

  void fetchProfileGroup(String profileGroupId) async {
    if (!_isFetchingGroupController.value) {
      _isFetchingGroupController.add(true);

      await SharedPreferencesService.getAuthToken()
          .then((String token) => apiService.fetchGroup(token, profileGroupId))
          .then((ResponseModel<ProfileGroupModel> response) {
        if (response.error == false) {
          return _profileGroupController.add(response.data);
        } else {
          throw Exception(response.message);
        }
      }).catchError(_profileGroupController.addError);

      _isFetchingGroupController.add(false);
    }
  }

  @override
  void dispose() {
    _isFetchingGroupController.close();
    _profileGroupController.close();
  }
}
