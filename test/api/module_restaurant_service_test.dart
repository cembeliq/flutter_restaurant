import 'package:dicoding_restaurant_app/data/api/restaurant_service.dart';
import 'package:dicoding_restaurant_app/data/model/restaurant_result.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'module_restaurant_service_test.mocks.dart';

var apiResponse = {
  "tes": 123,
  "error": false,
  "message": "success",
  "count": 1,
  "restaurants": [
    {
      "id": "rqdv5juczeskfw1e867",
      "name": "Melting Pot",
      "description": "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet.",
      "pictureId": "14",
      "city": "Medan",
      "rating": 4.2
    }
  ]
};

@GenerateMocks([http.Client])
void main() {
  group('fetch restaurant api', () {
    test('return an RestaurantResult if the http call completes successfully', () async {
      final client = new MockClient();

      when(client.get(Uri.https('restaurant-api.dicoding.dev', '/list')))
        .thenAnswer((_) async => http.Response(apiResponse.toString(), 200));

      expect(await RestaurantService().listRestaurant(), isA<RestaurantResult>());
    });

  });
}