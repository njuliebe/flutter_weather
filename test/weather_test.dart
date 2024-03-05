// Import the test package and Counter class
import 'package:vs_app/http/weather.dart';
import 'package:test/test.dart';

void main() {
  test('Counter value should be incremented', () {
    WeatherFetch wf = WeatherFetch();
    Future<Weather> res = wf.fetchAlbum();
    res.then((value) => print(value));

    print('test done');
  });
}
