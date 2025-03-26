---
---

# The Fourth Project: Cognate Detection

## Due: April 10th, 2025

Cognates are pairs of words that are descended from the same word in an language directly ancestral to the two languages from which the pairs are drawn. These are to be distinguished from loanwords (or *borrowings*), which are “borrowed” into one language from a another language. Borrowing is like adoption and the relationship between cognates is like tha between blood siblings.

Im this project, you will build a model to automatically identify cognates. You will be given data from four closely-related languages:

- Ukhrul (Tankghul)
- Kachai
- Huishu
- Tusom

These are Tibeto-Burman languages spoken in the northeast corner of Manipur State, in Northeast India. They diverged around 500–1000 years ago, and their phonologies are quite different, but it is still possible to identify cognates if you know what you're looking for.

## The Datasets

Each dataset will contain a list of Ukhrul words tha have cognates in the other language (form and gloss [=translation]) and a list of all of the words in the other language that I have collected (form and gloss).

Sets will be provided as tab-delimited files. Each set will have at least two files (one for Ukrhul and one for the other language) with two columns (form and gloss). The gold labels will be provided as a single-column file with the same number of rows as the Ukrhul file in which there is the form cognate to the Ukhrul form.

You will be provided with the following sets:

- Ukhrul–Huishu (development data with gold cognacy judgements)
- Ukhrul–Tusom
- Ukrhul–Kachai

The data is in [student_dataset.zip](https://github.com/user-attachments/files/19460386/student_dataset.zip)


## The Task

The task will be to generate a tab-separated file with ten columns correspoding to the top five most likely cognates (forms and glosses) in the other langugae to the corresponding Ukhrul word (the nth row consists of the top-five best cognate candidates for the nth Ukhrul word). The best candidate should be in the first-second column, the second best candidate should be in the third-fourth column, and so on.

The format should look like this:
```
[FORM1]\t[GLOSS1]\t[FORM2]\[GLOSS2]...[FORM5]\t[GLOSS5]\n
```

## Baseline

The baseline system takes the phonological similarity and semantic similarity of the candidate cognates into account. It uses a simple method of producing phonological embeddings that is based upon the tf-idf of IPA character 1-, 2-, and 3-grams. The algorithm simply ranks words according to the cosine similarity of their embeddings. The semantic similarity metric is “exact match on the gloss.” If the glosses of the Ukhrul word and the candidate match completely, `1` is added to the score. Otherwise `0` is added to the score.

The baseline code is here: https://colab.research.google.com/drive/1Duh7ZU7oSDNEvXckpG9sWUUjxr892XFX?usp=sharing

The baseline scores are as follows:

|---------------|----------------------|
| Language Pair | Mean Reciprocal Rank |
|---------------| -------------------: |
| Ukhrul-Huishu |                 0.61 |
| Ukhrul-Kachai |                 0.66 |
| Ukhrul-Tusom  |                 0.42 |
|---------------|----------------------|

## Evaluation

Results will be evaluated with [Mean Reciprocal Rank](https://en.wikipedia.org/wiki/Mean_reciprocal_rank). The reciprocal rank of a query response (candidate cognates) is the multiplicative inverse of the first correct answer. If the first answer is correct, is 1; if the second answer is correct, it is 1/2, if the third is correct, it is 1/2. If none of the answers is correct, it is 0. The formula is as follows:

{::nomarkdown}
<svg xmlns:xlink="http://www.w3.org/1999/xlink" width="23.441ex" height="7.676ex" style="vertical-align: -3.005ex; margin-right: -0.204ex;" viewBox="0 -2011.3 10092.7 3304.9" role="img" focusable="false" xmlns="http://www.w3.org/2000/svg" aria-labelledby="MathJax-SVG-1-Title">
<title id="MathJax-SVG-1-Title">{\displaystyle {\text{MRR}}={\frac {1}{|Q|}}\sum _{i=1}^{|Q|}{\frac {1}{{\text{rank}}_{i}}}.\!}</title>
<defs aria-hidden="true">
<path stroke-width="1" id="E1-MJMAIN-4D" d="M132 622Q125 629 121 631T105 634T62 637H29V683H135Q221 683 232 682T249 675Q250 674 354 398L458 124L562 398Q666 674 668 675Q671 681 683 682T781 683H887V637H854Q814 636 803 634T785 622V61Q791 51 802 49T854 46H887V0H876Q855 3 736 3Q605 3 596 0H585V46H618Q660 47 669 49T688 61V347Q688 424 688 461T688 546T688 613L687 632Q454 14 450 7Q446 1 430 1T410 7Q409 9 292 316L176 624V606Q175 588 175 543T175 463T175 356L176 86Q187 50 261 46H278V0H269Q254 3 154 3Q52 3 37 0H29V46H46Q78 48 98 56T122 69T132 86V622Z"></path>
<path stroke-width="1" id="E1-MJMAIN-52" d="M130 622Q123 629 119 631T103 634T60 637H27V683H202H236H300Q376 683 417 677T500 648Q595 600 609 517Q610 512 610 501Q610 468 594 439T556 392T511 361T472 343L456 338Q459 335 467 332Q497 316 516 298T545 254T559 211T568 155T578 94Q588 46 602 31T640 16H645Q660 16 674 32T692 87Q692 98 696 101T712 105T728 103T732 90Q732 59 716 27T672 -16Q656 -22 630 -22Q481 -16 458 90Q456 101 456 163T449 246Q430 304 373 320L363 322L297 323H231V192L232 61Q238 51 249 49T301 46H334V0H323Q302 3 181 3Q59 3 38 0H27V46H60Q102 47 111 49T130 61V622ZM491 499V509Q491 527 490 539T481 570T462 601T424 623T362 636Q360 636 340 636T304 637H283Q238 637 234 628Q231 624 231 492V360H289Q390 360 434 378T489 456Q491 467 491 499Z"></path>
<path stroke-width="1" id="E1-MJMAIN-3D" d="M56 347Q56 360 70 367H707Q722 359 722 347Q722 336 708 328L390 327H72Q56 332 56 347ZM56 153Q56 168 72 173H708Q722 163 722 153Q722 140 707 133H70Q56 140 56 153Z"></path>
<path stroke-width="1" id="E1-MJMAIN-31" d="M213 578L200 573Q186 568 160 563T102 556H83V602H102Q149 604 189 617T245 641T273 663Q275 666 285 666Q294 666 302 660V361L303 61Q310 54 315 52T339 48T401 46H427V0H416Q395 3 257 3Q121 3 100 0H88V46H114Q136 46 152 46T177 47T193 50T201 52T207 57T213 61V578Z"></path>
<path stroke-width="1" id="E1-MJMAIN-7C" d="M139 -249H137Q125 -249 119 -235V251L120 737Q130 750 139 750Q152 750 159 735V-235Q151 -249 141 -249H139Z"></path>
<path stroke-width="1" id="E1-MJMATHI-51" d="M399 -80Q399 -47 400 -30T402 -11V-7L387 -11Q341 -22 303 -22Q208 -22 138 35T51 201Q50 209 50 244Q50 346 98 438T227 601Q351 704 476 704Q514 704 524 703Q621 689 680 617T740 435Q740 255 592 107Q529 47 461 16L444 8V3Q444 2 449 -24T470 -66T516 -82Q551 -82 583 -60T625 -3Q631 11 638 11Q647 11 649 2Q649 -6 639 -34T611 -100T557 -165T481 -194Q399 -194 399 -87V-80ZM636 468Q636 523 621 564T580 625T530 655T477 665Q429 665 379 640Q277 591 215 464T153 216Q153 110 207 59Q231 38 236 38V46Q236 86 269 120T347 155Q372 155 390 144T417 114T429 82T435 55L448 64Q512 108 557 185T619 334T636 468ZM314 18Q362 18 404 39L403 49Q399 104 366 115Q354 117 347 117Q344 117 341 117T337 118Q317 118 296 98T274 52Q274 18 314 18Z"></path>
<path stroke-width="1" id="E1-MJSZ2-2211" d="M60 948Q63 950 665 950H1267L1325 815Q1384 677 1388 669H1348L1341 683Q1320 724 1285 761Q1235 809 1174 838T1033 881T882 898T699 902H574H543H251L259 891Q722 258 724 252Q725 250 724 246Q721 243 460 -56L196 -356Q196 -357 407 -357Q459 -357 548 -357T676 -358Q812 -358 896 -353T1063 -332T1204 -283T1307 -196Q1328 -170 1348 -124H1388Q1388 -125 1381 -145T1356 -210T1325 -294L1267 -449L666 -450Q64 -450 61 -448Q55 -446 55 -439Q55 -437 57 -433L590 177Q590 178 557 222T452 366T322 544L56 909L55 924Q55 945 60 948Z"></path>
<path stroke-width="1" id="E1-MJMATHI-69" d="M184 600Q184 624 203 642T247 661Q265 661 277 649T290 619Q290 596 270 577T226 557Q211 557 198 567T184 600ZM21 287Q21 295 30 318T54 369T98 420T158 442Q197 442 223 419T250 357Q250 340 236 301T196 196T154 83Q149 61 149 51Q149 26 166 26Q175 26 185 29T208 43T235 78T260 137Q263 149 265 151T282 153Q302 153 302 143Q302 135 293 112T268 61T223 11T161 -11Q129 -11 102 10T74 74Q74 91 79 106T122 220Q160 321 166 341T173 380Q173 404 156 404H154Q124 404 99 371T61 287Q60 286 59 284T58 281T56 279T53 278T49 278T41 278H27Q21 284 21 287Z"></path>
<path stroke-width="1" id="E1-MJMAIN-72" d="M36 46H50Q89 46 97 60V68Q97 77 97 91T98 122T98 161T98 203Q98 234 98 269T98 328L97 351Q94 370 83 376T38 385H20V408Q20 431 22 431L32 432Q42 433 60 434T96 436Q112 437 131 438T160 441T171 442H174V373Q213 441 271 441H277Q322 441 343 419T364 373Q364 352 351 337T313 322Q288 322 276 338T263 372Q263 381 265 388T270 400T273 405Q271 407 250 401Q234 393 226 386Q179 341 179 207V154Q179 141 179 127T179 101T180 81T180 66V61Q181 59 183 57T188 54T193 51T200 49T207 48T216 47T225 47T235 46T245 46H276V0H267Q249 3 140 3Q37 3 28 0H20V46H36Z"></path>
<path stroke-width="1" id="E1-MJMAIN-61" d="M137 305T115 305T78 320T63 359Q63 394 97 421T218 448Q291 448 336 416T396 340Q401 326 401 309T402 194V124Q402 76 407 58T428 40Q443 40 448 56T453 109V145H493V106Q492 66 490 59Q481 29 455 12T400 -6T353 12T329 54V58L327 55Q325 52 322 49T314 40T302 29T287 17T269 6T247 -2T221 -8T190 -11Q130 -11 82 20T34 107Q34 128 41 147T68 188T116 225T194 253T304 268H318V290Q318 324 312 340Q290 411 215 411Q197 411 181 410T156 406T148 403Q170 388 170 359Q170 334 154 320ZM126 106Q126 75 150 51T209 26Q247 26 276 49T315 109Q317 116 318 175Q318 233 317 233Q309 233 296 232T251 223T193 203T147 166T126 106Z"></path>
<path stroke-width="1" id="E1-MJMAIN-6E" d="M41 46H55Q94 46 102 60V68Q102 77 102 91T102 122T103 161T103 203Q103 234 103 269T102 328V351Q99 370 88 376T43 385H25V408Q25 431 27 431L37 432Q47 433 65 434T102 436Q119 437 138 438T167 441T178 442H181V402Q181 364 182 364T187 369T199 384T218 402T247 421T285 437Q305 442 336 442Q450 438 463 329Q464 322 464 190V104Q464 66 466 59T477 49Q498 46 526 46H542V0H534L510 1Q487 2 460 2T422 3Q319 3 310 0H302V46H318Q379 46 379 62Q380 64 380 200Q379 335 378 343Q372 371 358 385T334 402T308 404Q263 404 229 370Q202 343 195 315T187 232V168V108Q187 78 188 68T191 55T200 49Q221 46 249 46H265V0H257L234 1Q210 2 183 2T145 3Q42 3 33 0H25V46H41Z"></path>
<path stroke-width="1" id="E1-MJMAIN-6B" d="M36 46H50Q89 46 97 60V68Q97 77 97 91T97 124T98 167T98 217T98 272T98 329Q98 366 98 407T98 482T98 542T97 586T97 603Q94 622 83 628T38 637H20V660Q20 683 22 683L32 684Q42 685 61 686T98 688Q115 689 135 690T165 693T176 694H179V463L180 233L240 287Q300 341 304 347Q310 356 310 364Q310 383 289 385H284V431H293Q308 428 412 428Q475 428 484 431H489V385H476Q407 380 360 341Q286 278 286 274Q286 273 349 181T420 79Q434 60 451 53T500 46H511V0H505Q496 3 418 3Q322 3 307 0H299V46H306Q330 48 330 65Q330 72 326 79Q323 84 276 153T228 222L176 176V120V84Q176 65 178 59T189 49Q210 46 238 46H254V0H246Q231 3 137 3T28 0H20V46H36Z"></path>
<path stroke-width="1" id="E1-MJMAIN-2E" d="M78 60Q78 84 95 102T138 120Q162 120 180 104T199 61Q199 36 182 18T139 0T96 17T78 60Z"></path>
</defs>
<g stroke="currentColor" fill="currentColor" stroke-width="0" transform="matrix(1 0 0 -1 0 0)" aria-hidden="true">
 <use xlink:href="#E1-MJMAIN-4D"></use>
 <use xlink:href="#E1-MJMAIN-52" x="917" y="0"></use>
 <use xlink:href="#E1-MJMAIN-52" x="1654" y="0"></use>
 <use xlink:href="#E1-MJMAIN-3D" x="2668" y="0"></use>
<g transform="translate(3724,0)">
<g transform="translate(120,0)">
<rect stroke="none" width="1468" height="60" x="0" y="220"></rect>
 <use xlink:href="#E1-MJMAIN-31" x="484" y="676"></use>
<g transform="translate(60,-771)">
 <use xlink:href="#E1-MJMAIN-7C" x="0" y="0"></use>
 <use xlink:href="#E1-MJMATHI-51" x="278" y="0"></use>
 <use xlink:href="#E1-MJMAIN-7C" x="1070" y="0"></use>
</g>
</g>
</g>
<g transform="translate(5599,0)">
 <use xlink:href="#E1-MJSZ2-2211" x="0" y="0"></use>
<g transform="translate(147,-1090)">
 <use transform="scale(0.707)" xlink:href="#E1-MJMATHI-69" x="0" y="0"></use>
 <use transform="scale(0.707)" xlink:href="#E1-MJMAIN-3D" x="345" y="0"></use>
 <use transform="scale(0.707)" xlink:href="#E1-MJMAIN-31" x="1124" y="0"></use>
</g>
<g transform="translate(245,1238)">
 <use transform="scale(0.707)" xlink:href="#E1-MJMAIN-7C" x="0" y="0"></use>
 <use transform="scale(0.707)" xlink:href="#E1-MJMATHI-51" x="278" y="0"></use>
 <use transform="scale(0.707)" xlink:href="#E1-MJMAIN-7C" x="1070" y="0"></use>
</g>
</g>
<g transform="translate(7210,0)">
<g transform="translate(120,0)">
<rect stroke="none" width="2442" height="60" x="0" y="220"></rect>
 <use xlink:href="#E1-MJMAIN-31" x="970" y="676"></use>
<g transform="translate(60,-716)">
 <use xlink:href="#E1-MJMAIN-72"></use>
 <use xlink:href="#E1-MJMAIN-61" x="392" y="0"></use>
 <use xlink:href="#E1-MJMAIN-6E" x="893" y="0"></use>
 <use xlink:href="#E1-MJMAIN-6B" x="1449" y="0"></use>
 <use transform="scale(0.707)" xlink:href="#E1-MJMATHI-69" x="2797" y="-213"></use>
</g>
</g>
</g>
 <use xlink:href="#E1-MJMAIN-2E" x="9893" y="0"></use>
</g>
</svg>
{:/}

The function used for evaluation is as follows:

```python
def mean_reciprocal_rank(gold, inputs, preds):
  total = []
  for idx, inp in enumerate(inputs):
    if gold["\t".join(inp)] in preds[idx][:5]:
      total.append(1.0 / (preds[idx].index(gold["\t".join(inp)]) + 1))

  return sum(total) / len(total)
```

You will upload your outputs to Gradescope with the names:

- `ukhrul-tusom_out.tsv`
- `ukhrul-kachai_out.tsv`
