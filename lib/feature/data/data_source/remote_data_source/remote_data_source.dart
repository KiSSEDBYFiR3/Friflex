import 'dart:convert';
import 'package:friflex_test_task/feature/data/data_source/remote_data_source/i_remote_data_source.dart';
import 'package:friflex_test_task/feature/data/model/weather_model.dart';
import 'package:http/http.dart' as http;

class RemoteDataSource implements IRemoteDataSource {
  static const _apiKey = '958e4e5a2110e49eec0ce1acb5d008ce';
  late final String url;

  RemoteDataSource(
      {this.url =
          "https://api.openweathermap.org/data/2.5/forecast?appid=$_apiKey&units=metric&cnt=24"});

  @override
  // Делаем запрос в сеть. В случае ошибки, отлавливаем ее
  Future<WeatherModel> fetchWeatherForecast(String cityName) async {
    try {
      final response = await http.get(Uri.parse("$url&q=$cityName"));
      return WeatherModel.fromJson(json.decode(response.body));
    } catch (e) {
      throw Exception("Something went wrong while fetching data");
    }
  }
}
