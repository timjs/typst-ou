#import "/lib/basic/helpers.typ"

/// Helper to annotate contents with an Html class (when exporting to Html)
/// or just use the contents (when exporting to Pdf).
#let div-or-id(class: none, title: "", it) = context {
  if target() == "html" {html.div(class: class, title: title, it)} else {it}
}
/// Helper to force Typst to make a (single) paragraph.
/// Some OU components need this to work properly.
///
/// Note:
///     We could add an `html.p`, but then we'll have Typst paragraphs
///     wrapped in that `html.p`, which is not proper Html.
#let div-or-id-with-par(..args, it) = div-or-id(..args)[
  #it
  #parbreak()
]

/// Helper to produce an Html unordered list item (when exporting to Html)
/// or just use the contents (when exporting to Pdf).
/// Some OU components need this to work properly.
#let ul-li-or-id(it) = context {
  if target() == "html" {html.ul(html.li(it))} else {it}
}

/// Helper to produce an Html button (when exporting to Html)
/// or just nothing (when exporting to Pdf).
#let button-or-none(class: none) = context {
  if target() == "html" {html.button(class: class)}
}

/// Any OU component of `kind` with optional `icon`.
#let ou-component(kind, icon: "", it) = div-or-id-with-par(
  class: "bs-ou-component-" + kind,
  title: icon,
  it,
)

/// A block of `kind` styled by the OU
///
/// / `kind`: can be anything the OU provides as `bs-ou-component-X`
/// / `inner`: a wrapper function to put the body in
#let ou-block(kind, supplement: none, caption: none, inner: helpers.identity, ..args, it) = ou-component(
  kind,
  ..args,
  inner[
    #if supplement != none [=== #supplement #if caption != none [(#caption)]]
    #it
  ]
)
/// Possible implementation when using figures
/// / `it`: should be a `figure` element
// #let ou-block(kind, supplement, caption, wrapper: identity, it) = ou-component(
//   kind,
//   wrapper({
//     strong(counter(figure).display(it.numbering))
//     strong(it.supplement)
//     sym.space.quad
//     strong(it.caption)
//     parbreak()
//     it.body
//   })
// )


//// Basic components ////////////////////////////////////////////////////////////////////////////////

#let ou-block-white = ou-block.with("") //TODO: icon here?
#let ou-block-white-accent = ou-block.with("example", inner: div-or-id-with-par.with(class: "example-wrapper"))
// #let ou-block-white-pointing = ou-block.with("studyinstructions", inner: ul-li-or-id)
#let ou-block-gray = ou-block.with("case")
#let ou-block-gray-accent = ou-block.with("accent")


//// Custom components ///////////////////////////////////////////////////////////////////////////////

#let custom-block = ou-block.with("custom")
#let custom-block-gray = ou-block.with("custom-gray")


//// Study components //////////////////////////////////////////////////////////////////////////////

/*
<div class="bs-ou-component-sources">
  <h2>Bronnen</h2>
  <ul>
    <li><strong>[[Type bron]]</strong> <br>[[Toelichting]]</li>
    <li><strong>[[Type bron]]</strong> <br>[[Toelichting]]</li>
    <li><strong>[[Type bron]]</strong> <br>[[Toelichting]]</li>
    <li><strong>[[Type bron]]</strong> <br>[[Toelichting]]</li>
  </ul>
</div>

<div class="bs-ou-component-sources optional">
  <h2>Facultatieve bronnen</h2>
  <ul>
    <li><strong>[[Type bron]]</strong> <br>[[Toelichting]]</li>
    <li><strong>[[Type bron]]</strong> <br>[[Toelichting]]</li>
    <li><strong>[[Type bron]]</strong> <br>[[Toelichting]]</li>
    <li><strong>[[Type bron]]</strong> <br>[[Toelichting]]</li>
  </ul>
</div>
*/
// #let sources(optional: false, it) = div(class: "bs-ou-component-sources" + if optional {" optional"} else {""}, it)
// #let source(name, it) = [- *#name*\ #it]
#let sources(optional: false, its) = ou-component("sources" + if optional {" optional"} else {""})[ //, title: "Bronnen")[
  #for (name, source) in its [- *#name*\ #source]
]

/*
<div class="bs-ou-component-studyinstructions">
  <h2>Studeeraanwijzing(en)</h2>
  <ul>
    <li>[[Voeg hier de studeeraanwijzing toe]]</li>
  </ul>
</div>
*/
#let instruction(it) = ou-component("studyinstructions")[
  - #it
]

//// Meta components ///////////////////////////////////////////////////////////////////////////////

/*
<div class="bs-ou-component-learningobjectives">
  <h2>Leerdoelen</h2>
  <p>Na het afronden van dit onderdeel ben je in staat om:</p>
  <ul>
    <li>[[Leerdoel 1]]</li>
    <li>[[Leerdoel 2]]</li>
    <li>[[Leerdoel 3]]</li>
    <li>[[Leerdoel 4]]</li>
    <li>[[Leerdoel 5]]</li>
    <li>[[Leerdoel 6]]</li>
  </ul>
</div>
*/
#let goals(element: "leereenheid", it) = ou-component("learningobjectives")[ //, title: "Leerdoelen")[
  Na het bestuderen van deze #element wordt verwacht dat u:
  #it
]

#let materials = custom-block.with(icon: "")
#let chapter(chapter, authors, it) = materials[ //("instruction")[ //, title: "Aanwijzingen")[
  Bij deze leereenheid hoort hoofdstuk~#chapter van het tekstboek van #authors.
  #it
]

/*
<div class="bs-ou-component-studyload">
  <h2>Studiebelasting</h2>
  <p>De totale studiebelasting van deze cursus is [[Tijd]].</p>
</div>
*/
#let time(hours) = ou-component("studyload")[ //, title: "Belasting")[
  De totale studiebelasting van deze leereenheid bedraagt circa #hours uur.
  // De studielast van deze leereenheid is circa #hours uur.
]

//// Helper components /////////////////////////////////////////////////////////////////////////////

/*
<div class="bs-ou-component-inline-question-wrap">
  <h2>[[Vraag]]</h2>
  <p>[[Tekst]]</p>
  <ol>
    <li>[[Antwoordalternatief]]</li>
    <li>[[Antwoordalternatief]]</li>
    <li>[[Antwoordalternatief]]</li>
    <li>[[Antwoordalternatief]]</li>
  </ol>
  <div class="accordion bs-ou-component-inline-question">
    <div class="accordion-item">
      <div class="accordion-header collapser"><button class="accordion-button collapsed"></button></div>
      <div class="accordion-collapse collapse">
        <div class="accordion-body">
          <p>[[Antwoordalternatief]]</p>
        </div>
      </div>
    </div>
  </div>
</div>
*/
/// Gebruik in het geval van een meerkeuzevraag een geordende lijst om antwoordalternatieven aan te geven
#let question(it) = ou-component("inline-question-wrap")[
  #it
]

#let answer(it) = div-or-id(class: "accordion bs-ou-component-inline-question",
  div-or-id(class: "accordion-item",
    div-or-id(class: "accordion-header collapser", button-or-none(class: "accordion-button collapsed")) +
    div-or-id(class: "accordion-collapse collapse",
      div-or-id-with-par(class: "accordion-body")[
        #it
      ]
    )
  )
)

//// Block components //////////////////////////////////////////////////////////////////////////////

/*
<div class="bs-ou-component-case">
  <p>[[Voeg hier een casus in]]</p>
</div>
*/
#let exercise(caption: none, old: none, body, solution) = ou-block-gray(
  supplement: "Opdracht",
  caption: caption,// + if old != none [was #old],
  {
    body
    answer(solution)
  }
)

/*
<div class="bs-ou-component-accent">
  <h2>[[Titel]]</h2>
  <p>[[Voeg hier tekst toe]]</p>
</div>
*/
#let definition = ou-block-gray-accent.with(
  supplement: "Definitie",
)

/*
<div class="bs-ou-component-example">
  <h2>[[Titel]]</h2>
  <div class="example-wrapper">
    <p>[[Voeg hier tekst toe]]</p>
    <p>[[Afbeelding/Video]]</p>
  </div>
</div>
*/
#let example = ou-block-white-accent.with(
  supplement: "Voorbeeld",
)

#let accent = ou-block-gray-accent.with(
  supplement: "Belangrijk",
)


//// Old components ////////////////////////////////////////////////////////////////////////////////

// #let example(title: "", it) = ou-component-with-number(
//   kind: "example",
//   supplement: "Voorbeeld",
//   title: title,
// )
/*
<div class="bs-ou-component-coreconcept">
  <h2>Kernbegrip: [[Titel]]</h2>
  <p>[[Toelichting]]</p>
</div>
*/
#let concept-dont-use = ou-component.with("coreconcept", caption: [Studieconcept])


/*
<div class="bs-ou-component-studyskill">
  <h2>Studievaardigheid: [[Titel]]</h2>
  <p>[[Inhoud]]</p>
</div>
*/
#let skill-dont-use = ou-component.with("studyskill", caption: [Studievaardigheid])
