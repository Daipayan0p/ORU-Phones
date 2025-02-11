import 'dart:io';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

class Product {
  final String imageUrl;
  final String title;
  final String price;
  final String location;
  final String date;
  final String specifications;
  final String condition;
  final bool isVerified;

  Product({
    required this.imageUrl,
    required this.title,
    required this.price,
    required this.location,
    required this.date,
    required this.specifications,
    required this.condition,
    this.isVerified = false,
  });
}

class ProductCard extends StatelessWidget {
  final Product product;
  const ProductCard({super.key, required this.product});

  double scaleText(BuildContext context, double fontSize) {
    double scaleFactor = MediaQuery.of(context).size.width / 375;
    double adjustedSize = fontSize * scaleFactor;
    if (Platform.isAndroid) {
      adjustedSize -= 4;
    }
    return adjustedSize;
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade500,
            spreadRadius: 2,
            blurRadius: 30,
          ),
        ],
      ),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8),
              topRight: Radius.circular(8),
            ),
            child: Image.network(
              product.imageUrl,
              height: size.height*0.206,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          if (product.isVerified)
            Positioned(
              top: 10,
              child: Image.asset("assets/ORUVerified.png"),
            ),
          Positioned(
            top: 10,
            right: 10,
            child: Icon(
              Icons.favorite_border,
              color: Colors.white,
              size: 26,
            ),
          ),
          Positioned(
            bottom: size.height * 0.135,
            child: Container(
              width: 174,
              decoration: BoxDecoration(color: Color(0xA04C4C4C)),
              child: Center(
                child: AutoSizeText(
                  "PRICE NEGOTIABLE",
                  maxLines: 1,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: scaleText(context, 16),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Color(0xFFDFDFDF),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(8),
                  bottomRight: Radius.circular(8),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: AutoSizeText(
                      product.location,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.grey.shade700,
                        fontSize: scaleText(context, 14),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  AutoSizeText(
                    product.date,
                    maxLines: 1,
                    style: TextStyle(
                      color: Colors.grey.shade700,
                      fontSize: scaleText(context, 14),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 90,
            left: 8,
            right: 8,
            child: AutoSizeText(
              product.title,
              maxLines: 1,
              minFontSize: 18, // Adjust to prevent text from being too small
              overflow: TextOverflow.ellipsis, // Ensure text doesn't break UI
              wrapWords: false, // Prevent breaking words mid-line
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: scaleText(context, 18),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Positioned(
            bottom: 40,
            left: 8,
            child: AutoSizeText(
              product.price,
              maxLines: 1,
              style: TextStyle(
                fontSize: scaleText(context, 20),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Positioned(
            bottom: 70,
            left: 8,
            child: Row(
              children: [
                AutoSizeText(
                  product.specifications,
                  maxLines: 1,
                  style: TextStyle(
                    fontSize: scaleText(context, 15),
                    fontWeight: FontWeight.w500,
                    color: Colors.grey.shade600,
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 5),
                  height: 5,
                  width: 5,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey.shade600,
                  ),
                ),
                AutoSizeText(
                  product.condition,
                  maxLines: 1,
                  style: TextStyle(
                    fontSize: scaleText(context, 15),
                    fontWeight: FontWeight.w500,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
