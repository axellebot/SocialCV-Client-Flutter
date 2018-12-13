import 'package:cv/src/blocs/bloc_provider.dart';
import 'package:cv/src/models/api_models.dart';
import 'package:cv/src/models/part_model.dart';
import 'package:cv/src/services/api_service.dart';
import 'package:cv/src/services/shared_preferences_service.dart';
import 'package:rxdart/rxdart.dart';

/// Business Logic Component for Profile Part Fetch
class PartBloc extends BlocBase {
  PartBloc() {
    _isFetchingPartController.add(false);
  }

  ApiService apiService = ApiService();

  // Reactive variables
  final _isFetchingPartController = BehaviorSubject<bool>();
  final _partController = BehaviorSubject<PartModel>();

  // Streams
  Observable<bool> get isFetchingPartStream => _isFetchingPartController.stream;

  Observable<PartModel> get partStream => _partController.stream;

  void fetchProfilePart(String profilePartId) async {
    if (!_isFetchingPartController.value) {
      _isFetchingPartController.add(true);

      await SharedPreferencesService.getAuthToken()
          .then((String token) => apiService.fetchPart(token, profilePartId))
          .then((ResponseModel<PartModel> response) {
        if (response.error == false) {
          return _partController.add(response.data);
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
