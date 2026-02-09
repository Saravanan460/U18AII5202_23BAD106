student_name <- "SARAVANAN K"
roll_no <- "23BAD106"

cat("Name:", student_name, "\n")
cat("Roll No:", roll_no, "\n\n")

library(ggplot2)
library(dplyr)

# You must update this path to where your file is located
traffic_data <- read.csv("C:/Users/welcome/Downloads/4_traffic_accidents.csv")

head(traffic_data)

traffic_data$Accident_Type <- as.factor(traffic_data$Accident_Type)

traffic_data$Severity_Level <- as.numeric(factor(
  traffic_data$Severity,
  levels = c("Minor", "Major", "Fatal")
))

windows()  # Opens a separate graphics window (Windows OS)

ggplot(
  traffic_data,
  aes(
    x = Location,
    y = Severity_Level,
    color = Severity_Level,      # Color → Severity
    size = Vehicles_Involved,    # Size → Frequency/Count
    shape = Accident_Type        # Shape → Accident Type
  )
) +
  geom_point(alpha = 0.8) +
  scale_color_gradient(low = "green", high = "red") +
  scale_y_continuous(
    breaks = c(1, 2, 3),
    labels = c("Minor", "Major", "Fatal")
  ) +
  labs(
    title = paste(
      "Traffic Accident Severity Analysis\nName:",
      student_name, "| Roll No:", roll_no
    ),
    x = "Location",
    y = "Severity Level"
  ) +
  theme_minimal()
