student_name <- "SARAVANAN K | Roll No: 23BAD106"

library(ggplot2)
library(GGally)
library(dplyr)

df <- read.csv("C:/Users/selva/Downloads/6_retail_business.csv")

colnames(df) <- c(
  "Order_ID",
  "Region",
  "Product_Category",
  "Sales",
  "Profit",
  "Discount",
  "Customer_Segment"
)

windows()

ggparcoord(
  data = df,
  columns = c(4, 5, 6),
  groupColumn = "Customer_Segment",
  scale = "uniminmax"
) +
  labs(
    title = student_name,
    subtitle = "Parallel Coordinates: Sales, Profit, Discount by Segment"
  ) +
  theme_minimal()

windows()

ggplot(df, aes(x = Sales, y = Profit, size = Discount, color = Region)) +
  geom_point(alpha = 0.6) +
  scale_size(range = c(3, 10)) +
  labs(
    title = student_name,
    subtitle = "Bubble Chart: Sales vs Profit (Size = Discount)",
    x = "Sales",
    y = "Profit"
  ) +
  theme_minimal()

windows()

ggplot(df, aes(x = Sales, y = Profit, color = Customer_Segment)) +
  geom_point(size = 2) +
  facet_wrap(~Region) +
  geom_smooth(method = "lm", se = FALSE) +
  labs(
    title = student_name,
    subtitle = "Trellis Display: Performance by Region",
    x = "Sales",
    y = "Profit"
  ) +
  theme_bw()
