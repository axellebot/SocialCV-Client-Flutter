import 'package:cv/src/blocs/bloc_provider.dart';
import 'package:cv/src/models/api_models.dart';
import 'package:cv/src/models/group_model.dart';
import 'package:cv/src/services/cv_api_service.dart';
import 'package:cv/src/services/shared_preferences_service.dart';
import 'package:cv/src/utils/logger.dart';
import 'package:rxdart/rxdart.dart';

/// Business Logic Component for Group Fetch
class GroupBloc extends BlocBase {
  GroupBloc() {
    _isFetchingGroupController.add(false);
  }

  CVApiService apiService = CVApiService();

  // Reactive variables
  final _isFetchingGroupController = BehaviorSubject<bool>();
  final _groupController = BehaviorSubject<GroupModel>();

  // Streams
  Observable<bool> get isFetchingGroupStream =>
      _isFetchingGroupController.stream;

  Observable<GroupModel> get groupStream => _groupController.stream;

  void fetchGroup(String groupId) async {
    logger.info('fetchGroup');
    if (!_isFetchingGroupController.value) {
      _isFetchingGroupController.add(true);

      String accessToken = await SharedPreferencesService.getAccessToken();

      await apiService
          .fetchGroup(
        accessToken: accessToken,
        groupId: groupId,
      )
          .then((ResponseModel<GroupModel> response) {
        if (response.error == false) {
          _groupController.add(response.data);
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
