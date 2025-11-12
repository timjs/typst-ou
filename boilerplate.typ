#let template(it) = context {

  // TODO: move this somewhere else
  set heading(numbering: "1.1.1")

  if target() == "html" {

    // TODO: lift all one level
    // show heading.where(level: 1): html.h1

    // Wrap everything in OU styles
    show: (it) => html.html({
      let assets = "https://brightspace.ou.nl/shared/HTML-Template-Library/HTML-Templates-OU/_assets/"
      html.head({
        html.meta(charset: "utf-8")
        html.meta(name: "viewport", content: "width=device-width, initial-scale=1, shrink-to-fit=no")
        html.link(rel: "stylesheet", href: assets+"css/styles.min.css")
        html.link(rel: "stylesheet", href: assets+"css/custom.css")
        html.script(src: assets+"thirdpartylib/jquery/jquery-3.3.1.slim.min.js")
        html.script(src: assets+"thirdpartylib/bootstrap/js/bootstrap.min.js")
        html.script(src: assets+"js/scripts.min.js")
        html.script(src: assets+"js/custom-min.js")
      })
      html.body(
        html.span(class: "$SYNC_TAG:{{SYNC_TAG}}") +
        html.div(class: "container-fluid",
          html.div(class: "row",
            html.div(class: "col-sm-10 offset-sm-1",
              it
            )
          )
        )
      )
    })

    // Workaround to *not* include bytes of image but just refer to it
    show image: (it) => {
      html.img(
        // alt: if it.alt == none {""} else {it.alt},
        // height: it.height,
        // width: it.width,
        src: it.source,
      )
      html.pre(it.source)
    }

    // Workaround for SVG math
    // From: https://github.com/typst/typst/issues/721#issuecomment-3064895139
    show math.equation.where(block: true): (it) => {
      html.figure(role: "math", html.frame(it))
    }
    show math.equation.where(block: false): (it) => {
      html.span(role: "math", html.frame(it))
    }


    it
  } else {
    it
  }
}
