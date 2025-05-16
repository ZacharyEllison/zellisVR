import * as THREE from 'three';

let camera, scene, renderer;
let sign;

init();
animate();

function init() {
    const canvas = document.getElementById('xr-canvas');

    // Set up the renderer
    renderer = new THREE.WebGLRenderer({ canvas });
    renderer.setSize(window.innerWidth, window.innerHeight);
    renderer.xr.enabled = true;
    document.body.appendChild(renderer.domElement);

    // Set up the scene
    scene = new THREE.Scene();

    // Set up the camera
    camera = new THREE.PerspectiveCamera(70, window.innerWidth / window.innerHeight, 0.1, 1000);
    camera.position.set(0, 1.6, 3);
    scene.add(camera);

    // Add a simple 3D object (sign) to the scene
    const geometry = new THREE.PlaneGeometry(1, 0.5);
    const material = new THREE.MeshBasicMaterial({ color: 0xffffff, side: THREE.DoubleSide });
    sign = new THREE.Mesh(geometry, material);
    sign.position.set(0, 1.6, -2);
    scene.add(sign);

    // Implement basic WebXR support
    document.body.appendChild(THREE.WebXRManager.createButton(renderer));
}

function animate() {
    renderer.setAnimationLoop(render);
}

function render() {
    renderer.render(scene, camera);
}
