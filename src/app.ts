import express from "express";
import cors from "cors";
import helmet from "helmet";
import cookieParser from "cookie-parser";


const app = express();


app.use(helmet());

app.use(cors({
  origin: true,
  credentials: true
}));

app.use(express.json());

app.use(cookieParser());


app.get("/health", (req, res) => {

  res.json({
    status: "OK"
  });

});


export default app;