#!/bin/bash
#MODEL=base or big
MODEL=base

mkdir -p ../../results/$MODEL/generate

fairseq-generate ../../data/clean250-bin \
        --path ../../results/$MODEL/checkpoints/checkpoint_best.pt \
        --batch-size 128 \
        --beam 5  > ../../results/$MODEL/generate/result.txt