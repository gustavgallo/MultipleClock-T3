## 👥 Autores

- Gustavo Gallo - [@gustavgallo](https://github.com/gustavgallo)  
- Rodrigo Machado - [@GncRodrigo](https://github.com/GncRodrigo)

## 📌 Descrição

Este projeto visa a implementação e simulação de um sistema digital com múltiplos domínios de relógio, utilizando a linguagem de descrição de hardware **SystemVerilog**. O objetivo é explorar técnicas de sincronização entre diferentes domínios de clock, um aspecto crucial em sistemas digitais complexos.

## 🧩 Estrutura do Projeto

- **[1]** **deserializer**: recebe dados via data_in. Sempre que write_in estiver ativo, o bit é armazenado em data_out podendo formar um conjunto de 8 bits, trabalha com clock de 100KHz.
- **[2]** **queue**: armazena sequências de 8 bits em data_out, com capacidade para guardar até 4 entradas em len_out. Possui operações de **enqueue** (inserção) e **dequeue** (remoção), trabalha com clock de 10KHz.
- **[3]** **module_top**: conecta o deserializer à queue, enviando automaticamente data_out à fila quando o data_out do deserializer estiver completo, também gera os clocks para simulação e o sinal de **ack** utilizado no módulo **[1]**.
- **[4]** **tb_module_top**: módulo de teste, armazena oito palavras na queue, depois retira uma por vez exibindo seu conteúdo em data_out, após isso será atualizado o sinal reset, mais 8 palavras serão enfileiradas na queue, e haverá uma tentativa de inserir mais uma palavra, demonstrando um travamento com status alto *(caso ruim)*.
- **[5]** **Geração de Clocks**: dentro do module_top, existe um processo que gera clocks de 100KHz e de 10KHz derivados do clock de 1MHz gerado no testbench tb_module_top.sv.
  
## 🛠️ Tecnologias Utilizadas

- **Linguagem:** SystemVerilog  
- **Simulação:** ModelSim, Questa ou qualquer simulador compatível com SystemVerilog.

## 🚀 Como Executar

Clone o repositório:

bash
git clone https://github.com/gustavgallo/MultipleClock-T3.git


Em seguida, execute a simulação com:

bash
cd source



bash
vsim -do sim.do


Certifique-se de que o arquivo sim.do está corretamente configurado para compilar os módulos e iniciar a simulação.

## 🖥️ Simulação

Segue em anexo a forma de onda resultante do testbench **[4]**, e seus respectivos valores:

![Captura de tela de 2025-06-04 08-30-26](https://github.com/user-attachments/assets/8ab3f39a-3c7e-44ca-aca6-66402e568789)
