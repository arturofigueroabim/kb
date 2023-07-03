{
    "dataset_reader": {
        "type": "arg_classification_reader",
        "tokenizer_and_candidate_generator": {
            "type": "bert_tokenizer_and_candidate_generator",
            "bert_model_type": "bert-base-uncased",
            "do_lower_case": true,
            "entity_candidate_generators": {
                "wiki": {
                    "type": "wiki"
                },
                "wordnet": {
                    "type": "wordnet_mention_generator",
                    "entity_file": "~\\MasterThesis\\kb\\models\\knowbert_wiki_wordnet\\entities.jsonl"
                }
            },
            "entity_indexers": {
                "wiki": {
                    "type": "characters_tokenizer",
                    "namespace": "entity_wiki",
                    "tokenizer": {
                        "type": "word",
                        "word_splitter": {
                            "type": "just_spaces"
                        }
                    }
                },
                "wordnet": {
                    "type": "characters_tokenizer",
                    "namespace": "entity_wordnet",
                    "tokenizer": {
                        "type": "word",
                        "word_splitter": {
                            "type": "just_spaces"
                        }
                    }
                }
            }
        }
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
            "archive_file": "~\\MasterThesis\\kb\\models\\knowbert_wiki_wordnet\\knowbert_wiki_wordnet_model.tar.gz"
        },
        "type": "simple-classifier",
        "bert_dim": 768,
        "metric_a": {
            "type": "categorical_accuracy"
        },
        "num_labels": 2,
        "task": "classification"
    },
    "train_data_path": "~\\MasterThesis\\kb\\data\\train_adu\\train",
    "validation_data_path": "~\\MasterThesis\\kb\\data\\test_adu\\test",
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
        "directory_path": "~\\MasterThesis\\kb\\models\\knowbert_wiki_wordnet\\vocabulary_wordnet_wiki.tar.gz"
    }
}
