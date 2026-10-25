import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() => runApp(const AlemayehuPortfolioApp());

const _ink = Color(0xFF171717);
const _inkSoft = Color(0xFF242321);
const _paper = Color(0xFFF7F5F0);
const _white = Color(0xFFFFFFFF);
const _amber = Color(0xFFFFB000);
const _muted = Color(0xFFB8B4AC);
const _body = Color(0xFF5D5A54);

class AlemayehuPortfolioApp extends StatelessWidget {
  const AlemayehuPortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Alemayehu Bitew | Full-Stack Developer & Digital Marketer',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: _paper,
        colorScheme: ColorScheme.fromSeed(
          seedColor: _amber,
          brightness: Brightness.light,
          surface: _paper,
        ),
        fontFamily: 'Arial',
      ),
      home: const PortfolioHome(),
    );
  }
}

class PortfolioHome extends StatefulWidget {
  const PortfolioHome({super.key});

  @override
  State<PortfolioHome> createState() => _PortfolioHomeState();
}

class _PortfolioHomeState extends State<PortfolioHome> {
  final _scrollController = ScrollController();
  final _sectionKeys = <String, GlobalKey>{
    'About': GlobalKey(),
    'Expertise': GlobalKey(),
    'Projects': GlobalKey(),
    'Contact': GlobalKey(),
  };

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _goTo(String section) {
    final context = _sectionKeys[section]?.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 550),
        curve: Curves.easeInOutCubic,
        alignment: 0.04,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SelectionArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final wide = constraints.maxWidth >= 900;
            return CustomScrollView(
              controller: _scrollController,
              slivers: [
                SliverToBoxAdapter(
                  child: _NavigationBar(wide: wide, onNavigate: _goTo),
                ),
                SliverToBoxAdapter(child: _HeroSection(wide: wide, onProjects: () => _goTo('Projects'), onContact: () => _goTo('Contact'))),
                SliverToBoxAdapter(child: _ProofStrip(wide: wide)),
                SliverToBoxAdapter(
                  child: _AboutSection(
                    key: _sectionKeys['About'],
                    wide: wide,
                  ),
                ),
                SliverToBoxAdapter(
                  child: _ExpertiseSection(
                    key: _sectionKeys['Expertise'],
                    wide: wide,
                  ),
                ),
                SliverToBoxAdapter(
                  child: _ProjectsSection(
                    key: _sectionKeys['Projects'],
                    wide: wide,
                  ),
                ),
                SliverToBoxAdapter(
                  child: _ContactSection(
                    key: _sectionKeys['Contact'],
                    wide: wide,
                  ),
                ),
                SliverToBoxAdapter(child: _Footer(wide: wide)),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _NavigationBar extends StatelessWidget {
  const _NavigationBar({required this.wide, required this.onNavigate});
  final bool wide;
  final ValueChanged<String> onNavigate;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: _ink,
      padding: EdgeInsets.symmetric(horizontal: wide ? 64 : 22, vertical: 20),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: _amber,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Text('AB', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900, color: _ink)),
          ),
          const SizedBox(width: 13),
          const Expanded(
            child: Text(
              'ALEMAYEHU BITEW',
              style: TextStyle(color: _white, fontWeight: FontWeight.w800, letterSpacing: 1.2, fontSize: 13),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          if (wide)
            ...['About', 'Expertise', 'Projects', 'Contact'].map(
              (item) => Padding(
                padding: const EdgeInsets.only(left: 26),
                child: TextButton(
                  onPressed: () => onNavigate(item),
                  style: TextButton.styleFrom(foregroundColor: _white),
                  child: Text(item),
                ),
              ),
            )
          else
            PopupMenuButton<String>(
              tooltip: 'Navigate',
              icon: const Icon(Icons.menu_rounded, color: _white),
              onSelected: onNavigate,
              itemBuilder: (context) => ['About', 'Expertise', 'Projects', 'Contact']
                  .map((item) => PopupMenuItem(value: item, child: Text(item)))
                  .toList(),
            ),
        ],
      ),
    );
  }
}

class _HeroSection extends StatelessWidget {
  const _HeroSection({required this.wide, required this.onProjects, required this.onContact});
  final bool wide;
  final VoidCallback onProjects;
  final VoidCallback onContact;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: _ink,
      padding: EdgeInsets.fromLTRB(wide ? 64 : 24, wide ? 72 : 54, wide ? 64 : 24, wide ? 92 : 64),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1180),
          child: wide
              ? Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                  Expanded(flex: 7, child: _heroCopy()),
                  const SizedBox(width: 52),
                  const Expanded(flex: 5, child: _HeroVisual()),
                ])
              : Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  _heroCopy(),
                  const SizedBox(height: 44),
                  const _HeroVisual(),
                ]),
        ),
      ),
    );
  }

  Widget _heroCopy() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _Eyebrow('INDEPENDENT DEVELOPER · DIGITAL THINKER'),
          const SizedBox(height: 24),
          const Text.rich(
            TextSpan(children: [
              TextSpan(text: 'Building digital
experiences that
'),
              TextSpan(text: 'move work forward.', style: TextStyle(color: _amber)),
            ]),
            style: TextStyle(color: _white, fontSize: 48, height: 1.08, fontWeight: FontWeight.w900, letterSpacing: -1.8),
          ),
          const SizedBox(height: 24),
          const Text(
            'I’m Alemayehu Bitew — a Full-Stack Developer and Digital Marketer focused on practical software, thoughtful user experiences, and digital growth.',
            style: TextStyle(color: _muted, fontSize: 17, height: 1.7),
          ),
          const SizedBox(height: 32),
          Wrap(spacing: 12, runSpacing: 12, children: [
            FilledButton(
              onPressed: onProjects,
              style: FilledButton.styleFrom(backgroundColor: _amber, foregroundColor: _ink, padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 18)),
              child: const Text('Explore my work', style: TextStyle(fontWeight: FontWeight.w800)),
            ),
            OutlinedButton(
              onPressed: onContact,
              style: OutlinedButton.styleFrom(foregroundColor: _white, side: const BorderSide(color: Color(0xFF5B5954)), padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 18)),
              child: const Text('Let’s connect'),
            ),
          ]),
        ],
      );
}

class _HeroVisual extends StatelessWidget {
  const _HeroVisual();

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.05,
      child: Container(
        constraints: const BoxConstraints(maxWidth: 460),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: _inkSoft,
          borderRadius: BorderRadius.circular(28),
          border: Border.all(color: const Color(0xFF3A3834)),
        ),
        child: Stack(children: [
          Positioned(top: 8, right: 8, child: Container(width: 110, height: 110, decoration: BoxDecoration(color: _amber.withValues(alpha: 0.12), shape: BoxShape.circle))),
          Positioned(bottom: 18, left: 12, child: Container(width: 150, height: 150, decoration: BoxDecoration(color: const Color(0xFF36332D), borderRadius: BorderRadius.circular(32)))),
          Center(
            child: Container(
              width: 190,
              height: 190,
              decoration: BoxDecoration(color: _amber, borderRadius: BorderRadius.circular(34), boxShadow: [BoxShadow(color: _amber.withValues(alpha: 0.18), blurRadius: 42, spreadRadius: 2)]),
              child: const Center(child: Text('ዓ', style: TextStyle(fontSize: 112, height: 1, fontWeight: FontWeight.w800, color: _ink))),
            ),
          ),
          const Positioned(left: 14, top: 16, child: _CodeLabel('BUILD / LEARN / SHIP')),
          const Positioned(right: 12, bottom: 16, child: _CodeLabel('ETHIOPIA · WORLDWIDE')),
        ]),
      ),
    );
  }
}

class _CodeLabel extends StatelessWidget {
  const _CodeLabel(this.text);
  final String text;

  @override
  Widget build(BuildContext context) => Text(text, style: const TextStyle(color: _muted, fontSize: 9, letterSpacing: 1.4, fontWeight: FontWeight.w700));
}

class _ProofStrip extends StatelessWidget {
  const _ProofStrip({required this.wide});
  final bool wide;

  @override
  Widget build(BuildContext context) {
    final items = [
      ('01', 'Full-stack thinking'),
      ('02', 'Product-minded delivery'),
      ('03', 'Digital growth'),
    ];
    return Container(
      color: _amber,
      padding: EdgeInsets.symmetric(horizontal: wide ? 64 : 24, vertical: 25),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1180),
          child: Wrap(
            spacing: wide ? 58 : 24,
            runSpacing: 20,
            children: items.map((item) => Row(mainAxisSize: MainAxisSize.min, children: [
              Text(item.$1, style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 12, color: _ink)),
              const SizedBox(width: 12),
              Text(item.$2, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14, color: _ink)),
            ])).toList(),
          ),
        ),
      ),
    );
  }
}

class _AboutSection extends StatelessWidget {
  const _AboutSection({super.key, required this.wide});
  final bool wide;

  @override
  Widget build(BuildContext context) {
    return _SectionFrame(
      wide: wide,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const _Eyebrow('A LITTLE ABOUT ME', dark: true),
        const SizedBox(height: 20),
        if (wide)
          Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Expanded(flex: 5, child: Text('Technology should solve a real problem — and feel good to use.', style: TextStyle(fontSize: 36, height: 1.2, letterSpacing: -1.2, fontWeight: FontWeight.w900, color: _ink))),
            const SizedBox(width: 60),
            Expanded(flex: 5, child: _aboutBody()),
          ])
        else ...[
          const Text('Technology should solve a real problem — and feel good to use.', style: TextStyle(fontSize: 32, height: 1.2, letterSpacing: -1, fontWeight: FontWeight.w900, color: _ink)),
          const SizedBox(height: 22),
          _aboutBody(),
        ],
      ]),
    );
  }

  Widget _aboutBody() => const Text(
        'I bring software development and digital marketing together to help ideas become useful digital products. My work spans Flutter interfaces, PHP and MySQL backends, API integration, deployment workflows, and the content and visibility that help a product reach people.\n\nI value clear requirements, maintainable architecture, honest communication, and measurable progress. I keep learning, test assumptions, and aim to ship work that is useful beyond the demo.',
        style: TextStyle(fontSize: 16, height: 1.85, color: _body),
      );
}

class _ExpertiseSection extends StatelessWidget {
  const _ExpertiseSection({super.key, required this.wide});
  final bool wide;

  @override
  Widget build(BuildContext context) {
    final skills = [
      ('01', 'Flutter & Dart', 'Responsive interfaces, reusable widgets, and cross-platform application foundations.', Icons.devices_rounded),
      ('02', 'Backend engineering', 'PHP, MySQL, REST APIs, authentication patterns, and data-driven features.', Icons.storage_rounded),
      ('03', 'Product & UX thinking', 'Information structure, user journeys, practical flows, and accessible interaction design.', Icons.account_tree_rounded),
      ('04', 'Digital marketing', 'Content strategy, search visibility fundamentals, campaign thinking, and conversion-focused messaging.', Icons.trending_up_rounded),
    ];
    return Container(
      color: const Color(0xFFECE9E1),
      padding: EdgeInsets.symmetric(horizontal: wide ? 64 : 24, vertical: wide ? 84 : 60),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1180),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const _Eyebrow('WHAT I BRING', dark: true),
            const SizedBox(height: 16),
            const Text('A useful mix of skills.', style: TextStyle(fontSize: 38, fontWeight: FontWeight.w900, letterSpacing: -1.2, color: _ink)),
            const SizedBox(height: 34),
            LayoutBuilder(builder: (context, constraints) {
              final columns = constraints.maxWidth >= 800 ? 2 : 1;
              final cardWidth = (constraints.maxWidth - (columns - 1) * 18) / columns;
              return Wrap(
                spacing: 18,
                runSpacing: 18,
                children: skills.map((s) => SizedBox(
                  width: cardWidth,
                  child: Container(
                    padding: const EdgeInsets.all(26),
                    decoration: BoxDecoration(color: _paper, borderRadius: BorderRadius.circular(20), border: Border.all(color: const Color(0xFFE0DDD5))),
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Row(children: [
                        Container(width: 48, height: 48, decoration: BoxDecoration(color: _amber.withValues(alpha: 0.2), borderRadius: BorderRadius.circular(14)), child: Icon(s.$4, color: _ink)),
                        const Spacer(),
                        Text(s.$1, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w800, color: _body)),
                      ]),
                      const SizedBox(height: 24),
                      Text(s.$2, style: const TextStyle(fontSize: 21, fontWeight: FontWeight.w900, color: _ink)),
                      const SizedBox(height: 10),
                      Text(s.$3, style: const TextStyle(fontSize: 14, height: 1.7, color: _body)),
                    ]),
                  ),
                )).toList(),
              );
            }),
          ]),
        ),
      ),
    );
  }
}

class _ProjectsSection extends StatelessWidget {
  const _ProjectsSection({super.key, required this.wide});
  final bool wide;

  @override
  Widget build(BuildContext context) {
    final projects = [
      _ProjectInfo('01', 'InfinEth Solutions PLC', 'Company website & digital platform', 'Flutter Web · PHP · MySQL · REST API', 'A company-focused digital platform with service information, project content, account roles, and a PHP/MySQL backend.', 'https://infineth.com/#/home', 'LIVE PROJECT'),
      _ProjectInfo('02', 'CONQUER', 'Multiplayer game platform', 'Flutter · PHP · MySQL · JWT', 'A game product in development, with a Flutter client, backend API, player flows, and server-controlled game rules.', null, 'IN DEVELOPMENT'),
      _ProjectInfo('03', 'Personal portfolio', 'Professional presence', 'Flutter Web · Netlify', 'This portfolio foundation, designed to present projects, technical capabilities, and ways to connect in one place.', 'https://ayehualem.netlify.app/', 'PORTFOLIO'),
    ];
    return _SectionFrame(
      wide: wide,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const _Eyebrow('SELECTED WORK', dark: true),
        const SizedBox(height: 16),
        Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
          const Expanded(child: Text('Projects with a purpose.', style: TextStyle(fontSize: 38, fontWeight: FontWeight.w900, letterSpacing: -1.2, color: _ink))),
          if (wide) const Text('A growing body of work', style: TextStyle(color: _body, fontSize: 14)),
        ]),
        const SizedBox(height: 32),
        ...projects.map((project) => Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: _ProjectCard(project: project, wide: wide),
        )),
      ]),
    );
  }
}

class _ProjectInfo {
  const _ProjectInfo(this.number, this.name, this.subtitle, this.stack, this.description, this.url, this.status);
  final String number, name, subtitle, stack, description, status;
  final String? url;
}

class _ProjectCard extends StatelessWidget {
  const _ProjectCard({required this.project, required this.wide});
  final _ProjectInfo project;
  final bool wide;

  @override
  Widget build(BuildContext context) {
    final details = Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(project.status, style: const TextStyle(fontSize: 10, letterSpacing: 1.4, fontWeight: FontWeight.w900, color: Color(0xFF8A6200))),
      const SizedBox(height: 12),
      Text(project.name, style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w900, letterSpacing: -0.5, color: _ink)),
      const SizedBox(height: 5),
      Text(project.subtitle, style: const TextStyle(fontSize: 14, color: _body, fontWeight: FontWeight.w600)),
      const SizedBox(height: 16),
      Text(project.description, style: const TextStyle(fontSize: 14, height: 1.75, color: _body)),
      const SizedBox(height: 18),
      Text(project.stack, style: const TextStyle(fontSize: 12, color: _ink, fontWeight: FontWeight.w800)),
      if (project.url != null) ...[
        const SizedBox(height: 18),
        TextButton.icon(
          onPressed: () => _openExternal(project.url!),
          style: TextButton.styleFrom(foregroundColor: _ink, padding: EdgeInsets.zero),
          icon: const Icon(Icons.north_east_rounded, size: 17),
          label: const Text('Visit project'),
        ),
      ],
    ]);
    return Container(
      padding: EdgeInsets.all(wide ? 30 : 22),
      decoration: BoxDecoration(color: _white, borderRadius: BorderRadius.circular(22), border: Border.all(color: const Color(0xFFE7E3DA))),
      child: wide
          ? Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(width: 72, height: 72, alignment: Alignment.center, decoration: BoxDecoration(color: _ink, borderRadius: BorderRadius.circular(18)), child: Text(project.number, style: const TextStyle(color: _amber, fontWeight: FontWeight.w900, fontSize: 22))),
              const SizedBox(width: 26),
              Expanded(child: details),
            ])
          : Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(width: 58, height: 58, alignment: Alignment.center, decoration: BoxDecoration(color: _ink, borderRadius: BorderRadius.circular(16)), child: Text(project.number, style: const TextStyle(color: _amber, fontWeight: FontWeight.w900, fontSize: 19))),
              const SizedBox(height: 22),
              details,
            ]),
    );
  }
}

Future<void> _openExternal(String url) async {
  final uri = Uri.tryParse(url);
  if (uri == null || (uri.scheme != 'https' && uri.scheme != 'http')) return;
  await launchUrl(uri, mode: LaunchMode.externalApplication);
}

class _ContactSection extends StatelessWidget {
  const _ContactSection({super.key, required this.wide});
  final bool wide;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: _ink,
      padding: EdgeInsets.symmetric(horizontal: wide ? 64 : 24, vertical: wide ? 84 : 62),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1180),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const _Eyebrow('HAVE A PROJECT IN MIND?'),
            const SizedBox(height: 20),
            Text(
              wide ? 'Let’s make something
worth using.' : 'Let’s make something worth using.',
              style: TextStyle(color: _white, fontSize: wide ? 50 : 38, height: 1.08, fontWeight: FontWeight.w900, letterSpacing: -1.5),
            ),
            const SizedBox(height: 22),
            const ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 620),
              child: Text('Open to thoughtful collaborations, practical software projects, and opportunities to create digital value. Reach out through my GitHub profile to start a conversation.',
                style: TextStyle(color: _muted, fontSize: 16, height: 1.8)),
            ),
            const SizedBox(height: 28),
            FilledButton.icon(
              onPressed: () => _openExternal('https://github.com/ayehu1alem'),
              style: FilledButton.styleFrom(backgroundColor: _amber, foregroundColor: _ink, padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 18)),
              icon: const Icon(Icons.code_rounded),
              label: const Text('Find me on GitHub', style: TextStyle(fontWeight: FontWeight.w800)),
            ),
          ]),
        ),
      ),
    );
  }
}

class _Footer extends StatelessWidget {
  const _Footer({required this.wide});
  final bool wide;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: _ink,
      padding: EdgeInsets.fromLTRB(wide ? 64 : 24, 0, wide ? 64 : 24, 26),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1180),
          child: Column(children: [
            const Divider(color: Color(0xFF3A3834)),
            const SizedBox(height: 20),
            Row(children: [
              const Expanded(child: Text('© Alemayehu Bitew · Built with Flutter', style: TextStyle(color: _muted, fontSize: 12))),
              TextButton(
                onPressed: () => _openExternal('https://github.com/ayehu1alem/Full-Stack-Developer'),
                child: const Text('Source code ↗', style: TextStyle(color: _amber, fontSize: 12)),
              ),
            ]),
          ]),
        ),
      ),
    );
  }
}

class _SectionFrame extends StatelessWidget {
  const _SectionFrame({required this.wide, required this.child});
  final bool wide;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: wide ? 64 : 24, vertical: wide ? 84 : 60),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1180),
          child: child,
        ),
      ),
    );
  }
}

class _Eyebrow extends StatelessWidget {
  const _Eyebrow(this.text, {this.dark = false});
  final String text;
  final bool dark;

  @override
  Widget build(BuildContext context) => Text(
        text,
        style: TextStyle(
          color: dark ? const Color(0xFF866000) : _amber,
          fontSize: 11,
          letterSpacing: 2.0,
          fontWeight: FontWeight.w900,
        ),
      );
}
