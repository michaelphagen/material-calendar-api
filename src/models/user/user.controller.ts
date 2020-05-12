import { User } from "./user.model";
import { Request, Response } from "express";

export const createOne = (req: Request, res: Response) => {
  User.create(req.body)
    .then((data) => res.status(201).json({ data }))
    .catch((error) => {
      console.error(error);
      res.status(400).end();
    });
};

export const getMany = (_: Request, res: Response) => {
  User.find()
    .lean()
    .select(
      "-__v -createdAt -updatedAt -relations.updatedAt -relations.createdAt"
    )
    .then((data) => res.status(200).json({ data }))
    .catch((error) => {
      console.error(error);
      res.status(400).end();
    });
};

export const getOne = (req: Request, res: Response) => {
  User.findOne({ _id: req.params.id })
    .lean()
    .populate("projects")
    // leaving relations.project as just an ID
    .populate("relations.requested")
    .populate("relations.accepted")
    .then((data) => res.status(200).json({ data }))
    .catch((error) => {
      console.error(error);
      res.status(400).end();
    });
};

export const removeOne = (req: Request, res: Response) => {
  User.findOneAndRemove({ _id: req.params.id })
    .then((data) => res.status(200).json({ data }))
    .catch((error) => {
      console.error(error);
      res.status(400).end();
    });
};

export const updateOne = (req: Request, res: Response) => {
  User.findOneAndUpdate({ _id: req.params.id }, req.body, {
    new: true,
  })
    .lean()
    .then((data) => res.status(200).json({ data }))
    .catch((error) => {
      console.log(error);
      res.status(400).end();
    });
};
