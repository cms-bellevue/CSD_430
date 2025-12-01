/* Clint Scott
CSD 430
Module 8 - Project Part 3
11/30/2025

JavaScript for the update form.
Handles the "Add New" dropdown logic and disables the update button
until the user actually changes something.
*/

// Store the original form values so we can compare later
var origTitle, origYear, origGenre, origDirector;

// Grab values when the page loads to set our baseline
function initOriginalValues() {
    var titleEl = document.getElementById("title");
    var yearEl = document.getElementById("year");
    
    // Make sure elements exist before trying to read them
    if (titleEl && yearEl) {
        origTitle = titleEl.value.trim();
        origYear = yearEl.value;
        origGenre = getGenreValue();
        origDirector = getDirectorValue();

        // Start with the button disabled since nothing has changed yet
        toggleSubmitButton(false);
        
        // Attach listeners to watch for user input
        addChangeListeners();
    }
}

// Add event listeners to the standard inputs
function addChangeListeners() {
    document.getElementById("title").addEventListener("input", checkForChanges);
    document.getElementById("year").addEventListener("change", checkForChanges);
    // The dropdowns have their own onchange events in the HTML to handle the toggle logic,
    // so we don't need to add them here.
}

// check if we should use the dropdown value or the custom text input
function getGenreValue() {
    var select = document.getElementById("genreSelect");
    var custom = document.getElementById("customGenreInput");
    
    // If "Add New" is selected, return the text input value
    if (select.value === "NEW") {
        return custom.value.trim();
    }
    return select.value;
}

function getDirectorValue() {
    var select = document.getElementById("directorSelect");
    var custom = document.getElementById("customDirectorInput");
    
    if (select.value === "NEW") {
        return custom.value.trim();
    }
    return select.value;
}

// Compare current form values against the originals
function checkForChanges() {
    var currentTitle = document.getElementById("title").value.trim();
    var currentYear = document.getElementById("year").value;
    var currentGenre = getGenreValue();
    var currentDirector = getDirectorValue();

    // true if any field is different from what we started with
    var isChanged = (currentTitle !== origTitle) ||
                    (currentYear !== origYear) ||
                    (currentGenre !== origGenre) ||
                    (currentDirector !== origDirector);
    
    toggleSubmitButton(isChanged);
}

// Enable or disable the update button based on changes
function toggleSubmitButton(enable) {
    var btn = document.querySelector(".update-btn");
    if (btn) {
        if (enable) {
            btn.disabled = false;
            btn.classList.remove("disabled-btn");
        } else {
            btn.disabled = true;
            btn.classList.add("disabled-btn");
        }
    }
}

// Handle the dropdown logic. If "Add New" is picked, show the text box.
function handleDynamicSelect(selectObject, inputId, hiddenPayloadId) {
    var value = selectObject.value;
    var customInput = document.getElementById(inputId);
    var payload = document.getElementById(hiddenPayloadId);

    if (value === "NEW") {
        customInput.style.display = "block";
        customInput.required = true;
        customInput.value = ""; 
        customInput.focus();
        payload.value = ""; // Clear payload to force user input
    } else {
        customInput.style.display = "none";
        customInput.required = false;
        payload.value = value;
    }
    
    // Check for changes immediately after updating the UI
    checkForChanges();
}

// Keep the hidden input synced when typing in the custom text box
function syncCustomInput(inputObject, hiddenPayloadId) {
    var payload = document.getElementById(hiddenPayloadId);
    payload.value = inputObject.value;
    checkForChanges();
}

// Run init function when window is ready
window.onload = initOriginalValues;