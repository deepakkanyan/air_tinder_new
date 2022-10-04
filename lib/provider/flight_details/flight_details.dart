
import 'package:air_tinder/utils/instances.dart';

class FlightDetailsProvider{
  static FlightDetailsProvider instance = FlightDetailsProvider();
  final String departureCity = userDetailModel.departureDetails!['departureCity'];
  final String departureAirport =
  userDetailModel.departureDetails!['departureAirPort'];

  final String layoverCity = userDetailModel.layoverDetails!['layoverCity'];
  final String layoverAirport = userDetailModel.layoverDetails!['layoverAirPort'];

  final String landingCity = userDetailModel.landingDetails!['landingCity'];
  final String landingAirport = userDetailModel.landingDetails!['landingAirport'];

}