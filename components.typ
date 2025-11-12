#import "/lib/basic/helpers.typ": *

/// We need some way to print contents of a `div` when we're *not* exporting to Html,
/// that's what `div-or-id` is for.
#let div-or-id(class: none, it) = context {
  (if target() == "html" {html.div.with(class: class)} else {identity})(it)
}
#let button-or-none(class: none) = context {
  if target() == "html" {html.button(class: class)}
}
/// We need to make sure to add a `parbreak` to force Typst to make a (single) paragraph.
#let div-or-id-with-par(class: none, it) = div-or-id(class: class)[
  #it
  #parbreak()
]

// #let ou-component(kind, title: none, it) = div-or-id-with-par(class: "bs-ou-component-" + kind)[
#let ou-component(kind, it) = div-or-id-with-par(class: "bs-ou-component-" + kind, it)
/// A block of `kind` styled by the OU
///
/// / `kind`: can be anything the OU provides as `bs-ou-component-X`
/// / `wrapper`: a wrapper function to put the body in
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
#let ou-block(kind, supplement: none, caption: none, wrapper: identity, it) = ou-component(
  kind,
  wrapper[
    #if supplement != none [=== #supplement #if caption != none [(#caption)]]
    #it
  ]
)

#let ou-block-white = ou-block.with("")
#let ou-block-white-accent = ou-block.with("example", wrapper: div-or-id-with-par.with(class: "example-wrapper"))
#let ou-block-gray = ou-block.with("case")
#let ou-block-gray-accent = ou-block.with("accent")


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
#let objectives(it) = ou-component("learningobjectives")[ //, title: "Leerdoelen")[
  Na het bestuderen van deze leereenheid wordt verwacht dat u:
  #it
]

/*
<div class="bs-ou-component-instruction">
  <h2>Instructie</h2>
  <p>[[Voeg hier de instructie in]]</p>
</div>
*/
#let directions(chapter, authors, it) = ou-component("instruction")[ //, title: "Aanwijzingen")[
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
