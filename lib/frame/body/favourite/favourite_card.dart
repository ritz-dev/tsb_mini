
import 'package:flutter/material.dart';
import 'package:tsb_mini/package_mode.dart';
import 'package:tsb_mini/theme/responsive.dart';

class FavouriteCard extends StatefulWidget {
  final List<Map<String, dynamic>>? data;
  final String? search;
  final double? minPoint;
  final double? maxPoint;

  const FavouriteCard({
    super.key,
    this.data,
    this.search,
    this.minPoint,
    this.maxPoint,
  });

  @override
  State<FavouriteCard> createState() => _FavouriteCardState();
}

class _FavouriteCardState extends State<FavouriteCard> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    double containerHeight(double height) {
      if (height <= Responsive.mobileBreakpoint) {
        return 380;
      } else if (height <= Responsive.tabletBreakpoint) {
        return 670;
      } else {
        return 800; // desktop
      }
    }

    final filteredData = widget.data?.where((item) {
      final point = int.tryParse(item["point"].toString()) ?? 0;

      final isInRange = point >= (widget.minPoint ?? 0) &&
          point <= (widget.maxPoint ?? double.infinity);

      // fixed null check for search
      if (widget.search?.isEmpty ?? true) {
        return isInRange;
      } else {
        final searchLower = widget.search!.toLowerCase();
        final message = item["message"].toString().toLowerCase();
        final name = item["name"].toString().toLowerCase();
        final matchesSearch =
            message.contains(searchLower) || name.contains(searchLower);
        return matchesSearch && isInRange;
      }
    }).toList();

    if (filteredData == null || filteredData.isEmpty) {
      return Expanded(
        child: Center(
          child: PackageAssets.image(
            "assets/image/NoDataFound.png",
            width: 182,
            height: 169,
            fit: BoxFit.contain,
          ),
        ),
      );
    }


    return Expanded(
      child: ListView.builder(
        itemCount: filteredData.length,
        itemBuilder: (context, index) {
          final item = filteredData[index];
      
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 5,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Left - Image
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12), // round top-left
                    bottomLeft: Radius.circular(12), // round bottom-left
                  ),
                  child: PackageAssets.image(
                    item["image"], // your image url
                    width: screenWidth * 0.25,
                    height: screenWidth * 0.25,
                    fit: BoxFit.cover,
                  ),
                ),
      
                const SizedBox(width: 12),
      
                // Middle - Title, Point, Date
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            item["message"],
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          // SizedBox(width: 5),
                          PackageAssets.image(
                            item["icon"],
                            width: 20,
                            height: 20,
                            fit: BoxFit.contain,
                          )
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "${item["point"]} Points", // <-- was "points"
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.green,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${item["status"]} on ${item["date"]}',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
