# How to Use a Real Database (Google Firebase)

Currently, your login system uses **localStorage**, which saves passwords only on *your specific computer*. To make the app public so "every people" can use it from any device, you need a cloud database.

The industry standard for this type of modern web app is **Google Firebase**.

## Why Firebase?
1. **Real Authentication**: Handles secure Email/Password logins automatically.
2. **Accessible Everywhere**: Users can sign up on a phone and log in on a laptop.
3. **No Backend Server Needed**: accessible directly from your HTML/JavaScript.
4. **Free**: The "Spark Plan" is free for small projects.

---

## Step 1: Create a Firebase Project
1. Go to [console.firebase.google.com](https://console.firebase.google.com).
2. Click **Add project** and name it `DanceWebsite`.
3. Disable Google Analytics (for simplicity) and Create.

## Step 2: Enable Authentication
1. Turning on the "Login" feature:
2. Go to **Build** > **Authentication** > **Get Started**.
3. Select **Email/Password**.
4. Enable the **Email/Password** switch and click **Save**.

## Step 3: Get Your Connection (API Key)
1. Click the **Project Settings** (Gear icon ⚙️) at the top left.
2. Scroll to **Your apps**.
3. Click the **</>** (Web) icon.
4. Register app (Nickname: "DanceApp").
5. You will see a code block like `const firebaseConfig = { ... }`. **Copy this code!**

---

## Step 4: Update Your Code
Open `login.html` and replace your current `<script>` with this (using your copied keys):

```html
<!-- IMPORTS (Place this at the bottom of login.html body) -->
<script type="module">
  // Import the functions you need from the SDKs you need
  import { initializeApp } from "https://www.gstatic.com/firebasejs/10.7.1/firebase-app.js";
  import { getAuth, createUserWithEmailAndPassword, signInWithEmailAndPassword } from "https://www.gstatic.com/firebasejs/10.7.1/firebase-auth.js";

  // PASTE YOUR CONFIG HERE
  const firebaseConfig = {
    apiKey: "YOUR_API_KEY_HERE",
    authDomain: "dancewebsite.firebaseapp.com",
    projectId: "dancewebsite-1234",
    storageBucket: "dancewebsite.appspot.com",
    messagingSenderId: "...",
    appId: "..."
  };

  // Initialize Firebase
  const app = initializeApp(firebaseConfig);
  const auth = getAuth(app);

  // Expose functions to global window so your buttons still work
  window.handleAuth = async function() {
      const u = document.getElementById("user").value;
      const p = document.getElementById("pass").value;
      
      try {
          if (currentMode === 'signup') {
              await createUserWithEmailAndPassword(auth, u + "@example.com", p);
              alert("Account Created! Logging in...");
              window.location.href = "viewer.html";
          } else {
              await signInWithEmailAndPassword(auth, u + "@example.com", p);
              window.location.href = "viewer.html";
          }
      } catch (error) {
          alert("Error: " + error.message);
      }
  }

  // NOTE: Firebase usually requires emails, so we append '@example.com' to usernames automatically 
  // if you want to keep using simple names like 'deepak'.
</script>
```

## Step 5: Hosting (Making it Public)
To let people all over the world see it, you cannot just send them the file. You need to **Host** it.
1. Sign up for **Vercel** or **Netlify** (Free).
2. Drag and drop your `DanceWebsite` folder.
3. They will give you a link like `https://dance-culture-app.vercel.app`.
4. Share that link!
