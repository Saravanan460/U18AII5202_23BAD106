library(ggplot2)
library(dplyr)
student_name <- "SARAVANAN K"
roll_no <- "23BAD106"
subtitle_text <- paste("Name:", student_name, "| Roll No:", roll_no)
student_data <- read.csv("C:/Users/selva/Downloads/1.student_performance.csv")
head(student_data)
student_data$Avg_Internal <- rowMeans(
  student_data[, c("Internal_Test1", "Internal_Test2")]
)
subject_avg <- student_data %>%
  group_by(Subject) %>%
  summarise(Average_Marks = mean(Avg_Internal))
 
windows()
 
ggplot(subject_avg, aes(x = Subject, y = Average_Marks, fill = Subject)) +
  geom_bar(stat = "identity") +
  geom_text(aes(label = round(Average_Marks, 1)),
            vjust = -0.5,
            size = 5) +
  ggtitle("Subject-wise Average Marks") +
  labs(subtitle = subtitle_text) +
  xlab("Subject") +
  ylab("Average Marks") +
  ylim(0, max(subject_avg$Average_Marks) + 10)
 
 
test_avg <- data.frame(
  Test = c("Internal Test 1", "Internal Test 2"),
  Average = c(
    mean(student_data$Internal_Test1),
    mean(student_data$Internal_Test2)
  )
)
 
windows()   
 
ggplot(test_avg, aes(x = Test, y = Average, group = 1)) +
  geom_line() +
  geom_point(size = 3) +
  ggtitle("Performance Trend Across Internal Tests") +
  labs(subtitle = subtitle_text) +
  xlab("Test") +
  ylab("Average Marks")
 
grade_dist <- student_data %>%
  group_by(Final_Grade) %>%
  summarise(Count = n()) %>%
  mutate(Percentage = round(Count / sum(Count) * 100, 1),
         Label = paste0(Percentage, "%"))
 
windows()
 
ggplot(grade_dist, aes(x = "", y = Count, fill = Final_Grade)) +
  geom_bar(stat = "identity", width = 1) +
  coord_polar("y") +
  ggtitle("Grade Distribution") +
  labs(subtitle = subtitle_text) +
  geom_text(aes(label = Label),
            position = position_stack(vjust = 0.5),
            color = "white",
            size = 5) +
  theme_minimal()
