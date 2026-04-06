export default {
  logo: <span style={{ fontWeight: 700 }}>APW Docs</span>,
  banner: {
    key: 'apw-in-repo-docs',
    text: 'Markdown and MDX in this repository remain the source of truth. Nextra is the presentation layer.'
  },
  footer: {
    text: 'APW docs portal. The documentation source of truth stays in this repository.'
  },
  search: {
    placeholder: 'Search APW docs'
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

