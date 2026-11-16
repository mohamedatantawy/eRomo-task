import 'package:flutter/material.dart';

// ───────────────────────── Theme ─────────────────────────
class AppColors {
  static const teal = Color(0xFF1FB5C9);
  static const tealDark = Color(0xFF12A0B5);
  static const purple = Color(0xFF7B2CBF);
  static const text = Color(0xFF1E1E1E);
  static const muted = Color(0xFF9A9A9A);
  static const border = Color(0xFFEAEAEA);
  static const bg = Colors.white;
}

// ───────────────────────── Mock data ─────────────────────────
class Course {
  final String title;
  final String subtitle;
  final String price;
  final Color color;
  final IconData icon;
  const Course(this.title, this.subtitle, this.price, this.color, this.icon);
}

const _musicCourses = [
  Course(
    'Name of Course',
    'Text will put in this filed',
    '250 QAR',
    Color(0xFF3BA7C9),
    Icons.piano,
  ),
  Course(
    'Name of Course',
    'Text will put in this filed',
    '250 QAR',
    Color(0xFFE8892B),
    Icons.mic,
  ),
  Course(
    'Name of Course',
    'Text will put in this filed',
    '250 QAR',
    Color(0xFF8E8E93),
    Icons.headphones,
  ),
];
const _artCourses = [
  Course(
    'Name of Course',
    'Text will put in this filed',
    '250 QAR',
    Color(0xFF8D5A3B),
    Icons.brush,
  ),
  Course(
    'Name of Course',
    'Text will put in this filed',
    '250 QAR',
    Color(0xFF4A6FA5),
    Icons.palette,
  ),
  Course(
    'Name of Course',
    'Text will put in this filed',
    '250 QAR',
    Color(0xFF6B4E71),
    Icons.draw,
  ),
];
const _gamesCourses = [
  Course(
    'Name of Course',
    'Text will put in this filed',
    '250 QAR',
    Color(0xFF6C4DDB),
    Icons.sports_esports,
  ),
  Course(
    'Name of Course',
    'Text will put in this filed',
    '250 QAR',
    Color(0xFF1B2A6B),
    Icons.vrpano,
  ),
  Course(
    'Name of Course',
    'Text will put in this filed',
    '250 QAR',
    Color(0xFFD94F70),
    Icons.videogame_asset,
  ),
];

// ───────────────────────── Home screen ─────────────────────────
class SkillifyrApp extends StatefulWidget {
  const SkillifyrApp({super.key});

  @override
  State<SkillifyrApp> createState() => _SkillifyrAppState();
}

class _SkillifyrAppState extends State<SkillifyrApp> {
  int _navIndex = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 110),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _Header(),
            const SizedBox(height: 20),
            const _UpcomingCourse(),
            const SizedBox(height: 18),
            const _TopCategories(),
            const SizedBox(height: 18),
            const _FeaturedCourses(),
            const SizedBox(height: 16),
            const _PromoBanner(),
            const SizedBox(height: 18),
            _CourseSection(title: 'Music Courses', courses: _musicCourses),
            _CourseSection(title: 'Art Courses', courses: _artCourses),
            const _DiscountSection(),
            _CourseSection(title: 'Games Courses', courses: _gamesCourses),
            const _ArticlesSection(),
          ],
        ),
      ),
      bottomNavigationBar: _BottomNav(
        index: _navIndex,
        onTap: (i) => setState(() => _navIndex = i),
      ),
    );
  }
}

// ───────────────────────── Header (teal + search + banner) ─────────────────────────
class _Header extends StatefulWidget {
  const _Header();

  @override
  State<_Header> createState() => _HeaderState();
}

class _HeaderState extends State<_Header> {
  final _controller = PageController(viewportFraction: 1);
  int _page = 0;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.teal,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(36)),
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 10, 16, 18),
          child: Column(
            children: [
              // greeting row
              Row(
                children: [
                  const CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.white,
                    child: CircleAvatar(
                      radius: 18,
                      backgroundColor: Color(0xFFCDEEF4),
                      child: Icon(Icons.person, color: AppColors.tealDark),
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hello..',
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                      Text(
                        'Rasha Elsayed',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.menu, color: Colors.white, size: 30),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              // filter + search
              Row(
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(Icons.tune, color: AppColors.tealDark),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Container(
                      height: 44,
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Row(
                        children: [
                          Icon(Icons.search, color: AppColors.muted, size: 20),
                          SizedBox(width: 8),
                          Text(
                            'Search',
                            style: TextStyle(
                              color: AppColors.muted,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              // banner carousel
              SizedBox(
                height: 150,
                child: PageView(
                  controller: _controller,
                  onPageChanged: (i) => setState(() => _page = i),
                  children: const [_BannerCard(), _BannerCard(), _BannerCard()],
                ),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  3,
                  (i) => AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    margin: const EdgeInsets.symmetric(horizontal: 2.5),
                    width: i == _page ? 14 : 5,
                    height: 5,
                    decoration: BoxDecoration(
                      color: i == _page ? Colors.white : Colors.white54,
                      borderRadius: BorderRadius.circular(3),
                    ),
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

class _BannerCard extends StatelessWidget {
  const _BannerCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        gradient: const LinearGradient(
          colors: [Color(0xFF64C9DC), Color(0xFFBDE8F1)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      padding: const EdgeInsets.all(14),
      child: Row(
        children: [
          Expanded(
            flex: 5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Skillifyr',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Get exclusive limited-time offers that help you learn new skills for far less money.',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: .9),
                    fontSize: 9,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            flex: 5,
            child: Stack(
              children: [
                Positioned(
                  left: 0,
                  top: 0,
                  child: _MiniPhoto(
                    label: 'Dance Course',
                    icon: Icons.directions_run,
                    angle: -.08,
                  ),
                ),
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: _MiniPhoto(
                    label: 'Art Course',
                    icon: Icons.brush,
                    angle: .1,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MiniPhoto extends StatelessWidget {
  final String label;
  final IconData icon;
  final double angle;
  const _MiniPhoto({
    required this.label,
    required this.icon,
    required this.angle,
  });

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: angle,
      child: Container(
        width: 78,
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 6)],
        ),
        child: Column(
          children: [
            Container(
              height: 58,
              decoration: BoxDecoration(
                color: const Color(0xFFFFD6E0),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Icon(icon, color: AppColors.purple),
            ),
            const SizedBox(height: 3),
            Text(
              label,
              style: const TextStyle(fontSize: 8, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}

// ───────────────────────── Section header ─────────────────────────
class _SectionTitle extends StatelessWidget {
  final String title;
  const _SectionTitle(this.title);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: AppColors.text,
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: const Text(
              'View All',
              style: TextStyle(fontSize: 10, color: AppColors.text),
            ),
          ),
        ],
      ),
    );
  }
}

// ───────────────────────── Upcoming course ─────────────────────────
class _UpcomingCourse extends StatelessWidget {
  const _UpcomingCourse();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const _SectionTitle('Upcoming Course'),
        const SizedBox(height: 8),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: AppColors.border),
            boxShadow: const [
              BoxShadow(
                color: Color(0x14000000),
                blurRadius: 8,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 70,
                height: 70,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.teal, width: 5),
                ),
                child: const Text(
                  'Skillifyr',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                    color: AppColors.purple,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Expanded(
                          child: _InfoRow(
                            icon: Icons.calendar_today,
                            title: 'Today',
                            sub: '19 / 02 / 2025',
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColors.purple),
                            borderRadius: BorderRadius.circular(3),
                          ),
                          child: const Text(
                            'Lesson 06',
                            style: TextStyle(
                              fontSize: 8,
                              color: AppColors.purple,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    const Row(
                      children: [
                        Expanded(
                          child: _InfoRow(
                            icon: Icons.access_time,
                            title: '07:00 – 07:30 pm',
                            sub: '',
                          ),
                        ),
                        Expanded(
                          child: _InfoRow(
                            icon: Icons.person_outline,
                            title: 'Amr Maher',
                            sub: 'Business Developer',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    const _InfoRow(
                      icon: Icons.location_on_outlined,
                      title: '< BAHD',
                      sub: '',
                    ),
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

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String sub;
  const _InfoRow({required this.icon, required this.title, required this.sub});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 13, color: AppColors.text),
        const SizedBox(width: 4),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 8,
                  fontWeight: FontWeight.w600,
                ),
              ),
              if (sub.isNotEmpty)
                Text(
                  sub,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 7, color: AppColors.muted),
                ),
            ],
          ),
        ),
      ],
    );
  }
}

// ───────────────────────── Top categories ─────────────────────────
class _TopCategories extends StatelessWidget {
  const _TopCategories();

  @override
  Widget build(BuildContext context) {
    const cats = [
      ('Games', Icons.sports_esports, Color(0xFF555555)),
      ('Arts', Icons.palette, Color(0xFFE8892B)),
      ('Music', Icons.music_note, Color(0xFFE53935)),
      ('Dance', Icons.directions_run, AppColors.purple),
    ];
    return Column(
      children: [
        const _SectionTitle('Top Categories'),
        const SizedBox(height: 8),
        SizedBox(
          height: 40,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            scrollDirection: Axis.horizontal,
            itemCount: cats.length,
            separatorBuilder: (_, _) => const SizedBox(width: 8),
            itemBuilder: (_, i) => Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: const Color(0xFFF1F1F1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  Icon(cats[i].$2, size: 18, color: cats[i].$3),
                  const SizedBox(width: 6),
                  Text(
                    cats[i].$1,
                    style: const TextStyle(fontSize: 12, color: Colors.black54),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// ───────────────────────── Shared bits ─────────────────────────
class _PriceTag extends StatelessWidget {
  final String price;
  const _PriceTag(this.price);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: const BoxDecoration(
        color: AppColors.teal,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(8)),
      ),
      child: Text(
        price,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 10,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

// ───────────────────────── Featured courses ─────────────────────────
class _FeaturedCourses extends StatelessWidget {
  const _FeaturedCourses();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const _SectionTitle('Featured Courses'),
        const SizedBox(height: 8),
        SizedBox(
          height: 150,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            children: const [
              _FeaturedCard(color: Color(0xFFE9E4DC), icon: Icons.brush),
              SizedBox(width: 10),
              _FeaturedCard(
                color: Color(0xFFD7D7D7),
                icon: Icons.draw,
                favorite: true,
              ),
              SizedBox(width: 10),
              _FeaturedCard(color: Color(0xFFCFE6EA), icon: Icons.palette),
            ],
          ),
        ),
      ],
    );
  }
}

class _FeaturedCard extends StatelessWidget {
  final Color color;
  final IconData icon;
  final bool favorite;
  const _FeaturedCard({
    required this.color,
    required this.icon,
    this.favorite = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 140,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Stack(
              children: [
                Container(
                  height: 92,
                  width: double.infinity,
                  color: color,
                  child: Icon(icon, size: 40, color: Colors.black38),
                ),
                Positioned(
                  top: 6,
                  right: 6,
                  child: Container(
                    padding: const EdgeInsets.all(3),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.favorite,
                      size: 12,
                      color: favorite ? AppColors.purple : Colors.grey.shade300,
                    ),
                  ),
                ),
                const Positioned(
                  right: 0,
                  bottom: 0,
                  child: _PriceTag('250 QAR'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'Digital Art',
            style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700),
          ),
          const Text(
            'Graphic Design Essentials',
            style: TextStyle(fontSize: 8, color: AppColors.muted),
          ),
          const SizedBox(height: 2),
          const Row(
            children: [
              Icon(Icons.schedule, size: 9, color: AppColors.muted),
              SizedBox(width: 2),
              Text(
                '10 Days',
                style: TextStyle(fontSize: 8, color: AppColors.muted),
              ),
              SizedBox(width: 8),
              CircleAvatar(radius: 3.5, backgroundColor: Color(0xFF2962FF)),
              SizedBox(width: 3),
              Text(
                'Skillion Academy',
                style: TextStyle(fontSize: 8, color: AppColors.muted),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ───────────────────────── Promo banner ─────────────────────────
class _PromoBanner extends StatelessWidget {
  const _PromoBanner();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border),
        boxShadow: const [
          BoxShadow(
            color: Color(0x14000000),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 90,
            height: 90,
            decoration: BoxDecoration(
              color: const Color(0xFFFFE9B8),
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(
              Icons.card_giftcard,
              size: 44,
              color: AppColors.purple,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Skillifyr',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: AppColors.purple,
                  ),
                ),
                const Text(
                  'For 24 Hour only',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 2),
                const Text(
                  'Get instant courses saving you on upper-quality.',
                  style: TextStyle(fontSize: 8, color: AppColors.muted),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  height: 26,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.teal,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    child: const Text(
                      'Join Now',
                      style: TextStyle(fontSize: 10),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ───────────────────────── Generic course section ─────────────────────────
class _CourseSection extends StatelessWidget {
  final String title;
  final List<Course> courses;
  const _CourseSection({required this.title, required this.courses});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: Column(
        children: [
          _SectionTitle(title),
          const SizedBox(height: 8),
          SizedBox(
            height: 130,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: courses.length,
              separatorBuilder: (_, _) => const SizedBox(width: 10),
              itemBuilder: (_, i) => _CourseCard(course: courses[i]),
            ),
          ),
        ],
      ),
    );
  }
}

class _CourseCard extends StatelessWidget {
  final Course course;
  final String? discount;
  const _CourseCard({required this.course, this.discount});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 112,
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Stack(
              children: [
                Container(
                  height: 72,
                  width: double.infinity,
                  color: course.color,
                  child: Icon(course.icon, color: Colors.white70, size: 34),
                ),
                if (discount != null)
                  Positioned(left: 0, top: 0, child: _DiscountBadge(discount!)),
                Positioned(right: 0, bottom: 0, child: _PriceTag(course.price)),
              ],
            ),
          ),
          const SizedBox(height: 5),
          Center(
            child: Text(
              course.title,
              style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w700),
            ),
          ),
          Center(
            child: Text(
              course.subtitle,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 7, color: AppColors.muted),
            ),
          ),
        ],
      ),
    );
  }
}

class _DiscountBadge extends StatelessWidget {
  final String text;
  const _DiscountBadge(this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
      decoration: const BoxDecoration(
        color: AppColors.purple,
        borderRadius: BorderRadius.only(bottomRight: Radius.circular(8)),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 9,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

// ───────────────────────── Discounted ─────────────────────────
class _DiscountSection extends StatelessWidget {
  const _DiscountSection();

  @override
  Widget build(BuildContext context) {
    const items = [
      (Color(0xFFB6E34B), Icons.accessibility_new),
      (Color(0xFFE8B4A0), Icons.people),
      (Color(0xFFCDB4F0), Icons.sports_esports),
    ];
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: Column(
        children: [
          const _SectionTitle('Discounted For This Month'),
          const SizedBox(height: 8),
          SizedBox(
            height: 112,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: items.length,
              separatorBuilder: (_, _) => const SizedBox(width: 10),
              itemBuilder: (_, i) => Container(
                width: 112,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppColors.border),
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(10),
                        ),
                        child: Stack(
                          children: [
                            Container(
                              width: double.infinity,
                              color: items[i].$1,
                              child: Icon(
                                items[i].$2,
                                size: 36,
                                color: Colors.white70,
                              ),
                            ),
                            const Positioned(
                              left: 0,
                              top: 0,
                              child: _DiscountBadge('10% Off'),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 4),
                      child: Column(
                        children: [
                          Text(
                            'Name of Course',
                            style: TextStyle(
                              fontSize: 9,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            'Text will put in this filed',
                            style: TextStyle(
                              fontSize: 7,
                              color: AppColors.muted,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ───────────────────────── Articles ─────────────────────────
class _ArticlesSection extends StatelessWidget {
  const _ArticlesSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const _SectionTitle('Articles'),
        const SizedBox(height: 8),
        SizedBox(
          height: 120,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: 3,
            separatorBuilder: (_, _) => const SizedBox(width: 10),
            itemBuilder: (_, i) => Container(
              width: 250,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppColors.border),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(10),
                      ),
                      child: Container(
                        width: double.infinity,
                        color: i.isEven
                            ? const Color(0xFFDADFE6)
                            : const Color(0xFFF3DDE3),
                        child: const Icon(
                          Icons.article_outlined,
                          size: 40,
                          color: Colors.black38,
                        ),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(8, 6, 8, 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'How music affects our mood ?',
                          style: TextStyle(
                            fontSize: 9,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          'Music has a powerful influence on emotions, shaping how we feel every day.',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 7, color: AppColors.muted),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// ───────────────────────── Bottom navigation ─────────────────────────
class _BottomNav extends StatelessWidget {
  final int index;
  final ValueChanged<int> onTap;
  const _BottomNav({required this.index, required this.onTap});

  @override
  Widget build(BuildContext context) {
    Widget item(int i, IconData icon, {bool dot = false}) => Expanded(
      child: InkWell(
        onTap: () => onTap(i),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Icon(
              icon,
              color: index == i ? AppColors.teal : AppColors.tealDark,
              size: 24,
            ),
            if (dot)
              const Positioned(
                top: 18,
                right: 26,
                child: CircleAvatar(
                  radius: 3.5,
                  backgroundColor: AppColors.purple,
                ),
              ),
          ],
        ),
      ),
    );

    return SizedBox(
      height: 84,
      child: Stack(
        alignment: Alignment.bottomCenter,
        clipBehavior: Clip.none,
        children: [
          Container(
            height: 62,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(20),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: .08),
                  blurRadius: 12,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: Row(
              children: [
                item(0, Icons.favorite_border),
                item(1, Icons.calendar_today_outlined),
                const Expanded(child: SizedBox()), // space for center button
                item(3, Icons.notifications_none, dot: true),
                item(4, Icons.shopping_cart_outlined, dot: true),
              ],
            ),
          ),
          Positioned(
            top: 0,
            child: GestureDetector(
              onTap: () => onTap(2),
              child: Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: AppColors.teal,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 4),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.teal.withValues(alpha: .4),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.home_outlined,
                  color: Colors.white,
                  size: 26,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
