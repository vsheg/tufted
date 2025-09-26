#import "../src/tufte.typ": tufte-website

#let template = tufte-website.with(
  header-links: (
    "/posts/": "Posts",
    "/about/": "About",
  ),
)
