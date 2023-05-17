---
---

# The First Project

The goal of the first project is to develop a tokenizer—a morphological segmenter—that segments text from an arbitrary language more similarly to gold morpheme segmentations by a linguist than two baselines: a rule-based (FST) baseline and a Unigram tokenization model. 

## The data

You will be provided with data from two languages:

- Rarámuri (Tahumara) [tar], an indigenous language of Northern Mexico that is part of the Uto-Aztecan language family.
- Shipibo-Konibo [shp], a Panoan language of the Peruvian Amazon.

For each language, for each set (train, dev, and test), you will be provided with a source file. You will be provided the target file for the dev set\sidenote{The train and test target file will be held out.} The source file will consist of unsegmented words, one per line. The target fill will consist of the same words in the same order, but with the morphemes delimited by spaces, as shown below.
- `src: ointiyamaai`
- `tgt: ointi yama ai`

# The task

The goal is the reproduce the reference target given the source and a model trained on the (source side of the) training set. This can be seen an a sequence labeling task in which your model must decide whether a character is the beginning of a new span (morpheme) or the continuation of an existing span. There are other ways of viewing the task, but evaluation (in terms of precision/recall/F1) will be based on this paradigm. Labeling a character as “beginning” will be treated as a positive and not labeling it as such will be treated as a negative.

# Baselines

As will often be the case in this course, there will be two baselines: one data-driven and one rule-based.

- **FST (rule-based).** For each language, there will be a hand-crafted finite-state transducer based segmentation model. This model will be based on linguist analysis of the data and secondary literature on the morphology (word structure) of the language. You will be provided with access to the FST outputs for the dev set.
- **Unigram (data-driven).** For each language, a Unigram model will be trained on the training set. If other unlabeled text data can be found, it will be used as well (and shared with you). You will be provided with the Unigram tokenizer output for the dev set.
