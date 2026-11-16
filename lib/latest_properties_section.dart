import 'package:e_romo_task/featured_properties_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

// File-private constants (no clash with your other files)
const _kPrimary = Color(0xFF0B5C73);
const _kGrey = Color(0xFF7A7A7A);
const _kTagBg = Color(0xFFD9E1E7);

const _bathIcon = 'assets/icons/bathroom-svgrepo-com 1.svg';
const _areaIcon = 'assets/icons/site.svg';
const _locationIcon = 'assets/icons/location.svg';
const _clockIcon = 'assets/icons/clock.svg';
const _agentLogo = 'assets/images/logo_iconGG.jpg';

// ==================================================================
// Model
// ==================================================================
class LatestProperty {
  final String image;
  final String price; // "4,000,000"
  final String title;
  final int beds;
  final int baths;
  final String area; // "8,725 م²"
  final String location;
  final String timeAgo;
  final String type; // للبيع / للإيجار
  final String? agentLogo;

  const LatestProperty({
    required this.image,
    required this.price,
    required this.title,
    required this.beds,
    required this.baths,
    required this.area,
    required this.location,
    required this.timeAgo,
    this.type = 'للبيع',
    this.agentLogo,
  });
}

// ==================================================================
// Section: title + tabs + horizontal cards + dots
// ==================================================================
class LatestPropertiesSection extends StatefulWidget {
  final String title;
  final List<LatestProperty> items;
  final VoidCallback? onSeeAll;
  final void Function(LatestProperty property)? onTap;

  const LatestPropertiesSection({
    super.key,
    required this.title,
    required this.items,
    this.onSeeAll,
    this.onTap,
  });

  @override
  State<LatestPropertiesSection> createState() =>
      _LatestPropertiesSectionState();
}

class _LatestPropertiesSectionState extends State<LatestPropertiesSection> {
  final _controller = PageController(viewportFraction: 0.92);
  static const _tabs = ['الكل', 'البيع', 'للإيجار'];
  int _tab = 0;
  int _page = 0;

  List<LatestProperty> get _filtered {
    if (_tab == 1) return widget.items.where((e) => e.type == 'للبيع').toList();
    if (_tab == 2) {
      return widget.items.where((e) => e.type == 'للإيجار').toList();
    }
    return widget.items;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _changeTab(int i) {
    setState(() {
      _tab = i;
      _page = 0;
    });
    if (_controller.hasClients) _controller.jumpToPage(0);
  }

  @override
  Widget build(BuildContext context) {
    final data = _filtered;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ---------- Title + see all ----------
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Text(
                widget.title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: widget.onSeeAll,
                child: const Text(
                  'مشاهدة الكل',
                  style: TextStyle(fontSize: 14, color: _kGrey),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),

        // ---------- Tabs ----------
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              for (int i = 0; i < _tabs.length; i++) ...[
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () => _changeTab(i),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: Text(
                      _tabs[i],
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: i == _tab
                            ? FontWeight.w700
                            : FontWeight.w400,
                        color: i == _tab ? Colors.black : _kGrey,
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

        // ---------- Cards ----------
        SizedBox(
          height: 150,
          child: PageView.builder(
            controller: _controller,
            padEnds: false,
            itemCount: data.length,
            onPageChanged: (i) => setState(() => _page = i),
            itemBuilder: (_, i) => Padding(
              padding: EdgeInsetsDirectional.only(
                start: i == 0 ? 16 : 6,
                end: 6,
              ),
              child: LatestPropertyCard(
                property: data[i],
                onTap: widget.onTap == null
                    ? null
                    : () => widget.onTap!(data[i]),
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),

        // ---------- Dots ----------
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            data.length,
            (i) => AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              margin: const EdgeInsets.symmetric(horizontal: 3),
              width: 6,
              height: 6,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: i == _page ? _kPrimary : const Color(0xFFD9D9D9),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// ==================================================================
// Horizontal card (image on the start side, details next to it)
// ==================================================================
class LatestPropertyCard extends StatefulWidget {
  final LatestProperty property;
  final VoidCallback? onTap;

  const LatestPropertyCard({super.key, required this.property, this.onTap});

  @override
  State<LatestPropertyCard> createState() => _LatestPropertyCardState();
}

class _LatestPropertyCardState extends State<LatestPropertyCard> {
  bool _fav = true;

  @override
  Widget build(BuildContext context) {
    final p = widget.property;

    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.shade300),
        ),
        clipBehavior: Clip.antiAlias,
        child: Row(
          children: [
            // ---------- Image (right side in RTL) ----------
            SizedBox(
              width: 120,
              height: double.infinity,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    p.image,
                    fit: BoxFit.cover,
                    errorBuilder: (_, _, _) =>
                        Container(color: Colors.grey.shade300),
                  ),
                  Positioned(
                    top: 0,
                    left: 0,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 5,
                      ),
                      decoration: const BoxDecoration(
                        color: _kTagBg,
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(10),
                        ),
                      ),
                      child: Text(
                        p.type,
                        style: const TextStyle(
                          color: _kPrimary,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // ---------- Details ----------
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          '${p.price} ج.م',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: () => setState(() => _fav = !_fav),
                          child: Icon(
                            _fav ? Icons.favorite : Icons.favorite_border,
                            color: Colors.red,
                            size: 20,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      p.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 12, color: _kGrey),
                    ),
                    Row(
                      children: [
                        _stat(
                          const Icon(Icons.bed_outlined, size: 15),
                          '${p.beds}',
                        ),
                        const SizedBox(width: 10),
                        _stat(_svg(_bathIcon, 15, Colors.black), '${p.baths}'),
                        const SizedBox(width: 10),
                        Flexible(
                          child: _stat(
                            _svg(_areaIcon, 14, Colors.black),
                            p.area,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _meta(_locationIcon, p.location),
                              const SizedBox(height: 4),
                              _meta(_clockIcon, p.timeAgo),
                            ],
                          ),
                        ),
                        _agent(p.agentLogo),
                      ],
                    ),
                  ],
                ),
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
      const SizedBox(width: 3),
      Flexible(
        child: Text(
          text,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontSize: 11, color: kblack),
        ),
      ),
    ],
  );

  Widget _meta(String icon, String text) => Row(
    children: [
      _svg(icon, 12),
      const SizedBox(width: 4),
      Flexible(
        child: Text(
          text,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontSize: 11, color: _kGrey),
        ),
      ),
    ],
  );

  Widget _agent(String? logo) => Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('بواسطة', style: TextStyle(fontSize: 10)),
      const SizedBox(height: 2),
      SizedBox(
        width: 36,
        height: 28,
        child: logo != null
            ? Image.asset(logo, fit: BoxFit.contain)
            : Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.red.shade700,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: const Text(
                  'GS',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
      ),
    ],
  );
}

// ==================================================================
// Usage: the three sections from your design
// ==================================================================
class LatestPropertiesExample extends StatelessWidget {
  const LatestPropertiesExample({super.key});

  List<LatestProperty> _items(String image, String title) => List.generate(
    4,
    (_) => LatestProperty(
      image: image,
      price: '4,000,000',
      title: title,
      beds: 10,
      baths: 5,
      area: '8,725 م²',
      location: 'الشيخ زايد، الجيزة',
      timeAgo: 'منذ 4 أيام',
      agentLogo: _agentLogo,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        LatestPropertiesSection(
          title: 'احدث الشقق في مصر',
          items: _items(
            'assets/images/apartment.jpg',
            'شقة سكنية للبيع تشطيب سوبر لوكس',
          ),
        ),
        const SizedBox(height: 28),
        LatestPropertiesSection(
          title: 'احدث الفيلات في مصر',
          items: _items(
            'assets/images/vala.jpg',
            'فيلا سكنية للبيع تشطيب سوبر لوكس',
          ),
        ),
        const SizedBox(height: 28),
        LatestPropertiesSection(
          title: 'احدث الدوبلكس في مصر',
          items: _items(
            'assets/images/duplacas.png',
            'دوبلكس للبيع تشطيب سوبر لوكس',
          ),
        ),
      ],
    );
  }
}
