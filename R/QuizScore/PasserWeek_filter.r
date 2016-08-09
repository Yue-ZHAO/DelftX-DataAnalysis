 passerweek_filter <- function(df_progress, passscore=0){
    # Initialization
    library(ggplot2)
    if (passscore == 0) {
    	passscore <- max(df_progress[,"real_grade"]) * 0.6
    }

    tailsign <- tail(names(df_progress), n=1)
    
    df_progress_temp <- df_progress
    
    df_progress_temp$group <- "NotEnough"

    # for loop for the progress
    k_p <- ""
    index <- 1

    for (k in names(df_progress_temp)){

    	if (k == "course_learner_id" || k == "real_grade" || k == "group") {
    		
            index <- index + 1

    	} else {
    	    
    	    if (k == "Week_1" || index == 3) {

                df_progress_temp[which(df_progress_temp[, k]>=passscore), "group"] <- k

    	    } else {

                print(k_p)
                print(k)

                print(nrow(df_progress_temp[which(df_progress_temp[, k_p]<passscore & df_progress_temp[, k]>=passscore),]))

    		    df_progress_temp[which(df_progress_temp[, k_p]<passscore & df_progress_temp[, k]>=passscore), "group"] <- k    
    	    
            }

            index <- index + 1
            k_p <- k
        }
    }

    return (df_progress_temp[, c("course_learner_id", "group")])
 
 }