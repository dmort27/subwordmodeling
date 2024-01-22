---
---

# The First Project

The goal of the first project is to develop a tokenizer—a morphological segmenter—that segments text from an arbitrary language more similarly to gold morpheme segmentations by a linguist than two baselines: a Morfessor baseline and a Unigram tokenization model. 

## The data

You will be provided with data from two languages:

- Rarámuri (Tahumara) [tar], an indigenous language of Northern Mexico that is part of the Uto-Aztecan language family.
- Shipibo-Konibo [shp], a Panoan language of the Peruvian Amazon.

For each language, for each set (train, dev, and test), you will be provided with a source file. You will be provided the target file for the dev set\sidenote{The train and test target file will be held out.} The source file will consist of unsegmented words, one per line. The target fill will consist of the same words in the same order, but with the morphemes delimited by spaces, as shown below.
- `src: ointiyamaai`
- `tgt: ointi yama ai`

# The task

The goal is the reproduce the reference target given the source and a model trained on the (source side of the) training set. This can be seen an a sequence labeling task in which your model must decide whether a character is the beginning of a new span (morpheme) or the continuation of an existing span. Because of allomorphy in the data that is reduced to an underlying representation (see the lecture notes on allomorphy), we decided that it was unfair to simply score based on a sequence labeling paradigm. Instead, you will be scored based on precision/recall/F1 on a “bag of tokens.”

# Baselines

- **Morfessor (data-driven).** For each language, the Morfessor morphological segmentation algorithm will be applied. This algorithm, which is reasonably complicated, is designed to yield segmentations that resemble morpheme segemntations used by linguists.
- **Unigram (data-driven).** For each language, a Unigram model will be trained on the training set. If other unlabeled text data can be found, it will be used as well (and shared with you). You will be provided with the Unigram tokenizer output for the dev set.
