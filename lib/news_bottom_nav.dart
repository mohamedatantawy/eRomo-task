import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

// File-private constants (no clash with your other files)
const _kPrimary = Color(0xFF0B5C73);
const _kGrey = Color(0xFF7A7A7A);

// ==================================================================
// NEWS
// ==================================================================
class NewsModel {
  final String image;
  final String title;
  final String description;

  const NewsModel({
    required this.image,
    required this.title,
    required this.description,
  });
}

class NewsSection extends StatelessWidget {
  final String title;
  final List<NewsModel> items;
  final VoidCallback? onSeeAll;
  final void Function(NewsModel news)? onTap;

  const NewsSection({
    super.key,
    this.title = 'اهم الأخبار',
    required this.items,
    this.onSeeAll,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
          child: Row(
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: onSeeAll,
                child: const Text(
                  'مشاهدة الكل',
                  style: TextStyle(fontSize: 14, color: _kGrey),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 228,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: items.length,
            separatorBuilder: (_, _) => const SizedBox(width: 12),
            itemBuilder: (_, i) => NewsCard(
              news: items[i],
              onTap: onTap == null ? null : () => onTap!(items[i]),
            ),
          ),
        ),
      ],
    );
  }
}

class NewsCard extends StatelessWidget {
  final NewsModel news;
  final double width;
  final VoidCallback? onTap;

  const NewsCard({super.key, required this.news, this.width = 250, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.grey.shade300),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 105,
              width: double.infinity,
              child: Image.asset(
                news.image,
                fit: BoxFit.cover,
                errorBuilder: (_, _, _) =>
                    Container(color: Colors.grey.shade300),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(14, 14, 14, 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    news.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    news.description,
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 12,
                      height: 1.5,
                      color: _kGrey,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ==================================================================
// BOTTOM NAV (floating bar + raised center button)
// ==================================================================
class AppBottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onChanged;

  const AppBottomNav({
    super.key,
    required this.currentIndex,
    required this.onChanged,
  });

  // index: 0 developers, 1 market, 2 home (center), 3 offers, 4 my properties
  static const double _barHeight = 68;
  static const double _bottomGap = 10;
  static const double _centerSize = 60;

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).padding.bottom;

    return SizedBox(
      height: _barHeight + _bottomGap + 24 + bottomInset,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.bottomCenter,
        children: [
          // ---------- the white bar ----------
          Positioned(
            left: 16,
            right: 16,
            bottom: _bottomGap + bottomInset,
            height: _barHeight,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.10),
                    blurRadius: 16,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: _item(4, 'assets/icons/developer.svg', 'المطورون'),
                  ),
                  Expanded(child: _item(3, 'assets/icons/shop.svg', 'السوق')),
                  const Expanded(child: SizedBox()), // space for center button
                  Expanded(
                    child: _item(
                      1,
                      'assets/icons/fire-svgrepo-com 1.svg',
                      'العروض',
                    ),
                  ),
                  Expanded(
                    // no SVG was provided for this one -> Material icon
                    child: _item(
                      0,
                      null,
                      'عقاراتي',
                      fallback: Icons.apartment_outlined,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ---------- raised center button ----------
          Positioned(
            bottom: _bottomGap + bottomInset + _barHeight - _centerSize / 2 - 6,
            child: GestureDetector(
              onTap: () => onChanged(2),
              child: Container(
                width: _centerSize,
                height: _centerSize,
                decoration: BoxDecoration(
                  color: _kPrimary,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 4),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.18),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                alignment: Alignment.center,
                child: SvgPicture.asset(
                  'assets/icons/home_icon.svg',
                  width: 28,
                  height: 28,
                  colorFilter: const ColorFilter.mode(
                    Colors.white,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _item(int index, String? svg, String label, {IconData? fallback}) {
    final selected = currentIndex == index;
    final color = selected ? _kPrimary : const Color(0xFF484C52);

    return InkWell(
      onTap: () => onChanged(index),
      borderRadius: BorderRadius.circular(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (svg != null)
            SvgPicture.asset(
              svg,
              width: 24,
              height: 24,
              colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
            )
          else
            Icon(fallback, size: 25, color: color),
          const SizedBox(height: 4),
          Text(
            label,
            maxLines: 1,
            style: GoogleFonts.notoKufiArabic(
              fontSize: 12,
              height: 16 / 12,
              letterSpacing: 0,
              fontWeight: FontWeight.w400,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}

// ==================================================================
// Usage
// ==================================================================
class NewsAndNavExample extends StatefulWidget {
  const NewsAndNavExample({super.key});

  @override
  State<NewsAndNavExample> createState() => _NewsAndNavExampleState();
}

class _NewsAndNavExampleState extends State<NewsAndNavExample> {
  int _index = 2;

  static const _desc =
      'هذا النص هو مثال لنص يمكن أن يستبدل في نفس المساحة، لقد تم توليد هذا النص من مولد النص العربي.';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView(
          children: const [
            SizedBox(height: 24),
            NewsSection(
              items: [
                NewsModel(
                  image: 'assets/images/6eb7f96d6b29e18272b5315081e7fdcfe0de039d.jpg',
                  title: 'أحدث سوق إيجي',
                  description: _desc,
                ),
                NewsModel(
                  image: 'assets/images/6c717d30c8efbbc0c589fc1886c91f09a664d3e8.png',
                  title: 'أحدث سوق إيجي',
                  description: _desc,
                ),
              ],
            ),
            SizedBox(height: 24),
          ],
        ),
      ),
      bottomNavigationBar: AppBottomNav(
        currentIndex: _index,
        onChanged: (i) => setState(() => _index = i),
      ),
    );
  }
}
