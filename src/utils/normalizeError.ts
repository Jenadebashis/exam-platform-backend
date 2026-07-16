import { ApiError } from "./ApiError";

export const normalizeError = (error: unknown): ApiError => {
  if (error instanceof ApiError) {
    return error;
  }

  if (error instanceof Error) {
    return new ApiError({
      statusCode: 500,
      message: error.message,
      cause: error,
      isOperational: false,
    });
  }

  return new ApiError({
    statusCode: 500,
    message: "Internal Server Error",
    details: error,
    isOperational: false,
  });
};