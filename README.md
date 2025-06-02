# 🕒 MultipleClock-T3

## 👥 Autores

- Gustavo Gallo - [@gustavgallo](https://github.com/gustavgallo)  
- Rodrigo Machado - [@GncRodrigo](https://github.com/GncRodrigo)

## 📌 Descrição

Este projeto visa a implementação e simulação de um sistema digital com múltiplos domínios de relógio, utilizando a linguagem de descrição de hardware **SystemVerilog**. O objetivo é explorar técnicas de sincronização entre diferentes domínios de clock, um aspecto crucial em sistemas digitais complexos.

## 🧩 Estrutura do Projeto

- **Deserializer**: recebe dados via `data_in`. Sempre que `write_in` estiver ativo, o bit é armazenado em `data_out` podendo formar um conjunto de 8 bits.
- **Queue**: armazena sequências de 8 bits em `data_out`, com capacidade para guardar até 4 entradas em `len_out`. Possui operações de **enqueue** (inserção) e **dequeue** (remoção).
- **Module_top**: conecta o `Deserializer` à `Queue`, enviando automaticamente `data_out` à fila quando o `data_out` do `Deserializer` estiver completo.

## 🛠️ Tecnologias Utilizadas

- **Linguagem:** SystemVerilog  
- **Simulação:** ModelSim, Vivado ou qualquer simulador compatível com SystemVerilog.

## 🚀 Como Executar

Clone o repositório:

```bash
git clone https://github.com/gustavgallo/MultipleClock-T3.git
 ```
Em seguida, execute a simulação com:

```bash

vsim -do sim.do
```
Certifique-se de que o arquivo sim.do está corretamente configurado para compilar os módulos e iniciar a simulação.
