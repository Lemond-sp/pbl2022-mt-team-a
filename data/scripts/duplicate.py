from tqdm import tqdm
import argparse
from collections import defaultdict
# wc -l train.ja ---25740835 train.ja
# wc -l train_clear.ja --- 21891669 train_clear.ja
def parse_args():
    parser = argparse.ArgumentParser()
    parser.add_argument('--input', default="../raw-corpus/train")
    parser.add_argument('--output', default="../raw-corpus/train_clear")
    parser.add_argument('-s', '--src', default="ja")
    parser.add_argument('-t', '--tgt', default="en")
    args = parser.parse_args()
    return args
def main():
    opt = parse_args()
    with open(f"{opt.input}.{opt.src}") as f:
        all_input_src = f.readlines()
    with open(f"{opt.input}.{opt.tgt}") as f:
        all_input_tgt = f.readlines()
    MyDict = defaultdict(str)
    with open(f"{opt.output}.{opt.src}", "w") as src_f, open(f"{opt.output}.{opt.tgt}", "w") as tgt_f:
        pbar = tqdm(all_input_src, ncols=90, mininterval=0.5, ascii=True)
        for src_line, tgt_line in zip(pbar, all_input_tgt):
            if src_line in MyDict:
                tgt_list = MyDict[src_line].split("|||")
                if not tgt_line in tgt_list:
                    MyDict[src_line] += '|||' + tgt_line
                    src_f.write(src_line)
                    tgt_f.write(tgt_line)
            else:
                MyDict[src_line] = tgt_line
                src_f.write(src_line)
                tgt_f.write(tgt_line)
if __name__=="__main__":
    main()