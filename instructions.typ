//TODO: factor out `lookup-title-and-format`
#import "/lib/basic/helpers.typ": match
#import "/lib/book-toc.typ": lookup-title, lookup-title-and-format, book,
#import "/lib/ou/components.typ"

//FIXME: shadows `content` type, but it doesn't have a constructor...
#let content(it) = [#it]

#let refer(kind, number, page) = {
  [#kind~#number op pagina~#page uit #book.authors]
}

#let see-also(section) = {
  [(zie ook #lookup-title-and-format(section))]
}

#let study(section, next: false, emphasize: false, till-excluding: none, till-including: none, except: none) = {
  [ Bestudeer]
  if next [ vervolgens]
  if emphasize [ wél]
  [ #lookup-title-and-format(section)]
  if till-excluding != none [ tot aan (dus zonder) #lookup-title-and-format(till-excluding)]
  if till-including != none [ tot aan het einde van #lookup-title-and-format(till-including)]
  if except != none {
    [ behalve]
    if type(except) == str   [ #lookup-title-and-format(except)]
    if type(except) == array [ #except.map(lookup-title-and-format).join([, ], last: [ en ])]
  }
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
#let study-companion-text(section, emphasize: false, chapter: none) = [
  Bestudeer van #lookup-title-and-format(section) #if emphasize [óók al] het materiaal van de #link(
    if chapter == none {"https://mlscott14627.github.io/PLP5e_online/companion/complete.pdf"}
      else {"https://mlscott14627.github.io/PLP5e_online/companion/chap_" + chapter + ".pdf"}
  )[_Companion_].
]


#let skip(section, parent: none, till: none, repetition: false, extra: false) = {
  [ Sla]
  if parent != none [ van #lookup-title-and-format(parent)]
  if type(section) == array [ #section.map(lookup-title-and-format).join(",", last: " en ")]
    else [ #lookup-title-and-format(section)]
  [ over]
  if till != none [ tot aan #lookup-title-and-format(till)]
  if repetition [, dit is herhaling maar kun je lezen als opfrisser]
    else [, dit is geen tentamenstof]
  if extra [ maar kun je lezen ter verdieping]
  [.]
}
#let skip-rest(kind: "paragraaf", extra: false) = {
  [ Sla de rest van deze #kind over, dit is geen tentamenstof]
  if extra [ maar kun je lezen ter verdieping]
  [.]
}

#let check-yourself(next: false, section: none, except: (), only: ()) = {
  if next [ Doe daarna hetzelfde met]
    else [ Controleer met behulp van]
  [ de _Check your understanding_ aan het einde van]
  if section == none [ deze paragraaf ]
    else [ #lookup-title-and-format(section)]
  if next [.]
    else [ of je de lesstof hebt begrepen.]

  if except.len() > 0 {
    if except.len() <= 1 [ Vraag #except.at(0)]
      else [ Vragen #except.map(content).join([, ], last: [ en ])]
    [ kun je overslaan, dit behoort niet tot de lesstof.]
  }

  if only.len() > 0 {
    [ Hiervan]
    if only.len() <= 1 [ is alleen vraag #only]
      else [ zijn alleen vragen #only.map(content).join([, ], last: [ en ])]
    [ relevant.]
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

  Echter bevat deze nog geen opdrachten. Die zullen we deze week toevoegen!
]

#let fourth-edition() = [
  Mocht je de 4e editie hebben van dit boek,
  dan kun je met gerust hart het oude hoofdstuk lezen,
  deze is op kleine verbeteringen hetzelfde als die in de 5e editie.
]
