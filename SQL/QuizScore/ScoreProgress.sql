SELECT 
	assessments.course_learner_id as course_learner_id, 
	assessments.grade as grade, 
	assessments.max_grade as max_grade,
	questions.question_weight as question_weight,
	submissions.question_id as question_id,
	course_elements.week as relevant_week,
	submissions.submission_timestamp as submission_timestamp
FROM 
	DelftX.assessments AS assessments
	JOIN DelftX.submissions AS submissions
	ON assessments.assessment_id = submissions.submission_id
	JOIN DelftX.quiz_questions AS questions
	ON submissions.question_id = questions.question_id
    JOIN course_elements
    ON course_elements.element_id = questions.question_id
WHERE # select all the pass user
	assessments.course_learner_id IN (
		SELECT 
			course_learner_id 
		FROM 
			DelftX.course_learner
		WHERE 
			DelftX.course_learner.certificate_status <> "notpassing")
	AND questions.question_weight > 0
	AND assessments.grade > 0
	AND assessments.max_grade > 0
    AND course_elements.course_id = "course-v1:DelftX+EX101x+3T2015"