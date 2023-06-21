from typing import Iterator, List, Dict
import torch
from allennlp.data import DatasetReader, Instance
from allennlp.data.fields import TextField, LabelField
from allennlp.data.token_indexers import TokenIndexer, SingleIdTokenIndexer
from allennlp.data.tokenizers import Token

@DatasetReader.register("arg_classification_reader")
class ArgumentClassificationReader(DatasetReader):
    def __init__(self, token_indexers: Dict[str, TokenIndexer] = None) -> None:
        super().__init__(lazy=False)
        self.token_indexers = token_indexers or {"tokens": SingleIdTokenIndexer()}

    def text_to_instance(self, tokens: List[Token], label: str = None) -> Instance:
        text_field = TextField(tokens, self.token_indexers)
        fields = {"text": text_field}

        if label:
            fields["label"] = LabelField(label)

        return Instance(fields)

    def _read(self, file_path: str) -> Iterator[Instance]:
        with open(file_path, "r") as file:
            reader = csv.reader(file)
            next(reader)  # Skip header
            for row in reader:
                text, label = row
                tokens = [Token(word) for word in text.split()]
                yield self.text_to_instance(tokens, label)
