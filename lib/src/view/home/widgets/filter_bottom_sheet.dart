import 'package:flutter/material.dart';
import 'package:oru_phones/src/model/SearchFilters.dart';

class FiltersBottomSheet extends StatefulWidget {
  const FiltersBottomSheet({super.key, required this.filters});

  final SearchFilters filters;

  @override
  _FiltersBottomSheetState createState() => _FiltersBottomSheetState();
}

class _FiltersBottomSheetState extends State<FiltersBottomSheet> {
  int selectedCategoryIndex = 0;
  double minPrice = 5000;
  double maxPrice = 50000;

  late Map<String, List<String>> filters;

  @override
  void initState() {
    super.initState();
    filters = {
      "Brand": widget.filters.brands.toList(),
      "Condition": widget.filters.conditions.toList(),
      "Storage": widget.filters.storage.toList(),
      "RAM": widget.filters.ram.toList(),
      "Verification": ["Verified Only"],
      "Warranty": widget.filters.warranty.toList(),
      "Price Range": []
    };
  }

  Map<String, dynamic> selectedFilters = {};

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.58,
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          // Drag Handle
          Container(
            width: 40,
            height: 5,
            decoration: BoxDecoration(
              color: Colors.grey[400],
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          SizedBox(height: 10),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Filters",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
              ),
              IconButton(
                icon: Icon(Icons.close),
                onPressed: () => Navigator.pop(context),
              )
            ],
          ),

          Divider(),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: ListView.builder(
                    itemCount: filters.keys.length,
                    itemBuilder: (context, index) {
                      String category = filters.keys.elementAt(index);

                      return InkWell(
                        onTap: () {
                          setState(() {
                            selectedCategoryIndex = index;
                          });
                        },
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                          decoration: BoxDecoration(
                            color: selectedCategoryIndex == index
                                ? Colors.amber.withOpacity(0.2)
                                : Colors.transparent,
                            border: Border(
                              left: BorderSide(
                                color: selectedCategoryIndex == index
                                    ? Colors.amber
                                    : Colors.transparent,
                                width: 4,
                              ),
                            ),
                          ),
                          child: Text(category, style: TextStyle(fontSize: 16)),
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  width: 1,
                  height: double.infinity,
                  color: Colors.black26,
                ),
                // Selected Filter Options (Right Panel)
                Expanded(
                  flex: 4,
                  child: selectedCategoryIndex == filters.keys.length - 1
                      ? _buildVerticalPriceSlider()
                      : _buildFilterOptions(
                          filters.keys.elementAt(selectedCategoryIndex)),
                ),
              ],
            ),
          ),

          Divider(),

          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        selectedFilters.clear();
                        minPrice = 5000;
                        maxPrice = 50000;
                      });
                    },
                    child: Text(
                      "Clear All",
                      style: TextStyle(color: Colors.amber, fontSize: 16),
                    ),
                  ),
                ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.amber,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text("Apply"),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterOptions(String category) {
    List<String> options = filters[category] ?? [];

    return ListView.builder(
      itemCount: options.length,
      itemBuilder: (context, index) {
        String option = options[index];
        bool isSelected = selectedFilters[category]?.contains(option) ?? false;

        return CheckboxListTile(
          title: Text(option),
          value: isSelected,
          activeColor: Colors.amber,
          onChanged: (bool? value) {
            setState(() {
              if (value == true) {
                selectedFilters[category] = (selectedFilters[category] ?? [])
                  ..add(option);
              } else {
                selectedFilters[category]?.remove(option);
                if (selectedFilters[category]?.isEmpty ?? false) {
                  selectedFilters.remove(category);
                }
              }
            });
          },
        );
      },
    );
  }

  Widget _buildVerticalPriceSlider() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text("Price Range: ₹${minPrice.toInt()} - ₹${maxPrice.toInt()}",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        Expanded(
          child: RotatedBox(
            quarterTurns: 3,
            child: SliderTheme(
              data: SliderTheme.of(context).copyWith(
                trackHeight: 4.0,
                thumbShape: RoundSliderThumbShape(enabledThumbRadius: 8.0),
              ),
              child: RangeSlider(
                values: RangeValues(minPrice, maxPrice),
                min: 5000,
                max: 50000,
                divisions: 9,
                labels:
                    RangeLabels("₹${minPrice.toInt()}", "₹${maxPrice.toInt()}"),
                activeColor: Colors.black87,
                onChanged: (RangeValues values) {
                  setState(() {
                    minPrice = values.start;
                    maxPrice = values.end;
                  });
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
