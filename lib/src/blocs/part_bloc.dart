import 'package:cv/src/blocs/bloc_provider.dart';
import 'package:cv/src/models/api_models.dart';
import 'package:cv/src/models/part_model.dart';
import 'package:cv/src/services/cv_api_service.dart';
import 'package:cv/src/services/shared_preferences_service.dart';
import 'package:cv/src/utils/logger.dart';
import 'package:rxdart/rxdart.dart';

/// Business Logic Component for Profile Part Fetch
class PartBloc extends BlocBase {
  PartBloc() {
    _isFetchingPartController.add(false);
  }

  CVApiService apiService = CVApiService();

  // Reactive variables
  final _isFetchingPartController = BehaviorSubject<bool>();
  final _partController = BehaviorSubject<PartModel>();

  // Streams
  Observable<bool> get isFetchingPartStream => _isFetchingPartController.stream;

  Observable<PartModel> get partStream => _partController.stream;

  void fetchPart(String profilePartId) async {
    logger.info('fetchProfilePart');
    if (!_isFetchingPartController.value) {
      _isFetchingPartController.add(true);

      String accessToken = await SharedPreferencesService.getAccessToken();

      await apiService.fetchPart(
                accessToken: accessToken,
                partId: profilePartId,
              )
          .then((ResponseModel<PartModel> response) {
        if (response.error == false) {
          _partController.add(response.data);
        } else {
          throw Exception(response.message);
        }
      }).catchError(_partController.addError);

      _isFetchingPartController.add(false);
    }
  }

  @override
  void dispose() {
    _isFetchingPartController.close();
    _partController.close();
  }
}
