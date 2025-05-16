# Plan: Correct Sign Distance and Update Color for New PR

## 1. Check and Correct Real-World Distance
- Review A-Frame documentation: units are in meters by default.
- Test and measure the actual distance the sign appears in VR/XR.
- Adjust the Z position in the sign's placement logic (likely in config.js and index.html) so the sign is truly 6.1 meters (20 feet) away in real life.
- Document the new value and reasoning in code comments.

## 2. Update Sign Color to a Gentle Earth Tone
- Choose a gentle earth tone (e.g., #A67B5B, #C2B280, or #B2A98F).
- Update the sign's material color in index.html and config.html to use the new color.
- Ensure opacity and transparency are preserved for readability.

## 3. Verify Geometry and Units
- Confirm the sign's geometry is appropriate for the new distance and color.
- If needed, adjust the sign's size for better visibility at the corrected distance.

## 4. Prepare and Document PR
- Summarize changes in the PR description: corrected real-world distance, updated to earth tone color, and any geometry adjustments.
- Reference A-Frame documentation and any measurements taken.

---

**Next Steps:**
- Implement the above changes in a new branch.
- Test in VR/XR to confirm accuracy and appearance.
- Open a PR for review.
