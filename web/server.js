const express = require('express');
const cors = require('cors');
const bodyParser = require('body-parser');
const fetchImageUrlRouter = require('./routes/fetchImageUrl');

const app = express(); // Create an Express app instance

const port = 3018;

app.use(cors());
app.use(bodyParser.json());

app.use('/fetchImageUrl', fetchImageUrlRouter); // Define routes and middleware

app.post('/cashNotification', async (req, res) => {
  console.log('Received cash notification request');
  try {
    // Perform cash verification logic here

    // Simulate a delay of 3 minutes for verification
    await new Promise(resolve => setTimeout(resolve, 180000));

    // Send a response indicating success
    console.log('Sending response: Cash Received and Verified');
    res.status(200).json({ message: 'Cash Received and Verified22' });
  } catch (error) {
    console.error('Error during cash verification:', error);
    res.status(500).json({ message: 'Internal Server Error' });
  }
});

app.listen(port, () => {
  console.log(`Server is running at http://localhost:${port}`);
});

app.get('/getCashReceipt', (req, res) => {
  console.log('GET request received for /getCashReceipt');
  // Handle the request and send the cash receipt data
  // ...
});