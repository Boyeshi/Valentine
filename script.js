// Get elements
const yesBtn = document.getElementById('yes-btn');
const noBtn = document.getElementById('no-btn');
const questionSection = document.getElementById('question-section');
const successSection = document.getElementById('success-section');

// Track if answer has been given
let answered = false;

// Function to move the No button to a random position
function moveNoButton() {
    if (answered) return;
    
    const container = document.querySelector('.button-container');
    const containerRect = container.getBoundingClientRect();
    const btnRect = noBtn.getBoundingClientRect();
    
    // Calculate maximum positions to keep button in viewport
    const maxX = containerRect.width - btnRect.width;
    const maxY = containerRect.height - btnRect.height;
    
    // Generate random position
    const randomX = Math.random() * maxX;
    const randomY = Math.random() * maxY;
    
    // Apply new position
    noBtn.style.left = randomX + 'px';
    noBtn.style.top = randomY + 'px';
}

// Event listeners for No button
noBtn.addEventListener('mouseenter', moveNoButton);
noBtn.addEventListener('click', (e) => {
    e.preventDefault();
    moveNoButton();
});

// Touch events for mobile
noBtn.addEventListener('touchstart', (e) => {
    e.preventDefault();
    moveNoButton();
});

// Yes button event listener
yesBtn.addEventListener('click', () => {
    answered = true;
    questionSection.classList.add('hidden');
    successSection.classList.remove('hidden');
});

// Initialize No button position
window.addEventListener('load', () => {
    // Set initial position for No button
    noBtn.style.left = '0px';
    noBtn.style.top = '0px';
});
