import 'package:cv/src/blocs/bloc_provider.dart';
import 'package:cv/src/models/api_models.dart';
import 'package:cv/src/models/profile_part_model.dart';
import 'package:cv/src/services/api_service.dart';
import 'package:cv/src/services/shared_preferences_service.dart';
import 'package:rxdart/rxdart.dart';

/// Business Logic Component for Profile Part Fetch
class ProfilePartBloc extends BlocBase {
  ProfilePartBloc() {
    _isFetchingPartController.add(false);
  }

  ApiService apiService = ApiService();

  // Reactive variables
  final _isFetchingPartController = BehaviorSubject<bool>();
  final _profilePartController = BehaviorSubject<ProfilePartModel>();

  // Streams
  Observable<bool> get isFetchingPartStream => _isFetchingPartController.stream;
  Observable<ProfilePartModel> get profileStream =>
      _profilePartController.stream;

  void fetchProfilePart(String profilePartId) async {
    if (!_isFetchingPartController.value) {
      _isFetchingPartController.add(true);

      await SharedPreferencesService.getAuthToken()
          .then((String token) =>
              apiService.fetchProfilePart(token, profilePartId))
          .then((ResponseModel<ProfilePartModel> response) {
        if (response.error == false) {
          return _profilePartController.add(response.data);
        } else {
          throw Exception(response.message);
        }
      }).catchError(_profilePartController.addError);

      _isFetchingPartController.add(false);
    }
  }

  @override
  void dispose() {
    _isFetchingPartController.close();
    _profilePartController.close();
  }
}
