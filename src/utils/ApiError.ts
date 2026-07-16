interface ApiErrorOptions {
  statusCode: number;
  message: string;
  code?: string;
  details?: unknown;
  cause?: Error;
  isOperational?: boolean;
}

export class ApiError extends Error {
  public readonly statusCode: number;
  public readonly code?: string;
  public readonly details?: unknown;
  public readonly isOperational: boolean;

  constructor({
    statusCode,
    message,
    code,
    details,
    cause,
    isOperational = true,
  }: ApiErrorOptions) {
    super(message, { cause });

    this.name = "ApiError";

    this.statusCode = statusCode;
    this.code = code;
    this.details = details;
    this.isOperational = isOperational;

    if ("captureStackTrace" in Error) {
      Error.captureStackTrace(this, ApiError);
    }
  }
}