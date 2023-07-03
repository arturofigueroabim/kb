import csv
from typing import Iterable
from allennlp.data.dataset_readers.dataset_reader import DatasetReader
from allennlp.data.fields import LabelField, TextField
from allennlp.data.instance import Instance
from kb.bert_tokenizer_and_candidate_generator import TokenizerAndCandidateGenerator
from allennlp.common.file_utils import cached_path


@DatasetReader.register("arg_classification_reader")
class ArgumentClassificationReader(DatasetReader):
    def __init__(self,
                 tokenizer_and_candidate_generator: TokenizerAndCandidateGenerator,
                 entity_markers: bool = False):
        super().__init__()
        self.label_to_index = {'0': 0, '1': 1}
        self.tokenizer = tokenizer_and_candidate_generator

    def _read(self, file_path: str) -> Iterable[Instance]:
        """Creates examples for the training and dev sets."""

        with open(cached_path(file_path + '.gold.txt'), 'r', encoding='utf-8') as f:
            labels = f.read().split()

        with open(cached_path(file_path + '.data.txt'), 'r', encoding='utf-8') as f:
            sentences = f.read().splitlines()
            assert len(labels) == len(sentences), 'The length of the labels and sentences must match.'

            for sentence, label in zip(sentences, labels):
                token_candidates = self.tokenizer.tokenize_and_generate_candidates(sentence)
                fields = self.tokenizer.convert_tokens_candidates_to_fields(token_candidates)
                fields['label'] = LabelField(self.label_to_index[label], skip_indexing=True)
                yield Instance(fields)
