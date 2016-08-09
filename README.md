# SQL Scripts
SQL scripts are mainly used for extracting data from database directly.

## Quiz Score: Week Max Weight
* Please make sure that the weights of each problem in the metadata and the database are correct before you use weekmaxweight.sql to calculate the max score learners can get in each week.

## Quiz Score: Score Progress
It is used to extract all the progress of scores of passers.

## Quiz Score: Pass Students
It is used to extract the list of learner ids of passers.

# R Scripts
R scripts are mainly used to organize data extracted by SQL scripts and generate figures.

## Quiz Score: Progress Aggregation
It is used to aggregate scores of each learner by week.

* Input: Data extracted by ScoreProgress.sql
* Output: A data frame whose columns are ```course_learner_id, score, Week_1, ..., Week_n```. ```Week_n``` represent the total scores learners got after they finish problems released in the nth week.

## Quiz Score: Passer Week
It is used to group learners by the week they pass the course.

* Input: The result of ```Progress Aggregation```, pass threshold score.
* Output: A data frame whose columns are ```course_learner_id, group```. ```group``` are represented by the week learners passed the course (e.g "Week_5", "Week_6" etc.)
* This script put some learner who are tagged as passers but do not have enough scores (< pass threshold score) as passers who passed the course in the final week. The file with ```_filter``` will tag them as ```NotEnough```.

## Quiz Score: Progress Score (individual)
It is used to generate data frame which shows scores of each group of passers in each week.

* Input: the result of ```Progress Aggregation```, Week Max Weight, the result of ```Passer Week```
* Output: A data frame whose columns are ```course_learner_id, score, week, group```. ```score``` is the normalized score.


# Python Scripts