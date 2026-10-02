import 'dart:math' show min;

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

const _paper = Color(0xFFFAF7F2);
const _ink = Color(0xFF342A23);
const _muted = Color(0xFF77695D);
const _line = Color(0xFFE2D8CC);
const _forest = Color(0xFF70513D);
const _orange = Color(0xFFAD7852);
const _sage = Color(0xFFF0E8DD);

void main() {
  runApp(const PortfolioApp());
}

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rodham Kinya Karani — Portfolio',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: _paper,
        colorScheme: ColorScheme.fromSeed(
          seedColor: _forest,
          surface: _paper,
          primary: _forest,
          secondary: _orange,
        ),
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: _forest,
          selectionColor: Color(0x5570513D),
          selectionHandleColor: _forest,
        ),
      ),
      home: const PortfolioPage(),
    );
  }
}

class PortfolioPage extends StatefulWidget {
  const PortfolioPage({super.key});

  @override
  State<PortfolioPage> createState() => _PortfolioPageState();
}

class _PortfolioPageState extends State<PortfolioPage> {
  final _scrollController = ScrollController();
  final _sectionKeys = <String, GlobalKey>{
    'top': GlobalKey(),
    'profile': GlobalKey(),
    'experience': GlobalKey(),
    'education': GlobalKey(),
    'skills': GlobalKey(),
    'contact': GlobalKey(),
  };
  bool _menuOpen = false;

  static const _navigation = [
    ('profile', 'Profile'),
    ('experience', 'Experience'),
    ('education', 'Education'),
    ('skills', 'Skills'),
  ];

  static const _experience = [
    _Experience(
      role: 'Legal Advisor & Virtual Assistant',
      organization: 'Devsync Africa',
      context: 'February 2026 – Present',
      highlights: [
        'Serving as the company’s legal advisor and virtual assistant.',
      ],
    ),
    _Experience(
      role: 'Legal Intern',
      organization: 'United Nations Environment Programme (UNEP)',
      context: 'International internship',
      highlights: [
        'Analyzed international environmental agreements and compliance frameworks, producing research that informed policy development for global governance initiatives.',
        'Synthesized climate and international law findings into briefing materials for stakeholder engagement.',
      ],
    ),
    _Experience(
      role: 'Judicial Attachment, Mediation Desk',
      organization: 'Milimani High Court · Family Division, Nairobi',
      context: 'Court attachment',
      highlights: [
        'Supported judicial officers and mediators with case preparation, documentation, and scheduling across the case lifecycle.',
        'Assisted court-annexed mediation sessions and built practical experience supporting family law dispute resolution.',
        'Researched and drafted summaries on succession, divorce, and custody matters; maintained accurate court records.',
      ],
    ),
    _Experience(
      role: 'Legal Practicum, Legal Department',
      organization: 'Kenyatta National Hospital (KNH)',
      context: 'Public sector',
      highlights: [
        'Conducted regulatory audits of contracts and internal policy documentation, identifying compliance gaps.',
        'Researched health law and liability issues to support risk mitigation for the hospital legal department.',
      ],
    ),
  ];

  static const _education = [
    _Education(
      qualification: 'Bachelor of Laws (LLB)',
      institution: 'Daystar University, Kenya',
      detail: 'Class of 2025 · GPA 3.3 / 4.0',
    ),
    _Education(
      qualification: 'Advanced Studies in Intellectual Property',
      institution: 'WIPO Academy',
      detail: 'Scholarship recipient',
    ),
    _Education(
      qualification: 'Kenya Certificate of Secondary Education',
      institution: "Materi Girls' Secondary School",
    ),
  ];

  static const _skillGroups = [
    _SkillGroup(
      title: 'Legal & administrative support',
      skills: [
        'Legal research',
        'Drafting and proofreading',
        'Case files and records',
        'Regulatory and policy review',
        'Legislative analysis',
        'ADR support',
      ],
    ),
    _SkillGroup(
      title: 'Virtual assistance & operations',
      skills: [
        'Email and calendar management',
        'Scheduling and deadline tracking',
        'Data entry and spreadsheets',
        'Client and stakeholder communication',
        'Document preparation',
        'Task coordination',
      ],
    ),
    _SkillGroup(
      title: 'Tools & platforms',
      skills: [
        'Microsoft Office',
        'Google Workspace',
        'Zoom',
        'Google Meet',
        'CRM tools',
        'Canva',
        'Slack',
        'Microsoft Teams',
        'AI-assisted productivity tools',
      ],
    ),
  ];

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _scrollTo(String section) async {
    setState(() => _menuOpen = false);
    final targetContext = _sectionKeys[section]?.currentContext;
    if (targetContext == null) return;

    await Scrollable.ensureVisible(
      targetContext,
      duration: MediaQuery.of(context).disableAnimations
          ? Duration.zero
          : const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      alignment: 0.03,
    );
  }

  Future<void> _openContact(Uri uri) async {
    final opened = await launchUrl(uri);
    if (!opened && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not open this contact link.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            Container(
              key: _sectionKeys['top'],
              child: _SiteHeader(
                navigation: _navigation,
                menuOpen: _menuOpen,
                onToggleMenu: () => setState(() => _menuOpen = !_menuOpen),
                onNavigate: _scrollTo,
              ),
            ),
            _HeroSection(onExplore: () => _scrollTo('profile')),
            _PortfolioSection(
              key: _sectionKeys['profile'],
              number: '01',
              label: 'PROFILE',
              child: const _ProfileContent(),
            ),
            _PortfolioSection(
              key: _sectionKeys['experience'],
              number: '02',
              label: 'EXPERIENCE',
              background: _sage,
              child: _ExperienceContent(entries: _experience),
            ),
            _PortfolioSection(
              key: _sectionKeys['education'],
              number: '03',
              label: 'EDUCATION',
              child: _EducationContent(entries: _education),
            ),
            _PortfolioSection(
              key: _sectionKeys['skills'],
              number: '04',
              label: 'SKILLS',
              background: _sage,
              child: _SkillsContent(groups: _skillGroups),
            ),
            _ContactSection(
              key: _sectionKeys['contact'],
              onEmail: () => _openContact(
                Uri(scheme: 'mailto', path: 'rodhamkarani@gmail.com'),
              ),
              onPhone: () =>
                  _openContact(Uri(scheme: 'tel', path: '+254757753055')),
            ),
            _SiteFooter(onNavigate: _scrollTo),
          ],
        ),
      ),
    );
  }
}

class _SiteHeader extends StatelessWidget {
  const _SiteHeader({
    required this.navigation,
    required this.menuOpen,
    required this.onToggleMenu,
    required this.onNavigate,
  });

  final List<(String, String)> navigation;
  final bool menuOpen;
  final VoidCallback onToggleMenu;
  final ValueChanged<String> onNavigate;

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.sizeOf(context).width <= 800;

    return Container(
      decoration: const BoxDecoration(
        color: _paper,
        border: Border(bottom: BorderSide(color: _line)),
      ),
      child: _BoundedContent(
        child: Column(
          children: [
            SizedBox(
              height: 76,
              child: Row(
                children: [
                  _Wordmark(onTap: () => onNavigate('top')),
                  const Spacer(),
                  if (!isMobile)
                    Row(
                      children: [
                        for (final (id, label) in navigation)
                          _NavLink(label: label, onTap: () => onNavigate(id)),
                        _NavLink(
                          label: 'Contact ↗',
                          emphasized: true,
                          onTap: () => onNavigate('contact'),
                        ),
                      ],
                    )
                  else
                    IconButton(
                      tooltip: menuOpen
                          ? 'Close navigation'
                          : 'Open navigation',
                      onPressed: onToggleMenu,
                      icon: Icon(menuOpen ? Icons.close : Icons.menu),
                    ),
                ],
              ),
            ),
            if (isMobile && menuOpen)
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Wrap(
                    spacing: 22,
                    runSpacing: 14,
                    children: [
                      for (final (id, label) in navigation)
                        _NavLink(label: label, onTap: () => onNavigate(id)),
                      _NavLink(
                        label: 'Contact ↗',
                        emphasized: true,
                        onTap: () => onNavigate('contact'),
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
}

class _Wordmark extends StatelessWidget {
  const _Wordmark({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: 'Rodham Kinya Karani, home',
      child: InkWell(
        onTap: onTap,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 31,
              height: 31,
              alignment: Alignment.center,
              color: _forest,
              child: const Text(
                'RK',
                style: TextStyle(
                  color: _paper,
                  fontSize: 10,
                  fontFamily: 'monospace',
                ),
              ),
            ),
            const SizedBox(width: 11),
            const Text(
              'Rodham Kinya Karani',
              style: TextStyle(
                color: _ink,
                fontWeight: FontWeight.w700,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NavLink extends StatelessWidget {
  const _NavLink({
    required this.label,
    required this.onTap,
    this.emphasized = false,
  });

  final String label;
  final VoidCallback onTap;
  final bool emphasized;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 22),
      child: TextButton(
        onPressed: onTap,
        style: TextButton.styleFrom(
          foregroundColor: emphasized ? _ink : const Color(0xFF67594D),
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
          textStyle: TextStyle(
            fontSize: 12,
            fontWeight: emphasized ? FontWeight.w700 : FontWeight.w400,
          ),
        ),
        child: Text(label),
      ),
    );
  }
}

class _HeroSection extends StatelessWidget {
  const _HeroSection({required this.onExplore});

  final VoidCallback onExplore;

  @override
  Widget build(BuildContext context) {
    return _BoundedContent(
      child: LayoutBuilder(
        builder: (context, outerConstraints) => ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 620),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 25),
              const Row(
                children: [
                  _Eyebrow('●  PORTFOLIO / 2026'),
                  Spacer(),
                  _Eyebrow('01 — 05'),
                ],
              ),
              LayoutBuilder(
                builder: (context, constraints) {
                  final mobile = constraints.maxWidth <= 720;
                  final headingSize =
                      (mobile
                              ? constraints.maxWidth * 0.19
                              : constraints.maxWidth * 0.065)
                          .clamp(mobile ? 64.0 : 64.0, mobile ? 100.0 : 94.0)
                          .toDouble();

                  final copy = Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const _Eyebrow('PROFESSIONAL PORTFOLIO', color: _forest),
                      const SizedBox(height: 18),
                      Text.rich(
                        TextSpan(
                          style: TextStyle(
                            color: _ink,
                            fontSize: headingSize,
                            height: 0.92,
                            letterSpacing: -headingSize * 0.055,
                            fontWeight: FontWeight.w600,
                          ),
                          children: [
                            const TextSpan(text: 'Rodham\nKinya\n'),
                            TextSpan(
                              text: 'Karani',
                              style: TextStyle(
                                color: _ink,
                                fontFamily: 'Georgia',
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.w400,
                                letterSpacing: -headingSize * 0.06,
                              ),
                            ),
                            const TextSpan(
                              text: '.',
                              style: TextStyle(color: _orange),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 23),
                      ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 360),
                        child: Text(
                          'Lawyer focused on legal support, research, and dependable administrative coordination.',
                          style: TextStyle(
                            color: Color(0xFF71655B),
                            height: 1.7,
                            fontSize: 15,
                          ),
                        ),
                      ),
                      const SizedBox(height: 22),
                      DecoratedBox(
                        decoration: const BoxDecoration(
                          border: Border(bottom: BorderSide(color: _ink)),
                        ),
                        child: TextButton.icon(
                          onPressed: onExplore,
                          iconAlignment: IconAlignment.end,
                          icon: const Icon(Icons.arrow_downward, size: 17),
                          label: const Text('Explore portfolio'),
                          style: TextButton.styleFrom(
                            foregroundColor: _ink,
                            padding: const EdgeInsets.only(bottom: 9),
                            textStyle: const TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );

                  final artwork = const _HeroArtwork();

                  if (mobile) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 62),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          copy,
                          const SizedBox(height: 38),
                          SizedBox(height: 290, child: artwork),
                        ],
                      ),
                    );
                  }

                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 42),
                    child: SizedBox(
                      height: min(outerConstraints.maxWidth * 0.5, 520),
                      child: Row(
                        children: [
                          Expanded(child: copy),
                          const SizedBox(width: 46),
                          Expanded(child: artwork),
                        ],
                      ),
                    ),
                  );
                },
              ),
              const Divider(color: _line, height: 1),
              SizedBox(
                height: 56,
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final compact = constraints.maxWidth < 430;
                    return Row(
                      children: [
                        _Eyebrow(
                          compact
                              ? 'LEGAL SUPPORT · NAIROBI'
                              : 'LEGAL SUPPORT · NAIROBI, KENYA',
                        ),
                        const Spacer(),
                        _Eyebrow(compact ? '↓' : 'SCROLL TO DISCOVER  ↓'),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _HeroArtwork extends StatelessWidget {
  const _HeroArtwork();

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: LayoutBuilder(
        builder: (context, constraints) => Stack(
          fit: StackFit.expand,
          children: [
            Semantics(
              image: true,
              label: 'Portrait of Rodham Kinya Karani',
              child: Image.asset(
                'assets/rodham-karani-portrait.jpeg',
                fit: BoxFit.cover,
                alignment: const Alignment(0, -0.12),
              ),
            ),
            const DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0x1670513D),
                    Color(0x0070513D),
                    Color(0x0070513D),
                    Color(0xAA342A23),
                  ],
                  stops: [0, 0.25, 0.57, 1],
                ),
              ),
            ),
            Positioned(
              right: -constraints.maxWidth * 0.035,
              top: constraints.maxHeight * 0.2,
              child: Transform.rotate(
                angle: 0.785,
                child: Container(
                  width: constraints.maxWidth * 0.42,
                  height: constraints.maxWidth * 0.42,
                  decoration: BoxDecoration(
                    border: Border.all(color: _paper.withValues(alpha: 0.55)),
                  ),
                ),
              ),
            ),
            const Positioned(
              left: 20,
              top: 20,
              child: _Eyebrow('RK / 01', color: _paper),
            ),
            const Positioned(
              top: 13,
              right: 21,
              child: Text(
                '+',
                style: TextStyle(
                  color: _orange,
                  fontFamily: 'monospace',
                  fontSize: 24,
                ),
              ),
            ),
            const Positioned(
              right: 20,
              bottom: 18,
              child: Text(
                'LEGAL RESEARCH\nADMINISTRATIVE SUPPORT',
                textAlign: TextAlign.right,
                style: TextStyle(
                  color: _paper,
                  fontFamily: 'monospace',
                  height: 1.6,
                  fontSize: 9,
                  letterSpacing: 0.7,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PortfolioSection extends StatelessWidget {
  const _PortfolioSection({
    required super.key,
    required this.number,
    required this.label,
    required this.child,
    this.background = _paper,
  });

  final String number;
  final String label;
  final Widget child;
  final Color background;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: background,
        border: const Border(bottom: BorderSide(color: _line)),
      ),
      child: _BoundedContent(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final mobile = constraints.maxWidth <= 560;
            final labelColumn = SizedBox(
              width: mobile ? null : constraints.maxWidth * 0.27,
              child: Padding(
                padding: EdgeInsets.only(
                  top: mobile ? 0 : 9,
                  bottom: mobile ? 29 : 0,
                  right: mobile ? 0 : 26,
                ),
                child: Row(
                  mainAxisSize: mobile ? MainAxisSize.min : MainAxisSize.max,
                  children: [
                    _Eyebrow('$number / $label', color: _forest),
                    const SizedBox(width: 13),
                    Container(width: 28, height: 1, color: _orange),
                  ],
                ),
              ),
            );

            return Padding(
              padding: EdgeInsets.symmetric(vertical: mobile ? 66 : 96),
              child: mobile
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [labelColumn, child],
                    )
                  : Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        labelColumn,
                        Expanded(child: child),
                      ],
                    ),
            );
          },
        ),
      ),
    );
  }
}

class _ProfileContent extends StatelessWidget {
  const _ProfileContent();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SectionTitle(
          firstLine: 'Law, handled',
          secondLine: 'with care.',
        ),
        const SizedBox(height: 25),
        const Text(
          'Lawyer currently serving as Legal Advisor and Virtual Assistant at Devsync Africa since February 2026, with hands-on legal and administrative support experience at the High Court of Kenya, Kenyatta National Hospital, and the United Nations Environment Programme. Skilled in legal research, document drafting and proofreading, case file and calendar management, and professional stakeholder communication. Comfortable managing competing deadlines independently in fast-paced, remote, and in-person settings. Seeking a Legal Assistant or Virtual Assistant role.',
          style: TextStyle(
            color: Color(0xFF71655B),
            fontSize: 14,
            height: 1.85,
          ),
        ),
        const SizedBox(height: 42),
        const Divider(color: _line, height: 1),
        const SizedBox(height: 17),
        LayoutBuilder(
          builder: (context, constraints) {
            final mobile = constraints.maxWidth < 490;
            final facts = [
              _Fact(label: 'Location', value: 'Nairobi, Kenya'),
              _Fact(label: 'Focus', value: 'Legal & virtual assistance'),
              _Fact(label: 'Qualification', value: 'LLB · GPA 3.3 / 4.0'),
            ];
            return Wrap(
              spacing: mobile ? 0 : 20,
              runSpacing: 16,
              children: facts
                  .map(
                    (fact) => SizedBox(
                      width: mobile
                          ? constraints.maxWidth
                          : (constraints.maxWidth - 40) / 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            fact.label,
                            style: const TextStyle(color: _muted, fontSize: 11),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            fact.value,
                            style: const TextStyle(
                              color: _ink,
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                  .toList(),
            );
          },
        ),
      ],
    );
  }
}

class _ExperienceContent extends StatelessWidget {
  const _ExperienceContent({required this.entries});

  final List<_Experience> entries;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SectionTitle(firstLine: 'Work', secondLine: 'experience.'),
        const SizedBox(height: 18),
        for (final entry in entries)
          Container(
            padding: const EdgeInsets.symmetric(vertical: 24),
            decoration: const BoxDecoration(
              border: Border(top: BorderSide(color: Color(0xFFD9CBB9))),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 4, right: 16),
                  child: Container(
                    width: 9,
                    height: 9,
                    decoration: BoxDecoration(
                      color: backgroundColor(context),
                      border: Border.all(color: _orange, width: 2),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _Eyebrow(entry.context, color: _forest, fontSize: 8),
                      const SizedBox(height: 9),
                      Text(
                        entry.role,
                        style: const TextStyle(
                          color: _ink,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        entry.organization,
                        style: const TextStyle(
                          color: _forest,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 12),
                      for (final highlight in entry.highlights)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 5,
                                height: 5,
                                margin: const EdgeInsets.only(
                                  top: 7,
                                  right: 10,
                                ),
                                color: _orange,
                              ),
                              Expanded(
                                child: Text(
                                  highlight,
                                  style: const TextStyle(
                                    color: Color(0xFF62554A),
                                    fontSize: 12,
                                    height: 1.75,
                                  ),
                                ),
                              ),
                            ],
                          ),
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

  Color backgroundColor(BuildContext context) =>
      Theme.of(context).scaffoldBackgroundColor == _paper ? _sage : _paper;
}

class _EducationContent extends StatelessWidget {
  const _EducationContent({required this.entries});

  final List<_Education> entries;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SectionTitle(
          firstLine: 'Learning',
          secondLine: '& credentials.',
        ),
        const SizedBox(height: 18),
        for (final entry in entries)
          Container(
            padding: const EdgeInsets.symmetric(vertical: 21),
            decoration: const BoxDecoration(
              border: Border(top: BorderSide(color: _line)),
            ),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final compact = constraints.maxWidth < 480;
                final details = Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const _Eyebrow('EDUCATION', color: _forest, fontSize: 8),
                    const SizedBox(height: 10),
                    Text(
                      entry.qualification,
                      style: const TextStyle(
                        color: _ink,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      entry.institution,
                      style: const TextStyle(
                        color: Color(0xFF71655B),
                        fontSize: 12,
                      ),
                    ),
                  ],
                );
                if (entry.detail.isEmpty) return details;
                if (compact) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      details,
                      const SizedBox(height: 8),
                      _Eyebrow(entry.detail, color: _muted, fontSize: 9),
                    ],
                  );
                }
                return Row(
                  children: [
                    Expanded(child: details),
                    const SizedBox(width: 16),
                    Flexible(
                      child: _Eyebrow(
                        entry.detail,
                        color: _muted,
                        fontSize: 9,
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        const Divider(color: _line, height: 1),
      ],
    );
  }
}

class _SkillsContent extends StatelessWidget {
  const _SkillsContent({required this.groups});

  final List<_SkillGroup> groups;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SectionTitle(firstLine: 'Areas of', secondLine: 'expertise.'),
        const SizedBox(height: 20),
        const Text(
          'Legal and administrative support, with the organization and discretion needed to keep busy teams moving.',
          style: TextStyle(color: Color(0xFF71655B), fontSize: 14, height: 1.8),
        ),
        const SizedBox(height: 26),
        for (final group in groups)
          LayoutBuilder(
            builder: (context, constraints) {
              final compact = constraints.maxWidth < 500;
              return Container(
                padding: const EdgeInsets.symmetric(vertical: 20),
                decoration: const BoxDecoration(
                  border: Border(top: BorderSide(color: Color(0xFFD9CBB9))),
                ),
                child: compact
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _SkillGroupContent(group: group),
                          const SizedBox(height: 12),
                          _SkillChips(skills: group.skills),
                        ],
                      )
                    : Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: constraints.maxWidth * 0.38,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 18),
                              child: Text(
                                group.title,
                                style: const TextStyle(
                                  color: _ink,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                          Expanded(child: _SkillChips(skills: group.skills)),
                        ],
                      ),
              );
            },
          ),
        const Divider(color: Color(0xFFD9CBB9), height: 1),
      ],
    );
  }
}

class _SkillGroupContent extends StatelessWidget {
  const _SkillGroupContent({required this.group});

  final _SkillGroup group;

  @override
  Widget build(BuildContext context) => Text(
    group.title,
    style: const TextStyle(
      color: _ink,
      fontSize: 13,
      fontWeight: FontWeight.w600,
    ),
  );
}

class _SkillChips extends StatelessWidget {
  const _SkillChips({required this.skills});

  final List<String> skills;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        for (final skill in skills)
          Container(
            padding: const EdgeInsets.symmetric(vertical: 9, horizontal: 12),
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFFD9CBB9)),
            ),
            child: Text(
              skill,
              style: const TextStyle(color: Color(0xFF62554A), fontSize: 11),
            ),
          ),
      ],
    );
  }
}

class _ContactSection extends StatelessWidget {
  const _ContactSection({
    required super.key,
    required this.onEmail,
    required this.onPhone,
  });

  final VoidCallback onEmail;
  final VoidCallback onPhone;

  @override
  Widget build(BuildContext context) {
    return _BoundedContent(
      child: LayoutBuilder(
        builder: (context, constraints) {
          final mobile = constraints.maxWidth <= 600;
          final intro = Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _Eyebrow('05 / CONTACT', color: _forest),
              const SizedBox(height: 26),
              const _SectionTitle(
                firstLine: 'Let’s start',
                secondLine: 'a conversation.',
              ),
              const SizedBox(height: 16),
              const Text(
                'For Legal Assistant and Virtual Assistant opportunities, reach out directly.',
                style: TextStyle(
                  color: Color(0xFF71655B),
                  fontSize: 13,
                  height: 1.7,
                ),
              ),
            ],
          );
          final details = Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _ContactAction(
                icon: Icons.mail_outline,
                label: 'Email',
                detail: 'rodhamkarani@gmail.com',
                onTap: onEmail,
              ),
              _ContactAction(
                icon: Icons.phone_outlined,
                label: 'Phone',
                detail: '+254 757 753 055',
                onTap: onPhone,
              ),
              const _ContactAction(
                icon: Icons.location_on_outlined,
                label: 'Location',
                detail: 'Nairobi, Kenya',
              ),
              const Padding(
                padding: EdgeInsets.only(top: 10),
                child: Text(
                  'Professional referees available upon request.',
                  style: TextStyle(color: _muted, fontSize: 10),
                ),
              ),
            ],
          );
          return Padding(
            padding: EdgeInsets.symmetric(vertical: mobile ? 70 : 100),
            child: mobile
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [intro, const SizedBox(height: 36), details],
                  )
                : Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(child: intro),
                      const SizedBox(width: 48),
                      SizedBox(width: 340, child: details),
                    ],
                  ),
          );
        },
      ),
    );
  }
}

class _ContactAction extends StatelessWidget {
  const _ContactAction({
    required this.icon,
    required this.label,
    required this.detail,
    this.onTap,
  });

  final IconData icon;
  final String label;
  final String detail;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: onTap != null,
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 15),
          decoration: const BoxDecoration(
            border: Border(top: BorderSide(color: _line)),
          ),
          child: Row(
            children: [
              Icon(icon, size: 19, color: _forest),
              const SizedBox(width: 13),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      label,
                      style: const TextStyle(
                        color: _forest,
                        fontSize: 10,
                        height: 1.8,
                      ),
                    ),
                    Text(
                      detail,
                      style: const TextStyle(
                        color: _ink,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              if (onTap != null)
                const Icon(Icons.north_east, size: 16, color: _forest),
            ],
          ),
        ),
      ),
    );
  }
}

class _SiteFooter extends StatelessWidget {
  const _SiteFooter({required this.onNavigate});

  final ValueChanged<String> onNavigate;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: _line)),
      ),
      child: _BoundedContent(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final compact = constraints.maxWidth < 500;
            return SizedBox(
              height: 78,
              child: Row(
                children: [
                  _Wordmark(onTap: () => onNavigate('top')),
                  const Spacer(),
                  if (compact)
                    IconButton(
                      tooltip: 'Back to top',
                      onPressed: () => onNavigate('top'),
                      icon: const Icon(Icons.arrow_upward, size: 18),
                    )
                  else ...[
                    const _Eyebrow('PORTFOLIO / 2026'),
                    const Spacer(),
                    TextButton(
                      onPressed: () => onNavigate('top'),
                      style: TextButton.styleFrom(foregroundColor: _ink),
                      child: const Text(
                        'Back to top ↑',
                        style: TextStyle(fontSize: 11),
                      ),
                    ),
                  ],
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.firstLine, required this.secondLine});

  final String firstLine;
  final String secondLine;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final size = (constraints.maxWidth * 0.095)
            .clamp(40.0, 68.0)
            .toDouble();
        return Text.rich(
          TextSpan(
            style: TextStyle(
              color: _ink,
              fontSize: size,
              height: 1,
              letterSpacing: -size * 0.045,
              fontWeight: FontWeight.w500,
            ),
            children: [
              TextSpan(text: '$firstLine\n'),
              TextSpan(
                text: secondLine,
                style: const TextStyle(
                  fontFamily: 'Georgia',
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _Eyebrow extends StatelessWidget {
  const _Eyebrow(
    this.text, {
    this.color = _muted,
    this.fontSize = 9,
    this.textAlign = TextAlign.left,
  });

  final String text;
  final Color color;
  final double fontSize;
  final TextAlign textAlign;

  @override
  Widget build(BuildContext context) {
    return Text(
      text.toUpperCase(),
      textAlign: textAlign,
      style: TextStyle(
        color: color,
        fontSize: fontSize,
        letterSpacing: 0.8,
        fontFamily: 'monospace',
        height: 1.6,
      ),
    );
  }
}

class _BoundedContent extends StatelessWidget {
  const _BoundedContent({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final horizontalPadding = width < 600 ? width * 0.06 : width * 0.0625;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1320),
          child: child,
        ),
      ),
    );
  }
}

class _Experience {
  const _Experience({
    required this.role,
    required this.organization,
    required this.context,
    required this.highlights,
  });

  final String role;
  final String organization;
  final String context;
  final List<String> highlights;
}

class _Education {
  const _Education({
    required this.qualification,
    required this.institution,
    this.detail = '',
  });

  final String qualification;
  final String institution;
  final String detail;
}

class _SkillGroup {
  const _SkillGroup({required this.title, required this.skills});

  final String title;
  final List<String> skills;
}

class _Fact {
  const _Fact({required this.label, required this.value});

  final String label;
  final String value;
}
