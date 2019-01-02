import 'package:cv/src/blocs/bloc_provider.dart';
import 'package:cv/src/commons/values.dart';
import 'package:cv/src/models/api_models.dart';
import 'package:cv/src/models/group_model.dart';
import 'package:cv/src/services/cv_api_service.dart';
import 'package:cv/src/services/shared_preferences_service.dart';
import 'package:cv/src/utils/logger.dart';
import 'package:rxdart/rxdart.dart';

/// Business Logic Component for Group List Fetch
class GroupListBloc extends BlocBase {
  GroupListBloc() {
    _isFetchingGroupsController.add(false);
    _groupPerPage.add(KCVItemsPerPageDefault);
  }

  CVApiService apiService = CVApiService();

  // Reactive variables
  final _isFetchingGroupsController = BehaviorSubject<bool>();
  final _profileGroupsController = BehaviorSubject<List<GroupModel>>();
  final _groupPerPage = BehaviorSubject<String>();

  // Streams
  Observable<bool> get isFetchingGroupsStream =>
      _isFetchingGroupsController.stream;

  Observable<List<GroupModel>> get groupsStream =>
      _profileGroupsController.stream;

  Observable<String> get groupPerPage => _groupPerPage.stream;

  // Human functions
  void setItemsPerPage(String partPerPage) async {
    _groupPerPage.add(partPerPage);
  }

  void fetchPartGroups(String partId) async {
    logger.info('fetchPartGroups');
    if (!_isFetchingGroupsController.value) {
      _isFetchingGroupsController.add(true);

      String accessToken = await SharedPreferencesService.getAccessToken();

      await apiService
          .fetchPartGroups(
        accessToken: accessToken,
        partId: partId,
      )
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
    _groupPerPage.close();
  }
}
