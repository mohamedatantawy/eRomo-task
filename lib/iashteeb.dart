import 'package:flutter/material.dart';

// ───────────────────────── Theme tokens ─────────────────────────
class C {
  static const navy = Color(0xFF12233D);
  static const blue = Color(0xFF1F4A8A);
  static const blueDark = Color(0xFF1A3C73);
  static const orange = Color(0xFFF97316);
  static const bg = Color(0xFFF4F6F9);
  static const border = Color(0xFFE3E7ED);
  static const muted = Color(0xFF6B7585);
  static const text = Color(0xFF111C2E);
  static const iconBlue = Color(0xFF1F4A8A);
}

// ───────────────────────── Page ─────────────────────────
class IashteebApp extends StatefulWidget {
  const IashteebApp({super.key});
  @override
  State<IashteebApp> createState() => _IashteebAppState();
}

class _IashteebAppState extends State<IashteebApp> {
  int _tab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          const _Hero(),
          Transform.translate(
            offset: const Offset(0, -40),
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: _OpportunitiesCard(),
            ),
          ),
          Transform.translate(
            offset: const Offset(0, -24),
            child: const _TrustRow(),
          ),
          const _PromoSlider(),
          const _Categories(),
          const _TopPros(),
          const _LatestProjects(),
          const _Reels(),
          const _IdeaBookBanner(),
          const SizedBox(height: 16),
        ],
      ),
      bottomNavigationBar: _BottomNav(
        index: _tab,
        onTap: (i) => setState(() => _tab = i),
      ),
    );
  }
}

// ───────────────────────── Hero ─────────────────────────
class _Hero extends StatelessWidget {
  const _Hero();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // top bar
        Container(
          color: Colors.white,
          padding: EdgeInsets.fromLTRB(
            16,
            MediaQuery.of(context).padding.top + 8,
            16,
            10,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const _Logo(),
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: C.border),
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    const Icon(
                      Icons.notifications_none_rounded,
                      color: C.orange,
                      size: 20,
                    ),
                    Positioned(
                      top: 8,
                      right: 9,
                      child: Container(
                        width: 7,
                        height: 7,
                        decoration: const BoxDecoration(
                          color: C.orange,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        // blue area
        Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 58),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [C.blueDark, C.blue],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Good evening, Hekal team',
                style: TextStyle(color: Colors.white70, fontSize: 12),
              ),
              const SizedBox(height: 2),
              const Text(
                'Find Trusted\nConstruction',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  height: 1.2,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const Text(
                'Professionals',
                style: TextStyle(
                  color: C.orange,
                  fontSize: 26,
                  height: 1.2,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                'Search, compare, and connect with top professionals in design, construction, and finishing.',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 12,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 16),
              // search
              Container(
                height: 52,
                padding: const EdgeInsets.only(left: 14, right: 6),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.search, color: C.muted, size: 20),
                    const SizedBox(width: 8),
                    const Expanded(
                      child: Text(
                        'Search services, e.g. "epoxy"',
                        style: TextStyle(color: C.muted, fontSize: 13),
                      ),
                    ),
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: C.navy,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(
                        Icons.tune_rounded,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),
              SizedBox(
                height: 32,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: const [
                    _Chip('Interior design'),
                    _Chip('Finishing'),
                    _Chip('MEP'),
                    _Chip('Epoxy flooring'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _Logo extends StatelessWidget {
  const _Logo();
  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: const [
      Text(
        'iashteeb',
        style: TextStyle(
          color: C.blue,
          fontSize: 24,
          height: 1,
          fontWeight: FontWeight.w900,
        ),
      ),
      Text(
        'CONNECT. BUILD. TRANSFORM.',
        style: TextStyle(
          color: C.orange,
          fontSize: 5.5,
          letterSpacing: 0.6,
          fontWeight: FontWeight.w700,
        ),
      ),
    ],
  );
}

class _Chip extends StatelessWidget {
  final String label;
  const _Chip(this.label);
  @override
  Widget build(BuildContext context) => Container(
    margin: const EdgeInsets.only(right: 8),
    padding: const EdgeInsets.symmetric(horizontal: 14),
    alignment: Alignment.center,
    decoration: BoxDecoration(
      color: Colors.white.withValues(alpha: 0.08),
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: Colors.white.withValues(alpha: 0.35)),
    ),
    child: Text(
      label,
      style: const TextStyle(color: Colors.white, fontSize: 12),
    ),
  );
}

// ───────────────────────── Opportunities ─────────────────────────
class _OpportunitiesCard extends StatelessWidget {
  const _OpportunitiesCard();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 20,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEAF1FB),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Icon(Icons.auto_awesome, size: 11, color: C.blue),
                        SizedBox(width: 4),
                        Text(
                          'Matched for you',
                          style: TextStyle(fontSize: 10, color: C.blue),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'New opportunities for you',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                      color: C.navy,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: C.navy,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: const [
                    Icon(
                      Icons.local_fire_department_outlined,
                      color: C.orange,
                      size: 14,
                    ),
                    SizedBox(width: 6),
                    Text(
                      '24',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const _OppItem(
            code: 'BR-2026-0034',
            match: '94% match',
            urgency: 'Urgent (within 48 hours)',
            urgent: true,
            title: 'تشطيب فيلا بالتجمع الخامس',
            bold: false,
            meta: 'Full villa finishing · New Cairo',
          ),
          const _OppItem(
            code: 'BR-2026-0030',
            match: '88% match',
            urgency: 'Within 1 week',
            urgent: false,
            title:
                'Gypsum ceiling and hidden lighting for a 3-bedroom apartment',
            bold: true,
            meta: 'Gypsum & ceilings · Sheikh Zayed',
          ),
          const _OppItem(
            code: 'BR-2026-0025',
            match: '76% match',
            urgency: 'Planning stage',
            urgent: false,
            title: 'تصميم لاندسكيب لحديقة دوبلكس',
            bold: false,
            meta: 'Garden design · 6th of October',
          ),
          const SizedBox(height: 4),
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: C.orange,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Browse marketplace',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _OppItem extends StatelessWidget {
  final String code, match, urgency, title, meta;
  final bool urgent, bold;
  const _OppItem({
    required this.code,
    required this.match,
    required this.urgency,
    required this.urgent,
    required this.title,
    required this.bold,
    required this.meta,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: C.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(code, style: const TextStyle(fontSize: 10, color: C.muted)),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                decoration: BoxDecoration(
                  color: C.navy,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  match,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 9,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const Spacer(),
              Text(
                urgency,
                style: TextStyle(
                  fontSize: 10,
                  color: urgent ? const Color(0xFFE5483B) : C.orange,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: double.infinity,
            child: Text(
              title,
              style: TextStyle(
                fontSize: 13,
                color: C.navy,
                fontWeight: bold ? FontWeight.w800 : FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(height: 6),
          Text(meta, style: const TextStyle(fontSize: 10, color: C.muted)),
        ],
      ),
    );
  }
}

// ───────────────────────── Trust row ─────────────────────────
class _TrustRow extends StatelessWidget {
  const _TrustRow();
  @override
  Widget build(BuildContext context) {
    Widget item(IconData i, Color c, String t) => Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(i, size: 13, color: c),
        const SizedBox(width: 4),
        Text(t, style: const TextStyle(fontSize: 10, color: C.muted)),
      ],
    );
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        item(
          Icons.check_circle_outline,
          const Color(0xFF2E9E6B),
          '500+ Trusted Pros',
        ),
        item(Icons.star_border_rounded, C.orange, 'Real Reviews'),
        item(Icons.verified_user_outlined, C.blue, 'Quality Guaranteed'),
      ],
    );
  }
}

// ───────────────────────── Promo slider ─────────────────────────
class _PromoSlider extends StatelessWidget {
  const _PromoSlider();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              const PlaceholderBox(
                label: 'PROMO SLIDER · /WEB/SLIDERS',
                height: 150,
                radius: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 18,
                      height: 4,
                      decoration: BoxDecoration(
                        color: C.blue,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    const SizedBox(width: 4),
                    for (int i = 0; i < 2; i++)
                      Container(
                        width: 4,
                        height: 4,
                        margin: const EdgeInsets.only(right: 4),
                        decoration: const BoxDecoration(
                          color: Color(0xFFB9C3D1),
                          shape: BoxShape.circle,
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ───────────────────────── Section helpers ─────────────────────────
class _SectionHeader extends StatelessWidget {
  final String title, action;
  const _SectionHeader(this.title, this.action);
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.fromLTRB(16, 26, 16, 12),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w800,
            color: C.navy,
          ),
        ),
        Text(
          action,
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w700,
            color: C.blue,
          ),
        ),
      ],
    ),
  );
}

/// Diagonal-striped placeholder for photos.
class PlaceholderBox extends StatelessWidget {
  final String label;
  final double height;
  final double radius;
  const PlaceholderBox({
    super.key,
    required this.label,
    required this.height,
    this.radius = 16,
  });
  @override
  Widget build(BuildContext context) => ClipRRect(
    borderRadius: BorderRadius.circular(radius),
    child: SizedBox(
      height: height,
      width: double.infinity,
      child: CustomPaint(
        painter: _StripePainter(),
        child: Center(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            color: Colors.white.withValues(alpha: 0.7),
            child: Text(
              label,
              style: const TextStyle(fontSize: 9, color: C.muted),
            ),
          ),
        ),
      ),
    ),
  );
}

class _StripePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(
      Offset.zero & size,
      Paint()..color = const Color(0xFFE9EDF3),
    );
    final p = Paint()
      ..color = Colors.white.withValues(alpha: 0.55)
      ..strokeWidth = 8;
    for (double x = -size.height; x < size.width; x += 18) {
      canvas.drawLine(Offset(x, size.height), Offset(x + size.height, 0), p);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter old) => false;
}

// ───────────────────────── Categories ─────────────────────────
class _Categories extends StatelessWidget {
  const _Categories();
  static const items = <(IconData, String)>[
    (Icons.apartment_rounded, 'Structural'),
    (Icons.electrical_services_rounded, 'MEP'),
    (Icons.architecture_rounded, 'Architecture'),
    (Icons.weekend_outlined, 'Interiors'),
    (Icons.park_outlined, 'Landscape'),
    (Icons.view_in_ar_outlined, '3D Renders'),
    (Icons.calculate_outlined, 'BOQ'),
    (Icons.water_drop_outlined, 'Waterproofing'),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const _SectionHeader('Categories', 'See all'),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: GridView.count(
            crossAxisCount: 4,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 12,
            crossAxisSpacing: 10,
            childAspectRatio: 0.82,
            children: [
              for (final it in items)
                Column(
                  children: [
                    Container(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: C.border),
                      ),
                      child: Icon(it.$1, color: C.iconBlue, size: 24),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      it.$2,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 10, color: C.navy),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ],
    );
  }
}

// ───────────────────────── Top professionals ─────────────────────────
class _TopPros extends StatelessWidget {
  const _TopPros();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const _SectionHeader('Top professionals', 'See all'),
        SizedBox(
          height: 218,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            children: const [
              _ProCard(
                'NA',
                'Numidia Arts',
                'Decor & Interior Design · New Cairo',
                '4.9',
                '(128)',
                '86 projects',
                fav: true,
              ),
              _ProCard(
                'HK',
                'Hekal',
                'Finishing & Renovation · Zayed',
                '4.8',
                '(94)',
                '64 projects',
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ProCard extends StatelessWidget {
  final String initials, name, sub, rating, reviews, projects;
  final bool fav;
  const _ProCard(
    this.initials,
    this.name,
    this.sub,
    this.rating,
    this.reviews,
    this.projects, {
    this.fav = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: C.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              const ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
                child: PlaceholderBox(
                  label: 'COVER PHOTO',
                  height: 120,
                  radius: 0,
                ),
              ),
              if (fav)
                Positioned(
                  top: 10,
                  right: 10,
                  child: Container(
                    width: 28,
                    height: 28,
                    decoration: const BoxDecoration(
                      color: Color(0xFFFFE3E3),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.favorite_border,
                      size: 15,
                      color: Color(0xFFE5483B),
                    ),
                  ),
                ),
              Positioned(
                left: 12,
                bottom: -22,
                child: Container(
                  width: 40,
                  height: 40,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: C.navy,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                  child: Text(
                    initials,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w800,
                        color: C.navy,
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Icon(
                      Icons.verified_outlined,
                      size: 14,
                      color: C.blue,
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  sub,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 10, color: C.muted),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(
                      Icons.star_border_rounded,
                      size: 14,
                      color: C.orange,
                    ),
                    const SizedBox(width: 3),
                    Text(
                      rating,
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(width: 3),
                    Text(
                      reviews,
                      style: const TextStyle(fontSize: 10, color: C.muted),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      projects,
                      style: const TextStyle(fontSize: 10, color: C.muted),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ───────────────────────── Latest projects ─────────────────────────
class _LatestProjects extends StatelessWidget {
  const _LatestProjects();
  @override
  Widget build(BuildContext context) {
    Widget card(String title, String meta) => Container(
      width: 165,
      margin: const EdgeInsets.only(right: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const PlaceholderBox(label: 'PROJECT PHOTO', height: 200, radius: 16),
          const SizedBox(height: 10),
          Text(
            title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: C.navy,
            ),
          ),
          const SizedBox(height: 4),
          Text(meta, style: const TextStyle(fontSize: 10, color: C.muted)),
        ],
      ),
    );

    return Column(
      children: [
        const _SectionHeader('Latest projects', 'See all'),
        SizedBox(
          height: 290,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            children: [
              card(
                'Luxury villa finishing, Fifth Settlement',
                'Numidia Arts · 2025',
              ),
              card('Al-Tahrir Car Trading HQ', 'Numidia Arts · 2025'),
            ],
          ),
        ),
      ],
    );
  }
}

// ───────────────────────── Reels ─────────────────────────
class _Reels extends StatelessWidget {
  const _Reels();
  @override
  Widget build(BuildContext context) {
    Widget reel(String t) => Container(
      width: 112,
      margin: const EdgeInsets.only(right: 10),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: const Color(0xFF14264A),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Stack(
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.play_arrow_outlined,
              size: 15,
              color: C.navy,
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Text(
              t,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 10,
                fontWeight: FontWeight.w700,
                height: 1.25,
              ),
            ),
          ),
        ],
      ),
    );

    return Column(
      children: [
        const _SectionHeader('Reels', 'Watch'),
        SizedBox(
          height: 140,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            children: [
              reel('Before and after: a 180 m² apartment in New Cairo'),
              reel('Lighting a majlis with hidden coves'),
              reel('How we level floors before porcelain'),
            ],
          ),
        ),
      ],
    );
  }
}

// ───────────────────────── Idea book banner ─────────────────────────
class _IdeaBookBanner extends StatelessWidget {
  const _IdeaBookBanner();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          color: const Color(0xFF111F38),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 120,
                width: double.infinity,
                color: const Color(0xFF1A2B4A),
                alignment: Alignment.center,
                child: const Text(
                  'IDEA BOOK COLLAGE',
                  style: TextStyle(color: Colors.white54, fontSize: 9),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Save ideas. Show the look you want.',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        height: 1.25,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'Browse idea books by style, room and budget.',
                      style: TextStyle(color: Colors.white70, fontSize: 11),
                    ),
                    const SizedBox(height: 14),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: C.navy,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        'Browse idea books',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
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

// ───────────────────────── Bottom nav ─────────────────────────
class _BottomNav extends StatelessWidget {
  final int index;
  final ValueChanged<int> onTap;
  const _BottomNav({required this.index, required this.onTap});

  static const _items = <(IconData, String)>[
    (Icons.home_outlined, 'Home'),
    (Icons.explore_outlined, 'Explore'),
    (Icons.gavel_rounded, 'Tenders'),
    (Icons.toll_outlined, 'Credits'),
    (Icons.person_outline_rounded, 'Account'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: C.border)),
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 62,
          child: Row(
            children: [
              for (int i = 0; i < _items.length; i++)
                Expanded(
                  child: InkWell(
                    onTap: () => onTap(i),
                    child: Column(
                      children: [
                        Container(
                          height: 2,
                          width: 28,
                          color: i == index ? C.blue : Colors.transparent,
                        ),
                        const Spacer(),
                        Icon(
                          _items[i].$1,
                          size: 22,
                          color: i == index ? C.blue : C.muted,
                        ),
                        const SizedBox(height: 3),
                        Text(
                          _items[i].$2,
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: i == index
                                ? FontWeight.w700
                                : FontWeight.w400,
                            color: i == index ? C.blue : C.muted,
                          ),
                        ),
                        const SizedBox(height: 8),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
