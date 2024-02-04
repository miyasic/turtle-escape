const express = require('express');
const bodyParser = require('body-parser');
const jwt = require('jsonwebtoken');
const { GoogleAuth } = require('google-auth-library');
require('dotenv').config();

const app = express();
const PORT = process.env.PORT || 3000;

// ミドルウェアの設定
app.use(bodyParser.json());

app.post('/generate-jwt', async (req, res) => {
    const genericObject = req.body; // Flutter アプリから送られてくる JSON
    const private_key = process.env.PRIVATE_KEY.replace(/\\n/g, '\n');
    const credentials = {
        client_email: 'wallet@ggc-412221.iam.gserviceaccount.com', // 環境変数から取得するか、直接指定
        private_key: private_key,
    };

    // JWT の claims を設定
    const claims = {
        iss: credentials.client_email,
        aud: 'google',
        origins: ['http://localhost:3000'],
        typ: 'savetowallet',
        payload: {
            genericObjects: [genericObject],
        },
    };

    // JWT を生成
    const token = jwt.sign(claims, credentials.private_key, { algorithm: 'RS256' });

    // 生成した JWT をレスポンスとして返す
    res.json({ jwt: token });
});

app.listen(PORT, () => {
    console.log(`Server running on port ${PORT}`);
});
