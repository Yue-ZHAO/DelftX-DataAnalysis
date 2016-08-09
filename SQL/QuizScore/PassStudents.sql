SELECT 
	course_learner.course_learner_id 
FROM 
	DelftX.course_learner AS course_learner
    JOIN DelftX.learner_index AS learner_index
    ON learner_index.course_learner_id = course_learner.course_learner_id
WHERE 
	course_learner.certificate_status <> "notpassing"    
AND
    learner_index.course_id = "course-v1:DelftX+FP101x+3T2015"