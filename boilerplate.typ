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
        /// Below, the CSS code for OU block's.
        /// Contrary to the original, this  code is *parametrised* with an icon.
        /// The icon is a FontAwesome unicode char and is read from the `title` attribute.
        /// (Better would be the `data-text` attribute, but Typst doesn't support that.)
        html.style(
".bs-ou-component-custom {
  margin-bottom: 30px;
  padding: 20px 100px 10px 25px;
  position: relative;
  background-color: #FFF;
  border-left: 5px solid #E2001A;
  border-radius: 5px;
  box-shadow: 0px 0px 5px 0 rgba(0, 0, 0, 0.2);
  overflow: hidden;
}
.bs-ou-component-custom:after {
  padding: 10px 0;
  position: absolute;
  right: 0px;
  top: 10px;
  width: 60px;
  height: 45px;
  background-color: #E2001A;
  border-radius: 25px 0 0 25px;
  font: bold 18px/1.4 \"Font Awesome 6 Pro\";
  content: attr(title);
  color: #fff;
  text-align: center;
}
.bs-ou-component-custom-gray {
  padding: 20px 25px 5px 25px;
  margin-bottom: 30px;
  background-color: #EFEFEF;
  border-radius: 5px;
  position: relative;
}
.bs-ou-component-custom-gray:after {
  padding: 10px 0;
  position: absolute;
  right: 0px;
  top: 10px;
  width: 60px;
  height: 45px;
  background-color: #000;
  border-radius: 25px 0 0 25px;
  font: bold 18px/1.4 \"Font Awesome 6 Pro\";
  content: attr(title);
  color: #fff;
  text-align: center;
}"
        )
      })
      html.body(
        /// This is the sync tag used by the BrightSpace syncer.
        html.span(class: "$SYNC_TAG:{{SYNC_TAG}}") +
        /// Main content, as specified by the OU.
        html.div(class: "container-fluid",
          html.div(class: "row",
            html.div(class: "col-sm-10 offset-sm-1",
              it
            )
          )
        ) +
        /// This code moves each `hN` one up, to `h(N-1)`.
        /// Typst generates headings starting from `h2`,
        /// OU wants headings to start at `h1`.
        html.script(
"document.querySelectorAll('h1, h2, h3, h4, h5, h6').forEach(el => {
  const currentLevel = parseInt(el.tagName[1]);
  const newLevel = Math.max(currentLevel - 1, 1);
  const newHeading = document.createElement('h' + newLevel);
  newHeading.innerHTML = el.innerHTML;
  // Array.from(el.attributes).forEach(attr => newHeading.setAttribute(attr.name, attr.value));
  el.replaceWith(newHeading);
  if (newLevel === 1) {
    const hr = document.createElement('hr');
    newHeading.insertAdjacentElement('afterend', hr);
  }
});"
        )
      )
    })

    /// Workaround to *not* include bytes of image but just refer to it
    show image: (it) => {
      html.img(
        // alt: if it.alt == none {""} else {it.alt},
        // height: it.height,
        // width: it.width,
        src: it.source,
      )
      html.pre(it.source)
    }

    /// Workaround for SVG math
    /// From: https://github.com/typst/typst/issues/721#issuecomment-3064895139
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
