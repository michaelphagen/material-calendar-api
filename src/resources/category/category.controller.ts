import { controllers, onResult } from "../../utils/crud";
import { Request, Response } from "express";
import pool from "../../utils/db";

const query = `
  SELECT
    id,
    title,
    parent_id AS parentId
  FROM
    category
`;

export const getMany = (req: Request, res: Response) =>
  pool.query(query, onResult({ req, res }).read);

export default { ...controllers("category", "id"), getMany };
