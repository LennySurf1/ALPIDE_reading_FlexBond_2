# Comandi imoprtanti

- Caricare file .bit su fpga:
openFPGALoader -b nexysVideo ALP_testcardv1.bit

- Accendere il clk su tutte le porte della PCB di interfaccia con FPGA:
bash clock_toggle.sh on

- Spegnere il clk su tutte le porte della PCB di interfaccia con FPGA
bash clock_toggle.sh off

# Chipid of our bonding scheme

- chipid0 n.c. -> 0
- chipid1 n.c. -> 0
- chipid2 n.c. -> 0
- chipid3 n.c. -> 0
- chipid4 n.c. -> 0
- chipid5 n.c. -> 0
- chipid6 n.c. -> 0

# Configurazione chip
- "-w --write-reg <chip_id> <reg_addr> <value> 
- ALPIDE_REG_CMD = 0x0. Questo registro va settato a 0xd2. Sarebbe GRST. (Chip global reset). 
- ALPIDE_REG_CMD = 0x0. Questo registro va settato a 0xe4. Sarebbe PRST. (Pixel Matrix reset)
- ALPIDE_REG_MODE_CTRL  = 0x1. Questo registro va settato a 0x3cd. (Mode Control)
- ALPIDE_REG_CMU_DMU    = 0x10. Questo registro va settato a 0x76. (Disable Manchester Ecnoding).
- > ./tools/MB_daq_util  -w 0x0 0x0 0xd2
- > ./tools/MB_daq_util  -w 0x0 0x0 0xe4
- > ./tools/MB_daq_util  -w 0x0 0x1 0x3cd
- > ./tools/MB_daq_util  -w 0x0 0x10 0x76


# Write and read test 
- ./tools/MB_daq_util  -w 0x174 0x60e 0x35 # 0x60e è un registro delle soglie, 035 va bene
- ./tools/MB_daq_util  -r 0x174 0x60e  # cosi lo leggi, di solito è impostato a 0x32

# Operazioni fatte su HEPD:
std::map<std::string, uint16_t> reg_addr {
    {"mode_control", ALPIDE_REG_MODE_CTRL},
    {"CMU_DMU",      ALPIDE_REG_CMU_DMU},
    {"FROMU_conf_1", ALPIDE_REG_FROMU1},
    {"FROMU_conf_2", ALPIDE_REG_FROMU2},
    {"FROMU_conf_3", ALPIDE_REG_FROMU3},
    {"FROMU_pulsing_1", ALPIDE_REG_PULSING1},
    {"FROMU_pulsing_2", ALPIDE_REG_PULSING2},
    {"VRESETP", ALPIDE_REG_VRESETP},
    {"VRESETD", ALPIDE_REG_VRESETD},
    {"VCASP",   ALPIDE_REG_VCASP},
    {"VCASN",   ALPIDE_REG_VCASN},
    {"VCASN2",  ALPIDE_REG_VCASN2},
    {"VCLIP",   ALPIDE_REG_VCLIP},
    {"VTEMP",   ALPIDE_REG_VTEMP},
    {"IAUX2",   ALPIDE_REG_IAUX2},
    {"IRESET",  ALPIDE_REG_IRESET},
    {"IDB",     ALPIDE_REG_IDB},
    {"IBIAS",   ALPIDE_REG_IBIAS},
    {"ITHR",    ALPIDE_REG_ITHR}
};
