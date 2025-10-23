#import "/lib/basic/helpers.typ": *

#let div-or-id(class: "", it) = context {
  (if target() == "html" {html.div.with(class: class)} else {identity})(it)
}
#let button-or-none(class: "") = context {
  if target() == "html" {html.button(class: class)}
}

// Notes:
// - We need to make sure to add a `parbreak` to force Typst to make a (single) paragraph.
#let component(class: "", title: none, it) = div-or-id(class: class)[
  #if title != none [=== #title]
  #it
  #parbreak()
]
#let ou-component(class: "accent", title: none, it) = component(class: "bs-ou-component-" + class, title: title, it)
#let ou-block(prefix: "", title: "", it) = ou-component(
  class: "case",
  title: prefix + " " + title,
  it,
)


//// Study components ////

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
#let sources(optional: false, title: "Bronnen", its) = ou-component(class: "sources" + if optional {" optional"} else {""}, title: title,
  for (name, source) in its [- *#name*\ #source]
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
// #let example = compose(ou-component.with(class: "example"), component.with(class: "example-wrapper"))
#let example = ou-block.with(prefix: "Voorbeeld")

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
#let question = ou-component.with(class: "inline-question-wrap")

#let answer(it) = div-or-id(class: "accordion bs-ou-component-inline-question",
  div-or-id(class: "accordion-item",
    div-or-id(class: "accordion-header collapser", button-or-none(class: "accordion-button collapsed")) +
    div-or-id(class: "accordion-collapse collapse",
      div-or-id(class: "accordion-body",
        it
      )
    )
  )
)

/*
<div class="bs-ou-component-studyinstructions">
  <h2>Studeeraanwijzing(en)</h2>
  <ul>
    <li>[[Voeg hier de studeeraanwijzing toe]]</li>
  </ul>
</div>
*/
#let instruction(it) = ou-component(class: "studyinstructions", [- #it])

/*
<div class="bs-ou-component-instruction">
  <h2>Instructie</h2>
  <p>[[Voeg hier de instructie in]]</p>
</div>
*/
#let instruction-rename = ou-component.with(class: "instruction", title: "Instructie")

/*
<div class="bs-ou-component-case">
  <p>[[Voeg hier een casus in]]</p>
</div>
*/
/// TODO: rename?
#let exercise(title: "", old: none, it) = ou-block(
  prefix: "Opdracht",
  title: title + if old != none [(was #old)],
  it
)

/*
<div class="bs-ou-component-accent">
  <h2>[[Titel]]</h2>
  <p>[[Voeg hier tekst toe]]</p>
</div>
*/
#let emphasize = ou-component.with(class: "accent")

/*
<div class="bs-ou-component-coreconcept">
  <h2>Kernbegrip: [[Titel]]</h2>
  <p>[[Toelichting]]</p>
</div>
*/
#let concept = ou-component.with(class: "coreconcept")

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
#let objectives = ou-component.with(class: "learningobjectives", title: "Leerdoelen")


/*
<div class="bs-ou-component-studyload">
  <h2>Studiebelasting</h2>
  <p>De totale studiebelasting van deze cursus is [[Tijd]].</p>
</div>
*/
#let load = ou-component.with(class: "studyload", title: "Studiebelasting")

/*
<div class="bs-ou-component-studyskill">
  <h2>Studievaardigheid: [[Titel]]</h2>
  <p>[[Inhoud]]</p>
</div>
*/
#let skill = ou-component.with(class: "studyskill", title: "Studievaardigheid")
