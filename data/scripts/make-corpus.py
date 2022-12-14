# make-corpus.py

import sys

args = sys.argv

def cut(fname):
    fin = open(fname, "r")
    f1 = open("raw-corpus/train.en", "w")
    f2 = open("raw-corpus/train.ja", "w")
    for line in fin:
        part = line.strip().split("\t")
        f1.write(part[3] + "\n")
        f2.write(part[4] + "\n")       
    fin.close()
    f1.close()
    f2.close()

if __name__ == '__main__':
    cut(args[1])