# Alpide_Reading_FlexBond

Di seguito le impostazioni per utilizzare con interfaccia MacOS

## Connessioni fpga
- mettere il cavo usb dentro all'fpga nell'entrata "prog"
- c'è uno switch sull'fpga con on-off -> mettere su on.

## Per caricare il bitfile sull'fpga del firmware di comunicazione:
Versione firmwarew: hepd-tracker-daq-20211116-1814. Aggiornato con ultima versione del software della repo su Baltig.
- Usare il pacchetto openFPGALoader -> brew install openfpgaloader
- openFPGALoader -b nexysVideo ALP_testcardv1.bit 

## Pacchetti necessari
- libftdi1: brew install libftdi
- inih: brew install inih
- python3
- numpy 
- matplotlib 
- scipy

Controllare dove sono stati aggiunti. Di solito vengono messi in /opt/homebrew/Cellar/...
Questo path va inserito sia nel Makefile che nei file MB_daq_util.cpp e hpp

## Per il clk:
- bash clock_toggle.sh on
- bash clock_toggle.sh off

## Per creare l'eseguibile MB_daq_util:
Dove si trova il file MakeFile: 
- make 
- Se ci sono errori, controllare che stia trovando nel modo giusto i pacchetti di comunicazione seriale (libftdi e inih).

# Comandi per eseguire i test sul chip (dopo aver creato l'eseguibile MB_daq_util)
./tools/MB_daq_util -h (help)
./tools/MB_daq_util -i (inizializza)
./tools/MB_daq_util -a (chip_scan)

# Repository utilizzate di G. Gebbia
Da questo viene preso tutto quello che viene utilizzato 
- https://baltig.infn.it/GG-15775/hepd-tracker-daq

Repo aggiuntiva:
- https://gitlab.com/GpGb/HEPD_TDAQ

# Immagini utili

![FPGA ports](Images/FPGA_Ports.png)

![Pogo scheme](Images/Pogo_Scheme.jpeg)

Usare questi schemi per testing.

# Repo vecchia usata per i test sui lyso
https://drive.google.com/drive/folders/12p0JWjaGgzvKak4qei_NB-O77W0bTB8E?usp=sharing

# File di lettura che ci sono sul PC vecchio:
https://drive.google.com/drive/folders/14S2u1gzvflWTR40VqLGDE0Mm5YUJZrqv?usp=sharing

# File lettura singolo CHIP di ALICE
https://drive.google.com/drive/folders/1n7rbg-beAtrQjI7Wbsxem2dVMY0ZX2d_

# Comandi per HIC

- ./MB_daq_util  -w 0x174 0x60e 0x35 # 0x60e è un registro delle soglie, 035 va bene
- ./MB_daq_util  -r 0x174 0x60e  # cosi lo leggi, di solito è impostato a 0x32
- ./MB_daq_util  --dump-regs 0x174  # leggo tutti i registri del chip 174, che sarebbe, porta ethernet 1, il 7 non so bene cosa sia, 4 chip. i chip sono 0,1,2,3,4,8,9,a,b,c. Se metto porta 2 dell'fpga scrivo 274 per esempio.
- ./MB_daq_util  --dump-regs <chip_id> ti legge tutto, in una volta sola.
- ./MB_daq_util --fifotest 0x170, ti dice se comunicazione digitale sta avvenendo oppure no
- a volte la flash di inchioda quindi è necessario fare: --format-flash 
- quando carico il file nuovo di configurazione poi devo fare ./MB_daq_util  -i, in questo modo viene caricata nuovamente sulla FPGA.
- caricarlo sulla flash vuol dire già metterlo in memoria della FBGA. 
- --read-temp legge le temperature su tutti i chip
- ./MB_daq_util  -m # fa partire acuisizione triggerando a 1kHz. se invece faccio -q vuole un trigger esterno da inserire nella FPGA.
- bash run_digitalscan.sh 1 digital scan sulla porta 1 della fpga ethernet. Questo fa anche il processing dei file e diventano pdf.
- quando accendo il clk con comando da pc (basch clock_toggle.sh on) la corrente passa da circa 300 a circa 600. Quindi praticamente raddoppia! passa a 640 mA mentre sta facendo il digital scan. poi oscilla. 
- quando accendo hic ho 314 mA di supply e 0.3 mA di bias. per leggere quella corrente serve il microamperometro.
- quando faccio init anche la corrente cambia da circa 314 ma a circa 300 ma. 
- ./MB_daq_util  --list-files ti dice tutti i file che sono sulla flash.
- bash run_trehsold_scnh.sh -s 1 -> questo fa trh scan per indirizzo 1, quindi parte da 170 e arriva fino alla fine. 

# Note su lettura
- se fai chip scan e si blocca subito vuol dire che non trova il chipid giusto. Oppure che ci sono troppi chip, oppure che il pacchetto di comunicazione è vuoto. Bisogna fare bene attenzione a questa cosa.
- uso USB 3.0 sul hub
- dentro a alpide.h a riga 47 trovi il modo in cui vengono convertiti gli indirizzi in chipid, se noti esso parte da 0x70. Questo perchè nella modalità outer barrel i chipid partono da quel valore e poi proseguono, 0c700,0x701,0x702,... se vuoi cambiare il modo in cui vengono indirizzati i chip basta cambiare quel valore da cui parte il conteggio. Dopo la sequenza è un
- quando faccio threshold scan il risultato del fit s-curve viene riportato nel file txt fit.txt. Ricorda invece che nel file register_dump.txt viene riportato ogni singolo registro di ogni chip. Viene fatto un broadcast su tutti i chip che ci sono. Potrei anche provare a modificare questa cosa per trovare l'indirizzo del chip connesso.

# TODO:
- provare a fare la lettura sul sensore 6diff che abbiamo poi completato sul jig con teflon. Quello ha tutto connesso e si vede bene quando il clk è acceso. Si passa infatti da 32.1 a 66.9 mA quando accendo il clk. Esattamente come vedo sull'HIC che la corrente raddoppia. Questo sembra proprio funzionare bene. Una cosa che non capisco però è che noi abbiamo delle corrente di IBias molto molto elevate (si hanno microamperes con HIC) e noi con singolo chip abbiamo 3 mA, è davvero tanto. Sembra quindi che ci sia un problema sulla corrente di bias.

# Registri:
- Di seguito la sequenza di registri che viene impostata per ogni chip. Bisogna studiare bene i registri che vengono impostati nel file alpide.conf

0x170 0x1 0x3cd
0x170 0x2 0x0
0x170 0x3 0xffff
0x170 0x4 0x70
0x170 0x5 0x50
0x170 0x6 0x0
0x170 0x7 0x14
0x170 0x8 0x1f4
0x170 0x9 0x1
0x170 0xa 0x1
0x170 0xb 0x1
0x170 0xc 0x1
0x170 0xd 0x8179
0x170 0xe 0xaaa
0x170 0xf 0xaa
0x170 0x10 0x76
0x170 0x11 0xf0f
0x170 0x12 0x2fff
0x170 0x13 0xa0
0x170 0x14 0x108d
0x170 0x15 0x88
0x170 0x16 0x301
0x170 0x17 0x0
0x170 0x18 0x0
0x170 0x19 0x0
0x170 0x1a 0x0
0x170 0x1b 0x8
0x170 0x600 0x400
0x170 0x601 0x75
0x170 0x602 0x93
0x170 0x603 0x56
0x170 0x604 0x32
0x170 0x605 0xff
0x170 0x606 0x0
0x170 0x607 0x3e
0x170 0x608 0x0
0x170 0x609 0x0
0x170 0x60a 0x0
0x170 0x60b 0xffff
0x170 0x60c 0x1d
0x170 0x60d 0x40
0x170 0x60e 0x32
0x170 0x60f 0x0
0x170 0x610 0x400
0x170 0x611 0x0

- Questi i registi impostati su alpide.conf, davvero importante studiare i primi registri, sopratutto mode_control e CMU_DMU perchè dipendono da come connetti il chip. Da studiare sul manuale.

mode_control = 0x3cd
CMU_DMU = 0x76
FROMU_conf_1 = 0x70
FROMU_conf_2 = 0x50
FROMU_pulsing_1 = 0x14
FROMU_pulsing_2 = 0x1f4

VRESETD = 0x93
VCASN   = 0x32
VCASN2  = 0x3e
IDB     = 0x1d
ITHR    = 0x32