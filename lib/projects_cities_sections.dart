import 'package:e_romo_task/featured_properties_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

// File-private constants (no clash with your other files)
const _kGreen = Color(0xFF3BAA5C);
const _kGrey = Color(0xFF7A7A7A);

const _locationIcon = 'assets/icons/location.svg';
const _clockIcon = 'assets/icons/clock.svg';

// ==================================================================
// Shared section header (title + "مشاهدة الكل")
// ==================================================================
class SectionTitle extends StatelessWidget {
  final String title;
  final VoidCallback? onSeeAll;
  const SectionTitle({super.key, required this.title, this.onSeeAll});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
      child: Row(
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
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
    );
  }
}

// ==================================================================
// PROJECTS
// ==================================================================
class ProjectModel {
  final String image;
  final String title;
  final String description;
  final String location;
  final String timeAgo;
  final String? agentLogo;

  const ProjectModel({
    required this.image,
    required this.title,
    required this.description,
    required this.location,
    required this.timeAgo,
    this.agentLogo,
  });
}

class ProjectsSection extends StatelessWidget {
  final String title;
  final List<ProjectModel> items;
  final VoidCallback? onSeeAll;
  final void Function(ProjectModel project)? onTap;

  const ProjectsSection({
    super.key,
    this.title = 'اهم المشاريع العقارية في مصر',
    required this.items,
    this.onSeeAll,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(title: title, onSeeAll: onSeeAll),
        SizedBox(
          height: 270,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: items.length,
            separatorBuilder: (_, _) => const SizedBox(width: 12),
            itemBuilder: (_, i) => ProjectCard(
              project: items[i],
              onTap: onTap == null ? null : () => onTap!(items[i]),
            ),
          ),
        ),
      ],
    );
  }
}

class ProjectCard extends StatefulWidget {
  final ProjectModel project;
  final double width;
  final VoidCallback? onTap;

  const ProjectCard({
    super.key,
    required this.project,
    this.width = 230,
    this.onTap,
  });

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  bool _fav = true;

  @override
  Widget build(BuildContext context) {
    final p = widget.project;

    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        width: widget.width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(40),
          border: Border.all(color: _kGreen, width: 1.2),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ---------- Image + "مشروع" tag ----------
            SizedBox(
              height: 130,
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
                  Positioned(
                    right: 0,
                    bottom: 20,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 5,
                      ),
                      decoration: const BoxDecoration(
                        color: _kGreen,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(14),
                        ),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.apartment, size: 14, color: Colors.white),
                          SizedBox(width: 4),
                          Text(
                            'مشروع',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // ---------- Details ----------
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          p.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
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
                  Text(
                    p.description,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 13, color: _kGrey),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _meta(_locationIcon, p.location),
                            const SizedBox(height: 6),
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
          ],
        ),
      ),
    );
  }

  Widget _meta(String icon, String text) => Row(
    children: [
      SvgPicture.asset(icon, width: 14, height: 14),
      const SizedBox(width: 5),
      Flexible(
        child: Text(
          text,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontSize: 12, color: _kGrey),
        ),
      ),
    ],
  );

  Widget _agent(String? logo) => Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('بواسطة', style: TextStyle(fontSize: 11, color: kblack)),
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

// ==================================================================
// CITIES
// ==================================================================
class CityModel {
  final String name;
  final String image;
  final int forSale;
  final int forRent;

  const CityModel({
    required this.name,
    required this.image,
    required this.forSale,
    required this.forRent,
  });
}

class CitiesSection extends StatelessWidget {
  final String title;
  final List<CityModel> cities;
  final VoidCallback? onSeeAll;
  final void Function(CityModel city)? onTap;

  const CitiesSection({
    super.key,
    this.title = 'إبحث عن عقارك بالمدينة',
    required this.cities,
    this.onSeeAll,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(title: title, onSeeAll: onSeeAll),
        SizedBox(
          height: 200,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: cities.length,
            separatorBuilder: (_, _) => const SizedBox(width: 12),
            itemBuilder: (_, i) => CityCard(
              city: cities[i],
              onTap: onTap == null ? null : () => onTap!(cities[i]),
            ),
          ),
        ),
      ],
    );
  }
}

class CityCard extends StatelessWidget {
  final CityModel city;
  final double width;
  final VoidCallback? onTap;

  const CityCard({super.key, required this.city, this.width = 150, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: SizedBox(
          width: width,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(
                city.image,
                fit: BoxFit.cover,
                errorBuilder: (_, _, _) =>
                    Container(color: Colors.grey.shade400),
              ),
              // gradient so the white text stays readable
              DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withValues(alpha: 0.15),
                      Colors.black.withValues(alpha: 0.75),
                    ],
                    stops: const [0.3, 0.6, 1],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 0, 12, 14),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: Text(
                        city.name,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    const SizedBox(height: 28),
                    Text(
                      'عقارات للبيع : ${city.forSale}',
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'عقارات للإيجار : ${city.forRent}',
                      style: const TextStyle(color: Colors.white, fontSize: 12),
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
