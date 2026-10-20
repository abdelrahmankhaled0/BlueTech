import 'package:beauty_app/core/constants/app_colors.dart';
import 'package:beauty_app/features/home/data/models/product_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key, required this.product});

  final ProductModel product;

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  int _selectedImageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final product = widget.product;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark
        ? AppColors.darkTextPrimary
        : AppColors.lightTextPrimary;
    final secondaryTextColor = isDark
        ? AppColors.darkTextSecondary
        : AppColors.lightTextSecondary;
    final borderColor = isDark ? AppColors.darkBorder : AppColors.lightBorder;
    final images = product.images.isNotEmpty
        ? product.images
        : [product.imageUri];
    final discountedPrice =
        product.price * (1 - product.discountPercentage / 100);

    return Scaffold(
      appBar: AppBar(title: const Text('Product details')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildGallery(images, borderColor),
            const Gap(24),
            if (product.category.isNotEmpty)
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: isDark ? AppColors.darkCard : AppColors.lightCard,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  product.category.replaceAll('-', ' ').toUpperCase(),
                  style: TextStyle(
                    color: secondaryTextColor,
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1,
                  ),
                ),
              ),
            const Gap(10),
            if (product.brand.isNotEmpty) ...[
              Text(
                product.brand,
                style: TextStyle(
                  color: secondaryTextColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Gap(4),
            ],
            Text(
              product.title,
              style: TextStyle(
                color: textColor,
                fontSize: 26,
                fontWeight: FontWeight.bold,
                height: 1.2,
              ),
            ),
            const Gap(12),
            Row(
              children: [
                const Icon(Icons.star_rounded, color: Colors.amber, size: 22),
                const Gap(4),
                Text(
                  product.rate.toStringAsFixed(1),
                  style: TextStyle(
                    color: textColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Gap(6),
                Text(
                  product.reviews.isEmpty
                      ? 'Product rating'
                      : '(${product.reviews.length} reviews)',
                  style: TextStyle(color: secondaryTextColor),
                ),
                const Spacer(),
                Icon(
                  product.stock > 0
                      ? Icons.check_circle_outline
                      : Icons.remove_circle_outline,
                  size: 18,
                  color: product.stock > 0 ? Colors.green : Colors.redAccent,
                ),
                const Gap(5),
                Text(
                  product.availabilityStatus.isNotEmpty
                      ? product.availabilityStatus
                      : product.stock > 0
                      ? '${product.stock} in stock'
                      : 'Out of stock',
                  style: TextStyle(
                    color: secondaryTextColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const Gap(20),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '\$${discountedPrice.toStringAsFixed(2)}',
                  style: TextStyle(
                    color: textColor,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (product.discountPercentage > 0) ...[
                  const Gap(10),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Text(
                      '\$${product.price.toStringAsFixed(2)}',
                      style: TextStyle(
                        color: secondaryTextColor,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  ),
                  const Gap(8),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Text(
                      '${product.discountPercentage.toStringAsFixed(0)}% off',
                      style: const TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ],
            ),
            const Gap(24),
            _sectionTitle('About this product', textColor),
            const Gap(8),
            Text(
              product.description,
              style: TextStyle(
                color: secondaryTextColor,
                fontSize: 14,
                height: 1.65,
              ),
            ),
            if (product.tags.isNotEmpty) ...[
              const Gap(18),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: product.tags
                    .map(
                      (tag) => Chip(
                        label: Text(tag),
                        backgroundColor: isDark
                            ? AppColors.darkCard
                            : AppColors.lightCard,
                        side: BorderSide.none,
                        labelStyle: TextStyle(color: textColor, fontSize: 12),
                        visualDensity: VisualDensity.compact,
                      ),
                    )
                    .toList(),
              ),
            ],
            const Gap(24),
            _sectionTitle('Product information', textColor),
            const Gap(12),
            _informationCard(
              borderColor: borderColor,
              backgroundColor: isDark
                  ? AppColors.darkCard
                  : AppColors.lightCard,
              children: [
                if (product.sku.isNotEmpty)
                  _informationRow(
                    icon: Icons.qr_code_2,
                    label: 'SKU',
                    value: product.sku,
                    textColor: textColor,
                    secondaryTextColor: secondaryTextColor,
                  ),
                _informationRow(
                  icon: Icons.inventory_2_outlined,
                  label: 'Availability',
                  value: product.availabilityStatus.isNotEmpty
                      ? '${product.availabilityStatus} · ${product.stock} units'
                      : '${product.stock} units in stock',
                  textColor: textColor,
                  secondaryTextColor: secondaryTextColor,
                ),
                _informationRow(
                  icon: Icons.shopping_bag_outlined,
                  label: 'Minimum order',
                  value: '${product.minimumOrderQuantity} item(s)',
                  textColor: textColor,
                  secondaryTextColor: secondaryTextColor,
                ),
                if (product.shippingInformation.isNotEmpty)
                  _informationRow(
                    icon: Icons.local_shipping_outlined,
                    label: 'Shipping',
                    value: product.shippingInformation,
                    textColor: textColor,
                    secondaryTextColor: secondaryTextColor,
                  ),
                if (product.warrantyInformation.isNotEmpty)
                  _informationRow(
                    icon: Icons.verified_outlined,
                    label: 'Warranty',
                    value: product.warrantyInformation,
                    textColor: textColor,
                    secondaryTextColor: secondaryTextColor,
                  ),
                if (product.returnPolicy.isNotEmpty)
                  _informationRow(
                    icon: Icons.assignment_return_outlined,
                    label: 'Returns',
                    value: product.returnPolicy,
                    textColor: textColor,
                    secondaryTextColor: secondaryTextColor,
                    showDivider: false,
                  ),
              ],
            ),
            const Gap(24),
            _sectionTitle('Customer reviews', textColor),
            const Gap(12),
            if (product.reviews.isEmpty)
              Text(
                'No reviews yet.',
                style: TextStyle(color: secondaryTextColor),
              )
            else
              ...product.reviews.map(
                (review) => _reviewCard(
                  review,
                  backgroundColor: isDark
                      ? AppColors.darkCard
                      : AppColors.lightCard,
                  textColor: textColor,
                  secondaryTextColor: secondaryTextColor,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildGallery(List<String> images, Color borderColor) {
    final backgroundColor = Theme.of(context).cardTheme.color;

    return Column(
      children: [
        Container(
          height: 320,
          width: double.infinity,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: borderColor),
          ),
          clipBehavior: Clip.antiAlias,
          child: images.first.isEmpty
              ? const Icon(Icons.image_not_supported_outlined, size: 56)
              : PageView.builder(
                  itemCount: images.length,
                  onPageChanged: (index) {
                    setState(() => _selectedImageIndex = index);
                  },
                  itemBuilder: (context, index) => CachedNetworkImage(
                    imageUrl: images[index],
                    fit: BoxFit.contain,
                    placeholder: (context, url) =>
                        const Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) => const Center(
                      child: Icon(Icons.broken_image_outlined, size: 48),
                    ),
                  ),
                ),
        ),
        if (images.length > 1) ...[
          const Gap(12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              images.length,
              (index) => AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: index == _selectedImageIndex ? 20 : 7,
                height: 7,
                margin: const EdgeInsets.symmetric(horizontal: 3),
                decoration: BoxDecoration(
                  color: index == _selectedImageIndex
                      ? AppColors.primary
                      : borderColor,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }

  Widget _sectionTitle(String title, Color textColor) {
    return Text(
      title,
      style: TextStyle(
        color: textColor,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _informationCard({
    required Color borderColor,
    required Color backgroundColor,
    required List<Widget> children,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border.all(color: borderColor),
        borderRadius: BorderRadius.circular(18),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: Column(children: children),
    );
  }

  Widget _informationRow({
    required IconData icon,
    required String label,
    required String value,
    required Color textColor,
    required Color secondaryTextColor,
    bool showDivider = true,
  }) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 14),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, size: 19, color: secondaryTextColor),
              const Gap(10),
              SizedBox(
                width: 105,
                child: Text(
                  label,
                  style: TextStyle(color: secondaryTextColor, fontSize: 12),
                ),
              ),
              Expanded(
                child: Text(
                  value,
                  textAlign: TextAlign.end,
                  style: TextStyle(
                    color: textColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
        if (showDivider)
          Divider(height: 1, color: secondaryTextColor.withValues(alpha: 0.2)),
      ],
    );
  }

  Widget _reviewCard(
    ProductReview review, {
    required Color backgroundColor,
    required Color textColor,
    required Color secondaryTextColor,
  }) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  review.reviewerName,
                  style: TextStyle(
                    color: textColor,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const Icon(Icons.star_rounded, color: Colors.amber, size: 18),
              Text(
                review.rating.toString(),
                style: TextStyle(color: textColor, fontWeight: FontWeight.w600),
              ),
            ],
          ),
          if (review.date.isNotEmpty) ...[
            const Gap(3),
            Text(
              review.date.split('T').first,
              style: TextStyle(color: secondaryTextColor, fontSize: 11),
            ),
          ],
          const Gap(10),
          Text(
            review.comment,
            style: TextStyle(color: secondaryTextColor, height: 1.5),
          ),
        ],
      ),
    );
  }
}
