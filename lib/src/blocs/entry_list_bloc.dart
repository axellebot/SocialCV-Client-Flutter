import 'package:cv/src/blocs/bloc_provider.dart';
import 'package:cv/src/commons/values.dart';
import 'package:cv/src/models/api_models.dart';
import 'package:cv/src/models/entry_model.dart';
import 'package:cv/src/services/api_service.dart';
import 'package:cv/src/services/shared_preferences_service.dart';
import 'package:cv/src/utils/logger.dart';
import 'package:rxdart/rxdart.dart';

/// Business Logic Component for Entry List Fetch
class EntryListBloc extends BlocBase {
  EntryListBloc() {
    _isFetchingEntriesController.add(false);
    _entryPerPage.add(KCVItemsPerPageDefault);
  }

  ApiService apiService = ApiService();

  // Reactive variables
  final _isFetchingEntriesController = BehaviorSubject<bool>();
  final _entriesController = BehaviorSubject<List<EntryModel>>();
  final _entryPerPage = BehaviorSubject<String>();

  // Streams
  Observable<bool> get isFetchingGroupEntriesStream =>
      _isFetchingEntriesController.stream;

  Observable<List<EntryModel>> get entriesStream => _entriesController.stream;

  Observable<String> get entryPerPage => _entryPerPage.stream;

  // Human functions
  void setItemsPerPage(String partPerPage) async {
    _entryPerPage.add(partPerPage);
  }

  void fetchGroupEntries(String groupId) async {
    logger.info('fetchGroupEntries');
    if (!_isFetchingEntriesController.value) {
      _isFetchingEntriesController.add(true);

      await SharedPreferencesService.getAuthToken()
          .then((String token) => apiService.fetchGroupEntries(token, groupId))
          .then((ResponseModelWithArray<EntryModel> response) {
        if (response.error == false) {
          _entriesController.add(response.data);
        } else {
          throw Exception(response.message);
        }
      }).catchError(_entriesController.addError);

      _isFetchingEntriesController.add(false);
    }
  }

  @override
  void dispose() {
    _isFetchingEntriesController.close();
    _entriesController.close();
    _entryPerPage.close();
  }
}
