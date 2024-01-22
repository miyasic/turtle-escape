import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'my_value.g.dart';

@riverpod
String city(CityRef ref) => 'London';

@riverpod
String country(CountryRef ref) => 'England';

// I don't know why this annotation is working
// https://stackoverflow.com/questions/76591540/how-to-correctly-override-in-tests-the-provider-generated-by-riverpod
@Riverpod(dependencies: [])
Stream<int> counter(CounterRef ref) async* {
  var i = 0;
  while (true) {
    await Future<void>.delayed(Duration(seconds: i));
    yield i++;
  }
}
