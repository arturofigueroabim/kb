{
    "dataset_reader": {
        "type": "text_classification_json",
        "token_indexers": {
            "tokens": {
                "type": "single_id"
            }
        },
        "tokenizer": {
            "type": "word"
        },
        "segment_sentences": false,
        "max_sequence_length": 512,
        "skip_label_indexing": false,
        "lazy": false
    },
    "iterator": {
        "iterator": {
            "type": "basic",
            "batch_size": 32
        },
        "type": "self_attn_bucket",
        "batch_size_schedule": "base-12gb-fp32"
    },
    "model": {
        "model": {
            "type": "from_archive",
            "archive_file": "https://allennlp.s3-us-west-2.amazonaws.com/knowbert/models/knowbert_wiki_wordnet_model.tar.gz",
        },
        "type": "simple-classifier",
        "bert_dim": 768,
        "metric_a": {
            "type": "categorical_accuracy"
        },
        ": 2,
        "task": "classification"
    },
    "train_data_path": "/Users/arturofigueroa/PycharmProjects/kb/data/df_kb_train.jsonl",
    "validation_data_path": "/Users/arturofigueroa/PycharmProjects/kb/data/df_kb_validation.jsonl",
    "trainer": {
        "cuda_device": -1,
        "gradient_accumulation_batch_size": 32,
        "learning_rate_scheduler": {
            "type": "slanted_triangular",
            "num_epochs": 1,
            "num_steps_per_epoch": 169.75
        },
        "moving_average": {
            "decay": 0.95
        },
        "num_epochs": 1,
        "num_serialized_models_to_keep": 1,
        "optimizer": {
            "type": "bert_adam",
            "lr": 1e-05,
            "max_grad_norm": 1,
            "parameter_groups": [
                [
                    [
                        "bias",
                        "LayerNorm.bias",
                        "LayerNorm.weight",
                        "layer_norm.weight"
                    ],
                    {
                        "weight_decay": 0
                    }
                ]
            ],
            "t_total": -1,
            "weight_decay": 0.01
        },
        "should_log_learning_rate": true,
        "validation_metric": "+accuracy"
    },
    "vocabulary": {
        "directory_path": "https://allennlp.s3-us-west-2.amazonaws.com/knowbert/models/vocabulary_wordnet_wiki.tar.gz"
    }
}
