// pubspec.yaml dependencies:
//   flutter_localizations: {sdk: flutter}
//   google_fonts: ^6.2.1
//
// Replace the placeholder icons / brand names with your real assets
// (Image.asset / SvgPicture.asset) when you have them.

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';

void main() => runApp(const CodofoApp());

/* ───────────────────────── Theme ───────────────────────── */

class AppColors {
  static const green = Color(0xFF1E8E6E);
  static const greenLight = Color(0xFFE3F4EE);
  static const cream = Color(0xFFFBF5E6);
  static const yellow = Color(0xFFFFD04D);
  static const red = Color(0xFFE5484D);
  static const bg = Color(0xFFF7F8F7);
  static const text = Color(0xFF1F2A24);
  static const muted = Color(0xFF66726B);
  static const dark = Color(0xFF232826);
}

class Coupon {
  final String brand;
  final String discount;
  final String condition;
  final bool active;
  const Coupon(this.brand, this.discount, this.condition, this.active);
}

const _coupons = [
  Coupon('نعناع', '25%', 'للطلبات أكثر من 300 ريال', true),
  Coupon('المراعي', '25%', 'للطلبات أكثر من 300 ريال', false),
  Coupon('شاهد', '30%', 'للطلبات أكثر من 200 ريال', true),
  Coupon('نعناع', '15%', 'للطلبات أكثر من 100 ريال', true),
];

/* ───────────────────────── Page ───────────────────────── */

class CodofoApp extends StatelessWidget {
  const CodofoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const AppBottomBar(),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.only(bottom: 24),
          children: [
            const HomeHeader(),
            const SizedBox(height: 12),
            const SearchField(),
            const SizedBox(height: 16),
            const PromoBanner(),
            const SizedBox(height: 20),
            const CategoriesRow(),
            SectionHeader(title: 'الكوبونات الأكثر استخدامًا', onSeeAll: () {}),
            CouponList(coupons: _coupons, filled: true),
            SectionHeader(title: 'تصفح حسب العلامات التجارية', onSeeAll: () {}),
            const BrandsList(),
            SectionHeader(title: 'خصيصًا لك', onSeeAll: () {}),
            const ForYouGrid(),
            SectionHeader(title: 'أُضيف حديثًا', onSeeAll: () {}),
            CouponList(coupons: _coupons.reversed.toList()),
            const SeasonalSection(),
            SectionHeader(title: 'صفقات جديدة'),
            const DealsCard(),
            SectionHeader(title: 'كوبونك الخاص', onSeeAll: () {}),
            CouponList(coupons: _coupons, filled: true),
          ],
        ),
      ),
    );
  }
}

/* ───────────────────────── Header + search ───────────────────────── */

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.menu_rounded, size: 28),
          ),
          const Spacer(),
          Text(
            'كودوفو',
            style: GoogleFonts.cairo(
              fontSize: 26,
              fontWeight: FontWeight.w800,
              color: AppColors.green,
            ),
          ),
          const Spacer(),
          Badge(
            smallSize: 9,
            backgroundColor: AppColors.yellow,
            child: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.notifications_none_rounded, size: 26),
            ),
          ),
        ],
      ),
    );
  }
}

class SearchField extends StatelessWidget {
  const SearchField({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'ابحث عن كوبون أو متجر',
          filled: true,
          fillColor: Colors.white,
          prefixIcon: const Icon(Icons.search_rounded, color: AppColors.green),
          suffixIcon: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.tune_rounded, color: AppColors.green),
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 14),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}

/* ───────────────────────── Banner ───────────────────────── */

class PromoBanner extends StatelessWidget {
  const PromoBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: PageView(
        controller: PageController(viewportFraction: 0.9),
        children: List.generate(3, (_) => const _BannerCard()),
      ),
    );
  }
}

class _BannerCard extends StatelessWidget {
  const _BannerCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 6),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cream,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'نعناع',
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 18,
                    color: AppColors.green,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'غيّر مفهوم المقاضي مع بعض',
                  style: TextStyle(color: AppColors.muted, fontSize: 12),
                ),
                const Text(
                  'بخصومات تصل إلى 50%',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                    color: AppColors.text,
                  ),
                ),
                const SizedBox(height: 10),
                FilledButton(
                  onPressed: () {},
                  style: FilledButton.styleFrom(
                    backgroundColor: AppColors.green,
                    visualDensity: VisualDensity.compact,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text('اكتشفها الآن'),
                ),
              ],
            ),
          ),
          const Icon(
            Icons.shopping_basket_rounded,
            size: 90,
            color: AppColors.green,
          ),
        ],
      ),
    );
  }
}

/* ───────────────────────── Categories ───────────────────────── */

class CategoriesRow extends StatelessWidget {
  const CategoriesRow({super.key});

  @override
  Widget build(BuildContext context) {
    const items = [
      (Icons.phone_iphone_rounded, 'الجوالات', Color(0xFFDDEFD8)),
      (Icons.wifi_rounded, 'المنزل الذكي', Color(0xFFFFF1CF)),
      (Icons.local_grocery_store_rounded, 'البقالة', Color(0xFFD9F6F0)),
      (Icons.checkroom_rounded, 'الأزياء', Color(0xFFFBE0E4)),
    ];
    return SizedBox(
      height: 104,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: items.length,
        separatorBuilder: (_, _) => const SizedBox(width: 12),
        itemBuilder: (_, i) {
          final (icon, label, color) = items[i];
          return Container(
            width: 92,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x14000000),
                  blurRadius: 8,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundColor: color,
                  child: Icon(icon, color: AppColors.green),
                ),
                const SizedBox(height: 8),
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
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

/* ───────────────────────── Section header ───────────────────────── */

class SectionHeader extends StatelessWidget {
  final String title;
  final VoidCallback? onSeeAll;
  const SectionHeader({super.key, required this.title, this.onSeeAll});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 28, 16, 12),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w800,
                color: AppColors.text,
              ),
            ),
          ),
          if (onSeeAll != null)
            TextButton(
              onPressed: onSeeAll,
              child: const Text(
                'عرض الكل',
                style: TextStyle(color: AppColors.green),
              ),
            ),
        ],
      ),
    );
  }
}

/* ───────────────────────── Coupon card ───────────────────────── */

class CouponCard extends StatelessWidget {
  final Coupon coupon;
  final bool filled; // true = green card, false = light card
  const CouponCard({super.key, required this.coupon, this.filled = false});

  @override
  Widget build(BuildContext context) {
    final fg = filled ? Colors.white : AppColors.text;
    final accent = filled ? Colors.white : AppColors.green;

    return Container(
      width: 220,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: filled ? AppColors.green : Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: filled
            ? null
            : Border.all(color: AppColors.greenLight, width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: filled ? Colors.white : AppColors.greenLight,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  coupon.brand,
                  style: const TextStyle(
                    color: AppColors.green,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              const Spacer(),
              _StatusChip(active: coupon.active, onDark: filled),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            coupon.discount,
            style: TextStyle(
              fontSize: 34,
              height: 1.1,
              fontWeight: FontWeight.w800,
              color: accent,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            coupon.condition,
            style: TextStyle(fontSize: 12, color: fg.withValues(alpha: .85)),
          ),
          const Spacer(),
          SizedBox(
            height: 34,
            child: FilledButton.icon(
              onPressed: coupon.active ? () {} : null,
              icon: const Icon(Icons.local_activity_rounded, size: 16),
              label: const Text('عرض الكود', style: TextStyle(fontSize: 12)),
              style: FilledButton.styleFrom(
                backgroundColor: AppColors.yellow,
                foregroundColor: AppColors.text,
                disabledBackgroundColor: Colors.grey.shade300,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  final bool active;
  final bool onDark;
  const _StatusChip({required this.active, required this.onDark});

  @override
  Widget build(BuildContext context) {
    final color = active
        ? (onDark ? Colors.white : AppColors.green)
        : AppColors.red;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          active ? Icons.check_circle_rounded : Icons.cancel_rounded,
          size: 16,
          color: color,
        ),
        const SizedBox(width: 4),
        Text(
          active ? 'فعّال' : 'غير فعّال',
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: color,
          ),
        ),
      ],
    );
  }
}

class CouponList extends StatelessWidget {
  final List<Coupon> coupons;
  final bool filled;
  const CouponList({super.key, required this.coupons, this.filled = false});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 148,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: coupons.length,
        separatorBuilder: (_, _) => const SizedBox(width: 12),
        itemBuilder: (_, i) => CouponCard(coupon: coupons[i], filled: filled),
      ),
    );
  }
}

/* ───────────────────────── Brands ───────────────────────── */

class BrandsList extends StatelessWidget {
  const BrandsList({super.key});

  @override
  Widget build(BuildContext context) {
    const brands = ['نعناع', 'المراعي', 'شاهد VIP', 'نون', 'أمازون'];
    return SizedBox(
      height: 56,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: brands.length,
        separatorBuilder: (_, _) => const SizedBox(width: 10),
        itemBuilder: (_, i) => Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.greenLight),
          ),
          child: Text(
            brands[i],
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              color: AppColors.text,
            ),
          ),
        ),
      ),
    );
  }
}

/* ───────────────────────── For you grid ───────────────────────── */

class ForYouGrid extends StatelessWidget {
  const ForYouGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GridView.count(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 1.35,
        children: _coupons
            .map(
              (c) => LayoutBuilder(
                builder: (_, _) => FittedBox(
                  fit: BoxFit.contain,
                  child: SizedBox(
                    width: 220,
                    height: 160,
                    child: CouponCard(coupon: c),
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

/* ───────────────────────── Seasonal + deals ───────────────────────── */

class SeasonalSection extends StatelessWidget {
  const SeasonalSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 28),
      padding: const EdgeInsets.symmetric(vertical: 20),
      color: const Color(0xFFC0392B),
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Text(
              'عروض وكوبونات خاصة بمناسبة السنة الميلادية الجديدة',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          const SizedBox(height: 16),
          CouponList(coupons: _coupons),
        ],
      ),
    );
  }
}

class DealsCard extends StatelessWidget {
  const DealsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'استكشف صفقات جديدة بأوفر الأسعار وأفضل الخصومات',
                  style: TextStyle(fontWeight: FontWeight.w700, height: 1.6),
                ),
                const SizedBox(height: 12),
                FilledButton(
                  onPressed: () {},
                  style: FilledButton.styleFrom(
                    backgroundColor: const Color(0xFF8CCB5E),
                    foregroundColor: AppColors.text,
                  ),
                  child: const Text('اكتشفها الآن'),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          const Icon(
            Icons.shopping_cart_rounded,
            size: 90,
            color: Color(0xFFB9B3D9),
          ),
        ],
      ),
    );
  }
}

/* ───────────────────────── Bottom bar ───────────────────────── */

class AppBottomBar extends StatelessWidget {
  const AppBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: 64,
        margin: const EdgeInsets.fromLTRB(16, 0, 16, 8),
        decoration: BoxDecoration(
          color: AppColors.dark,
          borderRadius: BorderRadius.circular(22),
        ),
        child: Row(
          children: [
            const _NavItem(Icons.grid_view_rounded, 'الفئات'),
            const _NavItem(Icons.confirmation_number_outlined, 'الكوبونات'),
            Expanded(
              child: Transform.translate(
                offset: const Offset(0, -16),
                child: Center(
                  child: Container(
                    width: 56,
                    height: 56,
                    decoration: const BoxDecoration(
                      color: AppColors.green,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(color: Color(0x55000000), blurRadius: 10),
                      ],
                    ),
                    child: const Icon(
                      Icons.home_rounded,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ),
              ),
            ),
            const _NavItem(Icons.storefront_outlined, 'المتاجر'),
            const _NavItem(Icons.settings_outlined, 'الإعدادات'),
          ],
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  const _NavItem(this.icon, this.label);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: () {},
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: 22),
            const SizedBox(height: 2),
            Text(
              label,
              style: const TextStyle(color: Colors.white, fontSize: 10),
            ),
          ],
        ),
      ),
    );
  }
}
