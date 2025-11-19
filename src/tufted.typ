#import "math.typ": template-math
#import "refs.typ": template-refs
#import "notes.typ": template-notes
#import "figures.typ": template-figures
#import "layout.typ": full-width, margin-note

#let make-header(links) = html.header(
  html.nav(
    for (href, title) in links {
      html.a(href: href, title)
    },
  ),
)

#let tufted-web(
  header-links: none,
  title: "Tufted",
  lang: "en",
  global-css: "https://cdnjs.cloudflare.com/ajax/libs/tufte-css/1.8.0/tufte.min.css",
  local-css: "/assets/style.css",
  content,
) = {
  // Apply styling
  show: template-math
  show: template-refs
  show: template-notes
  show: template-figures

  html.html(
    lang: lang, // Typst ignores this for now, so hyphenation may not work properly
    {
      // Head
      html.head({
        html.meta(charset: "utf-8")
        html.meta(name: "viewport", content: "width=device-width, initial-scale=1")
        html.title(title)
        html.link(
          rel: "stylesheet",
          href: global-css,
        )
        html.link(rel: "stylesheet", href: local-css)
      })

      // Body
      html.body({
        // Add website header
        make-header(header-links)

        // Main content
        html.article(
          html.section(content),
        )
      })
    },
  )
}
