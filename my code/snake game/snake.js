let snake = [{ x: 10, y: 10 }];
let food = { x: 15, y: 10 };
//starts the game with deirection right
let direction = 'right';
let score = 0;
let foodEaten = 0;
let newHighScore = 0;
let gameInterval;
// sets the size of the snake which is equivalent to one tile of the grid
const snakeSize = 20;
// sets the size of the grid tiles
const tileSize = 20;
// adjusts the speed of the game refresh rate (10 fps)
const speed = 100;


// global variables
const canvas = document.getElementById('snakespace');
const ctx = canvas.getContext('2d');
let currentScoreElement = document.getElementById('currentScore');
let newHighScoreElement = document.getElementById('newHighScore');


// mother function the runs the game loop
function gameLoop(){
clearCanvas();
moveSnake();
checkFoodCollision();
checkCollision();
drawCanvas();
drawSnake();
highScore();
drawFood();
}


document.addEventListener('keydown', (event) => {
    event.preventDefault();
changeDirection(event.key);
});

// Event listener for the "Restart" button to restart the game after game over
const restartButton = document.getElementById("restartButton");
restartButton.addEventListener("click", () => {
    location.reload();
});

function changeDirection(key) {
    if (key === 'ArrowUp' && direction !== 'down') {
        direction = 'up';
    } else if (key === 'ArrowDown' && direction !== 'up') {
        direction = 'down';
    } else if (key === 'ArrowLeft' && direction !== 'right') {
        direction = 'left';
    } else if (key === 'ArrowRight' && direction !== 'left') {
        direction = 'right';
    }
}


function moveSnake() {
// Get the head of the Snake (first element in the array)
const head = { ...snake[0] };

// Update the head position based on the current direction
if (direction === 'up') {
    head.y -= 1;
    } else if (direction === 'down') {
    head.y += 1;
    } else if (direction === 'left') {
    head.x -= 1;
    } else if (direction === 'right') {
    head.x += 1;
    }

// Add the updated head back to the beginning of the Snake array
snake.unshift(head);
}

function checkFoodCollision() {
    // Implementation of the checkCollision() function.
    // Checks the snakes collision with the food
    if (snake[0].x === food.x && snake[0].y === food.y){
        //increment food counter to limit snakes body length
        foodEaten++;
        score += 100 * foodEaten;
        return true;
    } else {
        return false;
    }
}

function checkCollision() {
    if(snake[0].x >= canvas.width / tileSize || snake[0].y >= canvas.height / tileSize || snake[0].x < 0 || snake[0].y < 0){
        gameOver();
    }
    for (let i = 1; i < snake.length; i++){
        if (snake[0].x === snake[i].x && snake[0].y === snake[i].y){
            gameOver();
        }
    }
}

function drawCanvas() {
    // Canvas colouration set to a cream colour
    ctx.fillStyle = "rgb(255, 253, 208, 0.25)";
    ctx.fillRect(0, 0, canvas.width, canvas.height);
}

function clearCanvas(){
    // clear the canvas
    ctx.clearRect(0, 0, canvas.width, canvas.height);
}

function drawSnake() {
    // Implementation of the drawSnake() function.
    for (i = 0; i < snake.length; i++)
    {
        //draw each tile to make up the snakes body using the rbg values
        const segment = snake[i];
        const x = segment.x * tileSize;
        const y = segment.y * tileSize;

        ctx.fillStyle = "rgb(0, 0, 0)";
        ctx.fillRect(x, y, snakeSize, snakeSize);
    }

        // Decrease the snake's length if it hasn't consumed enough food
    while (snake.length > foodEaten + 1) {
        snake.pop();

    }
}

function drawFood() {
    if(checkFoodCollision()){
        food.x = Math.floor(Math.random() * (canvas.width / tileSize));
        food.y = Math.floor(Math.random() * (canvas.height / tileSize));
    }
    // Implementation of the drawFood() function.
    let x = food.x * tileSize;
    let y = food.y * tileSize;

    ctx.fillStyle = "rgb(255, 253, 208)";
    ctx.fillRect(x, y, tileSize, tileSize);
}

function highScore() {
    // Implementation of the score
    currentScoreElement.textContent = score;
    if(score > newHighScore) {
        newHighScore = score;
        // sends the new highscore info to index page via eventlistener
        newHighScoreElement.textContent = newHighScore;
    }
}

function gameOver() {
    console.log("Game Over");
    clearInterval(gameInterval);
    const gameOverOverlay = document.getElementById('gameOverOverlay');
    const gameOverScore = document.getElementById('gameOverScore');

    gameOverOverlay.style.display = 'flex';
    gameOverScore.textContent = score;
}

document.addEventListener('DOMContentLoaded', function(){
    // calls the game function and refreshes according to the speed set by var speed
    gameInterval = setInterval(gameLoop, speed);
    });
