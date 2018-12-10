import 'package:cv/src/blocs/bloc_provider.dart';
import 'package:cv/src/models/api_models.dart';
import 'package:cv/src/models/profile_entry_model.dart';
import 'package:cv/src/services/api_service.dart';
import 'package:cv/src/services/shared_preferences_service.dart';
import 'package:rxdart/rxdart.dart';

/// Business Logic Component for Profile Entry Fetch
class ProfileEntryBloc extends BlocBase {
  ProfileEntryBloc() {
    _isFetchingEntryController.add(false);
  }

  ApiService apiService = ApiService();

  // Reactive variables
  final _isFetchingEntryController = BehaviorSubject<bool>();
  final _profileEntryController = BehaviorSubject<ProfileEntryModel>();

  // Streams
  Observable<bool> get isFetchingStream => _isFetchingEntryController.stream;
  Observable<ProfileEntryModel> get profileStream =>
      _profileEntryController.stream;

  void fetchProfileEntry(String profileEntryId) async {
    if (!_isFetchingEntryController.value) {
      _isFetchingEntryController.add(true);

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

      _isFetchingEntryController.add(false);
    }
  }

  @override
  void dispose() {
    _isFetchingEntryController.close();
    _profileEntryController.close();
  }
}
