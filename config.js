document.addEventListener('DOMContentLoaded', () => {
    const form = document.getElementById('config-form');
    const signTextInput = document.getElementById('sign-text');
    const signDistanceInput = document.getElementById('sign-distance');

    // Load saved configuration from local storage
    const savedConfig = JSON.parse(localStorage.getItem('signConfig'));
    if (savedConfig) {
        signTextInput.value = savedConfig.text;
        signDistanceInput.value = savedConfig.distance;
    }

    form.addEventListener('submit', (event) => {
        event.preventDefault();

        const signText = signTextInput.value;
        const signDistance = parseFloat(signDistanceInput.value);

        // Save configuration to local storage
        const config = { text: signText, distance: signDistance };
        localStorage.setItem('signConfig', JSON.stringify(config));

        // Update the sign in the main app
        updateSign(signText, signDistance);
    });
});

function updateSign(text, distance) {
    // Send the updated configuration to the main app
    const message = { type: 'updateSign', text, distance };
    window.parent.postMessage(message, '*');
}
