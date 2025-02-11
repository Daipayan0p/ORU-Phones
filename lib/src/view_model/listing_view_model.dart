import 'package:oru_phones/src/api/api.dart';
import 'package:oru_phones/src/model/Listing.dart';
import 'package:oru_phones/src/model/SearchFilters.dart';
import 'package:stacked/stacked.dart';

class ListingViewModel extends BaseViewModel {
  late List<Listing> data = [];
  late SearchFilters filters;

  void getFilters() async {
    filters = await Api.showSearchFilters();
    rebuildUi();
  }

  void getData() async {
    data = await Api.fetchListings();
    rebuildUi();
  }
}
