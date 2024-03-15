---
---

# The Third Project 

The goal of the third mini-project is to add G2P support for an unsupported language to [Epitran](https://github.com/dmort27/epitran) or another, comparable framemork. In addition to adding support for the language, you must construct a set of unit tests that guarantee correct behavior of the module/model under varied conditions.

## Possible Frameworks

Here are some frameworks/model classes that would be appropriate:

- [Epitran](https://github.com/dmort27/epitran)
- [Phonetisaurus](https://github.com/AdolfVonKleist/Phonetisaurus) 
- Other WFST framework
- LSTM/GRU/Transformer using PyTorch

For WFST and neural models, you are responsible for finding your own training data, though I may be able to help with Arabic.

## Sources of Information

For constructing a rule-based G2P with Epitran, you will need references. You should usually start with Wikipedia, not because the description of the sound-symbol mappings and rules there are necessarily accurate, but because it can point you to other, more authoritative, resources. **You can start with, but should not stop with, the tables in a Wikipedia article.

## Languages in Urgent Need for Epitran Support

The following languages are well-represented in the Mozilla Common Voice dataset but are not currently supported by Epitran (presenting a problem for corpus phonetics researchers). **I strongly urge you to choose one of these languages**.

- Afrikaans
- Assamese
- Basaa
- Breton
- Welsh
- Danish
- Dioula
- Esperanto
- Estonian
- Finnish
- Frisian
- Irish
- Galician
- Igbo
- Interlingua
- Icelandic
- Japanese
- Kabyle
- Latvian
- Lithuanian
- Latgalian
- Luganda
- Moksha
- Meadow Mari
- Hill Mari
- Western Sierra Puebla Nahuatl
- Norwegian Nynorsk
- Occitan
- Pashto
- Quechua Chanka
- Romansh Sursilvan
- Romansh Vallader
- Saraiki
- Slovenian
- Sardinian
- Serbian
- Tigre
- Toki Pona
- Twi
- Votic
- Cantonese
- Tamazight


## Some Major Languages without Epitran Support

If you really don't want to do one of the Common Voice languages, here are the top-50 languages (in terms of number of speakers) that are not in Epitran yet.

- Iranian Persian
- Western Punjabi
- Gujarati
- Kannada
- Bhojpuri
- Nigerian Pidgin
- Maithili
- Sindhi
- Nepali
- Northern Pashto
- Magahi
- Saraiki
- Afrikaans
- Chhattisgarhi
- Assamese
- Chittagonian
- Deccan
- Sadri
- Cameroonian Pidgin
- Sylheti
- Sunda
- Igbo
- Fulfulde
- Ramanankan
- Northern Sotho
- Southern Sotho
- Setswana
- Jula

## Instructions for Adding Epitran Support for a Language

## <a name='extending-epitran'></a>Extending Epitran with map files, preprocessors and postprocessors

Language support in Epitran is provided through map files, which define mappings between orthographic and phonetic units, preprocessors that run before the map is applied, and postprocessors that run after the map is applied. Maps are defined in UTF8-encoded, comma-delimited value (CSV) files. The files are each named `<iso639>-<iso15924>.csv` where `<iso639>` is the (three letter, all lowercase) ISO 639-3 code for the language and `<iso15924>` is the (four letter, capitalized) ISO 15924 code for the script. These files reside in the `data` directory of the Epitran installation under the `map`, `pre`, and `post` subdirectories, respectively. The pre- and post-processor files are text files whose format is described belown. They follow the same naming conventions except that they have the file extensions `.txt`.

### Map files (mapping tables)

The map files are simple, two-column files where the first column contains the orthgraphic characters/sequences and the second column contains the phonetic characters/sequences. The two columns are separated by a comma; each row is terminated by a newline. For many languages (most languages with unambiguous, phonemically adequate orthographies) just this easy-to-produce mapping file is adequate to produce a serviceable G2P system.

The first row is a header and is discarded. For consistency, it should contain the fields "Orth" and "Phon". The following rows by consist of fields of any length, separated by a comma. The same phonetic form (the second field) may occur any number of times but an orthographic form may only occur once. Where one orthograrphic form is a prefix of another form, the longer form has priority in mapping. In other words, matching between orthographic units and orthographic strings is greedy. Mapping works by finding the longest prefix of the orthographic form and adding the corresponding phonetic string to the end of the phonetic form, then removing the prefix from the orthographic form and continuing, in the same manner, until the orthographic form is consumed. If no non-empty prefix of the orthographic form is present in the mapping table, the first character in the orthographic form is removed and appended to the phonetic form. The normal sequence then resumes. This means that non-phonetic characters may end up in the "phonetic" form, which we judge to be better than losing information through an inadequate mapping table.

### Preprocesssors and postprocessors

For language-script pairs with more complicated orthographies, it is sometimes necessary to manipulate the orthographic form prior to mapping or to manipulate the phonetic form after mapping. This is done, in Epitran, with grammars of context-sensitive string rewrite rules. In truth, these rules would be more than adequate to solve the mapping problem as well but in practical terms, it is usually easier to let easy-to-understand and easy-to-maintain mapping files carry most of the weight of conversion and reserve the more powerful context sensitive grammar formalism for pre- and post-processing.

The preprocessor and postprocessor files have the same format. They consist of a sequence of lines, each consisting of one of four types:

1. Symbol definitions
2. Context-sensitive rewrite rules
3. Comments
4. Blank lines

#### Symbol definitions

Lines like the following


```
::vowels:: = a|e|i|o|u
```


define symbols that can be reused in writing rules. Symbols must consist of a prefix of two colons, a sequence of one or more lowercase letters and underscores, and a suffix of two colons. The are separated from their definitions by the equals sign (optionally set off with white space). The definition consists of a substring from a regular expression.

Symbols must be defined before they are referenced.

#### Rewrite rules

Context-sensitive rewrite rules in Epitran are written in a format familiar to phonologists but transparent to computer scientists. They can be schematized as


```
a -> b / X _ Y
```


which can be rewitten as


```
XaY → XbY
```


The arrow `->` can be read as "is rewritten as" and the slash `/` can be read as "in the context". The underscore indicates the position of the symbol(s) being rewritten. Another special symbol is the octothorp `#`, which indicates the beginning or end of a (word length) string (a word boundary). Consider the following rule:


```
e -> ə / _ #
```


This rule can be read as "/e/ is rewritten as /ə/ in the context at the end of the word." A final special symbol is zero `0`, which represents the empty string. It is used in rules that insert or delete segments. Consider the following rule that deletes /ə/ between /k/ and /l/:


```
ə　-> 0 / k _ l
```


All rules must include the arrow operator, the slash operator, and the underscore. A rule that applies in a context-free fashion can be written in the following way:


```
ch -> x / _
```


The implementation of context-sensitive rules in Epitran pre- and post-processors uses regular expression replacement. Specifically, it employs the `regex` package, a drop-in replacement for `re`. Because of this, regular expression notation can be used in writing rules:


```
c -> s / _ [ie]
```


or


```
c -> s / _ (i|e)
```


For a complete guide to `regex` regular expressions, see the documentation for [`re`](https://docs.python.org/2/library/re.html) and for [`regex`](https://pypi.python.org/pypi/regex), specifically.

Fragments of regular expressions can be assigned to symbols and reused throughout a file. For example, symbol for the disjunction of vowels in a language can be used in a rule that changes /u/ into /w/ before vowels:


```
::vowels:: = a|e|i|o|u
...
u -> w / _ (::vowels::)
```


There is a special construct for handling cases of metathesis (where "AB" is replaced with "BA"). For example, the rule:


```
(?P<sw1>[เแโไใไ])(?P<sw2>.) -> 0 / _
```


Will "swap" the positions of any character in "เแโไใไ" and any following character. Left of the arrow, there should be two groups (surrounded by parentheses) with the names `sw1` and `sw2` (a name for a group is specified by `?P<name>` appearing immediately after the open parenthesis for a group). The substrings matched by the two groups, `sw1` and `sw2` will be "swapped" or metathesized. The item immediately right of the arrow is ignored, but the context is not.


To move IPA tones to the end of the word, first ensure that tones=True in the instantiated Epitran object and use the following rule:
```
(?P<sw1>[˩˨˧˦˥]+)(?P<sw2>\w+) -> 0 / _\b
```


The rules apply in order, so earlier rules may "feed" and "bleed" later rules. Therefore, their sequence is *very important* and can be leveraged in order to achieve valuable results.

#### Comments and blank lines

Comments and blank lines (lines consisting only of white space) are allowed to make your code more readable. Any line in which the first non-whitespace character is a percent sign `%` is interpreted as comment. The rest of the line is ignored when the file is interpreted. Blank lines are also ignored.

### A strategy for adding language support

Epitran uses a mapping-and-repairs approach to G2P. It is expected that there is a mapping between graphemes and phonemes that can do most of the work of converting orthographic representations to phonological representations. In phonemically adequate orthogrphies, this mapping can do *all* of the work. This mapping should be completed first. For many languages, a basis for this mapping table already exists on [Wikipedia](http://www.wikipedia.org) and [Omniglot](http://www.omniglot.com) (though the Omniglot tables are typically not machine readable).

On the other hand, many writing systems deviate from the phonemically adequate idea. It is here that pre- and post-processors must be introduced. For example, in Swedish, the letter `<a>` receives a different pronunciation before two consonants (/ɐ/) than elsewhere (/ɑː/). It makes sense to add a preprocessor rule that rewrites `<a>` as /ɐ/ before two consonants (and similar rules for the other vowels, since they are affected by the same condition). Preprocessor rules should generally be employed whenever the orthographic representation must be adjusted (by contextual changes, deletions, etc.) prior to the mapping step.

One common use for postprocessors is to eliminate characters that are needed by the preprocessors or maps, but which should not appear in the output. A classic example of this is the virama used in Indic scripts. In these scripts, in order to write a consonant *not followed* by a vowel, one uses the form of the consonant symbol with particular inherent vowel followed by a virama (which has various names in different Indic languages). An easy way of handling this is to allow the mapping to translate the consonant into an IPA consonant + an inherent vowel (which, for a given language, will always be the same), then use the postprocessor to delete the vowel + virama sequence (wherever it occurs).

In fact, any situation where a character that is introduced by the map needs to be subsequently deleted is a good use-case for postprocessors. Another example from Indian languages includes so-called schwa deletion. Some vowels implied by a direct mapping between the orthography and the phonology are not actually pronounced; these vowels can generally be predicted. In most languages, they occur in the context after a vowel+consonant sequence and before a consonant+vowel sequence. In other words, the rule looks like the following:


```
ə -> 0 / (::vowel::)(::consonant::) _ (::consonant::)(::vowel::)
```


Perhaps the best way to learn how to structure language support for a new language is to consult the existing languages in Epitran. The French preprocessor `fra-Latn.txt` and the Thai postprocessor `tha-Thai.txt` illustrate many of the use-cases for these rules.

## Submitting Your Module

If you are submitting a module to Epitran, please create a pull request on the Epitran GitHub repo, with mapping file, preprocessor, postprocessor, and unit tests. When it is accepted, zip your files into an archive. and submit them to gradescope.

If you are taking an alternate route, please submit a README to gradescope with a link to a GitHub repo containing the source code for your project.

The project is due by **April 2, 2024 at 11:59pm**.