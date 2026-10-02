import { ArrowDown, ArrowUpRight, BriefcaseBusiness, GraduationCap, Mail, MapPin, Menu, Phone, X } from 'lucide-react';
import { useState } from 'react';
import portrait from '../assets/rodham-karani-portrait.jpeg';

const sections = [
  { id: 'profile', label: 'Profile' },
  { id: 'experience', label: 'Experience' },
  { id: 'education', label: 'Education' },
  { id: 'skills', label: 'Skills' },
];

const experience = [
  {
    role: 'Legal Intern',
    organization: 'United Nations Environment Programme (UNEP)',
    context: 'International internship',
    highlights: [
      'Analyzed international environmental agreements and compliance frameworks, producing research that informed policy development for global governance initiatives.',
      'Synthesized climate and international law findings into briefing materials for stakeholder engagement.',
    ],
  },
  {
    role: 'Judicial Attachment, Mediation Desk',
    organization: 'Milimani High Court · Family Division, Nairobi',
    context: 'Court attachment',
    highlights: [
      'Supported judicial officers and mediators with case preparation, documentation, and scheduling across the case lifecycle.',
      'Assisted court-annexed mediation sessions and built practical experience supporting family law dispute resolution.',
      'Researched and drafted summaries on succession, divorce, and custody matters; maintained accurate court records.',
    ],
  },
  {
    role: 'Legal Practicum, Legal Department',
    organization: 'Kenyatta National Hospital (KNH)',
    context: 'Public sector',
    highlights: [
      'Conducted regulatory audits of contracts and internal policy documentation, identifying compliance gaps.',
      'Researched health law and liability issues to support risk mitigation for the hospital legal department.',
    ],
  },
];

const education = [
  { qualification: 'Bachelor of Laws (LLB)', institution: 'Daystar University, Kenya', detail: 'Class of 2025 · GPA 3.3 / 4.0' },
  { qualification: 'Advanced Studies in Intellectual Property', institution: 'WIPO Academy', detail: 'Scholarship recipient' },
  { qualification: 'Kenya Certificate of Secondary Education', institution: "Materi Girls' Secondary School", detail: '' },
];

const skillGroups = [
  {
    title: 'Legal & administrative support',
    skills: ['Legal research', 'Drafting and proofreading', 'Case files and records', 'Regulatory and policy review', 'Legislative analysis', 'ADR support'],
  },
  {
    title: 'Virtual assistance & operations',
    skills: ['Email and calendar management', 'Scheduling and deadline tracking', 'Data entry and spreadsheets', 'Client and stakeholder communication', 'Document preparation', 'Task coordination'],
  },
  {
    title: 'Tools & platforms',
    skills: ['Microsoft Office', 'Google Workspace', 'Zoom', 'Google Meet', 'CRM tools', 'Canva', 'Slack', 'Microsoft Teams', 'AI-assisted productivity tools'],
  },
];

function App() {
  const [menuOpen, setMenuOpen] = useState(false);

  const closeMenu = () => setMenuOpen(false);

  return (
    <>
      <header className="site-header">
        <a className="wordmark" href="#top" aria-label="Rodham Kinya Karani, home" onClick={closeMenu}>
          <span className="wordmark-mark">RK</span>
          <span>Rodham Kinya Karani</span>
        </a>
        <button
          className="menu-toggle"
          type="button"
          aria-label={menuOpen ? 'Close navigation' : 'Open navigation'}
          aria-expanded={menuOpen}
          onClick={() => setMenuOpen(!menuOpen)}
        >
          {menuOpen ? <X size={20} /> : <Menu size={20} />}
        </button>
        <nav className={menuOpen ? 'site-nav is-open' : 'site-nav'} aria-label="Main navigation">
          {sections.map((section) => (
            <a key={section.id} href={`#${section.id}`} onClick={closeMenu}>
              {section.label}
            </a>
          ))}
          <a className="nav-contact" href="#contact" onClick={closeMenu}>
            Contact <ArrowUpRight size={15} aria-hidden="true" />
          </a>
        </nav>
      </header>

      <main id="top">
        <section className="hero" aria-labelledby="hero-title">
          <div className="hero-topline">
            <span className="eyebrow"><span className="status-dot" /> Portfolio / 2026</span>
            <span className="hero-index">01 — 05</span>
          </div>
          <div className="hero-content">
            <div className="hero-copy">
              <p className="overline">Professional portfolio</p>
              <h1 id="hero-title">Rodham<br />Kinya<br /><span>Karani</span><i>.</i></h1>
              <p className="hero-description">LLB graduate focused on legal support, research, and dependable administrative coordination.</p>
              <a className="text-link" href="#profile">
                Explore portfolio <ArrowDown size={16} aria-hidden="true" />
              </a>
            </div>
            <img
              className="hero-art"
              src={portrait}
              alt="Portrait of Rodham Kinya Karani"
              width={830}
              height={768}
            />
          </div>
          <div className="hero-footer">
            <span>Legal support · Nairobi, Kenya</span>
            <span className="scroll-cue">Scroll to discover <span aria-hidden="true">↓</span></span>
          </div>
        </section>

        <div className="content-wrap">
          <section className="profile-section section-grid" id="profile" aria-labelledby="profile-title">
            <div className="section-aside">
              <span className="section-number">01 / PROFILE</span>
              <span className="section-rule" />
            </div>
            <div className="section-main">
              <h2 id="profile-title">Law, handled<br /><em>with care.</em></h2>
              <p className="section-intro">LLB graduate with hands-on legal and administrative support experience at the High Court of Kenya, Kenyatta National Hospital, and the United Nations Environment Programme. Skilled in legal research, document drafting and proofreading, case file and calendar management, and professional stakeholder communication. Comfortable managing competing deadlines independently in fast-paced, remote, and in-person settings. Seeking a Legal Assistant or Virtual Assistant role.</p>
              <div className="profile-facts">
                <div><span>Location</span><strong>Nairobi, Kenya</strong></div>
                <div><span>Focus</span><strong>Legal &amp; virtual assistance</strong></div>
                <div><span>Qualification</span><strong>LLB · GPA 3.3 / 4.0</strong></div>
              </div>
            </div>
          </section>

          <section className="experience-section section-grid section-band" id="experience" aria-labelledby="experience-title">
            <div className="section-aside">
              <span className="section-number">02 / EXPERIENCE</span>
              <span className="section-rule" />
            </div>
            <div className="section-main">
              <div className="section-heading-row">
                <h2 id="experience-title">Work<br /><em>experience.</em></h2>
                <BriefcaseBusiness className="heading-icon" size={27} strokeWidth={1.4} aria-hidden="true" />
              </div>
              <div className="experience-list">
                {experience.map((entry) => (
                  <article className="experience-item" key={entry.organization}>
                    <span className="timeline-marker" />
                    <div className="experience-entry-content">
                      <span className="small-label">{entry.context}</span>
                      <h3>{entry.role}</h3>
                      <p className="entry-organization">{entry.organization}</p>
                      <ul className="detail-list">
                        {entry.highlights.map((highlight) => <li key={highlight}>{highlight}</li>)}
                      </ul>
                    </div>
                  </article>
                ))}
              </div>
            </div>
          </section>

          <section className="education-section section-grid" id="education" aria-labelledby="education-title">
            <div className="section-aside">
              <span className="section-number">03 / EDUCATION</span>
              <span className="section-rule" />
            </div>
            <div className="section-main">
              <div className="section-heading-row">
                <h2 id="education-title">Learning<br /><em>& credentials.</em></h2>
                <GraduationCap className="heading-icon" size={29} strokeWidth={1.4} aria-hidden="true" />
              </div>
              <div className="education-list">
                {education.map((entry) => (
                  <article className="education-entry" key={entry.qualification}>
                    <div>
                      <span className="small-label">Education</span>
                      <h3>{entry.qualification}</h3>
                      <p>{entry.institution}</p>
                    </div>
                    {entry.detail && <span className="education-detail">{entry.detail}</span>}
                  </article>
                ))}
              </div>
            </div>
          </section>

          <section className="skills-section section-grid section-band" id="skills" aria-labelledby="skills-title">
            <div className="section-aside">
              <span className="section-number">04 / SKILLS</span>
              <span className="section-rule" />
            </div>
            <div className="section-main">
              <h2 id="skills-title">Areas of<br /><em>expertise.</em></h2>
              <p className="section-intro">Legal and administrative support, with the organization and discretion needed to keep busy teams moving.</p>
              <div className="skill-groups">
                {skillGroups.map((group) => (
                  <div className="skill-group" key={group.title}>
                    <h3>{group.title}</h3>
                    <div className="skill-list">
                      {group.skills.map((skill) => <span key={skill}>{skill}</span>)}
                    </div>
                  </div>
                ))}
              </div>
            </div>
          </section>

          <section className="contact-section" id="contact" aria-labelledby="contact-title">
            <div className="contact-copy">
              <span className="section-number">05 / CONTACT</span>
              <h2 id="contact-title">Let’s start<br /><em>a conversation.</em></h2>
              <p>For Legal Assistant and Virtual Assistant opportunities, reach out directly.</p>
            </div>
            <div className="contact-actions">
              <a className="contact-action" href="mailto:rodhamkarani@gmail.com">
                <Mail size={19} strokeWidth={1.5} aria-hidden="true" />
                <span>Email<br /><strong>rodhamkarani@gmail.com</strong></span>
                <ArrowUpRight size={16} aria-hidden="true" />
              </a>
              <a className="contact-action" href="tel:+254757753055">
                <Phone size={18} strokeWidth={1.5} aria-hidden="true" />
                <span>Phone<br /><strong>+254 757 753 055</strong></span>
                <ArrowUpRight size={16} aria-hidden="true" />
              </a>
              <div className="contact-action contact-location">
                <MapPin size={18} strokeWidth={1.5} aria-hidden="true" />
                <span>Location<br /><strong>Nairobi, Kenya</strong></span>
              </div>
              <p className="references-note">Professional referees available upon request.</p>
            </div>
          </section>
        </div>
      </main>

      <footer className="site-footer">
        <a className="wordmark" href="#top">
          <span className="wordmark-mark">RK</span>
          <span>Rodham Kinya Karani</span>
        </a>
        <span>Portfolio / 2026</span>
        <a href="#top" className="back-top">Back to top ↑</a>
      </footer>
    </>
  );
}

export default App;
