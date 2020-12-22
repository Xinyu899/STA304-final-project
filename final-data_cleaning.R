# Read in the raw data 
raw_data <- read_dta("ns20200625.dta")
# Add the labels
raw_data<- labelled::to_factor(raw_data)
# keep some variable
reduced_data <- 
  raw_data %>% 
  dplyr::select(vote_2020,
                vote_intention,
                registration,
                age,
                gender,
                education,
                household_income,
                race_ethnicity)
#Adjust Data types and remove NA
reduced_data$age<-as.numeric(reduced_data$age)
reduced_data <- na.omit(reduced_data)

# Keep the people that are going to vote
cleaned_data<-reduced_data %>% 
  dplyr::filter(registration=="Registered"&
                  vote_intention!="No, I am not eligible to vote"&
                  vote_intention!="No, I will not vote but I am eligible"&
                  (vote_2020=="Donald Trump"|vote_2020=="Joe Biden"))

high<-c('$55,000 to $59,999','$60,000 to $64,999','$65,000 to $69,999','$70,000 to $74,999',
        '$75,000 to $79,999','$80,000 to $84,999','$85,000 to $89,999','$90,000 to $94,999',
        '$95,000 to $99,999','$100,000 to $124,999','$125,000 to $149,999','$150,000 to $174,999',
        '$175,000 to $199,999','$200,000 to $249,999','250,000 and above')
cleaned_data$high_income<-ifelse(cleaned_data$household_income %in%  high, 1, 0)
cleaned_data$high_income<-as.factor(cleaned_data$high_income)
