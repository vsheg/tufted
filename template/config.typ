#import "@preview/tufted:0.0.1": *

#let template = tufted-web.with(
  header-links: (
    "/": "Home",
    "/posts/": "Posts",
    "/cv/": "CV",
    "/about/": "About",
  ),
  title: "Tufted",
)
