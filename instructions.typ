//TODO: factor out `lookup-title-and-format`
#import "/lib/book-toc.typ": lookup-title, lookup-title-and-format
#import "/lib/ou/components.typ"

#let study-entire(section, except: none) = {
  // [Lees van deze paragraaf alle subparagrafen]
  [Bestudeer #lookup-title-and-format(section)]
  if type(except) == str [
    behalve #lookup-title-and-format(except)
  ] else if type(except) == array [
    behalve subparagrafen #except.map(lookup-title).intersperse([, ]).join()
  ]
  [.]
}
#let study-from(section, till: none, till-end: none, next: false) = {
  [Bestudeer ]
  if next [vervolgens ]
  lookup-title-and-format(section)
  if till != none [ tot aan #lookup-title-and-format(till)]
  if till-end != none [ tot aan het einde van #lookup-title-and-format(till-end)]
  [.]
}

#let study-intro(book, section) = [
  Bestudeer in #book.authors de introductie van #lookup-title-and-format(section).
]
#let study-summary(section) = [
  Bestudeer de samenvatting in paragraaf #section.
]
#let study-main-text(section) = [
  Bestudeer van #lookup-title-and-format(section) de tekst in het boek.
  Het bijbehorende materiaal in de _Companion_ kunt je overslaan.
]

#let skip-entire(section) = [
  Sla #lookup-title-and-format(section) over, dit is geen tentamenstof.
]
#let skip-or-extra(section) = [
  De #lookup-title-and-format(section) is geen tentamenstof maar kun je lezen ter verdieping.
]

#let skip-from(section, till: none) = [
  Sla #lookup-title-and-format(section) over.
]
#let skip-rest-or-extra() = [
  De rest van deze paragraaf is geen tentamenstof, maar kun je lezen ter verdieping.
]

#let check-yourself(section: none, except: ()) = {
  [Controleer met behulp van de _Check your understanding_ aan het einde van ]
  if section == none [deze paragraaf] else [#lookup-title-and-format(section)]
  [ of je de lesstof hebt begrepen.]
  if except.len() > 0 {
    if except.len() <= 1 [
      Vraag #except.at(0)
    ] else [
      Vragen #except.join(", ")
    ]
    [kun je overslaan, dit behoort niet tot de lesstof.]
  }
}

#let make-exercise(number, page, book) = [
  Maak Exercise #number op pagina #page uit #book.authors.
]

#let under-construction() = components.accent()[
  Deze cursussite is nog in ontwikkeling!
  Bij leereenheden die nog niet compleet zijn zul je deze waarschuwing terugvinden.
  Verwijzingen naar het tekstboek voegen wij de komende tijd stapsgewijs toe.
  Ook zullen wij de lesstof uitbreiden met meer opdrachten.
]
#let sections-follow() = [
  Verdere leeswijzer voor dit hoofdstuk volgt nog...
]
#let exercises-follow() = components.accent()[
  De lesstof op deze pagina is compleet is zal niet meer veranderen.

  Echter bevat deze nog geen opdrachten. Begin komende week zullen wij die toevoegen!
]

#let fourth-edition() = [
  Mocht je de 4e editie hebben van dit boek,
  dan kun je met gerust hart het oude hoofdstuk lezen,
  deze is op kleine verbeteringen hetzelfde als die in de 5e editie.
]
