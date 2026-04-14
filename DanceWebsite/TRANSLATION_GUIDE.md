# Translation Library Documentation

## 📚 Overview
The AR/XR Tamil Culture platform uses a centralized translation system to manage all bilingual content (English & Tamil).

## 🎯 Key Benefits
- ✅ **Single Source of Truth**: All translations in one file
- ✅ **Easy Updates**: Update both languages in one place
- ✅ **Validation**: Automatically detect missing translations
- ✅ **Consistency**: Ensures all text uses the same translation keys
- ✅ **Maintainability**: Easy to add new translations

---

## 📁 File Structure
```
js/
├── translations.js    ← Main translation library (NEW)
└── app-logic.js      ← Application logic (uses translations)
```

---

## 🚀 How to Use

### 1. **Adding New Translations**

Open `js/translations.js` and add your new key to **BOTH** languages:

```javascript
const TRANSLATIONS = {
    'en': {
        // ... existing translations ...
        'my_new_key': 'My English Text',
    },
    'ta': {
        // ... existing translations ...
        'my_new_key': 'என் தமிழ் உரை',
    }
};
```

### 2. **Using Translations in HTML**

Add an ID to your HTML element:
```html
<h1 id="my-element">Default Text</h1>
```

### 3. **Applying Translation in JavaScript**

In your `changeLanguage()` function or initialization:
```javascript
const myElement = document.getElementById('my-element');
if (myElement) {
    myElement.innerText = getTranslation('my_new_key', lang);
}
```

---

## 🔧 Helper Functions

### `getTranslation(key, lang)`
Get a single translation:
```javascript
const text = getTranslation('welcome_to', 'ta');
// Returns: 'வரவேற்கிறோம்'
```

### `getAllTranslations(lang)`
Get all translations for a language:
```javascript
const allTamil = getAllTranslations('ta');
console.log(allTamil.home); // 'முகப்பு'
```

### `translationExists(key)`
Check if a key exists in both languages:
```javascript
if (translationExists('my_key')) {
    console.log('Translation is complete!');
}
```

### `getMissingTranslations()`
Find missing translations:
```javascript
const missing = getMissingTranslations();
console.log(missing.missingInTamil);    // Keys missing Tamil translation
console.log(missing.missingInEnglish);  // Keys missing English translation
```

---

## 📋 Translation Categories

The library organizes translations into logical groups:

1. **Navigation & Common** - Basic UI elements
2. **Menu & Settings** - App settings and menu items
3. **About Page** - Company and team information
4. **Dance Forms** - Names of all 16 art forms
5. **Dance Categories** - Classification labels
6. **Training & Learning** - Educational content
7. **Quiz** - Quiz-related text
8. **Activity** - User activity tracking
9. **Auth & Profile** - Login and profile management
10. **Gender Settings** - Avatar preferences
11. **Support** - Help and FAQ content
12. **Misc** - Other general text

---

## ✅ Best Practices

### DO:
- ✅ Use descriptive key names (`welcome_message` not `msg1`)
- ✅ Add translations to BOTH languages simultaneously
- ✅ Group related translations with comments
- ✅ Test both languages after adding new keys
- ✅ Run `getMissingTranslations()` periodically

### DON'T:
- ❌ Hardcode text directly in HTML/JS
- ❌ Add a key to only one language
- ❌ Use special characters in key names
- ❌ Duplicate keys across categories

---

## 🔄 Migration Guide

### From Old System to New Library

**Old Way (app-logic.js):**
```javascript
window.translations = {
    'en': { 'home': 'Home' },
    'ta': { 'home': 'முகப்பு' }
};
```

**New Way (translations.js):**
```javascript
// Already defined in TRANSLATIONS object
const homeText = getTranslation('home', currentLang);
```

---

## 🧪 Testing Translations

### Check for Missing Translations
```javascript
// Run in browser console
const missing = getMissingTranslations();
if (missing.missingInTamil.length > 0) {
    console.warn('Missing Tamil translations:', missing.missingInTamil);
}
if (missing.missingInEnglish.length > 0) {
    console.warn('Missing English translations:', missing.missingInEnglish);
}
```

### Verify a Translation
```javascript
// Check if translation exists
if (translationExists('my_key')) {
    console.log('EN:', getTranslation('my_key', 'en'));
    console.log('TA:', getTranslation('my_key', 'ta'));
}
```

---

## 📝 Example: Adding a New Feature

Let's add a "Favorites" feature:

### Step 1: Add Translations
```javascript
// In js/translations.js
'en': {
    // ... existing ...
    'favorites': 'Favorites',
    'add_to_favorites': 'Add to Favorites',
    'remove_from_favorites': 'Remove from Favorites',
    'no_favorites': 'No favorites yet',
},
'ta': {
    // ... existing ...
    'favorites': 'பிடித்தவை',
    'add_to_favorites': 'பிடித்தவைகளில் சேர்',
    'remove_from_favorites': 'பிடித்தவைகளிலிருந்து நீக்கு',
    'no_favorites': 'இன்னும் பிடித்தவை இல்லை',
}
```

### Step 2: Add HTML
```html
<button id="fav-btn" onclick="toggleFavorite()">
    Add to Favorites
</button>
<p id="no-fav-msg">No favorites yet</p>
```

### Step 3: Apply Translations
```javascript
function changeLanguage(lang) {
    // ... existing code ...
    
    // Favorites
    const favBtn = document.getElementById('fav-btn');
    if (favBtn) favBtn.innerText = getTranslation('add_to_favorites', lang);
    
    const noFavMsg = document.getElementById('no-fav-msg');
    if (noFavMsg) noFavMsg.innerText = getTranslation('no_favorites', lang);
}
```

---

## 🎨 Current Translation Coverage

**Total Keys**: ~150+
**Languages**: 2 (English, Tamil)
**Categories**: 12

### Coverage by Category:
- Navigation & Common: 15 keys
- Menu & Settings: 9 keys
- About Page: 18 keys
- Dance Forms: 16 keys
- Dance Categories: 16 keys
- Training & Learning: 13 keys
- Quiz: 9 keys
- Activity: 5 keys
- Auth & Profile: 9 keys
- Gender Settings: 4 keys
- Support: 6 keys
- Misc: 10 keys

---

## 🔍 Troubleshooting

### Translation Not Showing?
1. Check if key exists: `translationExists('your_key')`
2. Verify HTML element has correct ID
3. Ensure `changeLanguage()` is called
4. Check browser console for errors

### Missing Translation Warning?
1. Run `getMissingTranslations()`
2. Add missing keys to both languages
3. Test in both English and Tamil

---

## 📞 Support

For questions or issues with the translation system:
- Check this documentation first
- Review `js/translations.js` for examples
- Test using browser console helper functions

---

**Last Updated**: February 2026  
**Version**: 1.0  
**Maintained By**: E16 AI Development Team
