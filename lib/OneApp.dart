import 'package:e_romo_task/featured_properties_section.dart'
    show AppAssets, FeaturedPropertiesSection, PropertyModel;
import 'package:e_romo_task/latest_properties_section.dart';
import 'package:e_romo_task/news_bottom_nav.dart';
import 'package:e_romo_task/projects_cities_sections.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class OneApp extends StatelessWidget {
  const OneApp({super.key});

  @override
  Widget build(BuildContext context) {
    final baseTheme = Theme.of(context);
    return Theme(
      data: baseTheme.copyWith(
        textTheme: GoogleFonts.notoKufiArabicTextTheme(baseTheme.textTheme),
        primaryTextTheme: GoogleFonts.notoKufiArabicTextTheme(
          baseTheme.primaryTextTheme,
        ),
      ),
      child: const HomeScreen(),
    );
  }
}

const kPrimary = Color(0xFF0B5C73);
const kYellow = Color(0xFFF5B800);
const kGreen = Color(0xFF3BA55D);
const kGold = Color(0xFFE8AE14);

const kGrey = Color(0xFF6B7280);

// ------------------------------------------------------------------
// Placeholder images (replace with your own assets / API images)
// ------------------------------------------------------------------
const _img1 = 'https://picsum.photos/seed/room1/600/400';
const _img2 = 'https://picsum.photos/seed/room2/600/400';
const _img3 = 'https://picsum.photos/seed/tower/600/400';
const _img4 = 'https://picsum.photos/seed/villa/600/400';

class NetImage extends StatelessWidget {
  final String url;
  final double? width, height;
  final BorderRadius? radius;
  const NetImage(this.url, {super.key, this.width, this.height, this.radius});
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: radius ?? BorderRadius.zero,
      child: Image.network(
        url,
        width: width,
        height: height,
        fit: BoxFit.cover,
        errorBuilder: (_, _, _) => Container(
          width: width,
          height: height,
          color: Colors.grey.shade300,
        ),
      ),
    );
  }
}

// ------------------------------------------------------------------
// Home screen
// ------------------------------------------------------------------
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _navIndex = 2;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      endDrawer: const MoreDrawer(),
      backgroundColor: Colors.white,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            HomeHeader(
              onMenu: () => _scaffoldKey.currentState?.openEndDrawer(),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.only(bottom: 100),
                children: [
                  PromoBanner(
                    items: const [
                      PromoItem(
                        image: 'assets/images/5c8f4fffea8c06a489cb91a3844f20d209979c27.jpg',
                        title: 'منزل احلامك الآن متوفر',
                        subtitle: 'مشروع كمبوند الشيخ زايد اكثر من 200 شقة ومحل في انتظارك',
                      ),
                      PromoItem(
                        image: 'assets/images/5c8f4fffea8c06a489cb91a3844f20d209979c27.jpg',
                        title: 'استثمر في عقارك بثقة',
                        subtitle: 'أفضل العروض العقارية في القاهرة والجيزة بأسعار مناسبة',
                      ),
                      PromoItem(
                        image: 'assets/images/5c8f4fffea8c06a489cb91a3844f20d209979c27.jpg',
                        title: 'مكتبك لازم يكون أنيق',
                        subtitle: 'مساحات إدارية وتجارية بتشطيبات عصرية في أفضل المواقع',
                      ),
                      PromoItem(
                        image: 'assets/images/5c8f4fffea8c06a489cb91a3844f20d209979c27.jpg',
                        title: 'فيلتك الخاصة في انتظارك',
                        subtitle:
                            'فيلات ودوبلكس بتسهيلات في السداد ومقدم يبدأ من 5%',
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  FeaturedPropertiesSection(
                    title: 'عقارات مميزة في مصر',
                    onSeeAll: () {},
                    items: List.generate(
                      5,
                      (_) => const PropertyModel(
                        image: AppAssets.apartmentImage,
                        price: '4,000,000',
                        title: 'شقة سكنية للبيع تشطيب سوبر لوكس',
                        beds: 10,
                        baths: 5,
                        area: '8,725 م²',
                        location: 'الشيخ زايد، الجيزة',
                        timeAgo: 'منذ 4 أيام',
                        agentLogo: AppAssets.agentLogo,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  ProjectsSection(
                    onSeeAll: () {},
                    items: List.generate(
                      4,
                      (_) => const ProjectModel(
                        image: AppAssets.apartmentImage,
                        title: 'كمبوند الشيخ زايد',
                        description: 'شقق سكنية فاخرة ومطاعم تجارية',
                        location: 'الشيخ زايد، الجيزة',
                        timeAgo: 'منذ 4 أيام',
                        agentLogo: AppAssets.agentLogo,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  CitiesSection(
                    onSeeAll: () {},
                    cities: const [
                      CityModel(
                        name: 'القاهرة',
                        image: 'assets/images/cairo.jpg',
                        forSale: 505,
                        forRent: 1002,
                      ),
                      CityModel(
                        name: 'الجيزة',
                        image: 'assets/images/giza.jpg',
                        forSale: 505,
                        forRent: 1002,
                      ),
                      CityModel(
                        name: 'الإسكندرية',
                        image: 'assets/images/vala.jpg',
                        forSale: 320,
                        forRent: 780,
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  PromoBanner(
                    items: const [
                      PromoItem(
                        image: 'assets/images/5c8f4fffea8c06a489cb91a3844f20d209979c27.jpg',
                        title: 'منزل احلامك الآن متوفر',
                        subtitle: 'مشروع كمبوند الشيخ زايد اكثر من 200 شقة ومحل في انتظارك',
                      ),
                      PromoItem(
                        image: 'assets/images/5c8f4fffea8c06a489cb91a3844f20d209979c27.jpg',
                        title: 'منزل احلامك الآن متوفر',
                        subtitle: 'مشروع كمبوند الشيخ زايد اكثر من 200 شقة ومحل في انتظارك',
                      ),
                      // add 3 more items for the 4 dots
                    ],
                  ),
                  const SizedBox(height: 24),
                  LatestPropertiesSection(
                    title: 'احدث الشقق في مصر',
                    onSeeAll: () {},
                    items: List.generate(
                      4,
                      (_) => const LatestProperty(
                        image: 'assets/images/apartment.jpg',
                        price: '4,000,000',
                        title: 'شقة سكنية للبيع تشطيب سوبر لوكس',
                        beds: 10,
                        baths: 5,
                        area: '8,725 م²',
                        location: 'الشيخ زايد، الجيزة',
                        timeAgo: 'منذ 4 أيام',
                        agentLogo: 'assets/images/logo_iconGG.jpg',
                      ),
                    ),
                  ),
                  const SizedBox(height: 28),
                  LatestPropertiesSection(
                    title: 'احدث الفيلات في مصر',
                    onSeeAll: () {},
                    items: List.generate(
                      4,
                      (_) => const LatestProperty(
                        image: 'assets/images/vala.jpg',
                        price: '4,000,000',
                        title: 'فيلا سكنية للبيع تشطيب سوبر لوكس',
                        beds: 10,
                        baths: 5,
                        area: '8,725 م²',
                        location: 'الشيخ زايد، الجيزة',
                        timeAgo: 'منذ 4 أيام',
                        agentLogo: 'assets/images/logo_iconGG.jpg',
                      ),
                    ),
                  ),
                  const SizedBox(height: 28),
                  LatestPropertiesSection(
                    title: 'احدث الدوبلكس في مصر',
                    onSeeAll: () {},
                    items: List.generate(
                      4,
                      (_) => const LatestProperty(
                        image: 'assets/images/duplacas.png',
                        price: '4,000,000',
                        title: 'دوبلكس للبيع تشطيب سوبر لوكس',
                        beds: 10,
                        baths: 5,
                        area: '8,725 م²',
                        location: 'الشيخ زايد، الجيزة',
                        timeAgo: 'منذ 4 أيام',
                        agentLogo: 'assets/images/logo_iconGG.jpg',
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  NewsSection(
                    onSeeAll: () {},
                    items: const [
                      NewsModel(
                        image: 'assets/images/6eb7f96d6b29e18272b5315081e7fdcfe0de039d.jpg',
                        title: 'أحدث سوق إيجي',
                        description: 'هذا النص هو مثال لنص يمكن أن يستبدل في نفس المساحة، لقد تم توليد هذا النص من مولد النص العربي.',
                      ),
                      NewsModel(
                        image: 'assets/images/6c717d30c8efbbc0c589fc1886c91f09a664d3e8.png',
                        title: 'أحدث سوق إيجي',
                        description: 'هذا النص هو مثال لنص يمكن أن يستبدل في نفس المساحة، لقد تم توليد هذا النص من مولد النص العربي.',
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: AppBottomNav(
        currentIndex: _navIndex,
        onChanged: (i) => setState(() => _navIndex = i),
      ),
    );
  }
}

// ------------------------------------------------------------------
// Header
// ------------------------------------------------------------------
class HomeHeader extends StatelessWidget {
  const HomeHeader({
    super.key,
    this.onMenu,
    this.onNotifications,
    this.onMessages,
  });

  final VoidCallback? onMenu;
  final VoidCallback? onNotifications;
  final VoidCallback? onMessages;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
        child: Column(
          children: [
            // Logo
            Image.asset('assets/images/logo.png', height: 40),
            const SizedBox(height: 16),

            // Icons row + location
            Row(
              children: [
                // Location (right side in RTL)
                Row(
                  children: const [
                    Text(
                      'القاهرة',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(width: 4),
                    Icon(Icons.keyboard_arrow_down, size: 22),
                  ],
                ),
                const Spacer(),
                // Icons (left side in RTL)
                _HeaderIcon(
                  asset: 'assets/icons/messages1.svg',
                  onTap: onMessages,
                  // badge: true,
                ),
                const SizedBox(width: 16),
                _HeaderIcon(
                  asset: 'assets/icons/notification.svg',
                  onTap: onNotifications,
                  // badge: true,
                ),
                const SizedBox(width: 16),

                _HeaderIcon(
                  asset: 'assets/icons/hambergermenu.svg',
                  onTap: onMenu,
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Search bar
            Container(
              height: 44,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: const Color(0xFFF3F3F3),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: const [
                  Icon(Icons.search, size: 20, color: Colors.grey),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'كيف يمكننا مساعدتك',
                      style: TextStyle(fontSize: 13, color: Colors.grey),
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

class _HeaderIcon extends StatelessWidget {
  const _HeaderIcon({required this.asset, this.onTap, this.badge = false});

  final String asset;
  final VoidCallback? onTap;
  final bool badge;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          SvgPicture.asset(asset, width: 26, height: 26),
          if (badge)
            Positioned(
              top: -2,
              right: -2,
              child: Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  color: Colors.orange,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 1.5),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

// ------------------------------------------------------------------
// Promo banner with dots
// ------------------------------------------------------------------
class PromoItem {
  final String image, title, subtitle;
  const PromoItem({
    required this.image,
    required this.title,
    required this.subtitle,
  });
}

class PromoBanner extends StatefulWidget {
  final List<PromoItem> items;
  final double height;
  final VoidCallback? onContact;

  const PromoBanner({
    super.key,
    required this.items,
    this.height = 190,
    this.onContact,
  });

  @override
  State<PromoBanner> createState() => _PromoBannerState();
}

class _PromoBannerState extends State<PromoBanner> {
  final _controller = PageController();
  int _page = 0;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _go(int delta) {
    final target = (_page + delta).clamp(0, widget.items.length - 1);
    _controller.animateToPage(
      target,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: widget.height,
          child: Stack(
            children: [
              PageView.builder(
                controller: _controller,
                itemCount: widget.items.length,
                onPageChanged: (i) => setState(() => _page = i),
                itemBuilder: (_, i) => _slide(widget.items[i]),
              ),
              // In RTL the next page is to the LEFT, so the left arrow = next.
              Positioned(
                left: 12,
                top: 0,
                bottom: 0,
                child: Center(child: _arrow(Icons.chevron_right, () => _go(1))),
              ),
              Positioned(
                right: 12,
                top: 0,
                bottom: 0,
                child: Center(child: _arrow(Icons.chevron_left, () => _go(-1))),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            widget.items.length,
            (i) => AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              margin: const EdgeInsets.symmetric(horizontal: 5),
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: i == _page ? kPrimary : const Color(0xFFD9D9D9),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _slide(PromoItem item) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset(
          item.image,
          fit: BoxFit.cover,
          errorBuilder: (_, _, _) => Container(color: Colors.grey.shade400),
        ),
        // light dark overlay so the image stays visible but text is readable
        Container(color: Colors.black.withValues(alpha: 0.25)),
        Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 56),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  item.title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  item.subtitle,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.9),
                    fontSize: 12,
                    height: 1.4,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 14),
                SizedBox(
                  height: 30,
                  child: ElevatedButton(
                    onPressed: widget.onContact ?? () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kGold,
                      foregroundColor: Colors.black,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(horizontal: 22),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    child: const Text(
                      'تواصل الآن',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _arrow(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.black.withValues(alpha: 0.55),
        ),
        child: Icon(
          icon,
          color: Colors.white.withValues(alpha: 0.85),
          size: 22,
        ),
      ),
    );
  }
}

// ------------------------------------------------------------------
// Property cards
// ------------------------------------------------------------------
class PropertyCardsRow extends StatelessWidget {
  final bool featured;
  const PropertyCardsRow({super.key, this.featured = false});

  @override
  Widget build(BuildContext context) {
    final height = featured ? 270.0 : 150.0;
    return SizedBox(
      height: height,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: 5,
        separatorBuilder: (_, _) => const SizedBox(width: 12),
        itemBuilder: (_, i) => featured
            ? const FeaturedPropertyCard()
            : const HorizontalPropertyCard(),
      ),
    );
  }
}

class FeaturedPropertyCard extends StatelessWidget {
  const FeaturedPropertyCard({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: kYellow, width: 1.2),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              const NetImage(
                _img1,
                height: 110,
                width: double.infinity,
                radius: BorderRadius.vertical(top: Radius.circular(13)),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Row(
                  children: [
                    _tag('للبيع', Colors.grey.shade300, Colors.black),
                    const Spacer(),
                    _tag('مميز', kYellow, Colors.black, icon: Icons.star),
                  ],
                ),
              ),
            ],
          ),
          Padding(padding: const EdgeInsets.all(10), child: PropertyInfo()),
        ],
      ),
    );
  }

  Widget _tag(String t, Color bg, Color fg, {IconData? icon}) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
    color: bg,
    child: Row(
      children: [
        if (icon != null) Icon(icon, size: 12, color: fg),
        const SizedBox(width: 2),
        Text(t, style: TextStyle(fontSize: 10, color: fg)),
      ],
    ),
  );
}

class HorizontalPropertyCard extends StatelessWidget {
  const HorizontalPropertyCard({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 330,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: PropertyInfo(),
            ),
          ),
          Stack(
            children: [
              const NetImage(
                _img4,
                width: 120,
                height: double.infinity,
                radius: BorderRadius.horizontal(left: Radius.circular(13)),
              ),
              Positioned(
                top: 8,
                left: 8,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 2,
                  ),
                  color: Colors.grey.shade300,
                  child: const Text('للبيع', style: TextStyle(fontSize: 10)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class PropertyInfo extends StatelessWidget {
  const PropertyInfo({super.key});
  final _small = const TextStyle(fontSize: 11, color: kGrey);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            const Text(
              '4,000,000 ج.م',
              style: TextStyle(fontWeight: FontWeight.w800, fontSize: 14),
            ),
            const Spacer(),
            const Icon(Icons.favorite, color: Colors.red, size: 20),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          'شقة سكنية للبيع بتشطيب سوبر لوكس',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: _small,
        ),
        const SizedBox(height: 6),
        Row(
          children: [
            const Icon(Icons.bed_outlined, size: 14),
            const SizedBox(width: 2),
            const Text('5', style: TextStyle(fontSize: 11)),
            const SizedBox(width: 10),
            const Icon(Icons.bathtub_outlined, size: 14),
            const SizedBox(width: 2),
            const Text('10', style: TextStyle(fontSize: 11)),
            const SizedBox(width: 10),
            const Icon(Icons.square_foot, size: 14),
            const SizedBox(width: 2),
            const Text('8,725 م²', style: TextStyle(fontSize: 11)),
          ],
        ),
        const SizedBox(height: 6),
        Row(
          children: [
            const Icon(Icons.location_on, size: 13, color: kGrey),
            Text(' الشيخ زايد، الجيزة', style: _small),
          ],
        ),
        const SizedBox(height: 2),
        Row(
          children: [
            const Icon(Icons.access_time, size: 13, color: kGrey),
            Text(' منذ 4 أيام', style: _small),
          ],
        ),
        const SizedBox(height: 6),
        Row(
          children: [
            Text('بواسطة ', style: _small),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.red.shade700,
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Text(
                'GS',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// ------------------------------------------------------------------
// Projects
// ------------------------------------------------------------------
class ProjectsRow extends StatelessWidget {
  const ProjectsRow({super.key});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 235,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: 4,
        separatorBuilder: (_, _) => const SizedBox(width: 12),
        itemBuilder: (_, _) => Container(
          width: 250,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: kGreen, width: 1.2),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  const NetImage(
                    _img3,
                    height: 110,
                    width: double.infinity,
                    radius: BorderRadius.vertical(top: Radius.circular(13)),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 3,
                      ),
                      color: kGreen,
                      child: const Text(
                        'مشروع',
                        style: TextStyle(color: Colors.white, fontSize: 10),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: const [
                        Text(
                          'كمبوند الشيخ زايد',
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 13,
                          ),
                        ),
                        Spacer(),
                        Icon(Icons.favorite, color: Colors.red, size: 20),
                      ],
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'شقق سكنية فاخرة ومطاعم تجارية',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 11, color: kGrey),
                    ),
                    const SizedBox(height: 8),
                    const Row(
                      children: [
                        Icon(Icons.location_on, size: 13, color: kGrey),
                        Text(
                          ' الشيخ زايد، الجيزة',
                          style: TextStyle(fontSize: 11, color: kGrey),
                        ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    const Row(
                      children: [
                        Icon(Icons.access_time, size: 13, color: kGrey),
                        Text(
                          ' منذ 4 أيام',
                          style: TextStyle(fontSize: 11, color: kGrey),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ------------------------------------------------------------------
// Cities
// ------------------------------------------------------------------
class CitiesRow extends StatelessWidget {
  const CitiesRow({super.key});
  @override
  Widget build(BuildContext context) {
    const cities = [
      ['القاهرة', _img3],
      ['الجيزة', _img4],
      ['الإسكندرية', _img1],
    ];
    return SizedBox(
      height: 150,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: cities.length,
        separatorBuilder: (_, _) => const SizedBox(width: 12),
        itemBuilder: (_, i) => ClipRRect(
          borderRadius: BorderRadius.circular(14),
          child: SizedBox(
            width: 120,
            child: Stack(
              fit: StackFit.expand,
              children: [
                NetImage(cities[i][1]),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withValues(alpha: 0.7),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 8,
                  left: 8,
                  right: 8,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        cities[i][0],
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'عقارات للبيع : 505',
                        style: TextStyle(color: Colors.white, fontSize: 9),
                      ),
                      const Text(
                        'عقارات للإيجار : 1002',
                        style: TextStyle(color: Colors.white, fontSize: 9),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ------------------------------------------------------------------
// News
// ------------------------------------------------------------------
class NewsRow extends StatelessWidget {
  const NewsRow({super.key});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 210,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: 4,
        separatorBuilder: (_, _) => const SizedBox(width: 12),
        itemBuilder: (_, _) => Container(
          width: 260,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              NetImage(
                _img4,
                height: 90,
                width: double.infinity,
                radius: BorderRadius.vertical(top: Radius.circular(13)),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'احدث سوق إيجي',
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 13,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      'هذا النص هو مثال لنص يمكن أن يستبدل في نفس المساحة، لقد تم توليد هذا النص من مولد النص العربي.',
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 11, color: kGrey),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ------------------------------------------------------------------
// "More" drawer
// ------------------------------------------------------------------
class MoreDrawer extends StatelessWidget {
  const MoreDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final items = <(Object, String, int?)>[
      (Icons.favorite, 'عقاراتي المفضلة', null),
      ('assets/icons/notification.svg', 'الإشعارات', 2),
      ('assets/icons/messages1.svg', 'الدردشة', 5),
      (Icons.apartment, 'أضف عقارك', null),
      ('assets/icons/vip-2-svgrepo-com 1.svg', 'شراء باقات', null),
      ('assets/icons/updataProject.svg', 'أحدث المشاريع', null),
      ('assets/icons/help.svg', 'مركز المساعدة', null),
      ('assets/icons/callcenter.svg', 'خدمة العملاء', null),
      ('assets/icons/profileadd.svg', 'إنضم إلينا', null),
      ('assets/icons/profileadd.svg', 'تسجيل الخروج', null),
    ];
    return Drawer(
      width: 280,
      child: SafeArea(
        child: Column(
          children: [
            ListTile(
              title: const Text(
                'المزيد',
                style: TextStyle(fontWeight: FontWeight.w800),
              ),
              leading: const Text('🇪🇬 ⌄'),
              trailing: IconButton(
                icon: const Icon(Icons.chevron_left),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            const Divider(height: 1),
            ListTile(
              leading: const CircleAvatar(
                backgroundColor: kGreen,
                child: Icon(Icons.person, color: Colors.white),
              ),
              title: const Text(
                'عبدالله محمد',
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
              subtitle: const Text('القاهرة'),
            ),
            Expanded(
              child: ListView(
                children: [
                  for (final it in items)
                    ListTile(
                      leading: MenuIcon(
                        it.$1,
                        color: it.$2 == 'تسجيل الخروج' ? Colors.red : kPrimary,
                      ),
                      title: Text(it.$2, style: const TextStyle(fontSize: 14)),
                      trailing: it.$3 == null
                          ? null
                          : CircleAvatar(
                              radius: 9,
                              backgroundColor: Colors.red,
                              child: Text(
                                '${it.$3}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                ),
                              ),
                            ),
                      onTap: () {},
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

class MenuIcon extends StatelessWidget {
  const MenuIcon(this.icon, {super.key, this.size = 24, this.color});

  final Object icon;
  final double size;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    if (icon is String) {
      return SvgPicture.asset(
        icon as String,
        width: size,
        height: size,
        colorFilter: color == null
            ? null
            : ColorFilter.mode(color!, BlendMode.srcIn),
      );
    }
    return Icon(icon as IconData, size: size, color: color);
  }
}
