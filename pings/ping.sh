#!/usr/bin/env bash

SAMPLESIZE=30
EXPERIMENTS=50
INTERVAL=150
SOURCE=A		# A ou B (ajustar dependendo da origem)
SITE_C=www.uol.com.br
SITE_D=www.google.com
for(( i=1; i <= $EXPERIMENTS; i++)); do
    EXP=$( printf "%03d" ${i} )

    FILENAME_C="exp-${EXP}-${SOURCE}-C.txt"
    echo "Gerando amostras de $SOURCE para C em: $FILENAME_C"
    # roda ping de A para C em background
    ping -c ${SAMPLESIZE} ${SITE_C} > "$FILENAME_C" 2> /dev/null &
    PROCA=$!	# salva o PID do processo

    FILENAME_D="exp-${EXP}-${SOURCE}-D.txt"
    echo "Gerando amostras de $SOURCE para D em: $FILENAME_D"
    # roda ping de A para D em background
    ping -c ${SAMPLESIZE} ${SITE_D} > "$FILENAME_D" 2> /dev/null &
    PROCB=$!	# salva o PID do processo
    
    wait $PROCA $PROCB > /dev/null 2>&1	# espera os processos terminarem

    echo "Aguardando ${INTERVAL} segundos..."
    sleep ${INTERVAL}	# espera antes de reiniciar
done
