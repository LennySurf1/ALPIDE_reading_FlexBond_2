## 24 Settembre 2024

- Chip: gradual good
- corrente clk off: 17 mA (poi 20 nel pome)
- corrente clk on: 48 mA
- probe 10x accoppiamento DC
- clk amplitude sulla pcb della FPGA: circa 1 V (preciso 1.040 V) picco picco
- clk amplitude sulla pcb della FPGA: circa 2 V (preciso 1.85 V) picco picco
- Osc usato con limitr a 50 MHz

- clk_N on su PCB FPGA: ![alt text](doc/img_osc/240924_1048.PNG)  
-  clk_N on su piazzola differenziale vicino al tab bond: ![alt text](doc/img_osc/240924_1052.PNG)
- clk_P on su PCB FPGA: ![alt text](doc/img_osc/240924_1058.PNG) 
- clk_P on su piazzola differenziale vicino al tab: ![alt text](doc/img_osc/240924_1054.PNG) 
- clk_N on su PCB FPGA con Osc 100 MHz zoom: ![alt text](doc/img_osc/240924_1211.png) 
- clk_N on su PCB FPGA con Osc 100 MHz: ![alt text](doc/img_osc/240924_1209.png) 
- Nota: bisogna mettere il ground vicino a dove si fa la misura, se aggiungi un lungo ground la misura si rovina. Bisogna quindi mettere un ground vicino al punto di misura. Ecco perchè si mette la via delle differenziali col GND a fianco alle differenziali. 
- Nota: il segnale che esce dal dispositivo circuito integrato è più lento, viene infatti smussato. E diventa una onda triangolare praticamente. 
- clk_N on su piazzola differenziale vicino al tab FPGA con Osc 100 MHz ![alt text](doc/img_osc/240924_1300.png)
- immagine 2 e 3 nel rigol.
- Setup nuovo con calamite di Evgeny molto utile e punte da 200 Mhz. 
- Attenzione che Ev dice che una volta che connettiamo tutto il segnale è tutto insieme, non dipende da dove lo misuri, la linea è una cosa unica. Quindi bisogna fare le misure con: solo FPGA, FPGA+PCB verde, FPGA + PCB verde + flex.
