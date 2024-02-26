---
---

# The Second Project

The goal of the second project is to generate the inflectional forms of verbs for Karbardian (kbd), Swahili (swc), and Mixtec (sty) from roots + inflectional information better than non-neural and neural baselines. 

## The data
You willl be provided with data from three languages:
* Kabardian [kbd], a language primarily spoken in the North Caucases and written in Cyrillic.
* Swahili [swc], a language primarily spoken along the East African coast and written in a Latin script.
* Mixtec [xty], a language primarily spoken in Mexico and written in a Latin script in our dataset.

For each language, you will be provided with train, dev, and test files. Files are formatted in the unimorph standard, with the exception of the testset where the correct forms are ommitted:
`[ROOT] ([CORRECT]) [INFLECTION]`

## The task

You are expected to produce correct inflected forms for each line in the testset. Please name your files as `{lang}.txt` - i.e. `kbd.txt` - for submission to the autograder. You submission will be a list of generated forms seperated by newlines for each language. 
The baseline scores to beat are as follows:

| Language | Non-Neural Accuracy | Neural Accuracy |
| -------- | ------------------- | --------------- |
| kbd      | 88.5                | 67.6            |
| swc      | 72.3                | 0.95            |
| xty      | 73.5                | 79.8            |

Code to reproduce the baselines can be found [here](https://colab.research.google.com/drive/1nskoaUtxGfzk4GWqVJQUG2DSA-XsmSon?usp=sharing).
