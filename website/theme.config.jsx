export default {
  logo: (
    <span style={{ display: 'inline-flex', alignItems: 'center', gap: '0.65rem', fontWeight: 800 }}>
      <span
        style={{
          width: '0.9rem',
          height: '0.9rem',
          borderRadius: '999px',
          background: 'linear-gradient(135deg, #0f766e, #0f4c81)',
          boxShadow: '0 0 0 4px rgba(15, 118, 110, 0.12)'
        }}
      />
      APW Framework
    </span>
  ),
  banner: {
    key: 'apw-in-repo-docs',
    text: 'Professional portal, canonical repo docs. APW governance still lives in the root files and docs/.'
  },
  footer: {
    text: 'APW docs portal. Product-grade presentation, repo-root source of truth.'
  },
  search: {
    placeholder: 'Search guides, workflows, and reference'
  },
  sidebar: {
    defaultMenuCollapseLevel: 1
  },
  navigation: {
    prev: true,
    next: true
  },
  toc: {
    float: true,
    backToTop: true
  },
  editLink: {
    content: null
  },
  feedback: {
    content: null
  },
  useNextSeoProps() {
    return {
      titleTemplate: '%s - APW Docs'
    }
  }
}
