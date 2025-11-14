#import "math.typ": template-math
#import "refs.typ": template-refs
#import "notes.typ": template-notes
#import "figures.typ": template-figures

#let make-header(links) = html.elem(
  "header",
  html.elem(
    "nav",
    for (href, title) in links {
      html.elem("a", attrs: (href: href), title)
    },
  ),
)

#let tufted-web(header-links: none, title: "Tufted", content) = {
  // Apply styling
  show: template-math
  show: template-refs
  show: template-notes
  show: template-figures

  html.elem("html", {
    // Head
    html.elem("head", {
      html.elem("meta", attrs: ("charset": "UTF-8"))
      html.elem("meta", attrs: (
        "name": "viewport",
        "content": "width=device-width, initial-scale=1",
      ))
      html.elem("title", title)
      html.elem("link", attrs: (
        "rel": "stylesheet",
        href: "https://cdnjs.cloudflare.com/ajax/libs/tufte-css/1.8.0/tufte.min.css",
      ))
      html.elem("link", attrs: ("rel": "stylesheet", "href": "/assets/style.css"))
    })

    // Body
    html.elem(
      "body",
      {
        // Add website header
        make-header(header-links)

        // Main content
        html.elem(
          "article",
          html.elem("section", content),
        )
      },
    )
  })
}
