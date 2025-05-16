document.addEventListener("DOMContentLoaded", () => {
  const form = document.getElementById("config-form");
  const signTextInput = document.getElementById("sign-text");
  const signDistanceInput = document.getElementById("sign-distance");

  form.addEventListener("submit", (event) => {
    event.preventDefault();

    const signText = signTextInput.value;
    const signDistance = parseFloat(signDistanceInput.value);

    // Update the sign in the A-Frame scene
    updateSign(signText, signDistance);
  });
});

function updateSign(text, distance) {
  // A-Frame uses meters for all units. 6.1 meters = 20 feet.
  // The sign's Z position is set to -6.1 for accurate real-world distance.
  const sign = document.querySelector("#sign");
  sign.setAttribute("text", {
    value: text,
    align: "center",
    color: "#333",
    font: "https://cdn.aframe.io/fonts/Exo2Bold.fnt",
    width: 1.2,
    wrapCount: 24,
    baseline: "center",
    anchor: "center",
  });
  sign.setAttribute("position", `0 1.6 ${-distance}`);
  sign.setAttribute("material", "color", "#A67B5B"); // Gentle earth tone
  sign.setAttribute("material", "opacity", 0.95);
  sign.setAttribute("material", "transparent", true);
}
