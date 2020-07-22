import { controllers, onResult } from "../../utils/crud";
import { Request, Response } from "express";
import pool, { error500, inflate } from "../../utils/db";

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

/**
 * mysql does not accept key-value objects for bulk imports;
 * values must be an array of arrays.
 * Adjust the ordering here as needed.
 * @param event Event object
 */
const flattenEquipment = (
  equipment: {
    [k: string]: string | number | boolean;
  },
  bookingId: number
): (string | number | boolean)[] => [
  equipment.id,
  equipment.bookingId,
  equipment.quantity,
];

const insertManyQuery = `
  INSERT INTO equipment_reservation
    (equipment_id, booking_id, quantity)
  VALUES ?
`;

const reserveEquipment = (req: Request, res: Response) => {
  pool.query(
    "DELETE FROM equipment_reservation where booking_id = ?",
    [req.body[0].bookingId],
    onResult({ req, res }).create
  );
  pool.query(
    insertManyQuery,
    [
      req.body.map((item) =>
        flattenEquipment(item, req.body[0].bookingId as number)
      ),
    ],
    (err) => {
      const { context } = req.query;
      if (err) return res.status(500).json(error500(err, context));
      res.status(201).json({
        data: "OK",
        context,
      });
    }
  );
};

export const getOne = (req: Request, res: Response) =>
  pool.query(
    query + "WHERE id = ?",
    [req.params.id],
    onResult({ req, res, dataMapFn: inflate, take: 1 }).read
  );

export const getMany = (req: Request, res: Response) =>
  pool.query(query, onResult({ req, res, dataMapFn: inflate }).read);

export default {
  ...controllers("booking", "id"),
  getOne,
  getMany,
  reserveEquipment,
};
