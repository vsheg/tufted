#import "@preview/tufted:0.0.1": tufted-web

#let template = tufted-web.with(
  header-links: (
    "/posts/": "Posts",
    "/about/": "About",
  ),
)
