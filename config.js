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
