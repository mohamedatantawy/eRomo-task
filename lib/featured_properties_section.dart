import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

const kPrimary = Color(0xFF005879);
const kGold = Color(0xFFFFC400);
const kGrey = Color(0xFF7A7A7A);
const kblack = Color(0xFF000000);

// ------------------------------------------------------------------
// Asset paths
// ------------------------------------------------------------------
class AppAssets {
  static const bathIcon = 'assets/icons/bathroom-svgrepo-com 1.svg';
  static const clockIcon = 'assets/icons/clock.svg';
  static const locationIcon = 'assets/icons/location.svg';
  static const areaIcon = 'assets/icons/site.svg';
  static const sampleImage =
      'assets/images/2dddec53e986d2d5a47098e71be9e7e7e95bb3c8 (1).jpg';
  static const apartmentImage = 'assets/images/apartment.jpg';
  static const agentLogo = 'assets/images/logo_iconGG.jpg';
}

// ------------------------------------------------------------------
// Model
// ------------------------------------------------------------------
class PropertyModel {
  final String image;
  final String price; // e.g. "4,000,000"
  final String title;
  final int beds;
  final int baths;
  final String area; // e.g. "8,725 م²"
  final String location;
  final String timeAgo;
  final String type; // للبيع / للإيجار
  final bool isFeatured;
  final String? agentLogo; // asset path of the agent logo (optional)

  const PropertyModel({
    required this.image,
    required this.price,
    required this.title,
    required this.beds,
    required this.baths,
    required this.area,
    required this.location,
    required this.timeAgo,
    this.type = 'للبيع',
    this.isFeatured = true,
    this.agentLogo,
  });
}

// ------------------------------------------------------------------
// Section: header + filter tabs + horizontal list
// ------------------------------------------------------------------
class FeaturedPropertiesSection extends StatefulWidget {
  final String title;
  final List<PropertyModel> items;
  final VoidCallback? onSeeAll;

  const FeaturedPropertiesSection({
    super.key,
    required this.title,
    required this.items,
    this.onSeeAll,
  });

  @override
  State<FeaturedPropertiesSection> createState() =>
      _FeaturedPropertiesSectionState();
}

class _FeaturedPropertiesSectionState extends State<FeaturedPropertiesSection> {
  int _tab = 0;
  static const _tabs = ['الكل', 'البيع', 'للإيجار'];

  List<PropertyModel> get _filtered {
    if (_tab == 1) return widget.items.where((e) => e.type == 'للبيع').toList();
    if (_tab == 2)
      return widget.items.where((e) => e.type == 'للإيجار').toList();
    return widget.items;
  }

  @override
  Widget build(BuildContext context) {
    final data = _filtered;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              GestureDetector(
                onTap: widget.onSeeAll,
                child: const Text(
                  'مشاهدة الكل',
                  style: TextStyle(fontSize: 14, color: kGrey),
                ),
              ),
              const Spacer(),
              Text(
                widget.title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              for (int i = 0; i < _tabs.length; i++) ...[
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () => setState(() => _tab = i),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: Text(
                      _tabs[i],
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: i == _tab
                            ? FontWeight.w700
                            : FontWeight.w400,
                        color: i == _tab ? Colors.black : kGrey,
                      ),
                    ),
                  ),
                ),
                if (i != _tabs.length - 1)
                  Container(
                    width: 1,
                    height: 12,
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    color: Colors.grey.shade400,
                  ),
              ],
            ],
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 300,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: data.length,
            separatorBuilder: (_, _) => const SizedBox(width: 12),
            itemBuilder: (_, i) => FeaturedPropertyCard(property: data[i]),
          ),
        ),
      ],
    );
  }
}

// ------------------------------------------------------------------
// Card
// ------------------------------------------------------------------
class FeaturedPropertyCard extends StatefulWidget {
  final PropertyModel property;
  final double width;
  final VoidCallback? onTap;

  const FeaturedPropertyCard({
    super.key,
    required this.property,
    this.width = 230,
    this.onTap,
  });

  @override
  State<FeaturedPropertyCard> createState() => _FeaturedPropertyCardState();
}

class _FeaturedPropertyCardState extends State<FeaturedPropertyCard> {
  bool _fav = true;

  @override
  Widget build(BuildContext context) {
    final p = widget.property;

    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        width: widget.width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(40),
          border: Border.all(color: kGold, width: 1.2),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ---------------- Image + tags ----------------
            SizedBox(
              height: 135,
              width: double.infinity,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    p.image,
                    fit: BoxFit.cover,
                    errorBuilder: (_, _, _) =>
                        Container(color: Colors.grey.shade300),
                  ),
                  // "للبيع" tab - bottom left
                  Positioned(
                    left: 0,
                    bottom: 0,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 26,
                        vertical: 7,
                      ),
                      decoration: const BoxDecoration(
                        color: kGold,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(14),
                        ),
                      ),
                      child: Text(
                        p.type,
                        style: const TextStyle(
                          color: kPrimary,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  // "مميز" pill - bottom right
                  if (p.isFeatured)
                    Positioned(
                      right: 0,
                      bottom: 7,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: const BoxDecoration(
                          color: kGold,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(14),
                          ),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.star, size: 14, color: Colors.black),
                            SizedBox(width: 3),
                            Text(
                              'مميز',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),

            // ---------------- Details ----------------
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Price + favorite
                  Row(
                    children: [
                      Text(
                        '${p.price} ج.م',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () => setState(() => _fav = !_fav),
                        child: Icon(
                          _fav ? Icons.favorite : Icons.favorite_border,
                          color: Colors.red,
                          size: 24,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  // Title
                  Text(
                    p.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 13, color: kGrey),
                  ),
                  const SizedBox(height: 10),
                  // Beds / baths / area
                  Row(
                    children: [
                      _stat(
                        const Icon(Icons.bed_outlined, size: 17),
                        '${p.beds}',
                      ),
                      const SizedBox(width: 14),
                      _stat(
                        _svg(AppAssets.bathIcon, 17, Colors.black),
                        '${p.baths}',
                      ),
                      const SizedBox(width: 14),
                      _stat(_svg(AppAssets.areaIcon, 16, Colors.black), p.area),
                    ],
                  ),
                  const SizedBox(height: 10),
                  // Location / time + agent
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            _meta(AppAssets.locationIcon, p.location),
                            const SizedBox(height: 6),
                            _meta(AppAssets.clockIcon, p.timeAgo),
                          ],
                        ),
                      ),
                      _agent(p.agentLogo),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ---------------- helpers ----------------
  Widget _svg(String path, double size, [Color? color]) => SvgPicture.asset(
    path,
    width: size,
    height: size,
    colorFilter: color == null
        ? null
        : ColorFilter.mode(color, BlendMode.srcIn),
  );

  Widget _stat(Widget icon, String text) => Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      icon,
      const SizedBox(width: 4),
      Text(text, style: const TextStyle(fontSize: 13, color: kblack)),
    ],
  );

  Widget _meta(String icon, String text) => Row(
    children: [
      _svg(icon, 14),
      const SizedBox(width: 5),
      Flexible(
        child: Text(
          text,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontSize: 12, color: kGrey),
        ),
      ),
    ],
  );

  Widget _agent(String? logo) => Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text(
        'بواسطة',
        style: TextStyle(
          fontSize: 12,
          color: kblack,
          fontWeight: FontWeight.w400,
        ),
      ),
      const SizedBox(height: 2),
      SizedBox(
        width: 44,
        height: 36,
        child: logo != null
            ? Image.asset(logo, fit: BoxFit.contain)
            : Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.red.shade700,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Text(
                  'GS',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
      ),
    ],
  );
}
