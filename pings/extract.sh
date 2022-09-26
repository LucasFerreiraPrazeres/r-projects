#!/bin/bash

# processa arquivos gerados por ping.sh

# coleta dados
for exp in $( ls exp-*.txt );
do
	# atrasos
	head -n 31 ${exp} | tail -n 30 | cut -d ' ' -f 8 | cut -d '=' -f 2 > times-${exp}
	# taxas de erro
	tail -n 2 ${exp} | head -n 1 | cut -d ' ' -f 6 | tr -d '%' > per-${exp}
done

# salva tabelas csv de atrasos
paste times-exp-*-C.txt | tr '\t' ',' > times-C.txt
paste times-exp-*-D.txt | tr '\t' ',' > times-D.txt

# salva listas de taxas de erro
cat per-exp-*-C.txt > per-C.txt
cat per-exp-*-D.txt > per-D.txt

# remove arquivos temporários
rm -f times-exp-*.txt
rm -f per-exp-*.txt
