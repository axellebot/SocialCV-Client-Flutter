import 'package:cv/src/blocs/bloc_provider.dart';
import 'package:cv/src/models/api_models.dart';
import 'package:cv/src/models/group_model.dart';
import 'package:cv/src/services/api_service.dart';
import 'package:cv/src/services/shared_preferences_service.dart';
import 'package:cv/src/utils/logger.dart';
import 'package:rxdart/rxdart.dart';

/// Business Logic Component for Group List Fetch
class GroupListBloc extends BlocBase {
  GroupListBloc() {
    _isFetchingGroupsController.add(false);
  }

  ApiService apiService = ApiService();

  // Reactive variables
  final _isFetchingGroupsController = BehaviorSubject<bool>();
  final _profileGroupsController = BehaviorSubject<List<GroupModel>>();

  // Streams
  Observable<bool> get isFetchingGroupsStream =>
      _isFetchingGroupsController.stream;

  Observable<List<GroupModel>> get groupsStream =>
      _profileGroupsController.stream;

  void fetchPartGroups(String profilePartId) async {
    logger.info('fetchPartGroups');
    if (!_isFetchingGroupsController.value) {
      _isFetchingGroupsController.add(true);

      await SharedPreferencesService.getAuthToken()
          .then((String token) =>
              apiService.fetchPartGroups(token, profilePartId))
          .then((ResponseModelWithArray<GroupModel> response) {
        if (response.error == false) {
          _profileGroupsController.add(response.data);
        } else {
          throw Exception(response.message);
        }
      }).catchError(_profileGroupsController.addError);

      _isFetchingGroupsController.add(false);
    }
  }

  @override
  void dispose() {
    _isFetchingGroupsController.close();
    _profileGroupsController.close();
  }
}
