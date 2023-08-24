library(dplyr)
library(ggplot2)

# Read the CSV data
data <- read.csv("//wsl.localhost/Ubuntu/root/results/ancestry/new_data_15/ref_chr2_15.csv")

# Create the plot
plot <- ggplot(data, aes(x = K, y = CV_error)) +
  geom_line(color = "grey", size = 1) +  # Line graph with dark gray color
  geom_point(color = "black", size = 3, shape = 21, fill = "black") +  # Point markers
  geom_smooth(method = "loess", se = FALSE, color = "red", linetype = "dashed") +  # Smooth curve
  labs(title = "CV Error vs. K", x = "Number of Clusters (K)", y = "Cross-Validation Error") +
  theme_minimal() +
  theme(plot.title = element_text(size = 18, hjust = 0.5), axis.title = element_text(size = 14))

# Calculate lowest and highest points
lowest_point <- data[which.min(data$CV_error), ]
highest_point <- data[which.max(data$CV_error), ]

# Add lowest and highest point markers and labels
plot <- plot +
  geom_point(data = lowest_point, aes(x = K, y = CV_error), color = "red", size = 3) +
  geom_point(data = highest_point, aes(x = K, y = CV_error), color = "blue", size = 3) +
  geom_text(data = lowest_point, aes(x = K, y = CV_error, label = paste("Lowest:", round(K, 2), ",", round(CV_error, 5))),
            vjust = 1.5, color = "red", size = 3, hjust = 1) +
  geom_text(data = highest_point, aes(x = K, y = CV_error, label = paste("Highest:", round(K, 2), ",", round(CV_error, 5))),
            vjust = -1, color = "blue", size = 3, hjust = 1)

# Display the plot
print(plot)



#alternate plot
# Read the CSV file
#k_cv <- read.csv("//wsl.localhost/Ubuntu/root/results/ancestry/Admix_CV.csv")

# Create the plot
#ggplot(k_cv, aes(x = `K`, y = CV_error)) +
#  geom_line(color = "grey") +
#  geom_point(shape = 21, color = "black", fill = "#69b3a2", size = 3) +
#  geom_point(data = k_cv[which.min(k_cv$CV_error), ], 
#             aes(x = `K`, y = CV_error), 
#             color = "red", size = 3) +
#  geom_point(data = k_cv[which.max(k_cv$CV_error), ], 
#             aes(x = `K`, y = CV_error), 
#             color = "blue", size = 3) +
#  geom_text(data = k_cv[which.min(k_cv$CV_error), ], 
#            aes(x = `K`, y = CV_error, label = paste("Min (K =", `K`, ")\n(", round(CV_error, 4), ")", sep = "")), 
#            vjust = -1.5, hjust = 0, color = "red") +
#  geom_text(data = k_cv[which.max(k_cv$CV_error), ], 
#            aes(x = `K`, y = CV_error, label = paste("Max (K =", `K`, ")\n(", round(CV_error, 4), ")", sep = "")), 
#            vjust = 2, hjust = 0, color = "blue") +
#  xlab("K") + ylab("Cross-validation error") +
#  theme_bw()

