studentprogress <- function(path){
	
	df <- read.csv(path)

    # Remove the duplicated values: 
    #     Rows with same userid and problemid and the latest submission timestamps are reserved.
    df <- df[order(df$submission_timestamp, decreasing = TRUE),]
    #     Since EX101x consider the latest submission as the final result.
    #     And FP101x only has one submission for each problem.
    #     Other duplicated rows are disgards.
    df <- df[!duplicated(df[c("course_learner_id","question_id")]),]


	df$real_grade <- as.numeric(df$question_weight) * as.numeric(df$grade) / as.numeric(df$max_grade)

    df_filter <- df[, c("course_learner_id", "real_grade", "relevant_week")]

    df_progress <- aggregate(real_grade ~ relevant_week + course_learner_id, data=df_filter, FUN=sum)

    list_relevant_week <- unique(df_progress$relevant_week)

    # print(str(length(unique(df_progress$course_learner_id))))

    df_aggr <- aggregate(real_grade ~ course_learner_id, data=df_filter, FUN=sum)

    for (rw in list_relevant_week){
    	week_name <- paste("Week_", rw, sep="")
        df_progress_week <- df_progress[which(df_progress$relevant_week<=rw),]
        df_progress_week_aggr <- aggregate(real_grade ~ course_learner_id, data=df_progress_week, FUN=sum)
        names(df_progress_week_aggr) <- c("course_learner_id", week_name)
        df_aggr <- merge(df_aggr, df_progress_week_aggr, by="course_learner_id", all.x=TRUE) # by left
        df_aggr[is.na(df_aggr)] <- 0
    }

    return (df_aggr)
}