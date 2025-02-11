import 'package:flutter/material.dart';

class SortBottomSheet extends StatefulWidget{
  const SortBottomSheet({super.key});

  @override
  _SortBottomSheetState createState() => _SortBottomSheetState();
}

class _SortBottomSheetState extends State<SortBottomSheet> {
  int selectedOption = 0;

  final List<String> sortOptions = [
    "Value For Money",
    "Price: High To Low",
    "Price: Low To High",
    "Latest",
    "Distance",
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Drag Handle
          Container(
            width: 40,
            height: 5,
            margin: EdgeInsets.only(top: 8, bottom: 10),
            decoration: BoxDecoration(
              color: Colors.grey[400],
              borderRadius: BorderRadius.circular(10),
            ),
          ),

          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Sort",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
              ),
              IconButton(
                icon: Icon(Icons.close),
                onPressed: () => Navigator.pop(context),
              )
            ],
          ),

          Divider(),


          Flexible(
            child: SingleChildScrollView(
              child: Column(
                children: List.generate(sortOptions.length, (index) {
                  return InkWell(
                    onTap: () {
                      setState(() {
                        selectedOption = index;
                      });
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                      decoration: BoxDecoration(
                        color: selectedOption == index
                            ? Colors.amber.withOpacity(0.2)
                            : Colors.transparent,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            sortOptions[index],
                            style: TextStyle(fontSize: 16),
                          ),
                          Radio(
                            value: index,
                            groupValue: selectedOption,
                            activeColor: Colors.amber,
                            onChanged: (value) {
                              setState(() {
                                selectedOption = value as int;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),

          Divider(),

          Padding(
            padding: const EdgeInsets.only(left: 10, bottom: 20,right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                  onPressed: () {
                    setState(() {
                      selectedOption = -1;
                    });
                  },
                  child: Text(
                    "Clear",
                    style: TextStyle(color: Colors.amber, fontSize: 18),
                  ),
                ),
                MaterialButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  height: 40,
                  minWidth: 140,
                  onPressed: () {},
                  color: Colors.amber,
                  child: Text("Apply",style: TextStyle(fontSize: 18),),
                )
              ],
            ),
          )

        ],
      ),
    );
  }
}
