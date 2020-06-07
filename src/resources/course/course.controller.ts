import { Request, Response } from "express";
import pool, { error500, inflate } from "../../utils/db";
import { controllers } from "../../utils/crud";

const query = `
  SELECT DISTINCT
    original_course_name as title,
    instructor
  FROM
    course
`;

export const getMany = (req: Request, res: Response) => {
  pool.query(query, (err, rows) => {
    if (err) return res.status(500).json(error500(err));
    res.status(200).json({ data: rows, context: req.query.context });
  });
};

export default {
  ...controllers("course", "id"),
  getMany,
};