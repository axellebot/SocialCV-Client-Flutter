import 'package:cv/src/blocs/bloc_provider.dart';
import 'package:cv/src/models/api_models.dart';
import 'package:cv/src/models/group_model.dart';
import 'package:cv/src/services/api_service.dart';
import 'package:cv/src/services/shared_preferences_service.dart';
import 'package:rxdart/rxdart.dart';

/// Business Logic Component for Group Fetch
class GroupBloc extends BlocBase {
  GroupBloc() {
    _isFetchingGroupController.add(false);
  }

  ApiService apiService = ApiService();

  // Reactive variables
  final _isFetchingGroupController = BehaviorSubject<bool>();
  final _groupController = BehaviorSubject<GroupModel>();

  // Streams
  Observable<bool> get isFetchingGroupStream =>
      _isFetchingGroupController.stream;
  Observable<GroupModel> get groupStream => _groupController.stream;

  void fetchGroup(String profileGroupId) async {
    if (!_isFetchingGroupController.value) {
      _isFetchingGroupController.add(true);

      await SharedPreferencesService.getAuthToken()
          .then((String token) => apiService.fetchGroup(token, profileGroupId))
          .then((ResponseModel<GroupModel> response) {
        if (response.error == false) {
          return _groupController.add(response.data);
        } else {
          throw Exception(response.message);
        }
      }).catchError(_groupController.addError);

      _isFetchingGroupController.add(false);
    }
  }

  @override
  void dispose() {
    _isFetchingGroupController.close();
    _groupController.close();
  }
}
