import 'package:flutter/material.dart';
import 'package:guia_moteis/features/motels/domain/entities/suite_entity.dart';

class SuiteCard extends StatelessWidget {
  final SuiteEntity suite;

  const SuiteCard({Key? key, required this.suite}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: screenWidth * 0.9, // 90% of the screen width
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Suite Image
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                    ),
                    child: suite.photos.isNotEmpty
                        ? Image.network(
                      suite.photos.first,
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.broken_image, size: 100, color: Colors.grey),
                    )
                        : const SizedBox(
                      height: 200,
                      child: Center(
                        child: Icon(Icons.broken_image, size: 100, color: Colors.grey),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Center(
                    child: Text(
                      suite.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 20,
                      ),
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 4),

          // Pricing Section (Now dynamically expands)
          if (suite.pricing.isNotEmpty)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListView.builder(
                  shrinkWrap: true, // Ensures it takes only as much space as needed
                  physics: const NeverScrollableScrollPhysics(), // Prevents inner scrolling
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  itemCount: suite.pricing.length,
                  itemBuilder: (context, index) {
                    final pricing = suite.pricing[index];

                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          contentPadding: EdgeInsets.zero,
                          title: Row(
                            mainAxisSize: MainAxisSize.min, // Keeps title and badge close
                            children: [
                              Text(
                                pricing.formattedTime,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              if (pricing.discount != null) ...[
                                const SizedBox(width: 8), // Add spacing when discount exists
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6),
                                    border: Border.all(color: Colors.grey), // Grey border
                                  ),
                                  child: Text(
                                    '${((pricing.discount! / pricing.totalValue) * 100).round()}% OFF',
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                              ],
                            ],
                          ),
                          subtitle: pricing.discount != null
                              ? Row(
                            children: [
                              // Original Price (Strikethrough)
                              Text(
                                'R\$ ${pricing.totalValue.toStringAsFixed(2)} ',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey,
                                  decoration: TextDecoration.lineThrough, // Strikethrough
                                ),
                              ),

                              // Discounted Price (Red)
                              Text(
                                'R\$ ${(pricing.totalValue - pricing.discount!).toStringAsFixed(2)}',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red, // Discounted price in red
                                ),
                              ),
                            ],
                          )
                              : Text(
                            'R\$ ${pricing.totalValue.toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                            ),
                          ),
                          trailing: const Icon(
                            Icons.arrow_forward_ios,
                            size: 24,
                            color: Colors.grey,
                          ),
                          onTap: () {}, // Navigate to details page or action
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 8),
              ],
            ),
        ],
      ),
    );
  }
}
