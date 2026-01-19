student_name <- "SARAVANAN K"
roll_no <- "23BAD106"
subtitle_text <- paste("Name:", student_name, "| Roll No:", roll_no)
library(ggplot2)
library(dplyr)
data <- read.csv("C:/Users/saravanan/Downloads/2.ecommerce_transactions.csv")   #<------- change the file path
amount_col <- "Transaction_Amount"
date_col   <- "Transaction_Date"
data[[date_col]] <- as.Date(data[[date_col]])
 
dev.new()
ggplot(data, aes(x = .data[[amount_col]])) +
  geom_histogram(binwidth = 100, fill = "steelblue", color = "black") +
  geom_text(
    stat = "bin",
    binwidth = 100,
    aes(label = after_stat(count)),
    vjust = -0.5,
    size = 2.5
  ) +
  scale_x_continuous(breaks = seq(0, 5000, by = 500)) +
  theme_minimal() +
  labs(
    title = "Histogram of Transaction Amounts (Grouped in Hundreds)",
    subtitle = subtitle_text,
    x = "Transaction Amount",
    y = "Number of Transactions"
  )
 
dev.new()
ggplot(data, aes(y = .data[[amount_col]])) +
  geom_boxplot(fill = "orange", outlier.colour = "red") +
  geom_text(
    data = data %>% filter(.data[[amount_col]] %in% boxplot.stats(.data[[amount_col]])$out),
    aes(label = .data[[amount_col]]),
    hjust = -0.3,
    size = 3,
    color = "red"
  ) +
  theme_minimal() +
  labs(
    title = "Boxplot of Transaction Amounts",
    subtitle = subtitle_text,
    y = "Transaction Amount"
  )
monthly_sales <- data %>%
  mutate(month = format(.data[[date_col]], "%Y-%m")) %>%
  group_by(month) %>%
  summarise(total_sales = sum(.data[[amount_col]], na.rm = TRUE))
 
dev.new()
ggplot(monthly_sales, aes(x = month, y = 1, fill = total_sales)) +
  geom_tile() +
  geom_text(aes(label = round(total_sales, 0)), color = "white", size = 4) +
  theme_minimal() +
  theme(
    axis.text.y = element_blank(),
    axis.title.y = element_blank()
  ) +
  labs(
    title = "Monthly Sales Heatmap",
    subtitle = subtitle_text,
    x = "Month",
    fill = "Total Sales"
  )
