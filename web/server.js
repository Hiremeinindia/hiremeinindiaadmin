const express = require('express');
const cors = require('cors');
const bodyParser = require('body-parser');
const fetchImageUrlRouter = require('./routes/fetchImageUrl');

const app = express(); // Create an Express app instance

const port = 3019;

let isRequestReceived = false;

app.use(cors());
app.use(bodyParser.json());

app.use('/fetchImageUrl', fetchImageUrlRouter); // Define routes and middleware

app.post('/cashNotification', async (req, res) => {
  console.log('Received cash notification request');
  try {
    const imageUrl = req.body.imageUrl; // Retrieve imageUrl from request body
   
    // Perform cash verification logic here

    // Simulate a delay of 30 seconds for verification
    await new Promise(resolve => setTimeout(resolve,  10000));
    // Set the request received flag to true
    isRequestReceived = true; 
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
app.get('/getRequestStatus', (req, res) => {
  res.json({ isRequestReceived });
});
