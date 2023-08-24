library(tidyverse)

# Load and prepare data
var_qual <- read_delim("//wsl.localhost/Ubuntu/root/results/Summary_files/ref2_chr.lqual", delim = "\t", col_names = c("chr", "pos", "qual"), skip = 1)
var_depth <- read_delim("//wsl.localhost/Ubuntu/root/results/Summary_files/ref2_chr.ldepth.mean", delim = "\t", col_names = c("chr", "pos", "mean_depth", "var_depth"), skip = 1)
var_miss <- read_delim("//wsl.localhost/Ubuntu/root/results/Summary_files/ref2_chr.lmiss", delim = "\t", col_names = c("chr", "pos", "nchr", "nfiltered", "nmiss", "fmiss"), skip = 1)
var_freq <- read_delim("//wsl.localhost/Ubuntu/root/results/Summary_files/ref2_chr.frq", delim = "\t", col_names = c("chr", "pos", "nalleles", "nchr", "a1", "a2"), skip = 1)

# Create maf column in var_freq
var_freq <- var_freq %>% mutate(maf = pmin(a1, a2))

ind_depth <- read_delim("//wsl.localhost/Ubuntu/root/results/Summary_files/ref2_chr.idepth", delim = "\t", col_names = c("ind", "nsites", "depth"), skip = 1)
ind_miss <- read_delim("//wsl.localhost/Ubuntu/root/results/Summary_files/ref2_chr.imiss", delim = "\t", col_names = c("ind", "ndata", "nfiltered", "nmiss", "fmiss"), skip = 1)
ind_het <- read_delim("//wsl.localhost/Ubuntu/root/results/Summary_files/ref2_chr.het", delim = "\t", col_names = c("ind", "ho", "he", "nsites", "f"), skip = 1)

# Set a custom theme for better aesthetics
custom_theme <- function() {
  theme_minimal() +
    theme(panel.grid.major = element_blank(),
          panel.grid.minor = element_blank(),
          panel.border = element_blank(),
          axis.line = element_line(colour = "black"),
          legend.position = "none")
}

# Define a function to create a plot
create_plot <- function(data, x_col, plot_type = "density", title) {
  p <- ggplot(data, aes_string(x_col)) +
    (if (plot_type == "density") geom_density(fill = "#1f77b4", colour = "black", alpha = 0.6)
     else geom_histogram(fill = "#1f77b4", colour = "black", alpha = 0.6, bins = 30)) +
    custom_theme() +
    labs(title = title, x = x_col, y = NULL)
  return(p)
}

# Plotting
plots <- list(
  create_plot(var_qual, "qual", plot_type = "histogram", title = "Variant Quality Distribution"),
  create_plot(var_qual, "qual", plot_type = "density", title = "Variant Quality Distribution")+
    scale_x_continuous(limits = c(0, 5500)),
  create_plot(var_depth %>% filter(mean_depth <= 100), "mean_depth", plot_type = "density", title = "Variant Mean Depth Distribution"),
  create_plot(var_miss, "fmiss", plot_type = "density", title = "Variant Missingness Distribution") +
    scale_x_continuous(limits = c(0, 0.4)),
  create_plot(var_freq, "maf", plot_type = "density", title = "Minor Allele Frequency Distribution"),
  create_plot(ind_depth, "depth", plot_type = "histogram", title = "Individual Mean Depth Distribution"),
  create_plot(ind_miss, "fmiss", plot_type = "histogram", title = "Individual Missing Data Distribution"),
  create_plot(ind_het, "f", plot_type = "histogram", title = "Individual Heterozygosity Distribution")
)

# Print plots
for (p in plots) {
  print(p)
}

# Analyse variant depth vs mean
summary(var_depth$mean_depth)

# Summary of missingness profile
summary(var_miss$fmiss)

# Summary for allele freq
summary(var_freq$maf)

