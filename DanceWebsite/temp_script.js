import { } from 'firebase';

        import { initializeApp } from "https://www.gstatic.com/firebasejs/10.7.1/firebase-app.js";
        import { getAuth, signOut, onAuthStateChanged, updateProfile } from "https://www.gstatic.com/firebasejs/10.7.1/firebase-auth.js";

        const firebaseConfig = {
            apiKey: "AIzaSyAf_RQx8vc-ejThWx5U-W9F5xvQwKMRV6k",
            authDomain: "dancewebsite-a672c.firebaseapp.com",
            projectId: "dancewebsite-a672c",
            storageBucket: "dancewebsite-a672c.firebasestorage.app",
            messagingSenderId: "306223842216",
            appId: "1:306223842216:web:f7d47d407ffce1d735539d",
            measurementId: "G-3V06DPZS6P"
        };

        const app = initializeApp(firebaseConfig);
        const auth = getAuth(app);

        onAuthStateChanged(auth, (user) => {
            if (user) {
                document.getElementById('user-email').innerText = user.email;
                const displayName = user.displayName || user.email.split('@')[0];
                document.querySelectorAll('.profile-name-display').forEach(el => el.innerText = displayName);

                const localPic = localStorage.getItem('user_avatar_' + user.uid);
                if (localPic) {
                    document.querySelectorAll('.profile-pic-img').forEach(el => el.src = localPic);
                } else if (user.photoURL) {
                    document.querySelectorAll('.profile-pic-img').forEach(el => el.src = user.photoURL);
                }
            } else {
                window.location.href = "login.html";
            }
        });

        window.handleLogout = function () {
            signOut(auth).then(() => {
                window.location.href = "index.html";
            });
        }

        window.editProfile = async function () {
            const user = auth.currentUser;
            let newName = prompt("Enter your new name:", user.displayName || "");
            if (newName) {
                await updateProfile(user, { displayName: newName });
                document.querySelectorAll('.profile-name-display').forEach(el => el.innerText = newName);
            }
        }

        // --- CAMERA LOGIC ---
        let stream = null;
        window.triggerFileSelect = function () {
            const modal = document.getElementById('camera-modal');
            const video = document.getElementById('webcam-feed');
            if (navigator.mediaDevices && navigator.mediaDevices.getUserMedia) {
                navigator.mediaDevices.getUserMedia({ video: { facingMode: "user" } })
                    .then(function (s) {
                        stream = s;
                        video.srcObject = stream;
                        modal.style.display = 'flex';
                    })
                    .catch(() => document.getElementById('file-input').click());
            } else {
                document.getElementById('file-input').click();
            }
        }

        window.closeCamera = function () {
            document.getElementById('camera-modal').style.display = 'none';
            if (stream) stream.getTracks().forEach(track => track.stop());
        }

        window.takePhoto = function () {
            const video = document.getElementById('webcam-feed');
            const canvas = document.getElementById('camera-canvas');
            canvas.width = video.videoWidth; canvas.height = video.videoHeight;
            canvas.getContext('2d').drawImage(video, 0, 0);
            const dataUrl = canvas.toDataURL('image/png');
            document.querySelectorAll('.profile-pic-img').forEach(el => el.src = dataUrl);
            localStorage.setItem('user_avatar_' + auth.currentUser.uid, dataUrl);
            closeCamera();
        }

        window.handleFileSelect = function (event) {
            const file = event.target.files[0];
            const reader = new FileReader();
            reader.onload = (e) => {
                document.querySelectorAll('.profile-pic-img').forEach(el => el.src = e.target.result);
                localStorage.setItem('user_avatar_' + auth.currentUser.uid, e.target.result);
            };
            reader.readAsDataURL(file);
        }
    