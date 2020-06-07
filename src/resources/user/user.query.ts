export const groupQueryFn = (where = "") => `
SELECT
  g.id,
  g.projectId,
  g.members,
  IF(r.reservedHours IS NULL, 0, r.reservedHours) AS reservedHours
FROM
  (
    SELECT
      rg.id,
      rg.project_id AS projectId,
      JSON_ARRAYAGG(
        JSON_OBJECT(
          'username', u.user_id,
          'name', JSON_OBJECT('first', u.first_name,'last',u.last_name)
        )
      ) AS members
    FROM
      user u
      INNER JOIN student_group sg ON sg.student_id = u.id
      INNER JOIN rm_group rg ON rg.id = sg.group_id
    GROUP BY
      rg.id
  ) g
  LEFT JOIN
  (
    SELECT
      rg.id,
      CAST(SUM(TIME_TO_SEC(TIMEDIFF(a.end, a.start))) / 3600 AS DECIMAL(8,2)) as reservedHours
    FROM
      rm_group rg
	  INNER JOIN booking b on b.group_id = rg.id
      INNER JOIN allotment a on a.id = b.allotment_id
    GROUP BY
      rg.id
  ) r ON g.id = r.id
  ${where}
`;

export const userCourseQuery = `
  SELECT
    original_course_name as title,
    instructor,
    JSON_ARRAYAGG(rg.project_id) AS projectIds
  FROM
    rmss.course c
    INNER JOIN rm_group rg ON rg.course_id = c.id
    INNER JOIN student_group sg ON sg.group_id = rg.id
    INNER JOIN user u ON u.id = sg.student_id
  WHERE
    u.user_id = ?
  GROUP BY
    original_course_name;
`;

export const userProjectQuery = `
  SELECT
    pi.*
  FROM
    project_info pi
    INNER JOIN rm_group rg ON rg.project_id = pi.id
    INNER JOIN student_group sg ON sg.group_id = rg.id
    INNER JOIN user u ON u.id = sg.student_id 
  WHERE u.user_id = ?
`;

export const userQueryFn = (where = "") => `
  SELECT 
      u.user_id AS username,
      JSON_OBJECT('first',
              u.first_name,
              'last',
              u.last_name) AS name,
      JSON_ARRAY(CASE u.user_type
                  WHEN 1 THEN 'admin'
                  WHEN 2 THEN 'admin'
                  WHEN 3 THEN 'user'
                  WHEN 4 THEN 'staff'
              END) AS roles,
      JSON_OBJECT('email', JSON_ARRAY(u.email)) AS contact,
      IF(rg.project_id IS NOT NULL,
          JSON_ARRAYAGG(
            JSON_OBJECT(
              'id', rg.project_id,
              'title', c.name,
              'groupId', rg.id,
              'course', JSON_OBJECT(
                'id', c.id,
                'title', c.original_course_name
              )
            )
          ),
          JSON_ARRAY()) AS projects
  FROM
      user u
          LEFT JOIN
      student_group sg ON sg.student_id = u.id
          LEFT JOIN
      rm_group rg ON rg.id = sg.group_id
          LEFT JOIN
      course c ON c.id = rg.course_id
  ${where}
  GROUP BY u.id
`;
