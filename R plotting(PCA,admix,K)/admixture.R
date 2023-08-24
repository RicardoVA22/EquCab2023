source("//wsl.localhost/Ubuntu/root/results/ancestry/visFuns2.R")

plot_evalAdmix <- function(Q_file, R_file) {
  pop <- read.table("//wsl.localhost/Ubuntu/root/results/ancestry/new_data_15/ref_chr2_prun_15_PCA.fam")
  q <- read.table(Q_file)
  r <- as.matrix(read.table(R_file))
  palette(c("#A6CEE3", "#1F78B4", "#B2DF8A", "#33A02C", "#FB9A99", "#E31A1C", "#FDBF6F", "#FF7F00", "#CAB2D6", "#6A3D9A", "#FFFF99", "#B15928", "#1B9E77", "#999999", "#FF7F0E", "#D62728", "#E41A1C", "#377EB8", "#4DAF4A", "#984EA3", "#FF7F00", "#FFFF33", "#A65628", "#F781BF", "#999999","#A6CEE3","#1F78B4","#B2DF8A","#33A02C","#FB9A99","#E31A1C","#FDBF6F","#FF7F00","#CAB2D6","#6A3D9A","#FFFF99","#B15928","#1D4F9F","#BFF217","#60D5FD","#CC1577","#FF9326","#DF0101","#EC496F","#326397","#B26314","#027368","#A4A4A4","#610B5E"))
  
  ord <- orderInds(pop = as.vector(pop[, 2]), q = q)
  
  plotAdmixHorizontal(q, ord = ord, pop = pop[, 2])
  
  #r <- as.matrix(read.table("//wsl.localhost/Ubuntu/root/results/ancestry/evalAdmix.50.corr"))
  
  #plotCorRes(cor_mat = r, pop = as.vector(pop[, 2]), ord = ord, title = "Evaluation of Reference Panel admixture proportions with K=50", max_z = 0.1, min_z = -0.1)
}

plot_evalAdmix("//wsl.localhost/Ubuntu/root/results/ancestry/new_data_15/ref_chr2_prun_15_PCA.54.Q", "//wsl.localhost/Ubuntu/root/results/ancestry/new_data_15/evalAdmix.54.corr")

