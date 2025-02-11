import 'package:flutter/material.dart';
import 'package:oru_phones/src/view/home/widgets/SortBottomSheet.dart';
import 'package:oru_phones/src/view/home/widgets/filter_bottom_sheet.dart';
import 'package:oru_phones/src/view/home/widgets/outlined_button.dart';
import 'package:oru_phones/src/view/home/widgets/product_card.dart';
import 'package:oru_phones/src/view_model/listing_view_model.dart';
import 'package:stacked/stacked.dart';

class Body2 extends StatelessWidget {
  const Body2({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => ListingViewModel(),
      builder: (context, viewModel, child) {
        viewModel.getFilters();
        viewModel.getData();
        if (viewModel.data.isEmpty) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text(
                  "Best Deal in India",
                  style: TextStyle(fontSize: 22, color: Color(0xFF525252)),
                ),
              ),
              SizedBox(height: 10),
              SizedBox(
                height: 35,
                child: _besDealListView(context,viewModel),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // Two cards per row
                    crossAxisSpacing: 14.0,
                    mainAxisSpacing: 10.0,
                    childAspectRatio: .58, // Allow cards to take full height
                  ),
                  itemCount: viewModel.data.length,
                  itemBuilder: (context, index) => ProductCard(
                    product: Product(
                      imageUrl: viewModel.data[index].defaultImage,
                      title: viewModel.data[index].marketingName,
                      price: "₹ ${viewModel.data[index].discountedPrice}0",
                      location:
                          "${viewModel.data[index].listingState} ${viewModel.data[index].listingLocality}",
                      date: viewModel.data[index].listedBy,
                      // date: "July 25th",
                      specifications:
                          "${viewModel.data[index].deviceRam}/${viewModel.data[index].deviceStorage}",
                      condition: viewModel.data[index].deviceCondition,
                      isVerified: viewModel.data[index].verified,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _besDealListView(BuildContext context, ListingViewModel viewModel) {
    final List<Widget> navItems = [
      GestureDetector(
        onTap: () {
          _showSortBottomSheet(context);
        },
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.swap_vert, size: 18, color: Colors.black),
            SizedBox(width: 4),
            Text("Sort", style: TextStyle(fontSize: 16, color: Colors.black)),
            SizedBox(width: 4),
            Icon(Icons.arrow_drop_down, size: 18, color: Colors.black),
          ],
        ),
      ),
      GestureDetector(
        onTap: () {
          _showFiltersBottomSheet(context,viewModel);
        },
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.tune, size: 18, color: Colors.black),
            SizedBox(width: 4),
            Text("Filter", style: TextStyle(fontSize: 16, color: Colors.black)),
            SizedBox(width: 4),
            Icon(Icons.arrow_drop_down, size: 18, color: Colors.black),
          ],
        ),
      ),
    ];
    return ListViewOutLinedButton(itemList: navItems);
  }
}

void _showSortBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    isScrollControlled: true,
    builder: (context) {
      return SortBottomSheet();
    },
  );
}

void _showFiltersBottomSheet(BuildContext context, ListingViewModel viewModel) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.white,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      return FiltersBottomSheet(filters: viewModel.filters);
    },
  );
}
