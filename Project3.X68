*-----------------------------------------------------------
* Title      :Project I
* Written by :Daniel Giedraitis
* Date       :03/03/2022
* Description:
*-----------------------------------------------------------

*-------------------------------------------------------
* STARTING MEMORY ADDRESS FOR THE PROGRAMME $1000
*-------------------------------------------------------
    
    ORG $1000

*-------------------------------------------------------
*VALIDATION VALUES TO BE USED, MODIFY AS NEEDED
*ADD ADDITIONAL VALIDATION VALUES AS REQUIRED
*-------------------------------------------------------
EXIT                EQU 0     USED TO EXIT ASSEMBLY PROGRAM
OWNED_POTIONS       EQU 4     MIN NUMBER OF POTIONS
OWNED_WEAPONS       EQU 1     MIN WEAPON LEVEL
MAX_WEAPON          EQU 3     MAX WEAPON LEVEL
WINDMILL_AMOUNT     EQU 1     AMOUNT OF WINDMILLS IN PLAYER'S POSSESSION
SOLARPANEL_AMOUNT   EQU 1     AMOUNT OF SOLAR PANELS IN PLAYER'S POSSESSION
TREES_AMOUNT        EQU 5     AMOUNT OF TREES IN PLAYER'S POSSESSION
MONEY_AMOUNT        EQU 0     AMOUNT OF MONEY IN PLAYER'S POSSESSION
POTION_PRICE        EQU 10    PRICE OF POTION IN SHOP
WEAPON_PRICE        EQU 100   PRICE OF WEAPON UPGRADE IN SHOP
WINDMILL_PRICE      EQU 100   PRICE OF WINDMILL IN SHOP
SOLARPANEL_PRICE    EQU 50    PRICE OF SOLAR PANEL IN SHOP
TREES_PRICE         EQU 25    PRICE OF TREE IN SHOP
ENEMY_HEALTH        EQU 80    ENEMYS HEALTH
HEALTH              EQU 100   PLAYERS HEALTH
MINE_LOC            EQU 100   USED BELOW FOR SOME SIMPLE COLLISION DETECTION USING CMP
DAMAGE              EQU 30    THE AMOUNT OF DAMAGE A PLAYER CAN DO


*THE GAME BEGINS HERE
START:
    MOVE.B  #ENEMY_HEALTH,$4038  PUT ENEMY HEALTH IN MEMORY LOCATION $4038
    LEA     $4038,A2             ASSIGN ADDRESS A2 TO THAT MEMORY LOCATION
    MOVE.B  #OWNED_POTIONS,$4000 PUT POTION AMOUNT IN MEMORY LOCATION $4000
    LEA     $4000,A3             ASSIGN ADDRESS A3 TO THAT MEMORY LOCATION
    MOVE.B  #HEALTH,$4010        PUT HEALTH IN MEMORY LOCATION $4010
    LEA     $4010,A4             ASSIGN ADDRESS A4 TO THAT MEMORY LOCATION
    MOVE.B  #OWNED_WEAPONS,$4014 PUT WEAPON LEVEL IN MEMORY LOCATION $4014
    LEA     $4014,A5             ASSIGN ADDRESS A5 TO THAT MEMORY LOCATION
    MOVE.B  #MONEY_AMOUNT,$4022  PUT MONEY IN MEMORY LOCATION $4022
    LEA     $4022,A6             ASSIGN ADDRESS A6 TO THAT MEMORY LOCATION
    MOVE.B  #WINDMILL_AMOUNT,$4048      PUT WINDMILL IN MEMORY LOCATION $4048
    MOVE.B  $4048,4048
    MOVE.B  #SOLARPANEL_AMOUNT,$4058    PUT SOLAR PANEL IN MEMORY LOCATION $4058
    MOVE.B  $4058,4058
    MOVE.B  #TREES_AMOUNT,$4068         PUT TREES IN MEMORY LOCATION $4068
    MOVE.B  $4068,4068

    MOVE.B  #POTION_PRICE,$4032         PUT POTION PRICE IN MEMORY LOCATION $4032

    BSR     WELCOME    BRANCH TO THE WELCOME SUBROUTINE
    BSR     INPUT      BRANCH TO THE INPUT SUBROUTINE
    BSR     GAME       BRANCH TO THE GAME SUBROUTINE
    
*GAME LOOP
    ORG     $3000      THE REST OF THE PROGRAM IS TO BE LOCATED FROM 3000 ONWARDS

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
    BSR     ENDL            BRANCH TO ENDL SUBROUTINE
    LEA     WELCOME_MSG,A1  ASSIGN MESSAGE TO ADDRESS REGISTER A1
    MOVE.B  #14,D0          MOVE LITERAL 14 TO DO
    TRAP    #15             TRAP AND INTERPRET VALUE IN D0
    LEA     TO_DO_MSG,A1
    MOVE.B  #14,D0
    TRAP    #15

    RTS                     RETURN FROM WELCOME: SUBROUTINE

*-------------------------------------------------------
*---------GAMEPLAY INPUT VALUES SUBROUTINE--------------
*-------------------------------------------------------    
INPUT:
    BSR     WINDMILL        BRANCH TO WINDMILL INPUT SUBROUTINE
    BSR     SOLAR_PANEL     BRANCH TO SOLAR PANEL INPUT SUBROUTINE
    BSR     TREES           BRANCH TO TREES INPUT SUBROUTINE
    BSR     MONEY           BRANCH TO MONEY INPUT SUBROUTINE
    BSR     SHOW_HEALTH     BRANCH TO HEALTH INPUT SUBROUTINE
    BSR     POTIONS         BRANCH TO POTION INPUT SUBROUTINE
    BSR     PROMPT          BRANCH TO WEAPONS INPUT SUBROUTINE
    RTS

*-------------------------------------------------------
*----------------------GAMELOOP-------------------------
*------------------------------------------------------- 
GAMELOOP:
    BSR     QUEST_INFO      BRANCH TO UPDATE GAME SUBROUTINE        
    BSR     PLAYER_TURN     BRANCH TO PLAYER TURN SUBROUTINE
    BSR     ENEMY_TURN      BRANCH TO ENEMY_TURN SUBROUTINE
    BSR     PLAYER_TURN     BRANCH TO PLAYER TURN SUBROUTINE
    BSR     ENEMY_TURN      BRANCH TO ENEMY_TURN SUBROUTINE
    BSR     REPLAY          BRANCH TO REPLAY GAME SUBROUTINE
    RTS                     RETURN FROM GAMELOOP: SUBROUTINE

*-------------------------------------------------------
*---------------------QUEST_INFO------------------------
*------------------------------------------------------- 
QUEST_INFO
    BSR     ENDL            PRINT A CR AND LF
    BSR     DECORATE        DECORATE WITH DOTS USING A LOOP
    LEA     MISSION_MSG,A1   
    MOVE.B  #14,D0
    TRAP    #15
    BSR     DECORATE
    RTS
    
*-------------------------------------------------------
*-----------------PLAYER FIGHTING OPTIONS----------------
*-------------------------------------------------------- 
PLAYER_TURN:
    BSR     ENDL
    BSR     SHOW_HEALTH
    BSR     POTIONS
    BSR     DECORATE
    CMP     #1,(A2)
    BLT     WIN_FIGHT
    CMP     #1,(A4)
    BLT     LOSE_FIGHT
    LEA     USERTURN_MSG,A1
    MOVE.B  #14,D0
    TRAP    #15
    MOVE.B  #4,D0   
    TRAP    #15
    
    MOVE    D1,D0   GETS INPUT FROM PLAYER AND LETA CHOOSE OPTION
    CMP     #1,D1
    BNE     NEXT_CHOICE   IF OPTION 1 NOT CHOSEN, MOVES TO OPTION 2
    BSR     DECORATE  
    BSR     COLLISION   
    RTS

NEXT_CHOICE:
    CMP     #2,D1
    BNE     WRONG_CHOICE
    MOVE.B  (A3),D6
    CMP     #1,D6
    BGE     MINUS_POTION
    LEA     ZEROPOTION_MSG,A1
    MOVE.B  #14,D0
    TRAP    #15
    BSR     PLAYER_TURN
    RTS
    
MINUS_POTION:
    MOVE.B  (A4),D7
    CMP     #100,D7
    BGE     CANT_USE_POTION
    LEA     USE_POTION,A1
    MOVE.B  #14,D0
    TRAP    #15
    BSR     DECORATE
    SUB.B   #1,(A3)
    ADD.B   #60,(A4)
    BSR     SHOW_HEALTH
    BSR     POTIONS
    RTS
   
CANT_USE_POTION:
    LEA     FULL_HEALTH,A1
    MOVE.B  #14,D0
    TRAP    #15
    BSR     DECORATE 
    BSR     PLAYER_TURN
    RTS 
WRONG_CHOICE:
    LEA     WRONG_OPTION,A1
    MOVE.B  #14,D0
    TRAP    #15
    BNE     PLAYER_TURN
    RTS
    
*-------------------------------------------------------
*-------------------------WEAPONS-----------------------
*-------------------------------------------------------   
WEAPONS:
    BSR     ENDL
    LEA     WEAPONS_MSG,A1
    MOVE.B  #14,D0
    TRAP    #15
    MOVE.B  (A5),D1
    MOVE.B  #3,D0
    TRAP    #15
    BSR     ENDL
    BSR     DECORATE
    RTS
    
PROMPT:
    BSR     WEAPONS
    LEA     PRESS_ENTER,A1
    MOVE.B  #14,D0
    TRAP    #15
    MOVE.B  #4,D0   
    TRAP    #15
    LEA     SHOP_PROMPT,A1
    MOVE.B  #14,D0
    TRAP    #15
    MOVE.B  #4,D0   
    TRAP    #15
    MOVE    D1,D0
    CMP #1,D1
    BNE GAME
    BSR SHOP
    RTS

*-------------------------------------------------------
*--------------------Money display----------------------
*-------------------------------------------------------
MONEY:
    BSR     DECORATE
    LEA     MONEY_MSG,A1
    MOVE.B  #14,D0
    TRAP    #15
    MOVE.B  (A6),D1
    MOVE.B  #3,D0
    TRAP    #15
    BSR     ENDL
    RTS
    
*-------------------------------------------------------
*--------------------Windmill display-------------------
*-------------------------------------------------------
WINDMILL:
    BSR     DECORATE
    LEA     WINDMILL_MSG,A1
    MOVE.B  #14,D0
    TRAP    #15
    MOVE.B  (4048),D1
    MOVE.B  #3,D0
    TRAP    #15
    BSR     ENDL
    RTS


    
*-------------------------------------------------------
*--------------------Solar Panel display----------------
*-------------------------------------------------------
SOLAR_PANEL:
    BSR     ENDL
    LEA     SOLAR_PANEL_MSG,A1
    MOVE.B  #14,D0
    TRAP    #15
    MOVE.B  (4058),D1
    MOVE.B  #3,D0
    TRAP    #15
    BSR     ENDL            BRANCH TO ENDL SUBROUTINE
    RTS

*-------------------------------------------------------
*--------------------Trees display----------------------
*-------------------------------------------------------
TREES:
    BSR     ENDL
    LEA     TREES_MSG,A1
    MOVE.B  #14,D0
    TRAP    #15
    MOVE.B  (4068),D1
    MOVE.B  #3,D0
    TRAP    #15
    BSR     ENDL            BRANCH TO ENDL SUBROUTINE
    RTS



*-------------------------------------------------------
*--------------------POTION DISPLAY---------------------
*-------------------------------------------------------
POTIONS:
    BSR     ENDL
    LEA     POTIONS_MSG,A1
    MOVE.B  #14,D0
    TRAP    #15
    MOVE.B  (A3),D1
    MOVE.B  #3,D0
    TRAP    #15
    BSR     ENDL            BRANCH TO ENDL SUBROUTINE
    RTS
    
    
*-------------------------------------------------------
*--------------------PLAYER HEALTH----------------------
*-------------------------------------------------------
SHOW_HEALTH:
    BSR     ENDL
    LEA     HEALTH_MSG,A1
    MOVE.B  #14,D0
    TRAP    #15
    MOVE.B  (A4),D1
    MOVE.B  #3,D0
    TRAP    #15
    BSR     ENDL            BRANCH TO ENDL SUBROUTINE
    RTS
*-------------------------------------------------------
*---------------------ENEMY TURN------------------------
*------------------------------------------------------- 
ENEMY_TURN:
    BSR     ENDL
    BSR     DECORATE
    LEA     GAMEPLAY_MSG,A1
    MOVE.B  #14,D0
    TRAP    #15
    MOVE.B  #4,D0
    TRAP    #15
    SUB.B   #49,(A4)
    CMP     #1,(A2)            IF ENEMY HEALTH IS BELOW 1, PLAYER WINS
    BLT     WIN_FIGHT
    CMP     #1,(A4)             IF PLAYER HEALTH IS BELOW 1, PLAYER LOSES
    BLT     LOSE_FIGHT
    BSR     DECORATE
    BSR     PLAYER_TURN
    RTS

*-------------------------------------------------------
*------------------ATTACKING THE MINIBOSS---------------
*-------------------------------------------------------
COLLISION:
    LEA     HIT_MSG,A1
    MOVE    #14,D0
    TRAP    #15
    BSR     DECORATE
    BSR     ENDL
    MOVE.B  #DAMAGE,D5
    MULU    #OWNED_WEAPONS,D5           MULTIPLIES DAMAGE BY LEVEL OF WEAPON
    SUB.B   D5,(A2)
    CMP     #1,(A2)
    BLT WIN_FIGHT
    CMP     #1,(A4)
    BLT     LOSE_FIGHT
    LEA     SHOW_ENEMY_HEALTH,A1
    MOVE    #14,D0
    TRAP    #15
    MOVE.B  (A2),D1
    MOVE.B  #3,D0
    TRAP    #15
    BSR     ENDL
    CMP     #1,(A2)
    BLT     WIN_FIGHT
    CMP     #1,(A4)
    BLT     LOSE_FIGHT
    
    BSR     ENEMY_TURN
    RTS
    
WIN_FIGHT:
    BSR     SHOW_HEALTH     Displays health on screen
    ADD.B   #25,(A6)        Gives the player money for defeating mini boss
    BSR     MONEY           Displays money on screen
    BSR     ENDL
    LEA     WIN_MSG,A1      Displays the winning message
    MOVE.B  #14,D0
    TRAP    #15
    MOVE.B  #100,(A4)       Replenishes player health
    MOVE.B  #80,(A2)        Replenishes mini boss health
    BSR REPLAY
    RTS
     
LOSE_FIGHT:
    LEA     LOSE_MSG,A1     Displays the lose message 
    MOVE.B  #14,D0
    TRAP    #15
    MOVE.B  #100,(A4)
    BSR REPLAY
    RTS

*-------------------------------------------------------
*------------------SCREEN DECORATION--------------------
*-------------------------------------------------------
DECORATE:
    MOVE.B  #60, D3
    BSR     ENDL
OUT:
    LEA     LOOP_MSG,A1
    MOVE.B  #14,D0
    TRAP    #15
	SUB     #1,D3   DECREMENT LOOP COUNTER
    BNE     OUT	    REPEAT UNTIL D0=0
    BSR     ENDL
    RTS
    
*-------------------------------------------------------
*------------------------REPLAY-------------------------
*-------------------------------------------------------
REPLAY:
    BSR     ENDL
    LEA     REPLAY_MSG,A1
    MOVE.B  #14,D0
    TRAP    #15
    
    MOVE.B  #4,D0
    TRAP    #15

    CMP     #EXIT,D1
    BEQ     END         IF SR Z REGISTER CONTAINS 1 BEQ => BRANCH EQUALS
    BSR     INPUT

ENDL:
    MOVEM.L D0/A1,-(A7)
    MOVE    #14,D0
    LEA     CRLF,A1
    TRAP    #15
    MOVEM.L (A7)+,D0/A1
    RTS

*-------------------------------------------------------
*-------------------SHOP--------------------------------
*-------------------------------------------------------
SHOP:
    BSR     ENDL
    BSR     DECORATE
    LEA     SHOP_MSG,A1
    MOVE.B  #14,D0
    TRAP    #15
    LEA     PRESS_ENTER,A1 
    MOVE.B  #14,D0
    TRAP    #15
    MOVE.B  #4,D0   
    TRAP    #15
    BSR     DECORATE
    BSR     SHOP_MESSAGE
    RTS
SHOP_MESSAGE:
    LEA     PRICE_MSG,A1
    MOVE.B  #14,D0
    TRAP    #15
    MOVE.B  #4,D0   
    TRAP    #15
    
    MOVE    D1,D0   GETS INPUT FROM PLAYER AND LETS BUY STUFF
    CMP     #1,D1
    BNE     WEAPON_ITEM   IF OPTION 1 NOT CHOSEN, MOVES TO OPTION 2
    BNE     WINDMILL_ITEM
    
    MOVE.B  #POTION_PRICE,D4
    MOVE.B  (A6),D6
    CMP     D4,D6
    BGE     ADD_POTION  IF MONEY IS GREATER OR EQUAL TO PRICE OF POTION,CAN BUY
    LEA     NO_MONEY,A1
    MOVE.B  #14,D0
    TRAP    #15
    LEA     PRESS_ENTER,A1
    MOVE.B  #14,D0 
    TRAP    #15
    MOVE.B  #4,D0
    TRAP    #15
    BSR     MONEY 
    BSR     WINDMILL        
    BSR     SOLAR_PANEL     
    BSR     TREES  
    BSR     POTIONS
    BSR     WEAPONS           
    BSR     SHOP_MESSAGE
    RTS
WEAPON_ITEM:
    CMP     #2,D1
    BNE     GAME
    
    MOVE.B  #WEAPON_PRICE,D5
    MOVE.B  (A6),D6
    MOVE.B  (A5),D4
    CMP     #MAX_WEAPON,D4
    BEQ     CANT_ADD  IF MONEY IS EQUAL TO MAX NUMBER OF UPGRADES, CAN'T BUY
    CMP     D5,D6
    BGE     ADD_WEAPON  IF MONEY IS GREATER OR EQUAL TO PRICE OF WEAPON,CAN BUY
    LEA     NO_MONEY,A1
    MOVE.B  #14,D0
    TRAP    #15
    LEA     PRESS_ENTER,A1
    MOVE.B  #14,D0 
    TRAP    #15
    MOVE.B  #4,D0
    TRAP    #15
    BSR     MONEY
    BSR     WINDMILL        
    BSR     SOLAR_PANEL     
    BSR     TREES
    BSR     POTIONS
    BSR     WEAPONS
    BSR     SHOP_MESSAGE
    RTS
 
WINDMILL_ITEM:
    CMP     #3,D1
    BNE     GAME

    MOVE.B  #WINDMILL_PRICE,D4
    MOVE.B  (A6),D6
    CMP     D4,D6
    BGE     ADD_WINDMILL  IF MONEY IS GREATER OR EQUAL TO PRICE OF POTION,CAN BUY
    LEA     NO_MONEY,A1
    MOVE.B  #14,D0
    TRAP    #15
    LEA     PRESS_ENTER,A1
    MOVE.B  #14,D0 
    TRAP    #15
    MOVE.B  #4,D0
    TRAP    #15
    BSR     MONEY 
    BSR     WINDMILL        
    BSR     SOLAR_PANEL     
    BSR     TREES  
    BSR     POTIONS
    BSR     WEAPONS           
    BSR     SHOP_MESSAGE
    RTS

ADD_POTION:
    ADD.B   #1,(A3)
    SUB.B   #POTION_PRICE,(A6)
    BSR     ENDL
    BSR     MONEY
    BSR     WINDMILL        
    BSR     SOLAR_PANEL     
    BSR     TREES
    BSR     POTIONS
    BSR     WEAPONS
    BSR     ENDL
    BSR     SHOP_MESSAGE
    RTS
   
    
ADD_WEAPON:
    ADD.B   #1,(A5)
    SUB.B   #WEAPON_PRICE,(A6)
    BSR     ENDL
    BSR     MONEY
    BSR     WINDMILL        
    BSR     SOLAR_PANEL     
    BSR     TREES
    BSR     POTIONS
    BSR     WEAPONS
    BSR     ENDL
    BSR     SHOP_MESSAGE

    RTS
    
ADD_WINDMILL:
    ADD.B   #1,(4048)
    SUB.B   #WINDMILL_PRICE,(A6)
    BSR     ENDL
    BSR     MONEY
    BSR     WINDMILL        
    BSR     SOLAR_PANEL     
    BSR     TREES
    BSR     POTIONS
    BSR     WEAPONS
    BSR     ENDL
    BSR     SHOP_MESSAGE
    RTS
    
ADD_SOLARPANEL:
    ADD.B   #1,(4058)
    SUB.B   #SOLARPANEL_PRICE,(A6)
    BSR     ENDL
    BSR     MONEY
    BSR     WINDMILL        
    BSR     SOLAR_PANEL     
    BSR     TREES
    BSR     POTIONS
    BSR     WEAPONS
    BSR     ENDL
    BSR     SHOP_MESSAGE
    RTS

ADD_TREES:
    ADD.B   #1,(4068)
    SUB.B   #TREES_PRICE,(A6)
    BSR     ENDL
    BSR     MONEY
    BSR     WINDMILL        
    BSR     SOLAR_PANEL     
    BSR     TREES
    BSR     POTIONS
    BSR     WEAPONS
    BSR     ENDL
    BSR     SHOP_MESSAGE
    RTS

CANT_ADD:
    LEA     MAX_UPGRADE,A1
    MOVE.B  #14,D0 
    TRAP    #15
    BSR     SHOP_MESSAGE
    RTS

   
*-------------------------------------------------------
*-------------------DATA DELARATIONS--------------------
*-------------------------------------------------------

*---------------OPENING MESSAGE TO THE GAME-------------
CRLF:           DC.B    $0D,$0A,0
WELCOME_MSG:    DC.B    '********************************************************************************'
                DC.B    $0D,$0A
                DC.B    'You are the chosen one! You are the only person that can save the earth' 
                DC.B    $0D,$0A
                DC.B    'from Global Warming. Do not let us down !!!'
                DC.B    $0D,$0A
                DC.B    'These monsters have sprung out of nowhere... They have destroyed our land, taken'
                DC.B    $0D,$0A
                DC.B    'our money and it is time for these monsters to suffer the consequences !!!'
                DC.B    $0D,$0A
                DC.B    'It is time for you to show us what you are made of.'
                DC.B    $0D,$0A
                DC.B    $0D,$0A,0
TO_DO_MSG:      DC.B    'Your mission is straightforward. Complete the quests to earn yourself some'
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
MONEY_MSG:      DC.B    'Money in your pouch:',0
HEALTH_MSG:     DC.B    'Health:',0
*------------------------------------------------------

*-------------------GAMEPLAY---------------------------
MISSION_MSG:    DC.B    'Quest 1: Defeat the Mini boss to proceed onto the next Quest',0
                DC.B    $0D,$0A
                DC.B    'Eliminate the Mini boss to continue!',0
PRESS_ENTER:    DC.B    $0D,$0A
                DC.B    'Press enter to continue'
                DC.B    $0D,$0A,0
GAMEPLAY_MSG:   DC.B    'The Mini boss used earthquake',0
USERTURN_MSG: DC.B      'What do you want to do?'
                DC.B    $0D,$0A
                DC.B    '1 - Attack!  2 - Heal thyself!'
                DC.B    $0D,$0A,0
HIT_MSG:        DC.B    'You struck the Mini boss!',0
LOOP_MSG:       DC.B    '.',0
REPLAY_MSG:     DC.B    'ENTER 0 TO QUIT THE GAME OR ANY NUMBER TO REPLAY : ',0
FULL_HEALTH:    DC.B    $0D,$0A
                DC.B    'YOUR HEALTH IS FULL - Unable to heal'
                DC.B    $0D,$0A,0

USE_POTION:     DC.B    $0D,$0A
                DC.B    'You used a potion and gained 60 health'
                DC.B    $0D,$0A,0
ZEROPOTION_MSG: DC.B    'You have no potions available',0
SHOW_ENEMY_HEALTH:   DC.B    'Enemy Health:',0
LOSE_MSG:       DC.B    'The mini boss killed you and you Failed the Quest!',0
WIN_MSG:        DC.B    'You defeated the mini boss, you may proceed!',0

*-------------------------------------------------------

*-----------------------SHOP----------------------------
SHOP_MSG:       DC.B    '********************************************************************************'
                DC.B    $0D,$0A
                DC.B    'Welcome to the shop sir!'
                DC.B    $0D,$0A
                DC.B    'If you need any help, just let me know.'
                DC.B    $0D,$0A
                DC.B    '********************************************************************************'
                DC.B    $0D,$0A,0
SHOP_PROMPT:    DC.B    'Would you like to visit the shop?'
                DC.B    $0D,$0A
                DC.B    'Click number 1 - To enter Shop, Click Enter- To proceed into your first Quest'
                DC.B    $0D,$0A,0
PRICE_MSG:      DC.B    '(1)---Health Potion- 10'
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
                DC.B    'Choose something in the menu between (1-5) or Press Enter - to leave the shop'
                DC.B    $0D,$0A,0

NO_MONEY:       DC.B    $0D,$0A
                DC.B    'Not enough money to purchase item'
                DC.B    $0D,$0A,0
WRONG_OPTION:   DC.B    $0D,$0A
                DC.B    'Option Unavailable'
                DC.B    $0D,$0A,0
MAX_UPGRADE:    DC.B    'You have reached the max level for your weapon'
                DC.B    $0D,$0A
                DC.B    $0D,$0A,0
                
*------------------------------------------------------            

    END START






*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
