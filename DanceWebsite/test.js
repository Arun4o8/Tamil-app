function switchView(viewName) {
            document.querySelectorAll('.view-section').forEach(el => el.classList.remove('view-active'));
            const viewEl = document.getElementById('view-' + viewName);
            if (viewEl) viewEl.classList.add('view-active');

            document.querySelectorAll('.nav-item').forEach(el => el.classList.remove('active'));
            const navEl = document.getElementById('nav-' + viewName);
            if (navEl) navEl.classList.add('active');

            if (viewName === 'saved') renderSaved();
            window.location.hash = viewName;

            // Scroll to top when switching views
            window.scrollTo(0, 0);
        }

        function saveDance(name) {
            localStorage.setItem("savedDance", name);
            const toast = document.getElementById('toast');
            toast.style.transform = 'translateX(-50%) translateY(0)';
            setTimeout(() => toast.style.transform = 'translateX(-50%) translateY(150px)', 2000);
        }

        function recordActivity(name) {
            let activity = JSON.parse(localStorage.getItem('recentActivity')) || [];
            activity = activity.filter(item => item.name !== name);
            activity.unshift({ name: name, time: "Just now" });
            if (activity.length > 3) activity.pop();
            localStorage.setItem('recentActivity', JSON.stringify(activity));
            renderActivity();
        }

        const cultureDetailsData = {
            "Bharatanatyam": [
                { section: "Overview", content: "Bharatanatyam is one of the oldest and most popular classical dance forms of India, originating from the holy temples of Tamil Nadu. It is celebrated for its rhythmic footwork, intricate hand gestures, and geometric precision." },
                { section: "History & Origin", content: "Traces back over 2,000 years to the 'Natya Shastra' by Bharata Muni. Historically evolved from 'Sadir', performed as a sacred ritual in ancient Tamil temples." },
                { section: "Cultural Significance", content: "It is a spiritual art form that serves as a medium for 'Bhakti' (devotion) and 'Rasa' (aesthetics). It tells profound stories from Indian mythology through dance and drama." },
                { section: "Costume & Ornaments", content: "Dancers use exquisite silk sarees with pleated fans (that open like a peacock during squats), traditional Temple Jewelry (Kempu), and audible Ghungroos (ankle bells)." },
                { section: "Music & Instruments", content: "Performed to the rich traditions of **Carnatic Music**. The ensemble (Pakkavadhyam) includes: <br>â€¢ **Nattuvangam:** Small cymbals played by the Guru to maintain the rhythm (Tala). <br>â€¢ **Mridangam:** The double-headed drum providing the primary rhythmic beat. <br>â€¢ **Vocal:** A lead singer who narrates the story through soulful ragas. <br>â€¢ **Flute & Violin:** Melodic instruments that enhance the emotional mood (Bhava). <br>â€¢ **Veena:** Sometimes used for its ancient and divine resonance." },
                { section: "Expressions (Abhinaya)", content: "Focuses on 'Abhinaya' (facial expressions) and 'Mudras' (hand gestures) to communicate emotions (Bhava) and narratives (Kathaka) to the audience." },
                { section: "Performance Elements", content: "Consists of Nritta (pure rhythm), Nritya (expressive movement), and Natya (dramatic storytelling), usually starting with an Alarippu and ending with a Thillana." },
                { section: "Styles & Banis (Varieties)", content: "Bharatanatyam has several distinct styles or 'Banis', each with unique characteristics: <br>â€¢ **Pandanallur Bani:** Known for its geometric precision, linear movements, and emphasis on deep Araimandi. <br>â€¢ **Vazhuvoor Bani:** Noted for its grace, fluid transitions, and extensive use of Abhinaya (expressions). <br>â€¢ **Kalakshetra Bani:** A modernized, structured style popularized by Rukmini Devi Arundale, emphasizing sharp, clean lines and angularity. <br>â€¢ **Melattur Bani:** Heavily influenced by the Bhagavata Mela tradition, focusing on dramatic storytelling and rhythmic complexity." },
                { section: "Stage & Temple Connection", content: "Historically patronized in grand temples like the **Brihadisvara Temple (Tanjore)** and **Chidambaram**, where it was performed as an offering. **Example:** Dancers performed during the 'Kumbhabhishekam' and daily rituals in the temple mandapams. Later, **Rukmini Devi Arundale** played a key role in bringing it from templesteps to the modern global stage." }
            ],
            "Karakattam": [
                { section: "Overview", content: "Karakattam is an ancient folk dance of Tamil Nadu performed in praise of the rain goddess Mariamman. It involves balancing a pot (Karagam) on the head while dancing." },
                { section: "History & Origin", content: "Historically known as 'Kudakoothu', this art form has been referenced in ancient Tamil literature like 'Silappatikaram'. It was traditionally performed in temple festivals to ensure a good harvest." },
                { section: "Music & Instruments", content: "The dance is performed to the energetic **Naiyaandi Melam** ensemble: <br>â€¢ **Nadaswaram:** The primary woodwind instrument that leads the melody. <br>â€¢ **Thavil:** A barrel-shaped percussion instrument that provides the loud, fast-paced beat. <br>â€¢ **Pambai & Thamukku:** Smaller drums that add complex rhythmic layers." },
                { section: "Costume", content: "Dancers wear vibrant traditional attire and a brass pot decorated with floral arrangements and a wooden parrot pointing upwards." },
                { section: "Types of Karagam", content: "There are two main varieties: <br>â€¢ **Aatta Karagam:** Performed primarily for entertainment, focusing on balance and difficult acrobatic feats. <br>â€¢ **Sakthi Karagam:** Performed strictly for religious purposes in temples, often following a period of fasting and purification." }
            ],
            "Silambattam": [
                { section: "Overview", content: "Silambattam is an ancient staff-fencing martial art from Tamil Nadu. It is one of the oldest martial arts in the world, emphasizing speed, agility, and precision." },
                { section: "History & Origin", content: "Mentioned in the 'Silappatikaram' (2nd Century AD). It originated in the Kurinji mountains and was used by ancient Tamil kings to train their warriors." },
                { section: "Music & Instruments", content: "Demonstrations are often accompanied by traditional folk instruments to boost adrenaline: <br>â€¢ **Urumi:** A double-headed drum that creates a thunderous sound. <br>â€¢ **Thavil:** Used to provide the fast-paced rhythmic base for footwork. <br>â€¢ **Pambai:** Adds a sharp, echoing rhythm during combat sequences." },
                { section: "Equipment", content: "The primary tool is the 'Silambam' staff, usually made from Kurunthadi bamboo. Other weapons like 'Surul Vaal' (ribbon sword) and 'Vaalkeedam' (sword and shield) are also used." },
                { section: "Techniques", content: "Involves complex footwork patterns (Chuvadu) and rapid circular staff movements to defend against multiple attackers." },
                { section: "Varieties of Practice", content: "Silambattam is practiced in two primary forms: <br>â€¢ **Por-Silambam (Combat):** The raw, martial aspect focused on effective self-defense and attack. <br>â€¢ **Alankara-Silambam (Performance):** Focuses on the aesthetic beauty, rhythmic spinning, and synchronized coordination for public demonstrations." }
            ],
            "Kavadi Attam": [
                { section: "Overview", content: "Kavadi Attam is a religious and ceremonial dance performed by devotees during the worship of Lord Murugan, especially during festivals like Thaipusam." },
                { section: "Concept (Kavadi)", content: "The 'Kavadi' is a decorated wooden arch with peacock feathers, representing the burden carried by the devotee as an act of penance or gratitude." },
                { section: "Music & Instruments", content: "Devotees dance to the spiritual and high-energy **Kavadi Chindu** songs: <br>â€¢ **Urumi:** The 'talking drum' that creates deep, resonating bimbos. <br>â€¢ **Thavil:** Provides the essential rhythmic drive. <br>â€¢ **Nadaswaram:** Sometimes added for grand temple processions." },
                { section: "Visuals & Costume", content: "Devotees often wear saffron or yellow clothes and may perform difficult balancing acts with the Kavadi on their shoulders." },
                { section: "Varieties of Kavadi", content: "Depending on the offering, there are several types: <br>â€¢ **Pal Kavadi:** Bearing pots of milk to be offered for abhishekam. <br>â€¢ **Panneer Kavadi:** Carrying pots of rose water. <br>â€¢ **Pushpa Kavadi:** Decorated heavily with a variety of sacred flowers. <br>â€¢ **Mayil Kavadi:** Adorned with peacock feathers, representing the mount of Lord Murugan." }
            ],
            "Puliyattam": [
                { section: "Overview", content: "Puliyattam (Tiger Dance) is an energetic folk dance where performers mimic the graceful and powerful movements of a tiger." },
                { section: "Artistic Preparation", content: "Dancers paint their entire bodies with vibrant yellow and black stripes. They often wear masks or headpieces to complete the feline appearance." },
                { section: "Music & Instruments", content: "The tiger's pouncing movements are synchronized with the **Thappu** and **Melam**: <br>â€¢ **Thappu:** A flat frame drum that gives a sharp, slapping rhythm. <br>â€¢ **Urumi:** Provides the heavy bass that mimics the roar of the tiger. <br>â€¢ **Cymbals:** Used to signal sudden changes in the tiger's stalking pattern." },
                { section: "Context", content: "Usually performed during temple festivals and village celebrations, it captivates audiences with its raw energy and mimicry." },
                { section: "Regional Variations", content: "While 'Puliyattam' is the core Tamil name, it shares roots with other variations like the **Huli Vesha** of Karnataka and **Puli Kali** of Kerala, each with distinct body paint patterns and rhythmic pulses." }
            ],
            "Therukoothu": [
                { section: "Overview", content: "Therukoothu is an ancient form of street theater from Tamil Nadu that blends music, dance, dialogue, and drama." },
                { section: "Narrative Themes", content: "Plays are traditionally based on Indian epics like the 'Mahabharata'. It was historically used as a medium for moral and religious education." },
                { section: "Music & Instruments", content: "The ensemble, known as the **Koothu Mandali**, provides live backing: <br>â€¢ **Harmonium:** Provides the melodic background for the high-pitched singing. <br>â€¢ **Mridangam:** The primary percussion for the rhythmic dance sequences. <br>â€¢ **Cymbals:** Keeps the 'Tala' or rhythmic cycle intact. <br>â€¢ **Mukhavina:** A small woodwind instrument similar to a Nadaswaram." },
                { section: "Visual Grandeur", content: "Performers wear massive, ornate headgears (Kiridams), thick padding under costumes, and heavy makeup to enhance visibility for large outdoor audiences." }
            ],
            "Kummi": [
                { section: "Overview", content: "Kummi is a popular folk dance of Tamil Nadu, traditionally performed by women standing in a circle and clapping their hands." },
                { section: "Music & Instruments", content: "Unique for its **Acapella** nature, Kummi relies on natural rhythms: <br>â€¢ **Rhythmic Clapping:** The dancers' own hands serve as the primary instrument. <br>â€¢ **Folk Songs:** Lyrics usually celebrate harvest, village life, or goddesses. <br>â€¢ **Foot Stomping:** Adds a grounding beat to the circular rotation." },
                { section: "Cultural Significance", content: "Commonly performed during harvest festivals like 'Pongal' and other family celebrations, it symbolizes community bonding and joy." },
                { section: "Performance Loop", content: "The lead singer starts a verse, and the group follows, moving in a circle and bending in synchronization with the claps." }
            ],
            "Oyillattam": [
                { section: "Overview", content: "Oyillattam, the 'Dance of Grace', is a rhythmic and visually vibrant folk dance traditionally performed by men with colorful handkerchiefs." },
                { section: "Performance Art", content: "Dancers stand in a single row and perform rhythmic steps while waving cloths in their hands. The sync between the row of dancers is a sight to behold." },
                { section: "Music & Instruments", content: "Performed to the energetic beats of: <br>â€¢ **Thavil:** The heavy drum that dictates the pace of the flags/cloths being waved. <br>â€¢ **Cymbals:** Maintains the intricate rhythmic cycle (Tala). <br>â€¢ **Nadaswaram:** Often used to add a festive melodic layer." },
                { section: "Occasions", content: "Often performed during village festivals and grand celebrations in the southern regions of Tamil Nadu." }
            ],
            "Bommalattam": [
                { section: "Overview", content: "Bommalattam is the traditional art of puppetry in Tamil Nadu, combining strings and rods to bring characters to life." },
                { section: "Music & Instruments", content: "Storytelling is enhanced by a live musical troupe: <br>â€¢ **Harmonium:** Provides the background melody for the puppet's dialogues. <br>â€¢ **Mridangam:** Sets the rhythm for the characters' movements. <br>â€¢ **Cymbals & Shakers:** Adds sound effects for different scenes (e.g., combat, rain)." },
                { section: "The Puppets", content: "Puppets are usually made of wood, cloth, and leather. They are known for being exceptionally large and heavy compared to other Indian puppet forms." },
                { section: "Storytelling", content: "The puppeteers stay behind a screen and use songs and dialogues to narrate mythological epics and local legends." }
            ],
            "Villu Paatu": [
                { section: "Overview", content: "Villu Paatu (Bow Song) is an ancient musical storytelling tradition where a large bow serves as the primary musical instrument." },
                { section: "Music & Instruments", content: "The heart of this performance is the **Villu (Bow)**: <br>â€¢ **Villu:** A long bow struck with sticks (Veesu-kol) to create a jangling rhythmic sound. <br>â€¢ **Kudam:** A pot placed under the string to act as a resonator. <br>â€¢ **Udukku:** A small hour-glass drum that maintains the flow. <br>â€¢ **Cymbals:** Used by the supporting singers to keep time." },
                { section: "Narrative Style", content: "The main storyteller leads the troop in a musical dialogue, often preaching social values or narrating historical events." },
                { section: "Types of Stories", content: "Performances are categorized into: <br>â€¢ **Mythological:** Narrating epics like the Ramayana or stories of local deities. <br>â€¢ **Social:** Narrating tales of social reformation, bravery of local heroes, or current environmental themes." }
            ],
            "Kolattam": [
                { section: "Overview", content: "Kolattam is a traditional folk dance where participants strike bamboo sticks (Kalaada) together in rhythm. It is a dance of joy and community." },
                { section: "History & Origin", content: "One of the oldest recreational dances of Tamil Nadu, mentioned in ancient literature. It is often performed during the harvest season and temple festivals." },
                { section: "Music & Instruments", content: "The dance is performed to fast-paced folk songs, where the **rhythmic striking of sticks** provides the primary percussion, often accompanied by a Dholak or Thalam." },
                { section: "Pinnal Kolattam", content: "A complex variety where dancers hold ropes attached to a central pole. As they dance and strike sticks, they weave the ropes into an intricate braid and then unweave it in the second half of the performance." }
            ],
            "Poikkal Kuthirai Attam": [
                { section: "Overview", content: "Poikkal Kuthirai Attam (Dummy Horse Dance) features dancers wearing a horse-shaped frame around their hips, mimicking the movements of a rider." },
                { section: "Artistic Craft", content: "The horse frame is intricately decorated with colorful paper and beads. Dancers perform on wooden stilts or heavy wooden shoes to mimic the sound of hooves." },
                { section: "Music & Instruments", content: "Accompanied by the **Naiyaandi Melam** ensemble, featuring the Nadaswaram and Thavil, providing a high-energy backdrop for the performance." },
                { section: "Performance Varieties", content: "While common in Tamil Nadu, this art shares characteristics with the **Kacchi Ghori** dance of Rajasthan, showing its broad cultural resonance across India." }
            ],
            "Mayil Aattam": [
                { section: "Overview", content: "Mayil Aattam (Peacock Dance) is a graceful folk dance where performers dress as peacocks, using feathers and a beak to mimic the bird's movements." },
                { section: "Cultural Context", content: "Primarily performed in Hindu temples as an offering to Lord Murugan, whose mount (vahana) is the peacock." },
                { section: "Music & Instruments", content: "Danced to the rhythmic beats of the **Thavil** and the melodic strains of the **Nadaswaram**, capturing the elegance of the peacock." }
            ],
            "Devaraattam": [
                { section: "Overview", content: "Devaraattam is a traditional celebratory dance of victory, traditionally performed by men holding colorful handkerchiefs." },
                { section: "History", content: "Historically performed for Tamil kings returning from battle. It is characterized by bold steps and rhythmic arm swings." },
                { section: "Music & Instruments", content: "The dance is exclusively performed to the thunderous beats of the **Urumi Melam**, a set of double-headed drums that create a powerful resonance." }
            ],
            "Paampu Attam": [
                { section: "Overview", content: "Paampu Attam (Snake Dance) is a unique folk form where dancers mimic the slithering, twisting, and striking movements of a cobra." },
                { section: "Artistic Expression", content: "Dancers wear skin-tight costumes with snake patterns and use fluid body movements to represent the serpent's grace and danger." },
                { section: "Music & Instruments", content: "Accompanied by the **Magudi** (Pungi), the traditional wind instrument used by snake charmers, along with rhythmic drum beats." }
            ],
            "Paraiattam": [
                { section: "Overview", content: "Paraiattam is a high-energy dance performed with the Parai, one of the oldest percussion instruments of the Tamil people." },
                { section: "Symbolism", content: "The Parai drum was historically used to announce royal decrees and gather people. Today, it symbolizes resistance, celebration, and cultural pride." },
                { section: "Music & Instruments", content: "The **Parai** drum itself is the star, creating a sharp, slapping rhythm that is often accompanied by energetic chants and athletic dance moves." },
                { section: "Playing Varieties", content: "Performances vary from the somber **Funeral Processions** (where it serves a ritualistic purpose) to the high-energy **Temple Festivals** and **Social Awareness Rallies**, where it is a symbol of strength and resistance." }
            ],

            "Default": [
                { section: "Overview", content: "A traditional Tamil cultural heritage form that blends movement, rhythm, and storytelling." },
                { section: "Significance", content: "This art form represents the rich social and spiritual history of the Tamil people, passed down through generations." }
            ]
        };

        let activeDetailCulture = "";

        window.showCultureDetail = function (cultureName) {
            console.log("Opening details for: " + cultureName);
            activeDetailCulture = cultureName;
            recordActivity(cultureName + " (Explored)");

            const nameEl = document.getElementById('detail-culture-name');
            const imgEl = document.getElementById('detail-culture-image');
            const contentEl = document.getElementById('culture-detail-content');

            if (!nameEl || !imgEl || !contentEl) {
                console.error("Critical elements missing for detail view!");
                return;
            }

            nameEl.innerText = cultureName;

            // Map image
            const imgPath = "assets/cultures/" + cultureName.toLowerCase().replace(/\s/g, "") + "/thumb.png";
            imgEl.src = imgPath;
            imgEl.onerror = () => { imgEl.src = "https://images.unsplash.com/photo-1583244532610-2ca270176b05?auto=format&fit=crop&q=400"; };

            // Render details
            const data = cultureDetailsData[cultureName] || cultureDetailsData["Default"];

            let html = `
                <div style="margin-top: 10px; font-family: 'Outfit', sans-serif;">
                    <div style="font-size: 1.3rem; font-weight: 700; color: var(--primary); margin-bottom: 20px; display: flex; align-items: center; gap: 10px;">
                        <i class="fas fa-folder-open"></i> ${cultureName}
                    </div>
            `;

            data.forEach((group, index) => {
                html += `
                    <div class="animate-fade-in" style="margin-bottom: 20px; animation-delay: ${index * 0.1}s;">
                        <div style="color: var(--secondary); font-weight: 600; font-size: 1.1rem; margin-bottom: 8px; display: flex; align-items: center;">
                            <i class="fas fa-caret-right" style="color: var(--primary); margin-right: 10px;"></i> ${group.section}
                        </div>
                        <div style="margin-left: 45px; border-left: 2px solid rgba(255,255,255,0.05); padding-left: 15px;">
                            <div class="glass-panel" style="padding: 15px; border-radius: 12px;">
                                <p style="font-size: 0.95rem; line-height: 1.6; color: var(--text-muted); margin: 0;">${group.content}</p>
                            </div>
                        </div>
                    </div>
                `;
            });

            html += `</div>`;
            contentEl.innerHTML = html;

            switchView('culture-detail');
        }

        window.startTrainingFromDetail = function () {
            startTraining(activeDetailCulture);
        }

        window.launchXRFromDetail = (mode) => {
            if (mode === 'XR') {
                if (typeof connectToUnity === 'function') {
                    connectToUnity(window.activeDetailCulture, "Free Practice Mode");
                } else {
                    alert(`Starting VR Immersive Experience: ${window.activeDetailCulture}`);
                }
                if (typeof recordActivity === 'function') {
                    recordActivity(window.activeDetailCulture + " - VR Mode View");
                }
            } else {
                const msg = localStorage.getItem('selectedLanguage') === 'ta' ? `AR காட்சியைத் தொடங்குகிறது ${window.activeDetailCulture}... உங்கள் கேமராவை ஒரு தட்டையான மேற்பரப்பில் காட்டுங்கள்!` : `Opening AR View for ${window.activeDetailCulture}... Point your camera at a flat surface!`;
                alert(msg);
                if (typeof recordActivity === 'function') {
                    recordActivity(window.activeDetailCulture + " - AR Mode View");
                }
            }
        };


        function renderActivity() {
            let activity = JSON.parse(localStorage.getItem('recentActivity')) || [];
            let container = document.getElementById('activity-list');



            if (activity.length === 0) {
                container.innerHTML = '<p style="color: var(--text-muted); text-align: center; font-size: 0.9rem;">Start exploring to see history here!</p>';
                return;
            }

            container.innerHTML = activity.map(item => `
                <div class="glass-panel animate-fade-in" style="margin-bottom: 10px; padding: 15px;">
                    <div style="display: flex; gap: 15px; align-items: center;">
                        <div style="background: rgba(255,255,255,0.1); width: 40px; height: 40px; border-radius: 10px; display: flex; align-items: center; justify-content: center;">
                            <i class="fas fa-history" style="color: var(--secondary);"></i>
                        </div>
                        <div style="text-align: left;">
                            <h4 style="margin: 0; font-size: 1rem;">${item.name}</h4>
                            <p style="margin: 0; font-size: 0.8rem; color: var(--text-muted);">${item.time}</p>
                        </div>
                    </div>
                </div>
            `).join('');
        }

        function renderSaved() {
            const saved = localStorage.getItem("savedDance");
            const container = document.getElementById('saved-item-text');
            if (saved) {
                container.innerHTML = `<span style="color: var(--text-main); font-weight: 600;">Saved: ${saved}</span>`;
            }
        }


        /* 
           TRAINING LOGIC MOVED TO js/app-logic.js
           - methodsData
           - startTraining
           - showMethod
           - launchMethodExperience
        */

        function launchMode(name, mode) {
            if (mode === 'XR' || mode === 'XR Immersive') {
                connectToUnity(name, "Immersive Exploration");
                recordActivity(name + " (XR Immersive)");
                return;
            }

            let msg = "";
            let category = "";
            if (mode === 'AR') {
                msg = "Opening AR View for " + name + "... Point your camera at a flat surface!";
                category = " (AR View)";
            } else if (mode === 'Step') {
                msg = "Starting Step-by-Step Training for " + name + "... Follow the markers!";
                category = " (Training)";
            }
            alert(msg);
            recordActivity(name + category);
        }

        // --- UNITY BRIDGE LOGIC ---
        let unityInstance = null; // This will hold the Unity instance after initialization

        function connectToUnity(cultureName, methodTitle) {
            document.getElementById('unity-culture-label').innerText = cultureName + " AR/VR: " + methodTitle;
            document.getElementById('unity-path-hint').innerText = `/assets/cultures/${cultureName.toLowerCase().replace(/\s/g, "")}/model.glb`;

            // Switch to Unity view
            switchView('unity');

            // If unity is already loaded, tell it to switch culture immediately
            if (unityInstance) {
                unityRequestCulture(cultureName);
            }
        }

        // Communication TO Unity
        function unityRequestCulture(cultureName) {
            console.log("Sending command to Unity: Load culture -> " + cultureName);
            if (unityInstance) {
                // Syntax: unityInstance.SendMessage('GAMEOBJECT_NAME', 'FUNCTION_NAME', 'VALUE');
                unityInstance.SendMessage('CultureManager', 'LoadArtForm', cultureName);
            }
        }

        // Communication FROM Unity (Call this from Unity C# scripts using Application.ExternalCall)
        window.onUnityLoaded = function () {
            console.log("Unity Engine fully loaded and ready.");
            document.getElementById('unity-loading-bar').style.display = 'none';
            // Trigger initial load if we have a culture selected
            const cultureToLoad = activeDetailCulture || currentTrainingCulture || "Bharatanatyam";
            unityRequestCulture(cultureToLoad);
        }

        function toggleTheme() {
            const root = document.documentElement;
            const icon = document.getElementById('theme-toggle-icon');
            if (root.getAttribute('data-theme') === 'light') {
                root.removeAttribute('data-theme');
                icon.className = 'fas fa-toggle-on';
                icon.style.color = 'var(--primary)';
            } else {
                root.setAttribute('data-theme', 'light');
                icon.className = 'fas fa-toggle-off';
                icon.style.color = 'var(--text-muted)';
            }
        }

        let selectedCulture = "";

        function openExperience(name) {
            selectedCulture = name;
            document.getElementById('exp-title').innerText = name;
            document.getElementById('experience-modal').style.display = 'flex';
        }

        function closeExperience() {
            document.getElementById('experience-modal').style.display = 'none';
        }

        function proceedExperience(mode) {
            closeExperience();
            if (mode === 'Info') {
                showCultureDetail(selectedCulture);
            } else if (mode === 'Step-by-Step' || mode === 'Training') {
                startTraining(selectedCulture);
                recordActivity(selectedCulture + " (Training)");
            } else if (mode === 'AR View') {
                alert("Opening AR Camera for " + selectedCulture + ". Please point your camera to a flat surface.");
                recordActivity(selectedCulture + " (AR View)");
            } else if (mode === 'XR Immersive') {
                connectToUnity(selectedCulture, "Immersive 3D Exploration");
                recordActivity(selectedCulture + " (XR Immersive)");
            } else {
                recordActivity(selectedCulture + " (" + mode + ")");
            }
        }

        window.toggleHeaderMenu = function () {
            const menu = document.getElementById('header-menu');
            if (menu.style.display === 'none') {
                menu.style.display = 'flex';
                // Close when clicking outside
                document.addEventListener('click', closeMenuOutside);
            } else {
                menu.style.display = 'none';
                document.removeEventListener('click', closeMenuOutside);
            }
        }

        function closeMenuOutside(event) {
            const menu = document.getElementById('header-menu');
            const icon = document.querySelector('.fa-ellipsis-v');
            if (!menu.contains(event.target) && event.target !== icon) {
                menu.style.display = 'none';
                document.removeEventListener('click', closeMenuOutside);
            }
        }

        const quizRounds = [
            {
                title: "Round 1: History & Origins",
                questions: [
                    { question: "Historical records show Bharatanatyam evolved from which ancient dance form?", options: ["Sadir", "Kathak", "Odissi", "Kuchipudi"], answer: 0 },
                    { question: "Which dance is traditionally performed in honor of the rain goddess Mari Amman?", options: ["Karakattam", "Mayil Aattam", "Kummi", "Villu Paatu"], answer: 0 },
                    { question: "Who was the legendary pioneer responsible for bringing Bharatanatyam to the global stage?", options: ["Rukmini Devi Arundale", "Padma Subrahmanyam", "Birju Maharaj", "Mallika Sarabhai"], answer: 0 },
                    { question: "Devaraattam was historically performed to celebrate the return of whom?", options: ["Victorious Kings", "Harvest Festival", "Temple Priests", "Monsoon Rain"], answer: 0 }
                ]
            },
            {
                title: "Round 2: Rhythms & Instruments",
                questions: [
                    { question: "Which instrument in Villu Paatu uses a pot resonator placed under the string?", options: ["Kudam", "Thavil", "Mridangam", "Urumi"], answer: 0 },
                    { question: "In the folk dance 'Kummi', what is the dancers' primary rhythmic instrument?", options: ["Hand Claps", "Bamboo Sticks", "Cymbals", "Ankle Bells"], answer: 0 },
                    { question: "What is the woodwind instrument that typically leads the melody in Tamil folk ensembles?", options: ["Nadaswaram", "Flute", "Harmonium", "Shehnai"], answer: 0 },
                    { question: "Which 'talking drum' is known for creating deep vibrations that mimic a tiger's roar?", options: ["Urumi", "Parai", "Ghatam", "Veena"], answer: 0 }
                ]
            },
            {
                title: "Round 3: Visuals & Costumes",
                questions: [
                    { question: "What do Poikkal Kuthirai dancers wear to create the rhythmic sound of hooves?", options: ["Wooden Stilts", "Iron Boots", "Silver Chains", "Leather Sandals"], answer: 0 },
                    { question: "The 'Salangai' is a vital part of a dancer's attire. What is it?", options: ["Ankle Bells", "Silk Saree", "Head Crown", "Hand Rings"], answer: 0 },
                    { question: "Which dance features performers waving colorful handkerchiefs in a graceful row?", options: ["Oyillattam", "Karakattam", "Silambattam", "Therukoothu"], answer: 0 },
                    { question: "In Puliyattam, what vibrant colors are predominantly used for body painting?", options: ["Yellow and Black", "Red and Green", "Blue and Silver", "White and Gold"], answer: 0 }
                ]
            },
            {
                title: "Round 4: Arts & Traditions",
                questions: [
                    { question: "Silambattam martial arts originated in which specific mountain range?", options: ["Kurinji", "Himalayas", "Vindhyas", "Sahyadri"], answer: 0 },
                    { question: "Which dance form focuses on mimicking the slithering and hooded poses of a cobra?", options: ["Paampu Attam", "Mayil Aattam", "Puliyattam", "Bommalattam"], answer: 0 },
                    { question: "Bommalattam (Puppetry) traditionally uses puppets made from which material?", options: ["Wood & Leather", "Plastic & Metal", "Glass & Clay", "Paper & Thread"], answer: 0 },
                    { question: "Kavadi Attam is most famously associated with which Tamil festival?", options: ["Thaipusam", "Pongal", "Diwali", "Karthigai Deepam"], answer: 0 }
                ]
            }
        ];

        let currentRoundIndex = 0;
        let currentQuestionIndex = 0;
        let quizScore = 0;

        window.startQuiz = function () {
            currentRoundIndex = 0;
            currentQuestionIndex = 0;
            quizScore = 0;
            document.getElementById('quiz-intro').style.display = 'none';
            document.getElementById('quiz-result').style.display = 'none';
            document.getElementById('quiz-active').style.display = 'block';
            renderQuestion();
        }

        function renderQuestion() {
            const round = quizRounds[currentRoundIndex];
            const q = round.questions[currentQuestionIndex];

            document.getElementById('quiz-round-title').innerText = round.title;
            document.getElementById('quiz-question').innerText = q.question;

            const totalQuestionsInRound = round.questions.length;
            document.getElementById('quiz-progress').innerText = `Question ${currentQuestionIndex + 1} of ${totalQuestionsInRound} (Round ${currentRoundIndex + 1}/4)`;
            document.getElementById('quiz-score-ui').innerText = `Score: ${quizScore}`;
            document.getElementById('quiz-bar').style.width = ((currentQuestionIndex + 1) / totalQuestionsInRound * 100) + '%';

            const optionsContainer = document.getElementById('quiz-options');
            optionsContainer.innerHTML = '';
            q.options.forEach((opt, idx) => {
                const btn = document.createElement('button');
                btn.className = 'btn-secondary';
                btn.style.textAlign = 'left';
                btn.style.padding = '15px';
                btn.innerText = opt;
                btn.onclick = () => handleQuizAnswer(idx);
                optionsContainer.appendChild(btn);
            });
        }

        function handleQuizAnswer(selectedIndex) {
            const round = quizRounds[currentRoundIndex];
            const correctIndex = round.questions[currentQuestionIndex].answer;
            const btns = document.getElementById('quiz-options').querySelectorAll('button');

            if (selectedIndex === correctIndex) {
                quizScore++;
                btns[selectedIndex].style.background = 'rgba(76, 175, 80, 0.2)';
                btns[selectedIndex].style.borderColor = '#4caf50';
            } else {
                btns[selectedIndex].style.background = 'rgba(244, 67, 54, 0.2)';
                btns[selectedIndex].style.borderColor = '#f44336';
                btns[correctIndex].style.background = 'rgba(76, 175, 80, 0.2)';
                btns[correctIndex].style.borderColor = '#4caf50';
            }

            btns.forEach(b => b.onclick = null);

            setTimeout(() => {
                currentQuestionIndex++;
                if (currentQuestionIndex < round.questions.length) {
                    renderQuestion();
                } else if (currentRoundIndex < quizRounds.length - 1) {
                    currentRoundIndex++;
                    currentQuestionIndex = 0;
                    const nextRound = quizRounds[currentRoundIndex];
                    alert(`Round Complete! Get ready for ${nextRound.title}.`);
                    renderQuestion();
                } else {
                    showQuizResult();
                }
            }, 1200);
        }

        function showQuizResult() {
            const totalQuestions = quizRounds.reduce((acc, round) => acc + round.questions.length, 0);
            document.getElementById('quiz-active').style.display = 'none';
            document.getElementById('quiz-result').style.display = 'block';
            document.getElementById('result-score-text').innerText = `Total Score: ${quizScore} out of ${totalQuestions}`;

            let feedback = "";
            const percent = (quizScore / totalQuestions) * 100;
            if (percent === 100) feedback = "Master Class! You passed all rounds with flying colors.";
            else if (percent >= 70) feedback = "Great job! Your knowledge of history and music is impressive.";
            else feedback = "Nice attempt! Explore the history tree to master the music and origins.";

            document.getElementById('result-feedback').innerText = feedback;
            recordActivity("Quiz Rounds Completed (Score: " + quizScore + ")");
        }

        window.onload = function () {
            renderActivity();
            const hash = window.location.hash.replace('#', '');
            if (hash && document.getElementById('view-' + hash)) switchView(hash);
        };
    