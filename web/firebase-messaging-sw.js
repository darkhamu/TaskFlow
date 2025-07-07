// web/firebase-messaging-sw.js
importScripts('https://www.gstatic.com/firebasejs/10.0.0/firebase-app-compat.js');
importScripts('https://www.gstatic.com/firebasejs/10.0.0/firebase-messaging-compat.js');

firebase.initializeApp({
  apiKey: "AIzaSyDCXm1_NoSaZEwGJMQwrvoP0mfrg9hYSmA",
  authDomain: "taskflow-1282b.firebaseapp.com",
  projectId: "taskflow-1282b",
  storageBucket: "taskflow-1282b.firebasestorage.app",
  messagingSenderId: "953924610449",
  appId: "1:953924610449:web:5a097cb0cd99bbddba1230",
});

firebase.initializeApp(firebaseConfig);

const messaging = firebase.messaging();

messaging.onBackgroundMessage(function(payload) {
  console.log('[firebase-messaging-sw.js] Received background message ', payload);

  const notificationTitle = payload.notification.title;
  const notificationOptions = {
    body: payload.notification.body,
  };

  return self.registration.showNotification(notificationTitle, notificationOptions);
});