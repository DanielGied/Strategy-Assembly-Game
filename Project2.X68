*-----------------------------------------------------------
* Title      :
* Written by :
* Date       :
* Description:
*-----------------------------------------------------------
    ORG    $1000
    
EXIT        EQU 0      USED TO EXIT ASSEMBLY PROGRAM
OWNED_POTIONS EQU 2      MIN NUMBER OF POTIONS
OWNED_WEAPONS EQU 1      MIN WEAPON LEVEL
MAX_WEAPON    EQU 5      MAX WEAPON LEVEL
MONEY_AMOUNT  EQU 0     AMOUNT OF MONEY IN PLAYER'S POSSESSION
POTION_PRICE EQU 10     PRICE OF POTION IN SHOP
WEAPON_PRICE EQU 50     PRICE OF WEAPON UPGRADE IN SHOP
ENEMY_HEALTH EQU 75
HEALTH       EQU 100
MINE_LOC    EQU 100    USED BELOW FOR SOME SIMPLE COLLISION DETECTION USING CMP
DAMAGE      EQU 25

*START OF GAME
START:                  
    MOVE.B  #ENEMY_HEALTH,$4040
    LEA     $4040,A2
    MOVE.B  #OWNED_POTIONS,$4000 PUT POTION AMOUNT IN MEMORY LOCATION $4000
    LEA     $4000,A3   ASSIGN ADDRESS A3 TO THAT MEMORY LOCATION
    MOVE.B  #HEALTH,$4010
    LEA     $4010,A4
    MOVE.B  #OWNED_WEAPONS,$4020 PUT WEAPON LEVEL IN MEMORY LOCATION $4008
    LEA     $4020,A5   ASSIGN ADDRESS A4 TO THAT MEMORY LOCATION
    MOVE.B  #MONEY_AMOUNT,$4026
    LEA     $4026,A6

    
    MOVE.B  #POTION_PRICE,$4036
    

    BSR     WELCOME    BRANCH TO THE WELCOME SUBROUTINE
*    BSR     INPUT      BRANCH TO THE INPUT SUBROUTINE
    BSR     GAME_SUBROUTINE       BRANCH TO THE GAME SUBROUTINE

*GAME LOOP
    ORG     $3000      THE REST OF THE PROGRAM IS TO BE LOCATED FROM 3000 ONWARDS

*-------------------------------------------------------
*-------------------GAME SUBROUTINE---------------------
*-------------------------------------------------------
GAME_SUBROUTINE:
    BSR     GAMELOOP   BRANCH TO GAMELOOP SUBROUTINE
    RTS                RETURN FROM GAME: SUBROUTINE
          
END:

    SIMHALT    

*-------------------------------------------------------
*-------------------WELCOME SUBROUTINE------------------
*-------------------------------------------------------
WELCOME:
    BSR     endl            BRANCH TO ENDL SUBROUTINE
    LEA     WELCOME_MSG,A1  ASSIGN MESSAGE TO ADDRESS REGISTER A1
    MOVE.B  #14,D0          MOVE LITERAL 14 TO DO
    TRAP    #15             TRAP AND INTERPRET VALUE IN D0
    LEA     INSTRUCT_MSG,A1
    MOVE.B  #14,D0
    TRAP    #15

    RTS                     RETURN FROM WELCOME: SUBROUTINE
    
   
*-------------------------------------------------------
*-----------------------GAMELOOP------------------------
*------------------------------------------------------- 
GAMELOOP:
    BSR     QUEST_INFO 



MENU:
    LEA MESSAGE, A1
    MOVE.B #14, D0
    TRAP #15
    
    MOVE #4, D0
    TRAP #15
    
    CMP #1, D1 # COMPARE WITH 1
    BLT MENU
    CMP #4, D1 # COMPARE WITH 3
    BGT MENU
    BRA CHOICE
    
CHOICE:
    * PLEASE COMPLETE CHOICE AS IN FLOW CHART
    * NEED TO CHECK IF THE NUMBER IS EXACTLY 1 AND GOTO METHOD BUY_TREES
    * OR ELSE SHOW THE MENU AGAIN
    CMP #1, D1
    BEQ PURCHASE_TREES
    
    CMP #2, D1
    BEQ HARVEST_TREES
    
    CMP #3, D1
    BEQ PURCHASE_WINDMILLS
    
    CMP #4, D1
    BEQ PURCHASE_SOLAR_PANELS
    
    BRA MENU
    
PURCHASE_TREES:
    LEA TREES, A1
    MOVE.B #14, D0
    TRAP #15
    
    BRA GAME
    
HARVEST_TREES:
    LEA HARVEST, A1
    MOVE.B #14, D0
    TRAP #15
    
    BRA GAME
 
PURCHASE_WINDMILLS:
    LEA WINDMILL, A1
    MOVE.B #14, D0
    TRAP #15
    
    BRA GAME
    
PURCHASE_SOLAR_PANELS:
    LEA SOLAR, A1
    MOVE.B #14, D0
    TRAP #15
    
    BRA GAME

    
GAME:
    LEA GAME_MESSAGE, A1
    MOVE.B #14, D0
    TRAP #15      

*-------------------------------------------------------
*---------------------------QUEST_INFO------------------
*------------------------------------------------------- 
QUEST_INFO


endl:
    MOVEM.L D0/A1,-(A7)
    MOVE    #14,D0
    LEA     CRLF,A1
    TRAP    #15
    MOVEM.L (A7)+,D0/A1
    RTS
   

*-------------------------------------------------------
*-------------------DATA DELARATIONS--------------------
*-------------------------------------------------------

CRLF:           DC.B    $0D,$0A,0
WELCOME_MSG:    DC.B    '********************************************************************************'
                DC.B    $0D,$0A
                DC.B    'You are the chosen one! You are the only person that can save the earth' 
                DC.B    $0D,$0A
                DC.B    'from Global Warming. Do not let us down !!!'
                DC.B    $0D,$0A
                DC.B    'These monsters have sprung out of nowhere... They have taken our land and money'
                DC.B    $0D,$0A
                DC.B    'and it is time for these monsters to suffer the consequences !!!'
                DC.B    $0D,$0A
                DC.B    'It is time for you to show us what you are made of.'
                DC.B    $0D,$0A
                DC.B    $0D,$0A,0
INSTRUCT_MSG:   DC.B    'Your mission is straightforward. Complete the quests to earn yourself some'
                DC.B    $0D,$0A
                DC.B    'gold. Afterwards you can go to the shop and buy some windmills or solar'
                DC.B    $0D,$0A
                DC.B    'panels to save the earth from global warming.'
                DC.B    $0D,$0A
                DC.B    '********************************************************************************'
                DC.B    $0D,$0A
                DC.B    $0D,$0A,0
                
MESSAGE DC.B '(1) BUY TREES, (2) HARVEST, (3) BUY WINDMILLS, (4) BUY SOLAR PANELS : ', 0

TREES DC.B 'HOW MANY TREES WOULD YOU LIKE TO BUY? ', 0
HARVEST DC.B 'HOW MANY TREES WOULD YOU LIKE TO HARVEST? ', 0
WINDMILL DC.B 'HOW MANY WINDMILLS WOULD YOU LIKE TO BUY? ', 0
SOLAR DC.B 'HOW MANY SOLAR PANELS WOULD YOU LIKE TO BUY? ', 0

GAME_MESSAGE DC.B 'REST OF GAME HERE: ', 0


    END    START       






*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
