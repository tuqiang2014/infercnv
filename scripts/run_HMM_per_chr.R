#!/usr/bin/env Rscript

suppressPackageStartupMessages(library("argparse"))
    
parser = ArgumentParser()
parser$add_argument("--infercnv_obj", help="infercnv_obj file", required=TRUE, nargs=1)
args = parser$parse_args()

library(infercnv)
library(ggplot2)
library(futile.logger)

infercnv_obj_file = args$infercnv_obj

infercnv_obj = readRDS(infercnv_obj_file)

pdf('ladeda.pdf')
infercnv_obj.hmm = infercnv:::predict_CNV_via_HMM_each_chr_separately(infercnv_obj)

saveRDS(infercnv_obj.hmm, file=sprintf("%s-HMM.obj", infercnv_obj_file))

plot_cnv(infercnv_obj.hmm, output_filename=paste0(infercnv_obj_file, "-HMM"))

