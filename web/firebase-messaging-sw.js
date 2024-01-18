importScripts("https://www.gstatic.com/firebasejs/8.10.0/firebase-app.js");
importScripts("https://www.gstatic.com/firebasejs/8.10.0/firebase-messaging.js");
const firebaseConfig={
    apiKey: "AIzaSyBKUuhUeiA2DpvZD4od15RdHEBZyjsuVlA",
    appId: '1:316659430730:web:1afaddd5a3f41be5cffdb3',
    messagingSenderId: '316659430730',
    projectId: 'hiremeinindia-14695',
    authDomain: 'hiremeinindia-14695.firebaseapp.com',
    databaseURL:
        'https://hiremeinindia-14695-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'hiremeinindia-14695.appspot.com',
    measurementId: 'G-KVMWVJ99JL',
};
firebase.initializeApp(
  
    firebaseConfig
);

const messaging = firebase.messaging();

// Optional:
messaging.onBackgroundMessage((message) => {
  console.log("onBackgroundMessage", message);
});