# XR Tamil - Project Implementation & Methodology Reference

This document serves as a comprehensive technical guide for the **XR Tamil Culture** web application. It outlines the project's architecture, tools, and the step-by-step methodology used during development for future maintenance and scaling.

---

## 1. Project Architecture Overview
The application is designed as a **Single Page Application (SPA)** with a **Hybrid Mobile-First** approach. While multiple `.html` files exist for legacy/backup reasons, the primary logic and advanced features are consolidated into `viewer.html`.

### Exact Languages Used
- **HTML5**: For page structure and semantic organization.
- **CSS3**: For the entire design system, including Glassmorphism and responsive layouts.
- **JavaScript (ES6+)**: For all application logic, view switching, and Firebase integration.
- **Markdown**: For project documentation and technical guides.
- **(Planned) C#**: Specifically for Unity scripts to handle 3D model loading and interactions.

---

## 2. Directory & Asset Methodology
We implemented a **Folder-Based Asset System** to ensure scalability for AR/VR models.

### Structure:
- `/assets/cultures/`
  - `/[culture_name]/`
    - `thumb.png`: The visual icon/thumbnail used across the app.
    - `model.glb`: (Planned) The 3D model path sent to the Unity Engine.

**Benefit**: This allows the Unity Engine to predict the path of any culture's 3D assets simply by converting the culture name to lowercase (e.g., `Bharatanatyam` -> `assets/cultures/bharatanatyam/model.glb`).

---

## 3. Step-By-Step Development Process

### Phase 1: Foundation & Authentication
- **Firebase Auth**: Integrated Firebase SDK to handle user accounts.
- **Admin Backdoor**: Implemented a bypass (`admin` / `1234`) for rapid testing without external API calls.
- **SPA Routing**: Created the `switchView(viewName)` function.
  - *How it works*: It hides all `.view-section` elements and shows only the target ID. It also manages the browser `#hash` to support the "Back" button.

### Phase 2: Navigation & Dashboard
- **Bottom Navigation**: Fixed-position navigation bar with high Z-index.
- **Progress Tracking**: Logic to calculate "Exploration %" based on unique items in `localStorage['recentActivity']`.
- **Quick Links**: Direct triggers for Training and Exploration views.
- **Cultural Quiz**: Implemented a dynamic quiz system to test users' knowledge of Tamil heritage, featuring real-time feedback and score tracking.

### Phase 3: Cultural Exploration (The History Tree) [COMPLETED]
- All 16 major Tamil art forms (Bharatanatyam, Karakattam, Silambattam, Kavadi Attam, Puliyattam, Therukoothu, Kummi, Oyillattam, Bommalattam, Villu Paatu, Kolattam, Poikkal Kuthirai, Mayil Aattam, Devaraattam, Paampu Attam, and Paraiattam) are now fully populated with multi-section history data.
- **Exploration Click Mechanics**: 
    - *The Trigger*: Every dance card in the `dance-grid` has an `onclick` event listener pointing to `showCultureDetail('CultureName')`.
    - *Interactive Logic*: We moved the click event from the text to the **entire card container** to make it touch-friendly. 
    - *Event Isolation*: Used `event.stopPropagation()` on the "Save" (Heart) icons to ensure clicking "Save" doesn't accidentally trigger the History view.
- **Tree-Like Rendering**: 
    - *The Logic*: The `showCultureDetail()` function performs three tasks:
        1. It identifies the culture name and fetches its specific array from `cultureDetailsData`.
        2. It map-renders the content with a vertical connector line (`border-left`) and horizontal branch icons (`├──`).
        3. It calls `switchView('culture-detail')` to animate the transition.

### Phase 5: Festivals, Navigation & Translation Integrity [COMPLETED]
- **Celebrations Expansion**: Integrated 6 new festivals (Bhogi, Thaipongal, Mattu Pongal, Kaanum Pongal, Deepavali, and Aadi Pattam) into a dedicated view-driven system.
- **Navigation Overhaul**:
    - Centralized navigation icon added to the **Bottom Nav Bar** ("Events").
    - New access point created in the **Hamburger Side Menu** ("Celebrations").
    - Deep-linking implemented from the **Home Dashboard** card to the Celebrations grid.
- **Smart Logic & Hardening**:
    - Fixed critical layout bugs related to nested `div` structure in the home view.
    - Improved `showCultureDetail` to dynamically handle back-navigation (returning to either Dances or Festivals depending on context).
    - Hardened the **Translation Engine** by moving all Tamil dictionary data inline and using a robust query-selector based approach for 100% reliable multi-language support.

---

## 4. Tools & Procedure Reference

| Feature | Tool / Method | Procedure |
| :--- | :--- | :--- |
| **View Switching** | `switchView()` | Updates `.view-active` class and `window.location.hash`. |
| **History Logic** | `showCultureDetail(name)` | Pulls from `cultureDetailsData` and builds the Tree UI. |
| **Activity/Save** | `localStorage` | Uses `JSON.stringify` to store arrays of user progress. |
| **Redirects** | `window.location.href` | Used in legacy files (`home.html`, `explore.html`) to funnel users into the master `viewer.html`. |
| **Theming** | `root.setAttribute` | Toggles between Dark/Light modes using CSS Variables. |
| **Translation** | `window.changeLanguage(lang)` | In-place DOM updates using `data-i18n` and ID maps. |

---

## 5. Instructions for Future Scaling

### Adding a New Culture / Festival
1. Create a folder in `/assets/cultures/[newname]/`.
2. Add a `thumb.png` to that folder.
3. Add the data object to `cultureDetailsData` inside `viewer.html`.
4. (Optional) Add the Tamil translation to `window.TAMIL` and `window.cultureDetailsTamil`.
5. Add a card to the corresponding grid (`dance-grid` or `celebrations-grid`).

### Integrating New Unity Builds
1. Export your Unity project as **WebGL**.
2. Place the build files in the root directory.
3. Ensure your Unity `CultureManager` script has a public function named `LoadArtForm(string name)`.

---

*Document Updated: Mar 11, 2026*
*Status: Architecture Hardened & Festivals Live*
