progressplot_individual <- function(df_progress, weekmaxscore, df_passersgroup) {
	
	# for loop for the progress
    k_p <- ""
    index <- 1
    passlistindex <- 0
    df_temp <- df_progress
    avgscore <- weekmaxscore
    stdscore <- weekmaxscore

    for (k in names(df_progress)){
    	if (k == "course_learner_id" || k == "real_grade") {
    		index <- index + 1
    	} else {
    	    
    	    numpass <- 0
    	    
    	    if (k == "Week_1" || index == 3) {
                df_temp[, k] <- df_progress[, k] / weekmaxscore[k]
    	    } else {
    		    df_temp[, k] <- (df_progress[, k] - df_progress[, k_p]) / weekmaxscore[k]
    	    }

            index <- index + 1
            k_p <- k
        }
    }

    df_temp_2 <- data.frame()
    for (i in c(1:(index-3))) {
    	
    	week_i <- paste("Week_", i, sep="")

        df_temp_3 <- df_temp[, c("course_learner_id", week_i)]
        df_temp_3$week <- week_i
        names(df_temp_3) <- c("course_learner_id", "score", "week")

        if (i == 1) {
            df_temp_2 <- df_temp_3
        } else {   
            df_temp_2 <- rbind(df_temp_2, df_temp_3)
        }
    	
    }

    df_temp_2 <- merge(df_temp_2, df_passersgroup, by="course_learner_id")
    library("ggplot2")
    ggplot(df_temp_2, aes(x=week, y=score, group=course_learner_id, color=group), environment=environment()) + geom_line() 
    return (df_temp_2)

}