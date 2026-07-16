import type { Response } from "express";

interface ApiSuccessResponse<T> {
  readonly success: true;
  readonly message?: string;
  readonly data: T;
}

interface SendSuccessOptions<T> {
  readonly statusCode?: number;
  readonly message?: string;
  readonly data: T;
}

export const sendSuccess = <T>(
  res: Response,
  {
    statusCode = 200,
    message,
    data,
  }: SendSuccessOptions<T>
): Response => {
  if (message !== undefined) {
    return res.status(statusCode).json({
      success: true,
      message,
      data,
    } satisfies ApiSuccessResponse<T>);
  }

  return res.status(statusCode).json({
    success: true,
    data,
  } satisfies ApiSuccessResponse<T>);
};