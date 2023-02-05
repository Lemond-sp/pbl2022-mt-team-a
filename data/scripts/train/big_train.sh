#!/bin/bash

mkdir -p ../../results/big/

CUDA_VISIBLE_DEVICES=0,1,2,3 fairseq-train \
        ../../data/clean250-bin \
		    --arch transformer \
		    --encoder-layers 6 --encoder-embed-dim 1024 --encoder-ffn-embed-dim 4096 \
		    --decoder-layers 6 --decoder-embed-dim 1024 --decoder-ffn-embed-dim 4096 \
			--ddp-backend=no_c10d \
        --encoder-attention-heads 16 --decoder-attention-heads 16 \
		    --optimizer adam --adam-betas '(0.9,0.98)' \
		    --reset-optimizer --reset-dataloader --reset-meters \
		    --lr 0.0005 --lr-scheduler inverse_sqrt --warmup-init-lr 1e-07 --warmup-updates 4000 \
		    --dropout 0.3 --weight-decay 0.001 --clip-norm 1.0 \
		    --criterion label_smoothed_cross_entropy --label-smoothing 0.1 \
		    --max-tokens 100 --update-freq 50 \
		    --max-update 24000 \
		    --fp16 \
		    --save-interval-updates 200 --validate-interval-updates 200 \
		    --keep-interval-updates 20 --no-epoch-checkpoints \
				--patience 10 \
				--best-checkpoint-metric bleu --maximize-best-checkpoint-metric \
				--eval-bleu \
				--eval-bleu-print-samples \
				--eval-bleu-args '{"beam": 5, "lenpen": 1.0}' \
				--eval-bleu-detok space \
				--eval-bleu-remove-bpe=sentencepiece \
        --save-dir ../../results/big/checkpoints/ | tee -a ../../results/big/train.log