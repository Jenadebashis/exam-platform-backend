import type { ErrorRequestHandler } from "express";

import { env } from "../config/env";
import { normalizeError } from "../utils/normalizeError";

interface ApiErrorResponse {
  readonly success: false;
  readonly error: {
    message: string;
    code?: string;
    details?: unknown;
    stack?: string;
  };
}

export const errorMiddleware: ErrorRequestHandler = (
  error,
  _req,
  res,
  _next
) => {
  const apiError = normalizeError(error);

  const isDevelopment = env.NODE_ENV === "development";

  const exposeOperationalData = apiError.isOperational;

  const errorResponse: ApiErrorResponse["error"] = {
    message: exposeOperationalData
      ? apiError.message
      : "Internal Server Error",
  };

  if (exposeOperationalData && apiError.code !== undefined) {
    errorResponse.code = apiError.code;
  }

  if (exposeOperationalData && apiError.details !== undefined) {
    errorResponse.details = apiError.details;
  }

  if (isDevelopment && apiError.stack !== undefined) {
    errorResponse.stack = apiError.stack;
  }

  return res.status(apiError.statusCode).json({
    success: false,
    error: errorResponse,
  } satisfies ApiErrorResponse);
};