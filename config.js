document.addEventListener('DOMContentLoaded', () => {
    const form = document.getElementById('config-form');
    const signTextInput = document.getElementById('sign-text');
    const signDistanceInput = document.getElementById('sign-distance');

    form.addEventListener('submit', (event) => {
        event.preventDefault();

    const signText = signTextInput.value;
    const signDistance = parseFloat(signDistanceInput.value);

    // Update the sign in the A-Frame scene
    updateSign(signText, signDistance);
  });
});

function updateSign(text, distance) {
    const sign = document.querySelector('#sign');
    sign.setAttribute('text', 'value', text);
    sign.setAttribute('position', `0 1.6 ${-distance}`);
}

// Define an array of messages to randomize the sign's message
const messages = [
    "Take a deep breath!",
    "Remember to blink!",
    "Look around and relax!",
    "Stretch your neck!",
    "Focus on something far away!"
];

// Create a function to select a random message from the array
function getRandomMessage() {
    const randomIndex = Math.floor(Math.random() * messages.length);
    return messages[randomIndex];
}

// Use setInterval to call the function at regular intervals to update the sign's message
setInterval(() => {
    const randomMessage = getRandomMessage();
    updateSign(randomMessage, 2); // Assuming a default distance of 2 meters
}, 10000); // Update the message every 10 seconds
