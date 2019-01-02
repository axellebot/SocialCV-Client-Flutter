import 'package:cv/src/blocs/bloc_provider.dart';
import 'package:cv/src/commons/values.dart';
import 'package:cv/src/models/api_models.dart';
import 'package:cv/src/models/part_model.dart';
import 'package:cv/src/services/cv_api_service.dart';
import 'package:cv/src/services/shared_preferences_service.dart';
import 'package:cv/src/utils/logger.dart';
import 'package:rxdart/rxdart.dart';

/// Business Logic Component for Part List Fetch
class PartListBloc extends BlocBase {
  PartListBloc() {
    _isFetchingPartsController.add(false);
    _partPerPage.add(KCVItemsPerPageDefault);
  }

  CVApiService apiService = CVApiService();

  // Reactive variables
  final _isFetchingPartsController = BehaviorSubject<bool>();
  final _partsController = BehaviorSubject<List<PartModel>>();
  final _partPerPage = BehaviorSubject<String>();

  // Streams
  Observable<bool> get isFetchingPartsStream =>
      _isFetchingPartsController.stream;

  Observable<List<PartModel>> get partsStream => _partsController.stream;

  Observable<String> get partPerPage => _partPerPage.stream;

  // Human functions
  void setItemsPerPage(String partPerPage) async {
    _partPerPage.add(partPerPage);
  }

  void fetchProfileParts(String profileId) async {
    logger.info('fetchProfileParts');
    if (!_isFetchingPartsController.value) {
      _isFetchingPartsController.add(true);

      String accessToken = await SharedPreferencesService.getAccessToken();

      await apiService
          .fetchProfileParts(
        accessToken: accessToken,
        profileId: profileId,
      )
          .then((ResponseModelWithArray<PartModel> response) {
        if (response.error == false) {
          _partsController.add(response.data);
        } else {
          throw Exception(response.message);
        }
      }).catchError(_partsController.addError);

      _isFetchingPartsController.add(false);
    }
  }

  @override
  void dispose() {
    _isFetchingPartsController.close();
    _partsController.close();
    _partPerPage.close();
  }
}
