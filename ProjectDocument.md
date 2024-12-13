# BlackJack Brawl #

## Summary ##

BlackJack Brawl is a video game version of the popular poker game BlackJack, but with added twists. It is inspired by the popular indie  game Dungeons & Degenerate Gamblers, another video game version of blackjack. We were inspired to make our own video game version of Blackjack, but with unique mechanics and gameplay systems. The player competes in several rounds of blackjack with a computer enemy, each victory resulting in damage being dealt to one of the players. There are also special cards and power ups that can be applied by either player over the course of the game to enhance the experience. The game continues till one player has won enough to make their opponent's HP hit zero. 

## Project Resources

[Web-playable version of your game.](https://itch.io/)  
[Trailor](https://youtube.com)  
[Press Kit](https://dopresskit.com/)  
[Proposal: make your own copy of the linked doc.](https://docs.google.com/document/d/1qwWCpMwKJGOLQ-rRJt8G8zisCa2XHFhv6zSWars0eWM/edit?usp=sharing)  

## Gameplay Explanation ##

**In this section, explain how the game should be played. Treat this as a manual within a game. Explaining the button mappings and the most optimal gameplay strategy is encouraged.**

In BlackJack Brawl, the player plays a modified version of blackjack with augmented rules against a computer enemy.

There are four "classes" of deck in BlackJack Brawl (2 defense and 2 offense): Club, Spades, Heart, and Diamond. 
- Club: deals 1.5x damage to the opponent when you win
- Spades: when you win with a hand of 21, deal double damage to the opponent
- Heart: when you win, heal yourself half of the amount of damage you do
- Diamond: when you win with a hand of 21, heal 21 hp

Before the game begins, the player selects what suit they want their deck to be. This adds an element of strategization to the game, as the player must consider their playstyle and what type of power up they think will benefit them the most. This turns blackjack from a wholly luck based game to a part luck part skill game. The enemy is also assigned a suit. 

There are also 8 special cards that are included in the player's deck, each with a special effect. 
- Uno Stop: forcibly end the enemy's turn, worth 5 points
- Uno +2: add 2 points to your enemy's total, worth 2 points
- Uno Reverse: swap scores with the enemy, worth 5 points
- Tarot The Fool: increase your max score limit by 1 point, worth 0 points
- Tarot The Magician: take a random card from the enemy's hand, worth 10 points
- Tarot The Hangman: move a random card from the enemy's hand to their graveyard, worth 10 points
- Aggie Card: add 5 HP to yourself, worth 5 points
- Joker: deal a random amount of damage between 1 and 10 to the enemy, worth 5 points

The special cards add a new dimension of gameplay not present to normal blackjack. There is a tradeoff between how useful a special card's effect is and how many points is worth. Thus, drawing a special card with a good effect may be very useful to you, but the better the effect the more points its worth, the more danger there is that you bust. 

When the game starts, the player and the enemy both begin with 100 hp. Each round proceeds the same as normal blackjack, with the player and enemy taking turns drawing cards blindly from their deck and adding them to their hand. The goal is to draw until you decide to stop, and hopefully get closer to a total of 21 than your opponent. If either player exceeds a total of 21, they "bust" and automatically lose with a total of 0. 

Of the basic poker cards, there are numbers 2-10; J, Q, and K (all worth 10), and A (worth either 1 or 11 depending on which benefits the player more). 

After the round is over, the game compares the totals of the two players, and calculates the difference. That amount of damage is done to the losing player. Deck suit and special card effects are applied, the current hands in play move to the card graveyard, and another round begins. The game ends when one player's HP depletes to 0. 

**Add it here if you did work that should be factored into your grade but does not fit easily into the proscribed roles! Please include links to resources and descriptions of game-related material that does not fit into roles here.**

# Main Roles #

- Producer + Press Kit and Trailer: Yiming Feng
- Game Logic (Scenes) + Audio: Qingyue Yang
- Game Logic (Cards) + Gameplay Testing: Brian Li
- Game Logic (Table) + Visuals: Stephanie Hsia
- Game Logic (Player/Enemy) + Narrative Design: Alex Chen

Your goal is to relate the work of your role and sub-role in terms of the content of the course. Please look at the role sections below for specific instructions for each role.

Below is a template for you to highlight items of your work. These provide the evidence needed for your work to be evaluated. Try to have at least four such descriptions. They will be assessed on the quality of the underlying system and how they are linked to course content. 

*Short Description* - Long description of your work item that includes how it is relevant to topics discussed in class. [link to evidence in your repository](https://github.com/dr-jam/ECS189L/edit/project-description/ProjectDocumentTemplate.md)

Here is an example:  
*Procedural Terrain* - The game's background consists of procedurally generated terrain produced with Perlin noise. The game can modify this terrain at run-time via a call to its script methods. The intent is to allow the player to modify the terrain. This system is based on the component design pattern and the procedural content generation portions of the course. [The PCG terrain generation script](https://github.com/dr-jam/CameraControlExercise/blob/513b927e87fc686fe627bf7d4ff6ff841cf34e9f/Obscura/Assets/Scripts/TerrainGenerator.cs#L6).

You should replay any **bold text** with your relevant information. Liberally use the template when necessary and appropriate.

## Producer (Yiming Feng)

**Describe the steps you took in your role as producer. Typical items include group scheduling mechanisms, links to meeting notes, descriptions of team logistics problems with their resolution, project organization tools (e.g., timelines, dependency/task tracking, Gantt charts, etc.), and repository management methodology.**

## Game Logic (Scenes) (Qingyue Yang)

**Describe**

## Game Logic (Cards) (Brian Li)

**Describe**

## Game Logic (Table) (Stephanie Hsia)

**Describe**

## Game Logic (Player/Enemy) (Alex Chen)

**Describe**

# Sub-Roles

## Audio (Qingyue Yang)

**List your assets, including their sources and licenses.**
- bgm
  - ingame_bgm (original KD_Searching, Geumhyun Do, extended by suno.ai)
  - player_fail_bgm (by suno.ai)
  - player_win_bgm (original News broadcast opening song of CCTV, extended by suno.ai)
  - start_bgm (by suno.ai)
- sfx
  - background_story (we created that ourselves)
  - button_focus (from pixabay-cardeffect)
  - button_press (from pixabay-cardeffect)
  - button_start (from pixabay-cardeffect)
  - card_flip (from opengameart.org-cardeffect.zip)
  - card_plcae (from opengameart.org-cardeffect.zip)
  - card_slide (from opengameart.org-cardeffect.zip)
  - card_sound (from opengameart.org-cardeffect.zip)
  - game_fail (from pixabay-cardeffect)
  - game_win (from pixabay-cardeffect)

**Describe the implementation of your audio system.**

**Document the sound style.** 

## Gameplay Testing (Brian Li)

**Add a link to the full results of your gameplay tests.**

**Summarize the key findings from your gameplay tests.**

## Narrative Design (Alex Chen)

**Document how the narrative is present in the game via assets, gameplay systems, and gameplay.** 

## Press Kit and Trailer (Yiming Feng)

**Include links to your presskit materials and trailer.**

**Describe how you showcased your work. How did you choose what to show in the trailer? Why did you choose your screenshots?**

## Visuals (Stephanie Hsia)

**Describe.**
