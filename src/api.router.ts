import { Router } from "express";
import backupRouter from "./utils/backup";
import courseRouter from "./resources/course/course.router";
import equipmentRouter from "./resources/equipment/equipment.router";
import categoryRouter from "./resources/category/category.router";
import tagRouter from "./resources/tag/tag.router";
import eventRouter from "./resources/event/event.router";
import locationRouter from "./resources/location/location.router";
import projectRouter from "./resources/project/project.router";
import reservationRouter from "./resources/reservation/reservation.router";
import rosterRouter from "./utils/roster";
import semesterRouter from "./resources/semester/semester.router";
import userRouter from "./resources/user/user.router";
import virtualWeekRouter from "./resources/virtualWeek/virtualWeek.router";

const router = Router();

router.use("/backups", backupRouter);
router.use("/courses", courseRouter);
router.use("/equipment", equipmentRouter);
router.use("/categories", categoryRouter);
router.use("/tags", tagRouter);
router.use("/events", eventRouter);
router.use("/locations", locationRouter);
router.use("/projects", projectRouter);
router.use("/reservations", reservationRouter);
router.use("/rosters", rosterRouter);
router.use("/semesters", semesterRouter);
router.use("/users", userRouter);
router.use("/virtualweeks", virtualWeekRouter);

export default router;
