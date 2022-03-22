*-----------------------------------------------------------------------------------
* Title: Project I
* Written by: Daniel Giedraitis
* Student Number: C00260331
* Date created: 23/02/2022
* Description: Player gets a welcome message and the resources the player has at
*              the begining of the game and has two options to either go Shop or
*              complete the Quest. 
*Unaccomplished goals for Project: To add 1 or 2 more Quests into the game.
*Errors: Weapon will go up in levels but the damage doesnt change.
*-----------------------------------------------------------------------------------

*-------------------------------------------------------
* STARTING MEMORY ADDRESS FOR THE PROGRAMME $1000
*-------------------------------------------------------
    
    ORG $1000

*-------------------------------------------------------
*-----------------VALIDATION VALUES--------------------- 
*-------------------------------------------------------
EXIT                EQU 0     USED TO EXIT ASSEMBLY PROGRAM
OWNED_POTIONS       EQU 1     NUMBER OF POTIONS OWNED
CURRENT_LEVEL       EQU 1     CURRENT WEAPON LEVEL
MAX_WEAPON_LEVEL    EQU 3     MAX WEAPON LEVEL YOU CAN HAVE
WINDMILL_AMOUNT     EQU 10    AMOUNT OF WINDMILLS IN PLAYER'S POSSESSION
SOLARPANEL_AMOUNT   EQU 10    AMOUNT OF SOLAR PANELS IN PLAYER'S POSSESSION
TREES_AMOUNT        EQU 15    AMOUNT OF TREES IN PLAYER'S POSSESSION
GOLD_AMOUNT         EQU 100   AMOUNT OF GOLD IN PLAYER'S POSSESSION
POTION_PRICE        EQU 10    PRICE OF POTION IN SHOP
WEAPON_PRICE        EQU 100   PRICE OF WEAPON UPGRADE IN SHOP
WINDMILL_PRICE      EQU 100   PRICE OF WINDMILL IN SHOP
SOLARPANEL_PRICE    EQU 50    PRICE OF SOLAR PANEL IN SHOP
TREES_PRICE         EQU 25    PRICE OF TREE IN SHOP
BOSS_HEALTH         EQU 80    ENEMYS HEALTH
HEALTH              EQU 100   PLAYERS HEALTH
GLOBAL_TEMPERATURE  EQU 20    CURRENT TEMPERATURE
DAMAGE              EQU 25    THE AMOUNT OF DAMAGE A PLAYER CAN DO

*-------------------------------------------------------
*----------------THE GAME BEGINES HERE------------------
*-------------------------------------------------------
START:
    MOVE.B  #BOSS_HEALTH,$4038         PUT BOSS HEALTH IN MEMORY LOCATION $4038
    LEA     $4038,A2                   ASSIGN ADDRESS A2 TO THAT MEMORY LOCATION
    MOVE.B  #OWNED_POTIONS,$4000       PUT POTION AMOUNT IN MEMORY LOCATION $4000
    LEA     $4000,A3                   ASSIGN ADDRESS A3 TO THAT MEMORY LOCATION
    MOVE.B  #HEALTH,$4010              PUT HEALTH IN MEMORY LOCATION $4010
    LEA     $4010,A4                   ASSIGN ADDRESS A4 TO THAT MEMORY LOCATION
    MOVE.B  #CURRENT_LEVEL,$4014       PUT WEAPON LEVEL IN MEMORY LOCATION $4014
    LEA     $4014,A5                   ASSIGN ADDRESS A5 TO THAT MEMORY LOCATION
    MOVE.B  #GOLD_AMOUNT,$4022         PUT GOLD IN MEMORY LOCATION $4022
    LEA     $4022,A6                   ASSIGN ADDRESS A6 TO THAT MEMORY LOCATION
    MOVE.B  #WINDMILL_AMOUNT,$4048     PUT WINDMILL IN MEMORY LOCATION $4048
    MOVE.B  $4048,4048
    MOVE.B  #SOLARPANEL_AMOUNT,$4058   PUT SOLAR PANEL IN MEMORY LOCATION $4058
    MOVE.B  $4058,4058
    MOVE.B  #TREES_AMOUNT,$4068        PUT TREES IN MEMORY LOCATION $4068
    MOVE.B  $4068,4068
    MOVE.B  #GLOBAL_TEMPERATURE,$4078  PUT GLOBAL TEMPERATURE IN MEMORY LOCATION $4078
    MOVE.B  $4078,4078

    BSR     WELCOME    BRANCH TO THE WELCOME SUBROUTINE
    BSR     INPUT      BRANCH TO THE INPUT SUBROUTINE
    BSR     GAME       BRANCH TO THE GAME SUBROUTINE
*GAME LOOP    
    ORG     $2000      THE REST OF THE PROGRAM IS TO BE LOCATED 2000 ONWARDS 

*-------------------------------------------------------
*-------------------GAME SUBROUTINE---------------------
*-------------------------------------------------------
GAME:
    BSR     GAMELOOP   BRANCH TO GAMELOOP SUBROUTINE
    RTS                RETURN FROM GAME: SUBROUTINE
          
END:
    SIMHALT

*-------------------------------------------------------
*-------------------WELCOME SUBROUTINE------------------
*-------------------------------------------------------
WELCOME:
    LEA     WELCOME_MSG,A1  ASSIGN MESSAGE TO ADDRESS REGISTER A1
    MOVE.B  #14,D0          MOVE LITERAL 14 TO DO
    TRAP    #15             TRAP AND INTERPRET VALUE IN D0
    LEA     TO_DO_MSG,A1    DISPLAYS THE TO DO MESSAGE
    MOVE.B  #14,D0
    TRAP    #15
    RTS                     RETURN FROM WELCOME: SUBROUTINE

*-------------------------------------------------------
*---------GAMEPLAY INPUT VALUES SUBROUTINE--------------
*-------------------------------------------------------    
INPUT:
    BSR     DECORATE
    BSR     TEMPERATURE
    BSR     ENDL
    BSR     WINDMILL        BRANCH TO WINDMILL INPUT SUBROUTINE
    BSR     SOLAR_PANEL     BRANCH TO SOLAR PANEL INPUT SUBROUTINE
    BSR     TREES           BRANCH TO TREES INPUT SUBROUTINE
    BSR     GOLD            BRANCH TO GOLD INPUT SUBROUTINE
    BSR     ENDL            BRANCH TO ENDL SUBROUTINE
    BSR     SHOW_HEALTH     BRANCH TO HEALTH INPUT SUBROUTINE
    BSR     POTIONS         BRANCH TO POTION INPUT SUBROUTINE
    BSR     PROMPT          BRANCH TO WEAPONS INPUT SUBROUTINE
    RTS                     RETURN FROM INPUT: SUBROUTINE

*-------------------------------------------------------
*----------------------GAMELOOP-------------------------
*------------------------------------------------------- 
GAMELOOP:
    BSR     QUEST_INFO      BRANCH TO UPDATE GAME SUBROUTINE        
    BSR     PLAYER_TURN     BRANCH TO PLAYER TURN SUBROUTINE
    BSR     BOSS_TURN       BRANCH TO BOSS TURN SUBROUTINE
    BSR     PLAYER_TURN     BRANCH TO PLAYER TURN SUBROUTINE
    BSR     BOSS_TURN       BRANCH TO BOSS TURN SUBROUTINE
    BSR     PLAYER_TURN     BRANCH TO PLAYER TURN SUBROUTINE
    BSR     BOSS_TURN       BRANCH TO BOSS TURN SUBROUTINE
    BSR     PLAYER_TURN     BRANCH TO PLAYER TURN SUBROUTINE
    BSR     BOSS_TURN       BRANCH TO BOSS TURN SUBROUTINE
    BSR     PLAYER_TURN     BRANCH TO PLAYER TURN SUBROUTINE
    BSR     BOSS_TURN       BRANCH TO BOSS TURN SUBROUTINE
    BSR     PLAYER_TURN     BRANCH TO PLAYER TURN SUBROUTINE
    BSR     BOSS_TURN       BRANCH TO BOSS TURN SUBROUTINE
    BSR     REPLAY_GAME     BRANCH TO REPLAY GAME SUBROUTINE
    RTS                     RETURN FROM GAMELOOP: SUBROUTINE

*-------------------------------------------------------
*---------------------QUEST_INFO------------------------
*------------------------------------------------------- 
QUEST_INFO  
    BSR     CLEAR_SCREEN    BRANCH TO CLEAR SCREEN SUBROUTINE
    BSR     DECORATE        DECORATE WITH DOTS USING A LOOP
    LEA     QUEST_MSG,A1    PRINT QUEST_MSG 
    MOVE.B  #14,D0          
    TRAP    #15
    BSR     DECORATE
    BSR     ENDL
    BSR     TEMPERATURE
    BSR     ENDL
    RTS                     RETURN FROM QUEST_INFO: SUBROUTINE
    
POTION_CHOICE:
    CMP     #2,D1
    BNE     WRONG_CHOICE
    MOVE.B  (A3),D6
    CMP     #1,D6
    BGE     MINUS_POTION
    BSR     CLEAR_SCREEN
    BSR     DECORATE
    BSR     ENDL
    LEA     ZEROPOTION_MSG,A1
    MOVE.B  #14,D0
    TRAP    #15
    BSR     ENDL
    BSR     PLAYER_TURN         BRANCH TO PLAYER TURN SUBROUTINE
    RTS                         RETURN FROM NEXT_CHOICE: SUBROUTINE
    
MINUS_POTION:
    MOVE.B  (A4),D7
    CMP     #100,D7
    BGE     CANT_USE_POTION
    BSR     CLEAR_SCREEN        BRANCH TO CLEAR SCREEN SUBROUTINE
    BSR     DECORATE            BRANCH TO DECORATE SUBROUTINE
    LEA     USE_POTION,A1       DISPLAYS THE USE POTION MESSAGE
    MOVE.B  #14,D0
    TRAP    #15
    BSR     DECORATE            BRANCH TO DECORATE SUBROUTINE
    SUB.B   #1,(A3)
    ADD.B   #60,(A4)            USE POTION AND ADD 60 HEALTH TO PLAYER
    BSR     SHOW_HEALTH         BRANCH TO SHOW HEALTH SUBROUTINE
    BSR     POTIONS             BRANCH TO POTIONS SUBROUTINE
    BSR     DECORATE            BRANCH TO DECORATE SUBROUTINE
    BSR     ENDL                BRANCH TO ENDL SUBROUTINE
    RTS                         RETURN FROM MINUS_POTION: SUBROUTINE
   
CANT_USE_POTION:
    BSR     CLEAR_SCREEN
    BSR     DECORATE
    LEA     FULL_HEALTH,A1      DISPLAYS THE FULL HEALTH MESSAGE
    MOVE.B  #14,D0
    TRAP    #15
    BSR     ENDL
    BSR     DECORATE            BRANCH TO DECORATE SUBROUTINE
    BSR     PLAYER_TURN         BRANCH TO PLAYER TURN SUBROUTINE
    RTS                         RETURN FROM CANT_USE_POTION: SUBROUTINE
                                
WRONG_CHOICE:
    BSR     CLEAR_SCREEN
    BSR     DECORATE
    LEA     WRONG_OPTION,A1     DISPLAYS THE WRONG OPTION MESSAGE
    MOVE.B  #14,D0
    TRAP    #15
    BNE     PLAYER_TURN
    RTS                         RETURN FROM WRONG_CHOICE: SUBROUTINE
    
*-------------------------------------------------------
*-------------------------WEAPONS-----------------------
*-------------------------------------------------------   
WEAPONS:
    BSR     ENDL                BRANCH TO ENDL SUBROUTINE
    LEA     WEAPONS_MSG,A1      DISPLAYS THE WEAPONS MESSAGE
    MOVE.B  #14,D0
    TRAP    #15
    MOVE.B  (A5),D1
    MOVE.B  #3,D0
    TRAP    #15
    BSR     ENDL                BRANCH TO ENDL SUBROUTINE
    BSR     DECORATE            BRANCH TO DECORATE SUBROUTINE
    RTS                         RETURN FROM WEAPONS: SUBROUTINE
    
PROMPT:
    BSR     WEAPONS             BRANCH TO WEAPONS SUBROUTINE
    LEA     CLICK_ENTER,A1      DISPLAYS THE CLICK ENTER MESSAGE
    MOVE.B  #14,D0
    TRAP    #15
    MOVE.B  #4,D0   
    TRAP    #15
    BSR     CLEAR_SCREEN
    LEA     GAME_OPTION,A1      DISPLAYS THE GAME OPTION MESSAGE
    MOVE.B  #14,D0
    TRAP    #15
    BSR     ENDL
    LEA     GAME_OPTION1,A1      DISPLAYS THE GAME OPTION MESSAGE
    MOVE.B  #14,D0
    TRAP    #15
    MOVE.B  #4,D0   
    TRAP    #15
    MOVE    D1,D0
    CMP #1,D1
    BNE GAME
    BSR SHOP                    BRANCH TO SHOP SUBROUTINE
    RTS                         RETURN FROM PROMPT: SUBROUTINE

*-------------------------------------------------------
*--------------------GOLD display-----------------------
*-------------------------------------------------------
GOLD:
    BSR     DECORATE            BRANCH TO DECORATE SUBROUTINE
    LEA     GOLD_MSG,A1         DISPLAYS THE GOLD MESSAGE
    MOVE.B  #14,D0
    TRAP    #15
    MOVE.B  (A6),D1
    MOVE.B  #3,D0
    TRAP    #15
    BSR     ENDL                BRANCH TO ENL SUBROUTINE
    RTS                         RETURN FROM GOLD: SUBROUTINE
    
*-------------------------------------------------------
*---------------GLOBAL TEMPERATURE DISPLAY--------------
*-------------------------------------------------------
TEMPERATURE:
    LEA     CURRENT_TEMP,A1     DISPLAYS THE CURRENT AVERAGE GLOBAL TEMPERATURE MESSAGE
    MOVE.B  #14,D0
    TRAP    #15
    MOVE.B  (4078),D1
    MOVE.B  #3,D0
    TRAP    #15
    RTS                         RETURN FROM TEMPERATURE: SUBROUTINE

    
*-------------------------------------------------------
*--------------------Windmill display-------------------
*-------------------------------------------------------
WINDMILL:
    BSR     DECORATE            BRANCH TO DECORATE SUBROUTINE
    LEA     WINDMILL_MSG,A1     DISPLAYS THE WINDMILL MESSAGE
    MOVE.B  #14,D0
    TRAP    #15
    MOVE.B  (4048),D1
    MOVE.B  #3,D0
    TRAP    #15
    BSR     ENDL                BRANCH TO ENDL SUBROUTINE
    RTS                         RETURN FROM WINDMILL: SUBROUTINE
  
*-------------------------------------------------------
*--------------------Solar Panel display----------------
*-------------------------------------------------------
SOLAR_PANEL:
    BSR     ENDL                BRANCH TO ENDL SUBROUTINE
    LEA     SOLAR_PANEL_MSG,A1  DISPLAYS THE SOLAR PANEL MESSAGE
    MOVE.B  #14,D0
    TRAP    #15
    MOVE.B  (4058),D1
    MOVE.B  #3,D0
    TRAP    #15
    BSR     ENDL                BRANCH TO ENDL SUBROUTINE
    RTS                         RETURN FROM SOLAR_PANEL: SUBROUTINE

*-------------------------------------------------------
*--------------------Trees display----------------------
*-------------------------------------------------------
TREES:
    BSR     ENDL                BRANCH TO ENDL SUBROUTINE
    LEA     TREES_MSG,A1        DISPLAYS THE TREES MESSAGE
    MOVE.B  #14,D0
    TRAP    #15
    MOVE.B  (4068),D1
    MOVE.B  #3,D0
    TRAP    #15
    BSR     ENDL                BRANCH TO ENDL SUBROUTINE
    RTS                         RETURN FROM TREES: SUBROUTINE

*-------------------------------------------------------
*--------------------POTION DISPLAY---------------------
*-------------------------------------------------------
POTIONS:
    BSR     ENDL                BRANCH TO ENDL SUBROUTINE   
    LEA     POTIONS_MSG,A1      DISPLAYS THE POTIONS MESSAGE
    MOVE.B  #14,D0
    TRAP    #15
    MOVE.B  (A3),D1
    MOVE.B  #3,D0
    TRAP    #15
    BSR     ENDL                BRANCH TO ENDL SUBROUTINE
    RTS                         RETURN FROM POTIONS: SUBROUTINE
      
*-------------------------------------------------------
*--------------------PLAYER HEALTH----------------------
*-------------------------------------------------------
SHOW_HEALTH:
    LEA     HEALTH_MSG,A1       DISPLAYS THE HEALTH MESSAGE
    MOVE.B  #14,D0
    TRAP    #15
    MOVE.B  (A4),D1
    MOVE.B  #3,D0
    TRAP    #15
    BSR     ENDL                BRANCH TO ENDL SUBROUTINE
    RTS                         RETURN FROM SHOW_HEALTH: SUBROUTINE
    
*-------------------------------------------------------
*-----------------PLAYER FIGHTING OPTIONS----------------
*-------------------------------------------------------- 
PLAYER_TURN:
    BSR     ENDL                BRANCH TO ENDL SUBROUTINE
    BSR     DECORATE            BRANCH TO DECORATE SUBROUTINE
    BSR     SHOW_HEALTH         BRANCH TO SHOW HEALTH SUBROUTINE
    BSR     POTIONS             BRANCH TO POTIONS SUBROUTINE
    BSR     WINDMILL            BRANCH TO WINDMILL INPUT SUBROUTINE
    BSR     SOLAR_PANEL         BRANCH TO SOLAR PANEL INPUT SUBROUTINE
    BSR     TREES               BRANCH TO TREES INPUT SUBROUTINE
    BSR     DECORATE            BRANCH TO DECORATE SUBROUTINE
    CMP     #1,(A2)
    BLT     WIN_FIGHT
    CMP     #1,(A4)
    BLT     LOSE_FIGHT
    LEA     PLAYEROPTION_MSG,A1 DISPLAYS THE PLAYER OPTION MESSAGE
    MOVE.B  #14,D0
    TRAP    #15
    MOVE.B  #4,D0   
    TRAP    #15
    
    MOVE    D1,D0               GETS INPUT FROM PLAYER AND LET CHOOSE OPTION
    CMP     #1,D1
    BNE     POTION_CHOICE       IF OPTION 1 NOT CHOSEN, MOVE POTION CHOICE
    BSR     DECORATE            BRANCH TO DECORATE SUBROUTINE
    BSR     ATTACK              BRANCH TO ATTACK SUBROUTINE
    RTS                         RETURN FROM PLAYER_TURN: SUBROUTINE
    
  
*-------------------------------------------------------
*---------------------BOSS TURN-------------------------
*------------------------------------------------------- 
BOSS_TURN:
    BSR     ENDL                BRANCH TO ENDL SUBROUTINE
    BSR     DECORATE            BRANCH TO DECORATE SUBROUTINE
    LEA     BOSS_MSG,A1         DISPLAYS THE BOSS MESSAGE
    MOVE.B  #14,D0
    TRAP    #15
    LEA     LOSE_RESOURCES_MSG,A1   
    MOVE.B  #14,D0              DISPLAYS THE LOSE RESOURCES MESSAGE
    TRAP    #15
    LEA     GAIN_TEMP,A1
    MOVE.B  #14,D0
    TRAP    #15
    ADD.B   #2,4078             ADD 2 DEGREES CELSIUS TO THE TEMPERATURE
    SUB.B   #1,4048             1 WINDMILL DESTROYED
    SUB.B   #1,4058             1 SOLAR PANEL DESTROYED
    SUB.B   #2,4068             2 TREES DESTROYED
    SUB.B   #35,(A4)            BOSS DAMAGE DEALT TO PLAYER
    CMP     #1,(A2)             IF BOSS HEALTH IS BELOW 1, PLAYER WINS
    BLT     WIN_FIGHT
    CMP     #1,(A4)             IF PLAYER HEALTH IS BELOW 1, PLAYER LOSES
    BLT     LOSE_FIGHT
    BSR     DECORATE            BRANCH TO DECORATE SUBROUTINE
    BSR     ENDL
    BSR     TEMPERATURE
    BSR     ENDL
    BSR     PLAYER_TURN         BRANCH TO PLAYER TURN SUBROUTINE
    RTS                         RETURN FROM BOSS_TURN: SUBROUTINE

*-------------------------------------------------------
*------------------ATTACKING THE BOSS-------------------
*-------------------------------------------------------
ATTACK:
    BSR     CLEAR_SCREEN            BRANCH TO CLEAR SCREEN SUBROUTINE
    BSR     DECORATE                BRANCH TO DECORATE SUBROUTINE
    LEA     ATTACK_MSG,A1           DISPLAYS THE ATTACK MESSAGE
    MOVE    #14,D0
    TRAP    #15
    BSR     DECORATE                BRANCH TO DECORATE SUBROUTINE
    BSR     ENDL                    BRANCH TO ENDL SUBROUTINE
    MOVE.B  #DAMAGE,D5              THIS IS THE PLAYERS DAMAGE
    SUB.B   D5,(A2)
    CMP     #1,(A2)
    BLT     WIN_FIGHT
    CMP     #1,(A4)
    BLT     LOSE_FIGHT
    LEA     SHOW_BOSS_HEALTH,A1     DISPLAYS THE SHOW BOSS HEALTH MESSAGE
    MOVE    #14,D0
    TRAP    #15
    MOVE.B  (A2),D1
    MOVE.B  #3,D0
    TRAP    #15
    BSR     ENDL
    BSR     ENDL                    BRANCH TO ENDL SUBROUTINE
    BSR     DECORATE                BRANCH TO DECORATE SUBROUTINE
    BSR     ENDL                    BRANCH TO ENDL SUBROUTINE
    CMP     #1,(A2)
    BLT     WIN_FIGHT
    CMP     #1,(A4)
    BLT     LOSE_FIGHT
    
    BSR     BOSS_TURN               BRANCH TO BOSS TURN SUBROUTINE
    RTS                             RETURN FROM ATTACK: SUBROUTINE
    
WIN_FIGHT:
    BSR     SHOW_HEALTH             DISPLAYS HEALTH ON SCREEN
    ADD.B   #50,(A6)                GIVES THE PLAYER 50 GOLD FOR DEFEATING BOSS / COMPLETING THE QUEST
    BSR     ENDL                    BRANCH TO ENDL SUBROUTINE
    BSR     DECORATE
    BSR     TEMPERATURE
    BSR     ENDL
    BSR     GOLD                    DISPLAYS MONEY ON SCREEN
    BSR     ENDL                    BRANCH TO ENDL SUBROUTINE
    LEA     WIN_GOLD_MSG,A1         DISPLAYS THE WIN GOLD MESSAGE
    MOVE.B  #14,D0
    TRAP    #15
    BSR     DECORATE                BRANCH TO DECORATE SUBROUTINE
    BSR     ENDL                    BRANCH TO ENDL SUBROUTINE
    LEA     WIN_MSG,A1              DISPLAYS THE WINNING MESSAGE
    MOVE.B  #14,D0
    TRAP    #15
    BSR     ENDL                    BRANCH TO ENDL SUBROUTINE
    BSR     ENDL                    BRANCH TO ENDL SUBROUTINE
    BSR     DECORATE                BRANCH TO DECORATE SUBROUTINE
    MOVE.B  #100,(A4)               REPLENISHES PLAYER HEALTH
    MOVE.B  #80,(A2)                REPLENISHES MINI BOSS HEALTH
    BSR     REPLAY_GAME             BRANCH TO REPLAY GAME SUBROUTINE
    RTS                             RETURN FROM WIN_FIGHT: SUBROUTINE
     
LOSE_FIGHT:
    BSR     DECORATE                BRANCH TO DECORATE SUBROUTINE
    BSR     ENDL                    BRANCH TO ENDL SUBROUTINE
    BSR     DECORATE                BRANCH TO DECORATE SUBROUTINE
    MOVE.B  #0,(A4)                 SHOWS PLAYER HEALTH IS 0 BEFORE IT REPLENISHES THE HEALTH TO 100 IF REPLAY IS ENTERED
    BSR     SHOW_HEALTH             BRANCH TO SHOW HEALTH SUBROUTINE
    BSR     POTIONS                 BRANCH TO POTIONS SUBROUTINE
    BSR     WINDMILL                BRANCH TO WINDMILL INPUT SUBROUTINE
    BSR     SOLAR_PANEL             BRANCH TO SOLAR PANEL INPUT SUBROUTINE
    BSR     TREES                   BRANCH TO TREES INPUT SUBROUTINE
    BSR     DECORATE                BRANCH TO DECORATE SUBROUTINE
    BSR     ENDL                    BRANCH TO ENDL SUBROUTINE
    LEA     LOSE_MSG,A1             DISPLAYS THE LOSE MESSAGE 
    MOVE.B  #14,D0
    TRAP    #15
    BSR     ENDL                    BRANCH TO ENDL SUBROUTINE
    BSR     ENDL                    BRANCH TO ENDL SUBROUTINE
    BSR     DECORATE                BRANCH TO DECORATE SUBROUTINE
    MOVE.B  #100,(A4)               REPLENISHES PLAYER HEALTH
    MOVE.B  #80,(A2)                REPLENISHES MINI BOSS HEALTH
    BSR     REPLAY_GAME             BRANCH TO REPLAY GAME SUBROUTINE
    RTS                             RETURN FROM LOSE_FIGHT: SUBROUTINE

*-------------------------------------------------------
*------------------SCREEN DECORATION--------------------
*-------------------------------------------------------
DECORATE:
    MOVE.B  #60, D3
OUT:
    LEA     LOOP_MSG,A1             DISPLAYS THE LOOP MESSAGE
    MOVE.B  #14,D0
    TRAP    #15
	SUB     #1,D3                   DECREMENT LOOP COUNTER
    BNE     OUT	                    REPEAT UNTIL D0=0
    BSR     ENDL                    BRANCH TO ENDL SUBROUTINE
    RTS                             RETURN FROM OUT: SUBROUTINE
    
*-------------------------------------------------------
*----------------------REPLAY GAME----------------------
*-------------------------------------------------------
REPLAY_GAME:
    BSR     ENDL                    BRANCH TO ENDL SUBROUTINE
    LEA     REPLAY_MSG,A1           DISPLAYS THE REPLAY MESSAGE
    MOVE.B  #14,D0
    TRAP    #15
    
    MOVE.B  #4,D0
    TRAP    #15

    CMP     #EXIT,D1
    BEQ     END                     IF SR Z REGISTER CONTAINS 1 BEQ => BRANCH EQUALS
    BSR     CLEAR_SCREEN            BRANCH TO CLEAR SCREEN SUBROUTINE
    BSR     INPUT                   RETURN FROM REPLAY: SUBROUTINE

*-------------------------------------------------------
*-------------ENDL (SKIP LINE IN GAME)------------------
*-------------------------------------------------------
ENDL:                               
    MOVEM.L D0/A1,-(A7)
    MOVE    #14,D0
    LEA     CRLF,A1
    TRAP    #15
    MOVEM.L (A7)+,D0/A1
    RTS                             RETURN FROM ENDL: SUBROUTINE

*-------------------------------------------------------
*-------------------SHOP OPTIONS------------------------
*-------------------------------------------------------
SHOP:
    BSR     CLEAR_SCREEN            BRANCH TO CLEAR SCREEN SUBROUTINE
    LEA     SHOP_WELCOME,A1             DISPLAYS THE SHOP MESSAGE MESSAGE
    MOVE.B  #14,D0
    TRAP    #15
    BSR     ENDL                    BRANCH TO ENDL SUBROUTINE
    BSR     DECORATE
    BSR     TEMPERATURE
    BSR     ENDL
    BSR     DECORATE
    BSR     ENDL
    BSR     GOLD                    BRANCH TO GOLD SUBROUTINE
    BSR     DECORATE                BRANCH TO DECORATE SUBROUTINE
    BSR     ENDL                    BRANCH TO ENDL SUBROUTINE
    BSR     SHOP_MESSAGE            BRANCH TO SHOP MESSAGE SUBROUTINE
    RTS                             RETURN FROM SHOP: SUBROUTINE
    
SHOP_MESSAGE:
    LEA     PRICE_MSG,A1            DISPLAYS THE PRICE MESSAGE
    MOVE.B  #14,D0
    TRAP    #15
    MOVE.B  #4,D0   
    TRAP    #15
    
    MOVE    D1,D0                   GETS INPUT FROM PLAYER AND LETS BUY STUFF
    CMP     #1,D1
    BNE     WEAPON_ITEM             IF OPTION 1 NOT CHOSEN, MOVES TO OPTION 2
    
    MOVE.B  #POTION_PRICE,D4        
    MOVE.B  (A6),D6
    CMP     D4,D6
    BGE     ADD_POTION              IF MONEY IS GREATER OR EQUAL TO PRICE OF POTION,CAN BUY POTION
    LEA     NO_MONEY_POTION,A1      DISPLAYS THE NO MONEY FOR POTION MESSAGE
    MOVE.B  #14,D0
    TRAP    #15
    LEA     CLICK_ENTER,A1          DISPLAYS THE CLICK ENTER MESSAGE
    MOVE.B  #14,D0 
    TRAP    #15
    MOVE.B  #4,D0
    TRAP    #15
    BSR     CLEAR_SCREEN            BRANCH TO CLEAR SCREEN SUBROUTINE
    BSR     DECORATE
    BSR     TEMPERATURE
    BSR     ENDL
    BSR     DECORATE
    BSR     ENDL
    BSR     GOLD                    BRANCH TO GOLD SUBROUTINE
    BSR     WINDMILL                BRANCH TO WINDMILL SUBROUTINE
    BSR     SOLAR_PANEL             BRANCH TO SOLAR PANEL SUBROUTINE
    BSR     TREES                   BRANCH TO TREES SUBROUTINE
    BSR     POTIONS                 BRANCH TO POTIONS SUBROUTINE
    BSR     WEAPONS                 BRANCH TO WEAPONS SUBROUTINE
    BSR     SHOP_MESSAGE            BRANCH TO SHOP MESSAGE SUBROUTINE
    RTS                             RETURN FROM SHOP_MESSAGE: SUBROUTINE               
    
WEAPON_ITEM:
    CMP     #2,D1
    BNE     WINDMILL_ITEM
    
    MOVE.B  #WEAPON_PRICE,D5
    MOVE.B  (A6),D6
    MOVE.B  (A5),D4
    CMP     #MAX_WEAPON_LEVEL,D4
    BEQ     MAX_LEVEL               IF MONEY IS EQUAL TO MAX NUMBER OF UPGRADES, CAN'T BUY WEAPON UPGRADE
    CMP     D5,D6
    BGE     ADD_WEAPON              IF MONEY IS GREATER OR EQUAL TO PRICE OF WEAPON,CAN BUY WEAPON UPGRADE
    LEA     NO_MONEY_WEAPON,A1      DISPLAYS THE NO MONEY FOR WEAPON UPGRADE MESSAGE
    MOVE.B  #14,D0
    TRAP    #15
    LEA     CLICK_ENTER,A1          DISPLAYS THE CLICK ENTER MESSAGE
    MOVE.B  #14,D0 
    TRAP    #15
    MOVE.B  #4,D0
    TRAP    #15
    BSR     CLEAR_SCREEN            BRANCH TO CLEAR SCREEN SUBROUTINE
    BSR     DECORATE
    BSR     TEMPERATURE
    BSR     ENDL
    BSR     DECORATE
    BSR     ENDL
    BSR     GOLD                    BRANCH TO GOLD SUBROUTINE
    BSR     WINDMILL                BRANCH TO WINDMILL SUBROUTINE
    BSR     SOLAR_PANEL             BRANCH TO SOLAR PANEL SUBROUTINE
    BSR     TREES                   BRANCH TO TREES SUBROUTINE
    BSR     POTIONS                 BRANCH TO POTIONS SUBROUTINE
    BSR     WEAPONS                 BRANCH TO WEAPONS SUBROUTINE
    BSR     SHOP_MESSAGE            BRANCH TO SHOP MESSAGE SUBROUTINE
    RTS                             RETURN FROM WEAPON_ITEM: SUBROUTINE
 
WINDMILL_ITEM:
    CMP     #3,D1
    BNE     SOLAR_PANEL_ITEM

    MOVE.B  #WINDMILL_PRICE,D5
    MOVE.B  (A6),D6
    MOVE.B  (A5),D4
    CMP     D5,D6
    BGE     ADD_WINDMILL            IF MONEY IS GREATER OR EQUAL TO PRICE OF WINDMILL,CAN BUY
    LEA     NO_MONEY_WINDMILL,A1    DISPLAYS THE NO MONEY FOR WINDMILL MESSAGE
    MOVE.B  #14,D0
    TRAP    #15
    LEA     CLICK_ENTER,A1          DISPLAYS THE CLICK ENTER MESSAGE
    MOVE.B  #14,D0 
    TRAP    #15
    MOVE.B  #4,D0
    TRAP    #15
    BSR     CLEAR_SCREEN            BRANCH TO CLEAR SCREEN SUBROUTINE
    BSR     DECORATE
    BSR     TEMPERATURE
    BSR     ENDL
    BSR     DECORATE
    BSR     ENDL
    BSR     GOLD                    BRANCH TO GOLD SUBROUTINE
    BSR     WINDMILL                BRANCH TO WINDMILL SUBROUTINE  
    BSR     SOLAR_PANEL             BRANCH TO SOLAR PANEL SUBROUTINE    
    BSR     TREES                   BRANCH TO TREES SUBROUTINE
    BSR     POTIONS                 BRANCH TO POTIONS SUBROUTINE
    BSR     WEAPONS                 BRANCH TO WEAPONS SUBROUTINE         
    BSR     SHOP_MESSAGE            BRANCH TO SHOP MESSAGE SUBROUTINE
    RTS                             RETURN FROM WINDMILL_ITEM: SUBROUTINE           
    
SOLAR_PANEL_ITEM:
    CMP     #4,D1
    BNE     TREE_ITEM

    MOVE.B  #SOLARPANEL_PRICE,D5
    MOVE.B  (A6),D6
    MOVE.B  (A5),D4
    CMP     D5,D6
    BGE     ADD_SOLARPANEL          IF MONEY IS GREATER OR EQUAL TO PRICE OF SOLAR PANEL,CAN BUY
    LEA     NO_MONEY_SOLARPANEL,A1  DISPLAYS THE NO MONEY FOR SOLAR PANEL MESSAGE
    MOVE.B  #14,D0
    TRAP    #15
    LEA     CLICK_ENTER,A1          DISPLAYS THE CLICK ENTER MESSAGE
    MOVE.B  #14,D0 
    TRAP    #15
    MOVE.B  #4,D0
    TRAP    #15
    BSR     CLEAR_SCREEN            BRANCH TO CLEAR SCREEN SUBROUTINE
    BSR     DECORATE
    BSR     TEMPERATURE
    BSR     ENDL
    BSR     DECORATE
    BSR     ENDL
    BSR     GOLD                    BRANCH TO GOLD SUBROUTINE
    BSR     WINDMILL                BRANCH TO WINDMILL SUBROUTINE
    BSR     SOLAR_PANEL             BRANCH TO SOLAR PANEL SUBROUTINE  
    BSR     TREES                   BRANCH TO TREES SUBROUTINE
    BSR     POTIONS                 BRANCH TO POTIONS SUBROUTINE
    BSR     WEAPONS                 BRANCH TO WEAPONS SUBROUTINE          
    BSR     SHOP_MESSAGE            BRANCH TO SHOP MESSAGE SUBROUTINE
    RTS                             RETURN FROM SOLAR_PANEL_ITEM: SUBROUTINE
    
TREE_ITEM:
    CMP     #5,D1
    BNE     GAME

    MOVE.B  #TREES_PRICE,D5
    MOVE.B  (A6),D6
    MOVE.B  (A5),D4
    CMP     D5,D6
    BGE     ADD_TREES               IF MONEY IS GREATER OR EQUAL TO PRICE OF TREE,CAN BUY
    LEA     NO_MONEY_TREES,A1       DISPLAYS THE NO MONEY FOR TREES MESSAGE
    MOVE.B  #14,D0
    TRAP    #15
    LEA     CLICK_ENTER,A1          DISPLAYS THE CLICK ENTER MESSAGE
    MOVE.B  #14,D0 
    TRAP    #15
    MOVE.B  #4,D0
    TRAP    #15
    BSR     CLEAR_SCREEN            BRANCH TO CLEAR SCREEN SUBROUTINE
    BSR     DECORATE
    BSR     TEMPERATURE
    BSR     ENDL
    BSR     DECORATE
    BSR     ENDL
    BSR     GOLD                    BRANCH TO GOLD SUBROUTINE
    BSR     WINDMILL                BRANCH TO WINDMILL SUBROUTINE
    BSR     SOLAR_PANEL             BRANCH TO SOLAR PANEL SUBROUTINE
    BSR     TREES                   BRANCH TO TREES SUBROUTINE
    BSR     POTIONS                 BRANCH TO POTIONS SUBROUTINE
    BSR     WEAPONS                 BRANCH TO WEAPONS SUBROUTINE         
    BSR     SHOP_MESSAGE            BRANCH TO SHOP MESSAGE SUBROUTINE
    RTS                             RETURN FROM TREE_ITEM: SUBROUTINE
    
MAX_LEVEL:
    BSR     CLEAR_SCREEN            BRANCH TO CLEAR SCREEN SUBROUTINE
    BSR     DECORATE                BRANCH TO DECORATE SUBROUTINE
    BSR     ENDL                    BRANCH TO ENDL SUBROUTINE
    LEA     MAX_UPGRADE,A1          DISPLAYS THE MAX UPGRADE MESSAGE
    MOVE.B  #14,D0 
    TRAP    #15
    BSR     GOLD                    BRANCH TO GOLD SUBROUTINE
    BSR     WINDMILL                BRANCH TO WINDMILL SUBROUTINE
    BSR     SOLAR_PANEL             BRANCH TO SOLAR PANEL SUBROUTINE
    BSR     TREES                   BRANCH TO TREES SUBROUTINE
    BSR     POTIONS                 BRANCH TO POTIONS SUBROUTINE
    BSR     WEAPONS                 BRANCH TO WEAPONS SUBROUTINE
    BSR     SHOP_MESSAGE            BRANCH TO SHOP MESSAGE SUBROUTINE
    RTS                             RETURN FROM CANT_ADD: SUBROUTINE
    
CLEAR_SCREEN:
    MOVE.W		#$FF00,d1		    CLEAR SCREEN
	MOVEQ		#11,d0			
	TRAP		#15
	MOVE.W      #0,d1               PUT 0 INTO D1 SO IT DOESNT AFFECT ANY STORED DATA
	RTS


*-------------------------------------------------------
*--------------------ADD RESOURCES----------------------
*-------------------------------------------------------
ADD_POTION:
    BSR     CLEAR_SCREEN            BRANCH TO CLEAR SCREEN SUBROUTINE
    ADD.B   #1,(A3)
    SUB.B   #POTION_PRICE,(A6)
    BSR     DECORATE                BRANCH TO DECORATE SUBROUTINE
    BSR     ENDL                    BRANCH TO ENDL SUBROUTINE
    LEA     BOUGHT_POTION,A1        DISPLAYS THE BOUGHT POTION MESSAGE
    MOVE.B  #14,D0
    TRAP    #15
    BSR     ENDL                    BRANCH TO ENDL SUBROUTINE
    BSR     DECORATE
    BSR     TEMPERATURE
    BSR     ENDL
    BSR     GOLD                    BRANCH TO GOLD SUBROUTINE
    BSR     WINDMILL                BRANCH TO WINDMILL SUBROUTINE 
    BSR     SOLAR_PANEL             BRANCH TO SOLAR PANEL SUBROUTINE
    BSR     TREES                   BRANCH TO TREES SUBROUTINE
    BSR     POTIONS                 BRANCH TO POTIONS SUBROUTINE
    BSR     WEAPONS                 BRANCH TO WEAPONS SUBROUTINE
    BSR     ENDL                    BRANCH TO ENDL SUBROUTINE
    BSR     SHOP_MESSAGE            BRANCH TO SHOP MESSAGE SUBROUTINE
    RTS                             RETURN FROM ADD_POTION: SUBROUTINE
   
ADD_WEAPON:                         
    BSR     CLEAR_SCREEN            BRANCH TO CLEAR SCREEN SUBROUTINE
    ADD.B   #1,(A5)
    SUB.B   #WEAPON_PRICE,(A6)
    BSR     DECORATE                BRANCH TO DECORATE SUBROUTINE
    BSR     ENDL                    BRANCH TO ENDL SUBROUTINE
    LEA     BOUGHT_WEAPON,A1        DISPLAYS THE BOUGHT WEAPON MESSAGE
    MOVE.B  #14,D0
    TRAP    #15
    BSR     ENDL                    BRANCH TO ENDL SUBROUTINE
    BSR     DECORATE
    BSR     TEMPERATURE
    BSR     ENDL
    BSR     GOLD                    BRANCH TO GOLD SUBROUTINE
    BSR     WINDMILL                BRANCH TO WINDMILL SUBROUTINE 
    BSR     SOLAR_PANEL             BRANCH TO SOLAR PANEL SUBROUTINE
    BSR     TREES                   BRANCH TO TREES SUBROUTINE
    BSR     POTIONS                 BRANCH TO POTIONS SUBROUTINE
    BSR     WEAPONS                 BRANCH TO WEAPONS SUBROUTINE
    BSR     ENDL                    BRANCH TO ENDL SUBROUTINE
    BSR     SHOP_MESSAGE            BRANCH TO SHOP MESSAGE SUBROUTINE
    RTS                             RETURN FROM ADD_WEAPON: SUBROUTINE
    
ADD_WINDMILL:
    BSR     CLEAR_SCREEN            BRANCH TO CLEAR SCREEN SUBROUTINE
    ADD.B   #1,(4048)
    SUB.B   #WINDMILL_PRICE,(A6)
    BSR     DECORATE                BRANCH TO DECORATE SUBROUTINE
    BSR     ENDL                    BRANCH TO ENDL SUBROUTINE
    LEA     BOUGHT_WINDMILL,A1      DISPLAYS THE BOUGHT WINDMILL MESSAGE
    MOVE.B  #14,D0
    TRAP    #15
    SUB.B   #1,4078                 REMOVE 1 DEGREES CELSIUS TO THE TEMPERATURE
    BSR     ENDL                    BRANCH TO ENDL SUBROUTINE
    BSR     DECORATE
    BSR     TEMPERATURE
    BSR     ENDL
    BSR     GOLD                    BRANCH TO GOLD SUBROUTINE
    BSR     WINDMILL                BRANCH TO WINDMILL SUBROUTINE 
    BSR     SOLAR_PANEL             BRANCH TO SOLAR PANEL SUBROUTINE
    BSR     TREES                   BRANCH TO TREES SUBROUTINE
    BSR     POTIONS                 BRANCH TO POTIONS SUBROUTINE
    BSR     WEAPONS                 BRANCH TO WEAPONS SUBROUTINE
    BSR     ENDL                    BRANCH TO ENDL SUBROUTINE
    BSR     SHOP_MESSAGE            BRANCH TO SHOP MESSAGE SUBROUTINE
    RTS                             RETURN FROM ADD_WINDMILL: SUBROUTINE
    
ADD_SOLARPANEL:
    BSR     CLEAR_SCREEN            BRANCH TO CLEAR SCREEN SUBROUTINE
    ADD.B   #1,(4058)
    SUB.B   #SOLARPANEL_PRICE,(A6)
    BSR     DECORATE                BRANCH TO DECORATE SUBROUTINE
    BSR     ENDL                    BRANCH TO ENDL SUBROUTINE
    LEA     BOUGHT_SOLARPANEL,A1    DISPLAYS THE BOUGHT SOLAR PANEL MESSAGE
    MOVE.B  #14,D0
    TRAP    #15
    SUB.B   #1,4078                 REMOVE 1 DEGREES CELSIUS TO THE TEMPERATURE
    BSR     ENDL                    BRANCH TO ENDL SUBROUTINE
    BSR     DECORATE
    BSR     TEMPERATURE
    BSR     ENDL
    BSR     GOLD                    BRANCH TO GOLD SUBROUTINE
    BSR     WINDMILL                BRANCH TO WINDMILL SUBROUTINE 
    BSR     SOLAR_PANEL             BRANCH TO SOLAR PANEL SUBROUTINE
    BSR     TREES                   BRANCH TO TREES SUBROUTINE
    BSR     POTIONS                 BRANCH TO POTIONS SUBROUTINE
    BSR     WEAPONS                 BRANCH TO WEAPONS SUBROUTINE
    BSR     ENDL                    BRANCH TO ENDL SUBROUTINE
    BSR     SHOP_MESSAGE            BRANCH TO SHOP MESSAGE SUBROUTINE
    RTS                             RETURN FROM ADD_SOLARPANEL: SUBROUTINE

ADD_TREES:
    BSR     CLEAR_SCREEN            BRANCH TO CLEAR SCREEN SUBROUTINE
    ADD.B   #1,(4068)
    SUB.B   #TREES_PRICE,(A6)
    BSR     DECORATE                BRANCH TO DECORATE SUBROUTINE
    BSR     ENDL                    BRANCH TO ENDL SUBROUTINE
    LEA     BOUGHT_TREES,A1         DISPLAYS THE BOUGHT TREES MESSAGE
    MOVE.B  #14,D0
    TRAP    #15
    SUB.B   #1,4078                 REMOVE 1 DEGREES CELSIUS TO THE TEMPERATURE
    BSR     ENDL                    BRANCH TO ENDL SUBROUTINE
    BSR     DECORATE
    BSR     TEMPERATURE
    BSR     ENDL
    BSR     GOLD                    BRANCH TO GOLD SUBROUTINE
    BSR     WINDMILL                BRANCH TO WINDMILL SUBROUTINE 
    BSR     SOLAR_PANEL             BRANCH TO SOLAR PANEL SUBROUTINE
    BSR     TREES                   BRANCH TO TREES SUBROUTINE
    BSR     POTIONS                 BRANCH TO POTIONS SUBROUTINE
    BSR     WEAPONS                 BRANCH TO WEAPONS SUBROUTINE
    BSR     ENDL                    BRANCH TO ENDL SUBROUTINE
    BSR     SHOP_MESSAGE            BRANCH TO SHOP MESSAGE SUBROUTINE
    RTS                             RETURN FROM ADD_TREES: SUBROUTINE  

*-------------------------------------------------------
*-------------------DATA DELARATIONS--------------------
*-------------------------------------------------------

*---------------OPENING MESSAGE TO THE GAME-------------
WELCOME_MSG:    DC.B    '********************************************************************************'
                DC.B    $0D,$0A
                DC.B    'You are the chosen one! You are the only person that can save the earth' 
                DC.B    $0D,$0A
                DC.B    'from Global Warming. Do not let us down !!!'
                DC.B    $0D,$0A
                DC.B    'These monsters have sprung out of nowhere... They have destroyed our land, taken'
                DC.B    $0D,$0A
                DC.B    'our gold and it is time for these monsters to suffer the consequences !!!'
                DC.B    $0D,$0A
                DC.B    'It is time for you to show us what you are made of.'
                DC.B    $0D,$0A
                DC.B    $0D,$0A,0
TO_DO_MSG:      DC.B    'Your mission is straightforward. Complete the quest to earn yourself some'
                DC.B    $0D,$0A
                DC.B    'gold. Afterwards you can go to the shop and buy some windmills, solar'
                DC.B    $0D,$0A
                DC.B    'panels or trees to save the earth from global warming.'
                DC.B    $0D,$0A
                DC.B    '********************************************************************************'
                DC.B    $0D,$0A
                DC.B    $0D,$0A,0
*------------------------------------------------------

*---------WINDMILLS,SOLAR PANELS,TREES OWNED-----------
WINDMILL_MSG    DC.B    'Windmills owned:',0
SOLAR_PANEL_MSG DC.B    'Solar Panels owned:',0
TREES_MSG       DC.B    'Trees owned:',0
*------------------------------------------------------

*-------------------CHARACTER--------------------------
POTIONS_MSG:    DC.B    'Potions owned:',0                
WEAPONS_MSG:    DC.B    'Current Weapon Level:',0
GOLD_MSG:       DC.B    'Gold in your pouch:',0
HEALTH_MSG:     DC.B    'Your Health:',0
*------------------------------------------------------

*-------------------GAMEPLAY---------------------------
QUEST_MSG:          DC.B    'Quest:   The Boss is in your way of saving the Earth from'
                    DC.B    $0D,$0A
                    DC.B    '         global warming!!!'
                    DC.B    $0D,$0A
                    DC.B    '         Defeat the Boss before he destroys all of the land'
                    DC.B    $0D,$0A    
                    DC.B    '         and causes the world to end!!!'
                    DC.B    $0D,$0A,0
CLICK_ENTER:        DC.B    $0D,$0A
                    DC.B    'Click enter to continue'
                    DC.B    $0D,$0A,0
BOSS_MSG:           DC.B    'The Boss used earthquake and dealt 35 damage'
                    DC.B    $0D,$0A,0
PLAYEROPTION_MSG:   DC.B    'What would you like to do next?'
                    DC.B    $0D,$0A
                    DC.B    'Click (1) - Attack  Click (2) - Heal Yourself'
                    DC.B    $0D,$0A,0
ATTACK_MSG:         DC.B    'You struck the Boss and dealt 25 damage'
                    DC.B    $0D,$0A,0
LOOP_MSG:           DC.B    '.',0
REPLAY_MSG:         DC.B    'Enter (0) to Quit the game or (Any Number) to Replay : ',0
FULL_HEALTH:        DC.B    $0D,$0A
                    DC.B    'Your health is full, choose a different option!'
                    DC.B    $0D,$0A,0
USE_POTION:         DC.B    'You used a potion and gained 60 health'
                    DC.B    $0D,$0A,0
ZEROPOTION_MSG:     DC.B    'You have no potions left, choose a different option!',0
SHOW_BOSS_HEALTH:   DC.B    'Boss Health:',0
LOSE_RESOURCES_MSG: DC.B    'Earthquake destroyed 1 Solar Panel, 2 Trees and 1 Windmill'
                    DC.B    $0D,$0A,0                     
LOSE_MSG:           DC.B    'The has Boss killed you and you Failed the Quest!',0
WIN_MSG:            DC.B    'Congratulation you have defeated the Boss, you may proceed!',0
WIN_GOLD_MSG:       DC.B    'You completed the Quest and gained 50 Gold!'
                    DC.B    $0D,$0A,0    
CURRENT_TEMP:       DC.B    'The current Temperature in Degrees Celsius is: ',0
GAIN_TEMP:          DC.B    'The Temperature went up by 2 Degrees Celsius: '
                    DC.B    $0D,$0A,0
LOSE_TEMP:          DC.B    'The Temperature went down by 1 Degrees Celsius: '
                    DC.B    $0D,$0A,0
*-------------------------------------------------------

*-----------------------SHOP----------------------------
SHOP_WELCOME:   DC.B    '************************************************************'
                DC.B    $0D,$0A
                DC.B    'Welcome to the shop sir! We have a variety of menu choices'
                DC.B    $0D,$0A
                DC.B    'for you. If you need any help, just let me know.'
                DC.B    $0D,$0A
                DC.B    $0D,$0A
                DC.B    'Buy a windmill,solar panel or tree to decrease the'
                DC.B    $0D,$0A
                DC.B    'temperature if it is to high!'
                DC.B    $0D,$0A
                DC.B    '************************************************************'
                DC.B    $0D,$0A,0
GAME_OPTION:    DC.B    '********************************************************************************'
                DC.B    $0D,$0A
                DC.B    $0D,$0A
                DC.B    'Would you like to visit the Shop or start your first Quest?'
                DC.B    $0D,$0A
                DC.B    $0D,$0A
                DC.B    '********************************************************************************'
                DC.B    $0D,$0A,0
GAME_OPTION1:   DC.B    'Click (1) - To enter Shop, Click (Enter)- To proceed into your first Quest'
                DC.B    $0D,$0A,0
PRICE_MSG:      DC.B    '************************************************************'
                DC.B    $0D,$0A
                DC.B    '***                           MENU                       ***'
                DC.B    $0D,$0A
                DC.B    '************************************************************'
                DC.B    $0D,$0A
                DC.B    '(1)---Health Potion- 10'
                DC.B    $0D,$0A
                DC.B    '(2)---Sword Upgrade- 100'
                DC.B    $0D,$0A
                DC.B    '(3)---WindMill Cost- 100'
                DC.B    $0D,$0A
                DC.B    '(4)---Solar Panel Cost- 50'
                DC.B    $0D,$0A
                DC.B    '(5)---Tree Costs- 25'
                DC.B    $0D,$0A
                DC.B    '************************************************************'
                DC.B    $0D,$0A
                DC.B    'Choose something in the menu between (1-5) or Click Enter - to leave the shop'
                DC.B    $0D,$0A,0
WRONG_OPTION:   DC.B    $0D,$0A
                DC.B    'Option Unavailable'
                DC.B    $0D,$0A,0
MAX_UPGRADE:    DC.B    'You have reached the max level for your weapon'
                DC.B    $0D,$0A
                DC.B    $0D,$0A,0                
*------------------------------------------------------- 

*------Promt for not enough money for certain item------
NO_MONEY_POTION:      DC.B    $0D,$0A
                      DC.B    'Not enough gold to purchase Potion'
                      DC.B    $0D,$0A,0
NO_MONEY_WEAPON:      DC.B    $0D,$0A
                      DC.B    'Not enough gold to purchase Weapon upgrade'
                      DC.B    $0D,$0A,0
NO_MONEY_WINDMILL:    DC.B    $0D,$0A
                      DC.B    'Not enough gold to purchase Windmill'
                      DC.B    $0D,$0A,0
NO_MONEY_SOLARPANEL:  DC.B    $0D,$0A
                      DC.B    'Not enough gold to purchase Solar Panel'
                      DC.B    $0D,$0A,0
NO_MONEY_TREES:       DC.B    $0D,$0A
                      DC.B    'Not enough gold to purchase Tree'
                      DC.B    $0D,$0A,0
*------------------------------------------------------- 

*-----------Promt for bought certain item---------------
BOUGHT_POTION:        DC.B    'You bought a Potion from the shop'
                      DC.B    $0D,$0A,0
BOUGHT_WEAPON:        DC.B    'You bought a Weapon upgrade from the shop'
                      DC.B    $0D,$0A,0
BOUGHT_WINDMILL:      DC.B    'You bought a Windmill from the shop and decreased the'
                      DC.B    $0D,$0A
                      DC.B    'temperature by 1 Degrees Celsius.'
                      DC.B    $0D,$0A,0
BOUGHT_SOLARPANEL:    DC.B    'You bought a Solar Panel from the shop and decreased the'
                      DC.B    $0D,$0A
                      DC.B    'temperature by 1 Degrees Celsius.'
                      DC.B    $0D,$0A,0
BOUGHT_TREES:         DC.B    'You bought a Tree from the shop and decreased the'
                      DC.B    $0D,$0A
                      DC.B    'temperature by 1 Degrees Celsius.'
                      DC.B    $0D,$0A,0
*-------------------------------------------------------

*----------Used for ENDL (skip line in game)------------
CRLF:           DC.B    $0D,$0A,0
*-------------------------------------------------------

                  

    END START




















*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
