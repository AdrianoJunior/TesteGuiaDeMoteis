import 'package:flutter/material.dart';
import 'package:guia_moteis/features/motels/domain/entities/suite_entity.dart';

class SuiteCard extends StatefulWidget {
  final SuiteEntity suite;

  const SuiteCard({Key? key, required this.suite}) : super(key: key);

  @override
  _SuiteCardState createState() => _SuiteCardState();
}

class _SuiteCardState extends State<SuiteCard> {
  bool showAllItems = false;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: screenWidth * 0.9,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 🖼️ Suite Image
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                    ),
                    child: widget.suite.photos.isNotEmpty
                        ? Image.network(
                      widget.suite.photos.first,
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) =>
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

                  // 🏷️ Suite Name
                  Center(
                    child: Text(
                      widget.suite.name,
                      style: const TextStyle(fontWeight: FontWeight.w300, fontSize: 20),
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),

          // 🔹 Item Icons (Max 5)
          _buildIconsRow(),

          const SizedBox(height: 12),

          // 💰 Pricing
          _buildPricingSection(),
        ],
      ),
    );
  }

  /// 🔹 Displays up to 5 item category icons
  Widget _buildIconsRow() {
    final iconsToShow = widget.suite.itemCategories.take(3).toList();
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: iconsToShow.map((item) {
                return Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(10)
                    ),

                    child: Image.network(
                      item.icon,
                      width: 52,
                      height: 52,
                      errorBuilder: (_, __, ___) => const Icon(Icons.error, size: 32),
                    ),
                  ),
                );
              }).toList(),
            ),
            InkWell(
              onTap: () => _showDetailsDialog(context),
              child: Row(
                children: const [
                  Text(
                    'ver\ntodos',
                    style: TextStyle(color: Colors.grey, fontSize: 14, fontWeight: FontWeight.w500),
                    textAlign: TextAlign.center,
                  ),
                  Icon(Icons.keyboard_arrow_down, color: Colors.grey),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 💰 Pricing Section
  Widget _buildPricingSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(vertical: 4),
          itemCount: widget.suite.pricing.length,
          itemBuilder: (context, index) {
            final pricing = widget.suite.pricing[index];

            return Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(pricing.formattedTime, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w400)),
                      if (pricing.discount != null) ...[
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(color: Colors.grey),
                          ),
                          child: Text(
                            '${((pricing.discount! / pricing.totalValue) * 100).round()}% OFF',
                            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey),
                          ),
                        ),
                      ],
                    ],
                  ),
                  subtitle: pricing.discount != null
                      ? Row(
                    children: [
                      Text(
                        'R\$ ${pricing.totalValue.toStringAsFixed(2)} ',
                        style: const TextStyle(fontSize: 16, color: Colors.grey, decoration: TextDecoration.lineThrough),
                      ),
                      Text(
                        'R\$ ${(pricing.totalValue - pricing.discount!).toStringAsFixed(2)}',
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.red),
                      ),
                    ],
                  )
                      : Text('R\$ ${pricing.totalValue.toStringAsFixed(2)}', style: const TextStyle(fontSize: 18)),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 24, color: Colors.grey),
                  onTap: () {},
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  void _showDetailsDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.7,
          minChildSize: 0.5,
          maxChildSize: 0.9,
          builder: (context, scrollController) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              child: SingleChildScrollView(
                controller: scrollController,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        width: 40,
                        height: 5,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    Center(
                      child: Text(
                        widget.suite.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 22,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 2,
                      ),
                    ),
                    const SizedBox(height: 24),

                    _buildSectionTitle('principais itens'),
                    const SizedBox(height: 12),

                    Wrap(
                      spacing: 24,
                      runSpacing: 12,
                      alignment: WrapAlignment.center,
                      children: widget.suite.itemCategories.map((item) {
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.network(
                              item.icon,
                              width: 32,
                              height: 32,
                              errorBuilder: (_, __, ___) =>
                              const Icon(Icons.error, size: 32),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              item.name,
                              style: const TextStyle(fontSize: 14),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 32),

                    _buildSectionTitle('tem também'),
                    const SizedBox(height: 12),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        widget.suite.features.join(', '),
                        style: const TextStyle(fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildSectionTitle(String title) {
    return Row(
      children: [
        const Expanded(
          child: Divider(
            color: Colors.grey,
            thickness: 1.2,
            endIndent: 8,
          ),
        ),
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Expanded(
          child: Divider(
            color: Colors.grey,
            thickness: 1.2,
            indent: 8,
          ),
        ),
      ],
    );
  }

}
