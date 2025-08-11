import pygame
import random
import sys
import time

# Initialize pygame
pygame.init()

# Screen size
WIDTH = 600
HEIGHT = 400
BLOCK_SIZE = 20

# Colors
WHITE = (255, 255, 255)
GREEN = (0, 255, 0)
RED = (255, 0, 0)
BLACK = (0, 0, 0)

# Set up display
screen = pygame.display.set_mode((WIDTH, HEIGHT))
pygame.display.set_caption("Snake Game")

# Clock
clock = pygame.time.Clock()

# Snake setup (middle of screen, horizontal)
snake = [[WIDTH // 2, HEIGHT // 2],
         [WIDTH // 2 - BLOCK_SIZE, HEIGHT // 2],
         [WIDTH // 2 - 2 * BLOCK_SIZE, HEIGHT // 2]]

direction = None  # Wait for player to start
pending_direction = None

# Food setup
food = [random.randrange(0, WIDTH // BLOCK_SIZE) * BLOCK_SIZE,
        random.randrange(0, HEIGHT // BLOCK_SIZE) * BLOCK_SIZE]

score = 0

def show_score():
    font = pygame.font.SysFont('times new roman', 20)
    score_surface = font.render(f"Score: {score}", True, WHITE)
    screen.blit(score_surface, (10, 10))

def game_over():
    font = pygame.font.SysFont('times new roman', 50)
    go_surface = font.render(f"Game Over! Score: {score}", True, RED)
    go_rect = go_surface.get_rect(center=(WIDTH // 2, HEIGHT // 2))
    screen.blit(go_surface, go_rect)
    pygame.display.flip()
    time.sleep(2)
    pygame.quit()
    sys.exit()

while True:
    # Event handling
    for event in pygame.event.get():
        if event.type == pygame.QUIT:
            pygame.quit()
            sys.exit()
        elif event.type == pygame.KEYDOWN:
            if event.key == pygame.K_UP and direction != "DOWN":
                pending_direction = "UP"
            elif event.key == pygame.K_DOWN and direction != "UP":
                pending_direction = "DOWN"
            elif event.key == pygame.K_LEFT and direction != "RIGHT":
                pending_direction = "LEFT"
            elif event.key == pygame.K_RIGHT and direction != "LEFT":
                pending_direction = "RIGHT"

    if pending_direction:
        direction = pending_direction

    if direction:
        # Get new head position
        head_x, head_y = snake[0]
        if direction == "UP":
            head_y -= BLOCK_SIZE
        elif direction == "DOWN":
            head_y += BLOCK_SIZE
        elif direction == "LEFT":
            head_x -= BLOCK_SIZE
        elif direction == "RIGHT":
            head_x += BLOCK_SIZE

        new_head = [head_x, head_y]

        # Check wall collision
        if head_x < 0 or head_x >= WIDTH or head_y < 0 or head_y >= HEIGHT:
            game_over()

        # Add new head to the snake
        snake.insert(0, new_head)

        # Check if food eaten
        if new_head == food:
            score += 1
            food = [random.randrange(0, WIDTH // BLOCK_SIZE) * BLOCK_SIZE,
                    random.randrange(0, HEIGHT // BLOCK_SIZE) * BLOCK_SIZE]
        else:
            snake.pop()  # Remove tail

        # Check self collision
        if new_head in snake[1:]:
            game_over()

    # Drawing
    screen.fill(BLACK)

    for block in snake:
        pygame.draw.rect(screen, GREEN, (block[0], block[1], BLOCK_SIZE, BLOCK_SIZE))

    pygame.draw.rect(screen, RED, (food[0], food[1], BLOCK_SIZE, BLOCK_SIZE))

    show_score()
    pygame.display.update()

    clock.tick(10)
