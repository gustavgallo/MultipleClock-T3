# 🕒 MultipleClock-T3
## 👥 Autores
Gustavo Gallo - @gustavgallo

Rodrigo Machado - @GncRodrigo

## 📌 Descrição

Este projeto visa a implementação e simulação de um sistema digital com múltiplos domínios de relógio, utilizando a linguagem de descrição de hardware **SystemVerilog**. O objetivo é explorar técnicas de sincronização entre diferentes domínios de clock, um aspecto crucial em sistemas digitais complexos.

## 🧩 Estrutura do Projeto

- **Deserializer**: recebe 8 bits e armazena em `data_out`.
- **Queue**: armazena sequências de 8 bits em `len_out`, com capacidade para guardar até 4 dessas sequências. Possui operações de **enqueue** (inserção) e **dequeue** (remoção).
- **Module_top**: integra o `Deserializer` com a `Queue`. Quando `data_out` estiver preenchido, seu valor é automaticamente armazenado na fila.

## 🛠️ Tecnologias Utilizadas

- **Linguagem:** SystemVerilog  
- **Simulação:** Ferramentas como **ModelSim** ou **Vivado** podem ser utilizadas para simular e verificar o funcionamento do sistema.

## 🚀 Como Executar

Clone o repositório:

```bash
git clone https://github.com/gustavgallo/MultipleClock-T3.git
```
após isso use o comando:
```bash
vsim -do sim.do
