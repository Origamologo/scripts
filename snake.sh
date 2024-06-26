#!/bin/bash

# high_score=0
read high_score < /home/bluetab/scripts/snake.score
term_cols=`tput cols`  ##coloumns 
term_rows=`tput lines` ##Lines

draw(){
    echo -ne "\e[${1};${2}H$3"
}

draw_borders(){
    local border_color="\e[30;43m" no_color="\e[0m"
    draw 1 1 "$border_color+$no_color"
    for ((i=2; i<=((term_cols-1)); i++)); do ##top
        draw 1 $i "$border_color-$no_color"
    done
    draw 1 $term_cols "$border_color+$no_color"
    
    draw $((term_rows-1)) 1 "$border_color+$no_color"
    for ((i=2; i<=((term_cols-1)); i++)); do ##bottom
        draw $((term_rows-1)) $i "$border_color-$no_color"
    done
    draw $((term_rows-1)) $term_cols "$border_color+$no_color"
    
    for ((i=2; i<=((term_rows-2)); i++)); do ##left
        draw $i 1 "$border_color|$no_color"
    done
    
    for ((i=2; i<=((term_rows-2)); i++)); do ##right
        draw $i $term_cols "$border_color|$no_color"
    done
    echo -ne "\033[$term_rows;$1H\033[36mScore: 0\033[0m";
    ((score_y = $1))
    echo -ne "\033[$term_rows;$((term_cols-50))H\033[33mPress <enter> key to pause game   \033[0m";
    echo -ne "\033[$term_rows;3H\033[33m HighScore: $high_score\033[0m";
}

init_game(){
    clear
    start_x=$((term_rows/2)) 
    start_y=$((4 + $RANDOM % 8))  
    score_x=$term_rows
    score_y=$((term_cols/2))  
    screen_centerX=$start_x      
    screen_centerY=$score_y  
    randX=0
    randY=0
    flag=1
    score=0
    temp_sum=0          
    food_count=0        ##food_score
    snek="⋅⋅⋅⋅ "
    snake_color="\e[30;42m"
    no_color="\e[0m"
    direction_directives=(right right right right right)
    directionX=($start_x $start_x $start_x $start_x $start_x) ## direction of each character of snek
    directionY=(5 4 3 2 1)
    draw_borders $((term_rows-1)) $term_cols
}

game_exit(){
    stty echo;  #Restore echo
    tput rmcup; #Restore screen
    tput cvvis; #Restore cursor
    exit 0;
}

game_pause(){
    echo -en "\033[$term_rows;$((term_cols-50))H\033[33mGame paused, Use <enter> key to continue\033[0m"; ##overwrite the text 
    while read -n 1 key; do
        [[ ${key:-enter} = enter ]] && \
            echo -en "\033[$term_rows;$((term_cols-50))H\033[33mPress <enter> key to pause game           \033[0m" && return;
        [[ ${key:-enter} = q ]] && game_exit
    done
}

update() {                                    #Update the coordinates of each node
    case ${direction_directives[$1]} in
        right) ((directionY[$1]++));;
         left) ((directionY[$1]--));;
         down) ((directionX[$1]++));;
           up) ((directionX[$1]--));;
    esac
}

controls(){
    case ${key:-enter} in 
        s|S) if [[ ${direction_directives[0]} != "up" ]]
             then
             direction_directives[0]="down"
             fi
             ;;
        w|W) if [[ ${direction_directives[0]} != "down" ]]
             then
             direction_directives[0]="up"
             fi
             ;;
        a|A) if [[ ${direction_directives[0]} != "right" ]]
             then 
             direction_directives[0]="left"
             fi
             ;;
        d|D) if [[ ${direction_directives[0]} != "left" ]]
             then 
             direction_directives[0]="right"
             fi
             ;;
        q|Q) game_exit
             ;;
        enter) game_pause
             ;;
    esac
}

check_collision(){
    local x=$1
    local y=$2
    if (( ((x>=$((term_rows-1)))) || ((x<=1)) || ((y>=term_cols)) || ((y<=1)) )) ##with walls
    then 
    return 1
    fi
    for (( i = $((${#snek}-1)); i > 0; i-- ))
        do
        if (( ${directionX[0]} == ${directionY[$i]} && ${directionY[0]} == ${directionY[$i]} )) #crashed with itself
        then
        return 1
        fi 
    done
    echo -ne "\033[${directionX[0]};${directionY[0]}H\033[32m${snek[@]:0:1}\033[0m" 
    return 0
}

grow(){
    snek="⋅$snek"
    direction_directives=(${direction_directives[0]} ${direction_directives[@]})
    directionX=(${directionX[0]} ${directionX[@]})
    directionY=(${directionY[0]} ${directionY[@]})
    update 0
    check_collision ${directionX[0]} ${directionY[0]}
    echo -ne "\033[${directionX[0]};${directionY[0]}H\033[32m${snek[@]:0:1}\033[0m"
    return 0
}

generate_food(){
    randX=$((RANDOM%(term_rows-3)+2))
    randY=$((RANDOM%(term_cols-2)+2))
    for (( i = $((${#snek}-1)); i > 0; i-- ))
        do
        if (( ${randX} == ${directionY[$i]} && ${randY} == ${directionY[$i]} )) #crashed with food
        then
        generate_food
        fi 
    done
    food_count=$((RANDOM%9+1))
    echo -ne "\033[$randX;${randY}H$food_count"
    draw $randX ${randY} "$snake_color$food_count$no_color"
    flag=0
}

game_loop(){
    init_game
    while true
    do
        read -t 0.05 -n 1 key
        [[ $? -eq 0 ]] && controls
        ((flag==0)) || generate_food
        if (( temp_sum > 0 ))
            then
            ((temp_sum--))
            grow; (($?==0)) || return 1
        else
            update 0
            echo -ne "\033[${directionX[0]};${directionY[0]}H\033[32m${snek[@]:0:1}\033[0m"
            for (( i = $((${#snek}-1)); i > 0 ; i-- )) 
                do
                update $i
                echo -ne "\033[${directionX[$i]};${directionY[$i]}H\033[32m${snek[@]:$i:1}\033[0m"
                (( ${directionX[0]} == ${directionX[$i]} && ${directionY[0]} == ${directionY[$i]} )) && return 1 #crashed
                [[ ${direction_directives[$((i-1))]} = ${direction_directives[$i]} ]] || direction_directives[$i]=${direction_directives[$((i-1))]}
            done
        fi
        local tempX=${directionX[0]} tempY=${directionY[0]}
        (( ((tempX>=$((term_rows-1)))) || ((tempX<=1)) || ((tempY>=term_cols)) || ((tempY<=1)) )) && return 1
        (( tempX==randX && tempY==randY )) && ((flag=1)) && ((temp_sum+=food_count)) && ((score+=food_count));
        if (($score > $high_score))
        then 
        ((high_score=score))
        fi
        echo -ne "\033[$score_x;$((score_y+7))H$score";
    done
}

game_over_text=(
    '                                                 '
    '                Game Over !!!                    '
    '                                                 '
    '                   Score:                        '
    '               HighScore:                        '
    '          press   q   to quit                    '
    '          press   n   to start a new game        '
    '                                                 '
    '                                                 '
)

game_over() {
    local x=$((screen_centerX-4)) y=$((screen_centerY-25))
    for (( i = 0; i < 8; i++ )); do
        echo -ne "\033[$((x+i));${y}H${game_over_text[$i]}\033[0m";
    done
    echo $high_score > snake.score
    echo -ne "\033[$((x+3));$((screen_centerY+1))H${score}\033[0m";
    echo -ne "\033[$((x+4));$((screen_centerY+1))H${high_score}\033[0m";
}

start_game_text=(
    '                                                 '
    '                    Welcome                      '
    '                                                 '
    '         space or enter   to pause/play          '
    '         q                to quit the game       '
    '                                                 '
    '         Press <Enter> to start the game         '
    '                                                 '
);

start_game(){
    init_game
    local x=$((screen_centerX-5)) y=$((screen_centerY-25))
    for (( i = 0; i < 8; i++ )); do
        echo -ne "\033[$((x+i));${y}H${start_game_text[$i]}\033[0m";
    done
    while read -n 1 key; do
        [[ ${anykey:-enter} = enter ]] && break
        [[ ${anykey:-enter} = q ]] && game_exit
    done
    while true 
    do
        game_loop
        game_over
        while read -n 1 anykey; do
            [[ $anykey = n ]] && break;
            [[ $anykey = q ]] && game_exit;
        done
    done
}

main(){
    trap 'game_exit;' SIGTERM SIGINT 
    stty -echo
    tput civis
    tput smcup
    start_game 
}

main
