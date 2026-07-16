import type {
  NextFunction,
  Request,
  RequestHandler,
  Response,
} from "express";

type ControllerHandler = (
  req: Request,
  res: Response,
  next: NextFunction
) => void | Promise<void>;

export const asyncHandler =
  (handler: ControllerHandler): RequestHandler =>
    (req, res, next) => {
      Promise.resolve(handler(req, res, next)).catch(next);
    };