const signMessages = [
  "Take a deep breath and relax!",
  "Did you know? Blinking keeps your eyes healthy!",
  "Remember the 20-20-20 rule: every 20 minutes, look at something 20 feet away for 20 seconds.",
  "Smile! It's good for your eyes and your mood.",
  "Fun fact: Carrots really are good for your eyes!",
  "Give your eyes a break and enjoy the view!",
];

function getRandomSignMessage() {
  return signMessages[Math.floor(Math.random() * signMessages.length)];
}

document.addEventListener("DOMContentLoaded", () => {
  const form = document.getElementById("config-form");
  const signTextInput = document.getElementById("sign-text");
  const signDistanceInput = document.getElementById("sign-distance");

  // Set a random message on load if signTextInput exists
  if (signTextInput) {
    signTextInput.value = getRandomSignMessage();
  }

  form.addEventListener("submit", (event) => {
    event.preventDefault();

    const signText = signTextInput.value;
    const signDistance = parseFloat(signDistanceInput.value);

    // Update the sign in the A-Frame scene
    updateSign(signText, signDistance);
  });
});

function updateSign(text, distance) {
  const sign = document.querySelector("#sign");
  sign.setAttribute("text", {
    value: text,
    align: "center",
    color: "#333",
    font: "https://cdn.aframe.io/fonts/Exo2Bold.fnt", // fallback to a friendly font
    width: 1.2,
    wrapCount: 24,
    baseline: "center",
    anchor: "center",
  });
  sign.setAttribute("position", `0 1.6 ${-distance}`);
}

// On initial load, set a random message if on index.html
if (
  document.querySelector("a-scene") &&
  !document.getElementById("config-form")
) {
  const sign = document.querySelector("#sign");
  const randomMessage = getRandomSignMessage();
  sign.setAttribute("text", {
    value: randomMessage,
    align: "center",
    color: "#333",
    font: "https://cdn.aframe.io/fonts/Exo2Bold.fnt", // fallback to a friendly font
    width: 1.2,
    wrapCount: 24,
    baseline: "center",
    anchor: "center",
  });
}
