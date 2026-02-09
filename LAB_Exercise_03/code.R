student_name <- "SARAVANAN K"
roll_no <- "23BAD106"

cat("Name:", student_name, "\n")
cat("Roll No:", roll_no, "\n\n")

library(ggplot2)
library(dplyr)
library(GGally)

patient_data <- read.csv("C:/Users/selva/Downloads/3_healthcare_data.csv")

head(patient_data)

patient_data$Age_Group <- cut(
  patient_data$Age,
  breaks = c(0, 30, 50, 100),
  labels = c("Young", "Middle-aged", "Senior")
)

windows()

ggpairs(
  patient_data,
  columns = c("Age", "BMI", "Glucose_Level", "Blood_Pressure"),
  aes(color = Age_Group, alpha = 0.7)
) +
  ggtitle(paste(
    "Scatter Plot Matrix of Health Indicators\nName:",
    student_name, "| Roll No:", roll_no
  ))

health_vars <- patient_data[, c("Age", "BMI", "Glucose_Level", "Blood_Pressure")]
cor_matrix <- cor(health_vars)

cat("Correlation Matrix:\n")
print(round(cor_matrix, 2))
