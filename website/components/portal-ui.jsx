export function PortalHero({ eyebrow, title, lede, actions = [], stats = [] }) {
  return (
    <section className="apw-hero">
      <div className="apw-hero__content">
        {eyebrow ? <div className="apw-kicker">{eyebrow}</div> : null}
        <h1 className="apw-hero__title">{title}</h1>
        <p className="apw-hero__lede">{lede}</p>
        {actions.length ? (
          <div className="apw-action-row">
            {actions.map((action) => (
              <a
                key={`${action.href}-${action.label}`}
                className={`apw-button ${action.variant === 'secondary' ? 'apw-button--secondary' : ''}`}
                href={action.href}
              >
                {action.label}
              </a>
            ))}
          </div>
        ) : null}
      </div>
      {stats.length ? (
        <div className="apw-stat-grid">
          {stats.map((stat) => (
            <div className="apw-stat-card" key={`${stat.label}-${stat.value}`}>
              <div className="apw-stat-card__value">{stat.value}</div>
              <div className="apw-stat-card__label">{stat.label}</div>
            </div>
          ))}
        </div>
      ) : null}
    </section>
  )
}

export function PortalSectionIntro({ eyebrow, title, lede }) {
  return (
    <div className="apw-section-intro">
      {eyebrow ? <div className="apw-kicker">{eyebrow}</div> : null}
      <h2 className="apw-section-intro__title">{title}</h2>
      {lede ? <p className="apw-section-intro__lede">{lede}</p> : null}
    </div>
  )
}

export function PortalPillRow({ items = [] }) {
  if (!items.length) return null

  return (
    <div className="apw-pill-row">
      {items.map((item) => (
        <span className="apw-pill" key={item}>
          {item}
        </span>
      ))}
    </div>
  )
}
