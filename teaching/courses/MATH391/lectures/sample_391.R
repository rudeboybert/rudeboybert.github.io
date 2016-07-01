# students <- read.csv("~/Downloads/MATH_391_F.csv", header=TRUE)
# names <- paste(as.character(students$first_name), as.character(students$last_name))
# dput(names)

# MATH 391
names <- ("Justin Brooks", "Nathan Duncan", "Kevin Gallagher", "Julian Haft", 
 "Galen Harrison", "Tessa Hoppenfeld", "Bryan Kim", "Thomas Koskores", 
 "Kathleen Kruzich", "Jacob Menick", "Margaret Perlman", "Grace Poetzinger", 
 "Blake Rosenthal", "Dean Young", "Kuai Yu")

# Create groups
n <- length(names)
group <- 1:n %% ceiling(n / 3) + 1
groups <- data.frame(names=names, group=group)

# Randomly reassign groups
groups$group <- sample(groups$group)
groups
