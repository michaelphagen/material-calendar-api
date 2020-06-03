import { controllers } from "../../utils/crud";
import { Request, Response } from "express";
import pool, { error500 } from "../../utils/db";

const query = `
  SELECT
    id,
    purpose AS description,
    allotment_id AS eventId,
    group_id AS groupId,
    project_id AS projectId,
    guests,
    IF(
      cancel_request = 1,
      JSON_OBJECT(
        'requested', JSON_OBJECT(
          'on', cancel_request_time,
          'by', cancel_request_userid,
          'comment', cancel_request_comment
      ),
        'approved', JSON_OBJECT(
          'on', cancelled_time,
          'by', cancelled_approval
      ),
        'rejected', NULL
      ),
      NULL
    ) AS cancellation
  FROM
    booking
`;

export const getOne = (req: Request, res: Response) => {
  pool.query(query + "WHERE id = ?", [req.params.id], (err, rows) => {
    if (err) return res.status(500).json(error500(err));
    res.status(200).json({ data: rows[0], context: req.query.context });
  });
};

export const getMany = (req: Request, res: Response) => {
  pool.query(query, (err, rows) => {
    if (err) return res.status(500).json(error500(err));
    res.status(200).json({ data: rows, context: req.query.context });
  });
};

export default {
  ...controllers("booking", "id"),
  getOne,
  getMany,
};
