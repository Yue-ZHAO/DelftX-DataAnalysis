SELECT
    course_elements.week as relevant_week,  
    SUM(questions.question_weight) as weight_total
FROM
    DelftX.quiz_questions AS questions
    JOIN DelftX.course_elements AS course_elements
    ON course_elements.element_id = question_id
WHERE
    DelftX.course_elements.course_id = "course-v1:DelftX+EX101x+3T2015"
GROUP BY relevant_week