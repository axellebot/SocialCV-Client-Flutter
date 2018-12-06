import 'package:cv/src/blocs/bloc_provider.dart';
import 'package:cv/src/models/api_models.dart';
import 'package:cv/src/models/profile_entry_model.dart';
import 'package:cv/src/services/api_service.dart';
import 'package:cv/src/services/shared_preferences_service.dart';
import 'package:rxdart/rxdart.dart';

/// Business Logic Component for Profile Entry Fetch
class ProfileEntryBloc extends BlocBase {
  ProfileEntryBloc() {
    _isFetchingController.add(false);
  }

  // Reactive variables
  final _profileEntryController = BehaviorSubject<ProfileEntryModel>();
  final _isFetchingController = BehaviorSubject<bool>();

  ApiService apiService = ApiService();

  // Streams
  Observable<ProfileEntryModel> get profileStream =>
      _profileEntryController.stream;

  Observable<bool> get isFetchingStream => _isFetchingController.stream;

  void fetchProfileEntry(String profileEntryId) async {
    if (!_isFetchingController.value) {
      _isFetchingController.add(true);

      await SharedPreferencesService.getAuthToken()
          .then((String token) =>
              apiService.fetchProfileEntry(token, profileEntryId))
          .then((ResponseModel<ProfileEntryModel> response) {
        if (response.error == false) {
          return _profileEntryController.add(response.data);
        } else {
          throw Exception(response.message);
        }
      }).catchError(_profileEntryController.addError);

      _isFetchingController.add(false);
    }
  }

  @override
  void dispose() {
    _profileEntryController.close();
  }
}
