Video Demo: https://youtu.be/dgvCd4WHmMQ

Description: The Snake Game Project presents a classic rendition of the ever so loved Snake game, artistically crafted using HTML5, JavaScript and Css. Players assume control of two demensional snake that navigates it's way around a grid(canvas), the main objective being consume as much food as possible in order to attain the highest score whilst avoiding perilous encounters with the canvas boudaries or the snake's tail.
Project structure:

snake.js: this is the heart of the game, this is where the game's logic resides, this file is packed with javascript functions that are the back bone of the project, when the gameloop function is called it orchestrates all other functions allowing initialisation, user input management(input controls), collision detection and high score tracking.

index.html: the foundation of the project, index.html is a HTML5 file that is the base that everything has been built on, it utilises features such as overlays, buttons, canvas's and presenting visual elements.

style.css: Game styles and layouts are defined within this file, the code inside this file alters the appearance of the whole webpage.

Features implemented: Taking a glance at pivitol features that have been precisely implemented to make the game what it is today:

Collision detection: A robust mechanism that ensures the snake plays by the rules or introduces the perilous encounter mentioned previously. A function was created to check if the snake had collided with any of the walls or even itself by measuring the current position and comparing that to the position of the body(snake tail) or wall.

Food generation: the initial food position is at a fixed location infront of the snake but after that the food can appear anywhere on the canvas/grid, the food colour is also set to a cream colour so it takes a little more focus to find, all of these features had been carefully designed to infuse dynamism and unpredictability into the gameplay.

High score tracking: The high score accurately documents the users achievements and as they near their previous highs the pressure of the display shall add intensity to the gameplay.

Interactive movement: One of the key features of the project is its movement system, this allows players to obtain full control over the movement of the snake using keyboard(Up, Down, Left, and Right arrows). The arrow keys allow players to guide the snake with real time response in the direction of their desires.

Restart button and overlays: Both the overlay and restart button improve user experience by making the game features more convenient, the restart button allows the player to restart the game without having to refresh the page entirely, the overlay signifies a larger action taking place directing user attention to the next step after game over.

Future feature condsiderations: While the current iteration of the game is fully functional and captivating, the possibilities for future refinements are still available

Loop factor: The possibility of a loop factor being applied to the screen edges offers tantalizing potential, with such utility really transforms the users experience of the nostalgic classic game and brings foward a slightly modern feel.

Customisable food, snake or canvas: crafting an immersive experience can be difficult task but one way to create that is through personalised customisation, the choice of appearance for generatred food, snake colour(skin) and backgrounds(canvas) will further user engagement.

Personal user accounts: Facilitating personal accounts can be leveraged to store highscores and customisations, this would most likely introduce python into the project through server-side scripting.

Leaderboard: Running off the previous capability to create personalised user accounts will open new prospects like leaderboards and live highscore tracking, this feature will be the introduction of SQL databases, after signing in each user could see their name prominently displayed alongside their peak highscore.

My conclusion of the grand Project: The Snake Game Project offers enthralling and challenging gameplay that develops into a nostalgic quest to beat your highscore. this project serves as an instructive showcase of fundamental game development principles using HTML5 and teases exciting enhancements for future iterations through Javascript and CSS code. the main purpose of this was to reignite the sensations of old and feel free by unlocking memorabilia.
