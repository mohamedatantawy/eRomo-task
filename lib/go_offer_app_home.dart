import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


// ───────────────────────── Theme tokens ─────────────────────────
class AppColors {
  static const primary = Color(0xFF4B3FE4);
  static const primaryDark = Color(0xFF3A2FC9);
  static const green = Color(0xFF1ED48B);
  static const greenDark = Color(0xFF0F9E5E);
  static const bg = Color(0xFFF6F5FF);
  static const text = Color(0xFF1E1B4B);
  static const muted = Color(0xFF8A89A6);
  static const star = Color(0xFFFFB800);
}

// ───────────────────────── Data ─────────────────────────
class Coupon {
  final String brand;
  final String logoText;
  final Color logoColor;
  final int discount;
  final bool verified;
  const Coupon(this.brand, this.logoText, this.logoColor, this.discount,
      {this.verified = true});
}

const levis = Coupon('ليفيز', "Levi's", Color(0xFFC41230), 25);
const almarai = Coupon('المراعي', 'المراعي', Color(0xFF1E5AA8), 15);
const lacoste = Coupon('لاكوست', 'LACOSTE', Color(0xFF0B6B3A), 30);
const nana = Coupon('نانا صناع', 'nana صناع', Color(0xFF111111), 30);
const shahid = Coupon('شاهد', 'shahid vip', Color(0xFF0B7A5B), 15);
const dates = Coupon('تمور وكثر', 'تمور', Color(0xFFB4561B), 30, verified: false);

// ───────────────────────── Ticket shapes ─────────────────────────
/// Rounded rectangle with two half-circle notches on the left & right edges.
class SideNotchClipper extends CustomClipper<Path> {
  final double yFraction;
  final double radius;
  final double notch;
  const SideNotchClipper(
      {this.yFraction = .62, this.radius = 14, this.notch = 9});

  @override
  Path getClip(Size s) {
    var p = Path()
      ..addRRect(RRect.fromRectAndRadius(
          Offset.zero & s, Radius.circular(radius)));
    final y = s.height * yFraction;
    for (final x in [0.0, s.width]) {
      p = Path.combine(PathOperation.difference, p,
          Path()..addOval(Rect.fromCircle(center: Offset(x, y), radius: notch)));
    }
    return p;
  }

  @override
  bool shouldReclip(covariant SideNotchClipper o) =>
      o.yFraction != yFraction || o.notch != notch;
}

/// Rounded rectangle with notches on top & bottom at [xFromLeft].
class DividerNotchClipper extends CustomClipper<Path> {
  final double xFromLeft;
  final double radius;
  final double notch;
  const DividerNotchClipper(
      {this.xFromLeft = 104, this.radius = 14, this.notch = 9});

  @override
  Path getClip(Size s) {
    var p = Path()
      ..addRRect(RRect.fromRectAndRadius(
          Offset.zero & s, Radius.circular(radius)));
    for (final y in [0.0, s.height]) {
      p = Path.combine(PathOperation.difference, p,
          Path()..addOval(Rect.fromCircle(center: Offset(xFromLeft, y), radius: notch)));
    }
    return p;
  }

  @override
  bool shouldReclip(covariant DividerNotchClipper o) => o.xFromLeft != xFromLeft;
}

class TicketShadow extends StatelessWidget {
  final CustomClipper<Path> clipper;
  final Widget child;
  final Color color;
  const TicketShadow(
      {super.key,
      required this.clipper,
      required this.child,
      this.color = Colors.white});

  @override
  Widget build(BuildContext context) {
    return PhysicalShape(
      clipper: clipper,
      color: color,
      elevation: 6,
      shadowColor: AppColors.primary.withOpacity(.35),
      child: child,
    );
  }
}

// ───────────────────────── Small widgets ─────────────────────────
class BrandLogo extends StatelessWidget {
  final Coupon c;
  final double size;
  const BrandLogo(this.c, {super.key, this.size = 16});

  @override
  Widget build(BuildContext context) => Text(
        c.logoText,
        textAlign: TextAlign.center,
        style: GoogleFonts.cairo(
            fontSize: size, fontWeight: FontWeight.w900, color: c.logoColor),
      );
}

class ShowCodeButton extends StatelessWidget {
  final bool filled;
  const ShowCodeButton({super.key, this.filled = true});

  @override
  Widget build(BuildContext context) {
    if (filled) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 3),
        decoration: BoxDecoration(
            color: AppColors.primary, borderRadius: BorderRadius.circular(20)),
        child: Text('عرض الكود',
            style: GoogleFonts.cairo(
                color: Colors.white, fontSize: 10, fontWeight: FontWeight.w700)),
      );
    }
    return Row(mainAxisSize: MainAxisSize.min, children: [
      Text('عرض الكود',
          style: GoogleFonts.cairo(
              color: AppColors.primary,
              fontSize: 10,
              fontWeight: FontWeight.w700)),
      const Icon(Icons.chevron_left, size: 14, color: AppColors.primary),
    ]);
  }
}

class SectionTitle extends StatelessWidget {
  final String text;
  final Color color;
  const SectionTitle(this.text, {super.key, this.color = AppColors.primary});

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.fromLTRB(16, 18, 16, 10),
        child: Text(text,
            style: GoogleFonts.cairo(
                fontSize: 12, fontWeight: FontWeight.w700, color: color)),
      );
}

// ───────────────────────── Coupon cards ─────────────────────────
/// Wide ticket used in horizontal lists (most used / new / special).
class WideCoupon extends StatelessWidget {
  final Coupon c;
  final double width;
  const WideCoupon(this.c, {super.key, this.width = 330});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: 118,
      child: TicketShadow(
        clipper: const DividerNotchClipper(xFromLeft: 104),
        child: Row(children: [
          // Info (right in RTL)
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(12, 10, 14, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(children: [
                    Icon(Icons.favorite, size: 16, color: Colors.red.shade400),
                    const Spacer(),
                    Text(c.brand,
                        style: GoogleFonts.cairo(
                            fontSize: 13,
                            fontWeight: FontWeight.w800,
                            color: AppColors.text)),
                  ]),
                  Text('كود خصم',
                      style: GoogleFonts.cairo(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: AppColors.text)),
                  Text('${c.discount}%',
                      style: GoogleFonts.cairo(
                          fontSize: 28,
                          height: 1.1,
                          fontWeight: FontWeight.w900,
                          color: AppColors.green)),
                  Row(children: [
                    const ShowCodeButton(filled: false),
                    const Spacer(),
                    const Icon(Icons.access_time,
                        size: 11, color: AppColors.muted),
                    const SizedBox(width: 3),
                    Text('اخر استخدام منذ 1 ساعة',
                        style: GoogleFonts.cairo(
                            fontSize: 9, color: AppColors.muted)),
                  ]),
                ],
              ),
            ),
          ),
          // Dashed divider
          CustomPaint(
              size: const Size(1, double.infinity), painter: _DashedLine()),
          // Logo side (left in RTL)
          SizedBox(
            width: 103,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                if (c.verified)
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Text('كود فعال',
                        style: GoogleFonts.cairo(
                            fontSize: 8, color: AppColors.greenDark)),
                    const SizedBox(width: 3),
                    const Icon(Icons.check_circle,
                        size: 12, color: AppColors.green),
                  ])
                else
                  const SizedBox(height: 12),
                BrandLogo(c, size: 18),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  const Icon(Icons.star, size: 12, color: AppColors.star),
                  const SizedBox(width: 2),
                  Text('(4.9)',
                      style: GoogleFonts.cairo(
                          fontSize: 8, color: AppColors.muted)),
                  const SizedBox(width: 8),
                  Text('مشاركة',
                      style: GoogleFonts.cairo(
                          fontSize: 8, color: AppColors.text)),
                  const SizedBox(width: 2),
                  const Icon(Icons.ios_share, size: 11, color: AppColors.text),
                ]),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}

class _DashedLine extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final p = Paint()
      ..color = AppColors.primary.withOpacity(.25)
      ..strokeWidth = 1;
    double y = 12;
    while (y < size.height - 12) {
      canvas.drawLine(Offset(0, y), Offset(0, y + 4), p);
      y += 8;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter old) => false;
}

/// Compact vertical card used in the 2-column "for you" grid.
class GridCoupon extends StatelessWidget {
  final Coupon c;
  const GridCoupon(this.c, {super.key});

  @override
  Widget build(BuildContext context) {
    return TicketShadow(
      clipper: const SideNotchClipper(yFraction: .66, radius: 12, notch: 8),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 14, 10, 10),
        child: Column(children: [
          SizedBox(height: 26, child: Center(child: BrandLogo(c, size: 16))),
          const SizedBox(height: 6),
          Text('كود خصم',
              style: GoogleFonts.cairo(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: AppColors.text)),
          Text('${c.discount}%',
              style: GoogleFonts.cairo(
                  fontSize: 28,
                  height: 1.1,
                  fontWeight: FontWeight.w900,
                  color: AppColors.green)),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            const Icon(Icons.access_time, size: 10, color: AppColors.muted),
            const SizedBox(width: 3),
            Text('اخر استخدام منذ 1 ساعة',
                style: GoogleFonts.cairo(fontSize: 8, color: AppColors.muted)),
          ]),
          const Spacer(),
          Row(children: [
            const Icon(Icons.star, size: 12, color: AppColors.star),
            Text(' (4.9)',
                style: GoogleFonts.cairo(fontSize: 8, color: AppColors.muted)),
            const Spacer(),
            const ShowCodeButton(),
            const Spacer(),
            Icon(Icons.check_circle,
                size: 13,
                color: c.verified ? AppColors.green : Colors.grey.shade400),
          ]),
        ]),
      ),
    );
  }
}

// ───────────────────────── Home screen ─────────────────────────
class GoOfferApp extends StatelessWidget {
  const GoOfferApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: SafeArea(
        bottom: false,
        child: ListView(
          padding: const EdgeInsets.only(bottom: 110),
          children: [
            const _Header(),
            const _SearchBar(),
            const _BannerCarousel(),
            const SectionTitle('تسوق حسب الفئات'),
            const _CategoryGrid(),
            const SectionTitle('الكوبونات الأكثر استخداماً'),
            const _HList(coupons: [levis, lacoste, nana]),
            const SizedBox(height: 22),
            const _BrandsSection(),
            const SectionTitle('خصصناها لك'),
            const _ForYouGrid(),
            const SectionTitle('مضافة حديثاً'),
            const _HList(coupons: [levis, almarai, shahid]),
            const _NationalDaySection(),
            const SectionTitle('كوبونات الخاص'),
            const _HList(coupons: [levis, lacoste, nana]),
            const SizedBox(height: 14),
            const _AlmaraiOffer(),
            const SizedBox(height: 10),
            const _Dots(count: 4, active: 0),
          ],
        ),
      ),
      bottomNavigationBar: const _BottomNav(),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: Row(children: [
        const Icon(Icons.menu_open, color: AppColors.primary),
        const Spacer(),
        Row(children: [
          Text('GO OFFER',
              style: GoogleFonts.cairo(
                  fontSize: 15,
                  fontWeight: FontWeight.w900,
                  color: AppColors.primary)),
          const SizedBox(width: 6),
          const Icon(Icons.local_offer, color: AppColors.primary, size: 22),
        ]),
        const Spacer(),
        const Icon(Icons.notifications_none, color: AppColors.primary),
      ]),
    );
  }
}

class _SearchBar extends StatelessWidget {
  const _SearchBar();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Container(
        height: 46,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: AppColors.primary.withOpacity(.25)),
          boxShadow: [
            BoxShadow(
                color: AppColors.primary.withOpacity(.12),
                blurRadius: 12,
                offset: const Offset(0, 4))
          ],
        ),
        child: Row(children: [
          const Icon(Icons.search, color: AppColors.primary),
          const SizedBox(width: 8),
          Expanded(
            child: Text('ابحث هنا...',
                style: GoogleFonts.cairo(fontSize: 12, color: AppColors.muted)),
          ),
          CircleAvatar(
            radius: 15,
            backgroundColor: AppColors.primary,
            child: const Icon(Icons.mic, size: 16, color: Colors.white),
          ),
        ]),
      ),
    );
  }
}

class _BannerCarousel extends StatelessWidget {
  const _BannerCarousel();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 130,
      child: PageView(
        controller: PageController(viewportFraction: .88),
        padEnds: true,
        children: const [
          _Banner(
            colors: [Color(0xFFFF9A3C), Color(0xFFFFB347)],
            title: 'عُرض كوبونات بندة',
            body: 'كوبونات شغالة مضمونة في 1500 متجر\nمعاملات مضمونة في كل المتاجر',
          ),
          _Banner(
            colors: [Color(0xFF2ED3A0), Color(0xFF16A877)],
            title: 'عروض اليوم الوطني',
            body: 'خصومات حصرية لفترة محدودة',
          ),
          _Banner(
            colors: [Color(0xFF5B8CFF), Color(0xFF4B3FE4)],
            title: 'كوبونات جديدة',
            body: 'اكتشف أحدث الأكواد اليوم',
          ),
        ],
      ),
    );
  }
}

class _Banner extends StatelessWidget {
  final List<Color> colors;
  final String title;
  final String body;
  const _Banner(
      {required this.colors, required this.title, required this.body});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 6),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: colors),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
              color: colors.first.withOpacity(.4),
              blurRadius: 12,
              offset: const Offset(0, 6))
        ],
      ),
      child: Row(children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(title,
                  style: GoogleFonts.cairo(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w800)),
              const SizedBox(height: 4),
              Text(body,
                  style: GoogleFonts.cairo(
                      color: Colors.white.withOpacity(.9), fontSize: 9.5)),
              const SizedBox(height: 8),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 3),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)),
                child: Text('اكتشف الآن',
                    style: GoogleFonts.cairo(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        color: colors.last)),
              ),
            ],
          ),
        ),
        const SizedBox(width: 10),
        Stack(alignment: Alignment.center, children: [
          const Icon(Icons.shopping_cart, size: 70, color: Colors.white),
          Positioned(
            top: 4,
            child: CircleAvatar(
              radius: 16,
              backgroundColor: Colors.redAccent,
              child: Text('%',
                  style: GoogleFonts.cairo(
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                      fontSize: 16)),
            ),
          ),
        ]),
      ]),
    );
  }
}

class _CategoryGrid extends StatelessWidget {
  const _CategoryGrid();

  static const _items = <(String, IconData)>[
    ('الجوالات', Icons.smartphone),
    ('المنزل الذكي', Icons.devices_other),
    ('البقالة', Icons.shopping_basket_outlined),
    ('الملابس', Icons.checkroom),
    ('الطيران و السفر', Icons.flight_takeoff),
  ];

  @override
  Widget build(BuildContext context) {
    final tiles = <Widget>[
      for (final it in _items) _CategoryTile(label: it.$1, icon: it.$2),
      const _CategoryTile(label: 'المزيد', icon: Icons.chevron_left, more: true),
    ];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GridView.count(
        crossAxisCount: 3,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 1.08,
        children: tiles,
      ),
    );
  }
}

class _CategoryTile extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool more;
  const _CategoryTile(
      {required this.label, required this.icon, this.more = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: more ? AppColors.primary : Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
              color: AppColors.primary.withOpacity(.18),
              blurRadius: 10,
              offset: const Offset(0, 4))
        ],
      ),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Icon(icon, size: 34, color: more ? Colors.white : AppColors.primary),
        const SizedBox(height: 6),
        Text(label,
            style: GoogleFonts.cairo(
                fontSize: 10.5,
                fontWeight: FontWeight.w700,
                color: more ? Colors.white : AppColors.text)),
      ]),
    );
  }
}

class _HList extends StatelessWidget {
  final List<Coupon> coupons;
  const _HList({required this.coupons});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width * .86;
    return SizedBox(
      height: 134,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.fromLTRB(16, 6, 16, 10),
        itemCount: coupons.length,
        separatorBuilder: (_, __) => const SizedBox(width: 14),
        itemBuilder: (_, i) => WideCoupon(coupons[i], width: w.clamp(280, 360)),
      ),
    );
  }
}

class _BrandsSection extends StatelessWidget {
  const _BrandsSection();

  static const _brands = [nana, almarai, dates];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
            colors: [AppColors.primary, AppColors.primaryDark],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text('تصفح حسب العلامات التجارية',
              style: GoogleFonts.cairo(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w700)),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 84,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: _brands.length,
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemBuilder: (_, i) => Container(
              width: 96,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(12)),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    BrandLogo(_brands[i], size: 15),
                    const SizedBox(height: 6),
                    Text(_brands[i].brand,
                        style: GoogleFonts.cairo(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            color: AppColors.text)),
                  ]),
            ),
          ),
        ),
      ]),
    );
  }
}

class _ForYouGrid extends StatelessWidget {
  const _ForYouGrid();

  static const _items = [almarai, levis, shahid, dates, lacoste, nana];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GridView.count(
        crossAxisCount: 2,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 1.08,
        children: [for (final c in _items) GridCoupon(c)],
      ),
    );
  }
}

class _NationalDaySection extends StatelessWidget {
  const _NationalDaySection();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.only(top: 22, bottom: 12),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF16A864), Color(0xFF2BC37C), Color(0x00FFFFFF)],
          stops: [0, .55, 1],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text('عروض خاصة بمناسبة\nاليوم الوطني الـ94',
              style: GoogleFonts.cairo(
                  color: Colors.white,
                  fontSize: 16,
                  height: 1.4,
                  fontWeight: FontWeight.w800)),
        ),
        const SizedBox(height: 22),
        const SectionTitle('العروض و الكوبونات', color: AppColors.greenDark),
        const _HList(coupons: [levis, lacoste]),
      ]),
    );
  }
}

class _AlmaraiOffer extends StatelessWidget {
  const _AlmaraiOffer();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: SizedBox(
        height: 150,
        child: Stack(children: [
          PhysicalShape(
            clipper: const SideNotchClipper(yFraction: .64, radius: 18, notch: 10),
            color: Colors.white,
            elevation: 4,
            shadowColor: AppColors.primary.withOpacity(.35),
            child: Container(),
          ),
          // Border outline following the same shape
          Positioned.fill(
            child: CustomPaint(
                painter: _TicketBorder(
                    const SideNotchClipper(yFraction: .64, radius: 18, notch: 10))),
          ),
          Positioned.fill(
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Column(children: [
                  BrandLogo(almarai, size: 18),
                  Text('العرض اليومي لبراند "المراعي"',
                      style: GoogleFonts.cairo(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: AppColors.primary)),
                  Text('احصل على كود خصم المراعي بقيمة 50% على منتجات مختارة',
                      style: GoogleFonts.cairo(
                          fontSize: 8.5, color: AppColors.muted)),
                  const SizedBox(height: 4),
                  const ShowCodeButton(filled: false),
                ]),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: CustomPaint(
                    size: const Size(double.infinity, 1),
                    painter: _HDashed()),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8, top: 2),
                child: Column(children: [
                  Text('50%',
                      style: GoogleFonts.cairo(
                          fontSize: 34,
                          height: 1.1,
                          fontWeight: FontWeight.w900,
                          color: AppColors.green)),
                  Text('خصم',
                      style: GoogleFonts.cairo(
                          fontSize: 14,
                          height: 1,
                          fontWeight: FontWeight.w800,
                          color: AppColors.text)),
                ]),
              ),
            ]),
          ),
        ]),
      ),
    );
  }
}

class _TicketBorder extends CustomPainter {
  final CustomClipper<Path> clipper;
  _TicketBorder(this.clipper);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawPath(
      clipper.getClip(size),
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.2
        ..color = AppColors.primary,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter old) => false;
}

class _HDashed extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final p = Paint()
      ..color = AppColors.primary.withOpacity(.3)
      ..strokeWidth = 1;
    double x = 0;
    while (x < size.width) {
      canvas.drawLine(Offset(x, 0), Offset(x + 4, 0), p);
      x += 8;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter old) => false;
}

class _Dots extends StatelessWidget {
  final int count;
  final int active;
  const _Dots({required this.count, required this.active});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        count,
        (i) => Container(
          margin: const EdgeInsets.symmetric(horizontal: 3),
          width: 7,
          height: 7,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: i == active
                ? AppColors.green
                : AppColors.primary.withOpacity(.2),
          ),
        ),
      ),
    );
  }
}

// ───────────────────────── Bottom navigation ─────────────────────────
class _BottomNav extends StatelessWidget {
  const _BottomNav();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 84,
      child: Stack(clipBehavior: Clip.none, alignment: Alignment.bottomCenter, children: [
        Container(
          height: 64,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(22)),
            boxShadow: [
              BoxShadow(
                  color: AppColors.primary.withOpacity(.18),
                  blurRadius: 16,
                  offset: const Offset(0, -4))
            ],
          ),
          child: Row(children: const [
            Expanded(child: _NavItem('الفئات', Icons.grid_view_rounded)),
            Expanded(child: _NavItem('الكوبونات', Icons.confirmation_number_outlined)),
            Expanded(child: SizedBox()), // space for center button
            Expanded(child: _NavItem('المتاجر', Icons.storefront_outlined)),
            Expanded(child: _NavItem('المنتجات', Icons.inventory_2_outlined)),
          ]),
        ),
        Positioned(
          top: 0,
          child: Container(
            width: 58,
            height: 58,
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(18),
              boxShadow: [
                BoxShadow(
                    color: AppColors.primary.withOpacity(.5),
                    blurRadius: 14,
                    offset: const Offset(0, 6))
              ],
            ),
            child: const Icon(Icons.home_rounded, color: Colors.white, size: 28),
          ),
        ),
      ]),
    );
  }
}

class _NavItem extends StatelessWidget {
  final String label;
  final IconData icon;
  const _NavItem(this.label, this.icon);

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Icon(icon, size: 22, color: AppColors.muted),
      const SizedBox(height: 2),
      Text(label,
          style: GoogleFonts.cairo(
              fontSize: 9.5,
              fontWeight: FontWeight.w600,
              color: AppColors.muted)),
    ]);
  }
}