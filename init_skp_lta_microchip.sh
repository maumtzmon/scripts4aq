#!/bin/bash
source setup_lta.sh

source voltage_skp_lta_v1_microchip.sh
#source voltage_skp_lta_v2_microchip_horizontal.sh
#source voltage_skp_lta_v2_microchip.sh

lta sseq sequencers/microchip/sequencer_microchip_binned_brenda.xml
#lta sseq sequencers/microchip/sequencer_microchip_brenda_HA.xml
#lta sseq sequencers/microchip/sequencer_microchip_brenda_VB.xml
#lta sseq sequencers/microchip/sequencer_microchip_noreset_brenda.xml

lta set sinit 30
lta set pinit 0
lta set ssamp 200
lta set psamp 200
lta set packSource 9
lta set cdsout 3
