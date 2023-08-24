# Load tidyverse package
library(ggrepel)
library(tidyverse)
library(dplyr)
library(ggplot2)

# Read data and eigenvalues
pca <- read_table("C:/Users/rackb/Desktop/data/new data 15th/ref_chr2_prun_15_PCA.eigenvec", col_names = FALSE)
eigenval <- scan("C:/Users/rackb/Desktop/data/new data 15th/ref_chr2_prun_15_PCA.eigenval")

# Sort out the pca data
# Remove nuisance column
pca <- pca[,-1]
# Set names
names(pca)[1] <- "RUN_ID"
names(pca)[2:ncol(pca)] <- paste0("PC", 1:(ncol(pca)-1))

# Replacement data
replacement_data <- data.frame(
  RUN_ID = c("SRR5755256","SRR20981633", "ERR953404", "SRR19364599", "ERR11152727", "SRR8074196", "SRR19364636", "SRR19364574", "SRR4054279", "SRR19364620", "SRR20981665", "SRR20981663", "SRR19364657", "SRR19364582", "SRR20981661", "SRR1769892", "ERR982786", "SRR6650587", "SRR6474876", "SRR6650591", "ERR1305961", "SRR20981643", "SRR19364598", "SRR1048526", "SRR19364660", "SRR16979493", "SRR6650593", "ERR1397960", "ERR2179542", "ERR1545179", "ERR2179554", "SRR19364661", "SRR20981650", "SRR19364616", "SRR3017654", "SRR19364651", "SAMN07276823", "SRR12719770", "SRR16979522", "SRR20981657", "SRR3017651", "SRR5131683", "SRR8442604", "SRR19364598", "ERR982794", "SRR19427108", "ERR2179546", "SRR3017601", "SRR3017650", "SRR3017631", "SRR13311580", "SRR19364568", "SRR19364596", "SRR19364570", "SRR12719745", "SRR12086707", "SRR2142311", "ERR11152732", "SRR3952018", "SRR8698434", "SRR2142313", "ERR11152723", "ERR953413", "SRR9912868", "SRR20981608", "SRR19364578", "SRR10847558", "SRR19364642", "ERR2179550", "SRR19364571", "SRR1769893", "ERR1021785", "SRR16979467"),
  BREED = c("Italian Trotter","Akhal Teke", "American_Miniature_Horse", "American Paint Horse", "American_Quarter_Horse", "American Standardbred horse", "American_Warmblood", "Andalusian", "Appaloosa", "Appendix Quarter Horse", "Arabian", "Ardennes", "Baise", "Batagai", "Bavarian Warmblood", "Belgian Warmblood", "Chakouyi Horse", "Clydesdale", "Connemara", "Criollo", "Crossbred (Warmblood/Quarter Horse)", "Debao", "debao pony", "duelmener", "Dutch Warmblood", "Falabella", "Friesian", "Friesian dwarf", "German Riding Pony", "German WarmBlood", "Haflinger", "Hanoverian", "Hequ", "Holsteiner", "Icelandic", "Irish Sport Horse", "Italian Trotter", "Jeju Horse", "jinjiang pony", "Kazakh", "Knaubstrupper", "Lipizzan", "lowland", "Lusitano", "Mangalarga Marchador Horse", "Mongolian horse", "Morgan Horse", "Mountain Zebra1", "Noriker", "North swedish draft_H3817", "Norwegian Fjord", "Oldenburg", "Percheron", "Percheron Cross", "Przewalski", "Quarter Horse", "Saxon-Thuringian Heavy Warmblood", "Selle Francais stallion", "Shetland pony", "Shire", "Sorraia", "Swiss Warmblood", "Tennessee Walking Horse", "Thoroughbred", "Tibetan", "Trakehner", "Warmblood", "Warmblood x American Paint Horse", "Welsh Pony", "Westphalian", "whole blood", "Yakutian horse", "yili horse")
)

# Loop through the replacement data and update pca$BREED
for (i in 1:nrow(replacement_data)) {
  run_id <- replacement_data$RUN_ID[i]
  breed <- replacement_data$BREED[i]
  pca$RUN_ID[pca$RUN_ID == run_id] <- breed
}

# Replacement data
replacement_data <- tribble(
  ~BREED, ~BloodType,
  "Akhal Teke", "Hotbloods",
  "American Paint Horse", "Warmbloods",
  "American Standardbred horse", "Warmbloods",
  "American_Miniature_Horse", "Pony",
  "American_Quarter_Horse", "Warmbloods",
  "American_Warmblood", "Warmbloods",
  "Andalusian", "Hotbloods",
  "Appaloosa", "Hotbloods",
  "Appendix Quarter Horse", "Warmbloods",
  "Arabian", "Hotbloods",
  "Ardennes", "Coldbloods",
  "Baise", "Warmbloods",
  "Batagai", "Warmbloods",
  "Bavarian Warmblood", "Hotbloods",
  "Belgian Warmblood", "Warmbloods",
  "Chakouyi Horse", "Hotbloods",
  "Clydesdale", "Coldbloods",
  "Connemara", "Warmbloods",
  "Criollo", "Warmbloods",
  "Crossbred (Warmblood/Quarter Horse)", "Warmbloods",
  "Debao", "Pony",
  "debao pony", "Pony",
  "duelmener", "Pony",
  "Dutch Warmblood", "Warmbloods",
  "Falabella", "Pony",
  "Friesian", "Warmbloods",
  "Friesian dwarf", "Pony",
  "German Riding Pony", "Pony",
  "German WarmBlood", "Warmbloods",
  "Haflinger", "Pony",
  "Hanoverian", "Warmbloods",
  "Hequ", "Warmbloods",
  "Holsteiner", "Warmbloods",
  "Icelandic", "Warmbloods",
  "Irish Sport Horse", "Warmbloods",
  "Italian Trotter", "Hotbloods",
  "Jeju Horse", "Pony",
  "jinjiang pony", "Pony",
  "Kazakh", "Pony",
  "Knaubstrupper", "Pony",
  "Lipizzan", "Coldbloods",
  "lowland", "Warmbloods",
  "Lusitano", "Warmbloods",
  "Mangalarga Marchador Horse", "Coldbloods",
  "Mongolian horse", "Warmbloods",
  "Morgan Horse", "Warmbloods",
  "Mountain Zebra1", "Warmbloods",
  "Noriker", "Warmbloods",
  "North swedish draft_H3817", "Warmbloods",
  "Norwegian Fjord", "Coldbloods",
  "Oldenburg", "Warmbloods",
  "Percheron", "Coldbloods",
  "Percheron Cross", "Coldbloods",
  "Przewalski", "Ancestry",
  "Quarter Horse", "Warmbloods",
  "Saxon-Thuringian Heavy Warmblood", "Warmbloods",
  "Selle Francais stallion", "Warmbloods",
  "Shetland pony", "Pony",
  "Shire", "Coldbloods",
  "Sorraia", "Warmbloods",
  "Swiss Warmblood", "Warmbloods",
  "Tennessee Walking Horse", "Warmbloods",
  "Thoroughbred", "Warmbloods",
  "Tibetan", "Hotbloods",
  "Trakehner", "Warmbloods",
  "Warmblood", "Warmbloods",
  "Warmblood x American Paint Horse", "Warmbloods",
  "Welsh Pony", "Pony",
  "Westphalian", "Warmbloods",
  "whole blood", "Warmbloods",
  "Yakutian horse", "Pony",
  "Yili horse", "Pony"
)


# Merge pca with replacement_data based on RUN_ID
merged_data <- pca %>%
  left_join(replacement_data, by = c("RUN_ID" = "BREED"))

merged_data <- merged_data %>%
  select(RUN_ID, BloodType, everything())

# Print updated merged data
print(merged_data)
#data<-data.frame(merged_data)
#write.csv(data, file = "//wsl.localhost/Ubuntu/root/results/ancestry/PCA_table.csv", row.names = FALSE)


# plot pca: PC1 vs PC2
pve <- data.frame(PC = 1:20, pve = eigenval/sum(eigenval)*100)

# Create the plot
a <- ggplot(pve, aes(PC, pve)) +
  geom_bar(stat = "identity", fill = "grey", color = "black") +
  geom_text(aes(label = paste0(round(pve, 2), "%")), vjust = -0.5, color = "black", size = 3) +
  labs(x = "Principal Component", y = "Percentage Variance Explained") +
  theme_minimal() +
  #theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank()) +
  scale_x_continuous(breaks = seq(1, 20, by = 1)) +
  scale_y_continuous(limits = c(0, 10), expand = c(0, 0.05)) +
  coord_cartesian(clip = "off")

# Print the final plot
print(a)


# calculate the cumulative sum of the percentage variance explained

#data=cumsum(pve$pve)
data <- cumsum(pve$pve)

# Create the line plot
plot <- ggplot(data.frame(PC = 1:20, Cumulative_PVE = data), aes(PC, Cumulative_PVE)) +
  geom_line(color = "red", size = 1.5) +
  geom_point(color = "black", size = 4, shape = 21, fill = "white", stroke = 1) +
  labs(
    x = "Principal Component",
    y = "Cumulative Percentage Variance Explained",
  ) +
  theme_minimal() +
  theme(
    plot.title = element_text(size = 18, hjust = 0.5, margin = margin(b = 15)),
    plot.subtitle = element_text(size = 14, hjust = 0.5, margin = margin(b = 20)),
    axis.title = element_text(size = 14),
    axis.text = element_text(size = 12),
    panel.grid.major = element_line(color = "gray", size = 0.2),  # Add major grid lines
    panel.grid.minor = element_blank(),
    panel.border = element_blank(),
    axis.line = element_line(color = "black")
  )

# Print the plot
print(plot)

# Filter out rows with missing values in PC1 and PC2 columns
filtered_data <- merged_data %>%
  filter(!is.na(PC1) & !is.na(PC2))

# Impute missing values with zero (or any appropriate value)
filtered_data <- merged_data %>%
  filter(!is.na(PC1) & !is.na(PC2)) %>%
  mutate(PC1 = if_else(is.na(PC1), mean(PC1, na.rm = TRUE), PC1),
         PC2 = if_else(is.na(PC2), mean(PC2, na.rm = TRUE), PC2))

# Convert BloodType to a factor with specified levels
filtered_data$BloodType <- factor(filtered_data$BloodType, levels = c("Hotbloods", "Warmbloods", "Coldbloods","Ancestry","Pony"))




# Plot the scatter plot with correct colors
p <- ggplot(filtered_data, aes(PC1, PC2, shape = BloodType, color = BloodType)) +
  geom_point(size = 4) +
  #geom_text(aes(label = RUN_ID), size = 3, vjust = -0.5)+
  geom_text(aes(label = ifelse(RUN_ID == "Przewalski", "Przewalski", "")), size = 3, vjust = -0.5, show.legend = FALSE) +  # Add label for the specific sample
  scale_colour_manual(values = c("Hotbloods" = "black", "Warmbloods" = "red", "Coldbloods" = "blue","Ancestry"="green","Pony"="purple") ) +
  scale_shape_manual(values = seq(0, 67)) +
  coord_equal() +
  theme_light() +
  xlab(paste0("PC1 (", signif(pve$pve[1], 3), "%)")) +
  ylab(paste0("PC2 (", signif(pve$pve[2], 3), "%)"))

p_zoomed <- p + xlim(-0.1, 1) + ylim(-0.3, 0.6)
print(p_zoomed)



# Zoomed-in plot
p <- ggplot(filtered_data, aes(PC1, PC2, shape = BloodType, color = BloodType)) +
  geom_point(size = 4) +
  #geom_text_repel(aes(label = RUN_ID), size = 2.5, show.legend = FALSE, max.overlaps = Inf) +
  scale_colour_manual(values = c("Hotbloods" = "black", "Warmbloods" = "red", "Coldbloods" = "blue","Ancestry"="green","Pony"="purple")) +
  scale_shape_manual(values = seq(0, 67)) +
  coord_equal() +
  theme_light() +
  xlab(paste0("PC1 (", signif(pve$pve[1], 3), "%)")) +
  ylab(paste0("PC2 (", signif(pve$pve[2], 3), "%)"))

p_zoomed <- p + xlim(-0.07, 0.07) + ylim(-0.06, 0.05)
print(p_zoomed)


# make plot
a <- ggplot(pve, aes(PC, pve)) + geom_bar(stat = "identity")
a + ylab("Percentage variance explained") + theme_light() + xlab("Percentage Component") + theme_light()


# Filter out rows with missing values in PC3 and PC4 columns
filtered_data_3_4 <- merged_data %>%
  filter(!is.na(PC3) & !is.na(PC4))

# Impute missing values with zero (or any appropriate value)
filtered_data_3_4 <- filtered_data_3_4 %>%
  mutate(PC3 = if_else(is.na(PC3), mean(PC3, na.rm = TRUE), PC3),
         PC4 = if_else(is.na(PC4), mean(PC4, na.rm = TRUE), PC4))


p_3_4 <- ggplot(filtered_data_3_4, aes(PC3, PC4, shape = BloodType, color = BloodType)) +
  geom_point(size = 4) +
  #geom_text_repel(aes(label = RUN_ID), size = 2.5, show.legend = FALSE, max.overlaps = Inf) +
  geom_text(aes(label = ifelse(RUN_ID == "Mangalarga Marchador Horse", "Mangalarga Marchador Horse", "")), size = 3, vjust = -0.5, show.legend = FALSE) +  # Add label for the specific sample
  geom_text(aes(label = ifelse(RUN_ID == "Quarter Horse", "Quarter Horse", "")), size = 3, vjust = -0.5, show.legend = FALSE) +  # Add label for the specific sample
  scale_colour_manual(values = c("Hotbloods" = "black", "Warmbloods" = "red", "Coldbloods" = "blue","Ancestry"="green","Pony"="purple")) +
  scale_shape_manual(values = seq(0, 67)) +
  coord_equal() +
  theme_light() +
  xlab(paste0("PC3 (", signif(pve$pve[3], 3), "%)")) +
  ylab(paste0("PC4 (", signif(pve$pve[4], 3), "%)"))

# Zoomed-in plot for PC3 vs PC4
p_zoomed_3_4 <- p_3_4 + xlim(-0.5, 0.5) + ylim(-0.25, 1)
print(p_zoomed_3_4)


# Plot the scatter plot for PC3 vs PC4
p_3_4 <- ggplot(filtered_data_3_4, aes(PC3, PC4, shape = BloodType, color = BloodType)) +
  geom_point(size = 3) +
  #geom_text_repel(aes(label = RUN_ID), size = 3.3, show.legend = FALSE, max.overlaps = Inf) +
  scale_colour_manual(values = c("Hotbloods" = "black", "Warmbloods" = "red", "Coldbloods" = "blue","Ancestry"="green","Pony"="purple")) +
  scale_shape_manual(values = seq(0, 67)) +
  coord_equal() +
  theme_light() +
  xlab(paste0("PC3 (", signif(pve$pve[3], 3), "%)")) +
  ylab(paste0("PC4 (", signif(pve$pve[4], 3), "%)"))

# Zoomed-in plot for PC3 vs PC4
p_zoomed_3_4 <- p_3_4 + xlim(-0.35, 0.5) + ylim(-0.25, 0.25)
print(p_zoomed_3_4)


