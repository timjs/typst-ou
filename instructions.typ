#import "/lib/book-toc.typ": contents, book, lookup-and-format

#let study-entire(section, except: none) = {
  // [Lees van deze paragraaf alle subparagrafen]
  [Bestudeer #lookup-and-format(section)]
  if type(except) == str [
    behalve #lookup-and-format(except).
  ]
  else if type(except) == array [
    behalve subparagrafen #except.map(lookup-and-format).intersperse([, ]).join().
  ]
  else [.]
}
#let study-from(section, till: none, next: false) = {
  [Bestudeer ]
  if next [vervolgens ]
  lookup-and-format(section)
  if till != none [ tot aan #lookup-and-format(till)]
  [.]
}

#let study-intro(section) = [
  Bestudeer in #book.authors de introductie van #lookup-and-format(section).
]
#let study-summary(section) = [
  Bestudeer de samenvatting in paragraaf #section.
]
#let study-main-text(section) = [
  Bestudeer van #lookup-and-format(section) de tekst in het boek.
  Het bijbehorende materiaal in de _Companion_ kunt u overslaan.
]

#let skip-entire(section) = [
  Sla #lookup-and-format(section) over, dit is geen tentamenstof.
]
#let skip-from(section, till: none) = [
  Sla #lookup-and-format(section) over.
]
#let skip-or-extra(section) = [
  De #lookup-and-format(section) is geen tentamenstof maar kunt u lezen ter verdieping.
]
#let skip-rest-or-extra() = [
  De rest van deze paragraaf is geen tentamenstof, maar kunt u lezen ter verdieping.
]