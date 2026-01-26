import express from "express";
import cors from "cors";
import midtransClient from "midtrans-client";

const app = express();
app.use(cors());
app.use(express.json());

const MIDTRANS_SERVER_KEY = process.env.MIDTRANS_SERVER_KEY;

const snap = new midtransClient.Snap({
  isProduction: false,
  serverKey: SERVER_KEY,
  clientKey: CLIENT_KEY,
});

// ✅ Test route
app.get("/", (req, res) => {
  res.send("Midtrans server aktif!");
});

// ✅ Generate Token route
app.post("/generate-token", async (req, res) => {
  try {
    const { amount } = req.body;
    console.log("💰 Request diterima, amount:", amount);

    const parameter = {
      transaction_details: {
        order_id: "order-" + Date.now(),
        gross_amount: amount,
      },
      credit_card: { secure: true },
      customer_details: {
        first_name: "Zen",
        email: "zen@example.com",
        phone: "081234567890",
      },
    };

    const transaction = await snap.createTransaction(parameter);
    console.log("✅ Token dibuat:", transaction.token);
    res.json({
      token: transaction.token,
      redirect_url: transaction.redirect_url,
    });
  } catch (err) {
    console.error("❌ Error Midtrans:", err.message);
    res.status(500).json({ error: err.message });
  }
});

app.listen(3000, () => console.log("✅ Server berjalan di port 3000"));
