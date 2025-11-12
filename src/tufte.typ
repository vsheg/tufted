#import "math.typ": template-math

#let make-header(links) = html.elem(
  "header",
  html.elem(
    "nav",
    for (href, title) in links {
      html.elem("a", attrs: (href: href), title)
    },
  ),
)


#let tufte-website(header-links: none, content) = {
  // Apply math hack to render as SVG
  show: template-math

  html.elem("html", {
    // Head
    html.elem("head", {
      html.elem("meta", attrs: ("charset": "UTF-8"))
      html.elem("meta", attrs: (
        "name": "viewport",
        "content": "width=device-width, initial-scale=1",
      ))
      html.elem("title", "Posts - Sheg's Blog")
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
