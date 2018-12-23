import 'package:cv/src/blocs/bloc_provider.dart';
import 'package:cv/src/models/api_models.dart';
import 'package:cv/src/models/part_model.dart';
import 'package:cv/src/services/api_service.dart';
import 'package:cv/src/services/shared_preferences_service.dart';
import 'package:cv/src/utils/logger.dart';
import 'package:rxdart/rxdart.dart';

/// Business Logic Component for Part List Fetch
class PartListBloc extends BlocBase {
  PartListBloc() {
    _isFetchingPartsController.add(false);
  }

  ApiService apiService = ApiService();

  // Reactive variables
  final _isFetchingPartsController = BehaviorSubject<bool>();
  final _partsController = BehaviorSubject<List<PartModel>>();

  // Streams
  Observable<bool> get isFetchingPartsStream =>
      _isFetchingPartsController.stream;

  Observable<List<PartModel>> get partsStream => _partsController.stream;

  void fetchProfileParts(String profileId) async {
    logger.info('fetchProfileParts');
    if (!_isFetchingPartsController.value) {
      _isFetchingPartsController.add(true);

      await SharedPreferencesService.getAuthToken()
          .then(
              (String token) => apiService.fetchProfileParts(token, profileId))
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
  }
}
