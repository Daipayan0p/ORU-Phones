import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TopBrandBottomSheet extends StatefulWidget {
  @override
  _TopBrandBottomSheetState createState() => _TopBrandBottomSheetState();
}

class _TopBrandBottomSheetState extends State<TopBrandBottomSheet> {
  Future<List<dynamic>> fetchBrands() async {
    try {
      final response =
          await http.get(Uri.parse("http://40.90.224.241:5000/makeWithImages"));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data["dataObject"] ?? [];
      } else {
        throw Exception("Failed to load brands: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Failed to fetch brands: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
      future: fetchBrands(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(
              child: Text("Error: ${snapshot.error}",
                  style: TextStyle(color: Colors.red)));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(
              child: Text("No brands available",
                  style: TextStyle(color: Colors.grey)));
        }

        final brands = snapshot.data!;

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Select a Brand",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: Icon(Icons.close),
                  )
                ],
              ),
              Divider(),

              Expanded(
                child: GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4, // 3 brands per row
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 1.0, // Square items
                  ),
                  itemCount: brands.length,
                  itemBuilder: (context, index) {
                    final brand = brands[index];
                    final imageUrl = brand["imagePath"];

                    return Card(
                      color: Colors.white,
                      elevation: 2,
                      shape: CircleBorder(),
                      child: InkWell(
                        onTap: () {
                          // Handle brand tap
                          print("Brand tapped: ${brand["name"]}");
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (imageUrl != null)
                              Image.network(
                                imageUrl,
                                width: 50,
                                height: 50,
                                errorBuilder: (context, error, stackTrace) =>
                                    const Icon(Icons.broken_image,
                                        size: 50, color: Colors.grey),
                              ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }
}
