library(dplyr)
head(train)
train <- train %>%
  mutate(across(c(job, marital, education, default, housing, loan, contact, month, poutcome, y), ~trimws(gsub("\"", "", .)))) %>%
  filter(!is.na(age) & !is.na(job) & !is.na(y)) %>%
  mutate(y = as.factor(y),
         default = as.factor(default),
         housing = as.factor(housing),
         loan = as.factor(loan))
summary(train)


library(ggplot2)
ggplot(train, aes(x = y, fill = y)) +
  geom_bar() +
  labs(title = "Subscription Rate", x = "Subscribed", y = "Count") +
  scale_fill_manual(values = c("no" = "#ff7300", "yes" = "#82ca9d")) +
  theme_minimal()


# Phân phối tuổi
ggplot(train, aes(x = age, fill = y)) +
  geom_histogram(binwidth = 5, position = "stack") +
  labs(title = "Age Distribution by Subscription", x = "Age", y = "Count") +
  scale_fill_manual(values = c("no" = "#ff7300", "yes" = "#82ca9d")) +
  theme_minimal()

# Phân phối số dư
ggplot(train, aes(x = balance, fill = y)) +
  geom_histogram(binwidth = 5000, position = "stack") +
  labs(title = "Balance Distribution by Subscription", x = "Balance", y = "Count") +
  scale_fill_manual(values = c("no" = "#ff7300", "yes" = "#82ca9d")) +
  theme_minimal()

# Phân phối thời gian gọi
ggplot(train, aes(x = duration, fill = y)) +
  geom_histogram(binwidth = 200, position = "stack") +
  labs(title = "Call Duration Distribution by Subscription", x = "Duration (seconds)", y = "Count") +
  scale_fill_manual(values = c("no" = "#ff7300", "yes" = "#82ca9d")) +
  theme_minimal()


# Theo nghề nghiệp
job_summary <- train %>%
  group_by(job, y) %>%
  summarise(count = n()) %>%
  mutate(rate = count / sum(count) * 100) %>%
  filter(y == "yes")

ggplot(job_summary, aes(x = reorder(job, rate), y = rate)) +
  geom_bar(stat = "identity", fill = "#82ca9d") +
  coord_flip() +
  labs(title = "Subscription Rate by Job", x = "Job", y = "Subscription Rate (%)") +
  theme_minimal()

# Theo trình độ học vấn
edu_summary <- train %>%
  group_by(education, y) %>%
  summarise(count = n()) %>%
  mutate(rate = count / sum(count) * 100) %>%
  filter(y == "yes")

ggplot(edu_summary, aes(x = education, y = rate)) +
  geom_bar(stat = "identity", fill = "#82ca9d") +
  labs(title = "Subscription Rate by Education", x = "Education", y = "Subscription Rate (%)") +
  theme_minimal()


month_order <- c("jan", "feb", "mar", "apr", "may", "jun", "jul", "aug", "sep", "oct", "nov", "dec")
month_summary <- train %>%
  group_by(month, y) %>%
  summarise(count = n()) %>%
  mutate(rate = count / sum(count) * 100) %>%
  filter(y == "yes") %>%
  mutate(month = factor(month, levels = month_order))

ggplot(month_summary, aes(x = month, y = rate, group = 1)) +
  geom_line(color = "#82ca9d", size = 1) +
  geom_point(color = "#82ca9d", size = 3) +
  labs(title = "Subscription Rate by Month", x = "Month", y = "Subscription Rate (%)") +
  theme_minimal()

write.csv(job_summary, "job_summary.csv", row.names = FALSE)
write.csv(month_summary, "month_summary.csv", row.names = FALSE)