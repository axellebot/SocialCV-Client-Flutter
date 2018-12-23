import 'package:cv/src/blocs/bloc_provider.dart';
import 'package:cv/src/commons/logger.dart';
import 'package:cv/src/models/api_models.dart';
import 'package:cv/src/models/entry_model.dart';
import 'package:cv/src/services/api_service.dart';
import 'package:cv/src/services/shared_preferences_service.dart';
import 'package:rxdart/rxdart.dart';

/// Business Logic Component for Entry Fetch
class EntryBloc extends BlocBase {
  EntryBloc() {
    _isFetchingEntryController.add(false);
  }

  ApiService apiService = ApiService();

  // Reactive variables
  final _isFetchingEntryController = BehaviorSubject<bool>();
  final _entryController = BehaviorSubject<EntryModel>();

  // Streams
  Observable<bool> get isFetchingEntryStream =>
      _isFetchingEntryController.stream;

  Observable<EntryModel> get entryStream => _entryController.stream;

  void fetchEntry(String profileEntryId) async {
    logger.info('fetchEntry');
    if (!_isFetchingEntryController.value) {
      _isFetchingEntryController.add(true);

      await SharedPreferencesService.getAuthToken()
          .then((String token) => apiService.fetchEntry(token, profileEntryId))
          .then((ResponseModel<EntryModel> response) {
        if (response.error == false) {
          _entryController.add(response.data);
        } else {
          throw Exception(response.message);
        }
      }).catchError(_entryController.addError);

      _isFetchingEntryController.add(false);
    }
  }

  @override
  void dispose() {
    _isFetchingEntryController.close();
    _entryController.close();
  }
}
