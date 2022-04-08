#!/bin/bash
#Vvr=-6
#Vvh=3
#Vth=2.5
#Vhh=2
#delayV=300
Vvsub = 70
channel=3

imgFOLDER=`dirname $BASH_SOURCE`/images/microchip/07APR2022
runname=mod9_wfr13
lockfilename=lockfile

doClean(){
        if [ ! -f "$lockfilename" ]; then break; fi
	lta NROW 650
	lta NCOL 600
        lta NBINROW 1
        lta NBINCOL 1
	lta NSAMP 1
	lta EXPOSURE 0
	lta name $imgFOLDER/skp_${runname}_NSAMP1_NROW650_NCOL600_EXPOSURE0_cleanimg
	lta read
	}

doClear(){
        lta sseq sequencers/microchip/sequencer_clear_microchip_brenda.xml
        lta startseq
        sleep 60
        lta readoff
	}

doRaw(){
	lta startseq
	sleep 0
	lta set bufSel $channel	# Select ADC channel to capture (0-3)
	echo "Taking raw of channel $channel"
	# Transfer raw data
	lta set packSource 4
	lta set packStart 1
	lta getraw
	lta set packSource 9
	lta set packStart 0
	}

doBinned(){
        if [ ! -f "$lockfilename" ]; then break; fi
        lta NROW 65
        lta NCOL 60
        lta NBINROW 10
        lta NBINCOL 10
        lta NSAMP 1
        lta EXPOSURE 0
        lta name $imgFOLDER/skp_${runname}_NSAMP225_NROW65_NCOL60_NBINROW10_NBINCOL10_EXPOSURE0_binnedimg
        lta read
        }

doSettings(){
	rows=25
        lta NROW $rows
        cols=700
        lta NCOL $cols
        nsmpls=225
        lta NSAMP $nsmpls
        expo=0
	lta EXPOSURE $expo
        lta NBINROW 1
        lta NBINCOL 1

#	lta delay_V_Overlap $delayV
#	lta set vr $Vvr
#	lta set psamp 1
#	lta set h1ah $Vhh
#	lta set h1bh $Vhh
#	lta set h2ch $Vhh
#	lta set h3ah $Vhh
#	lta set h3bh $Vhh
#	lta set v1ah $Vvh
#	lta set v1bh $Vvh
#	lta set v2ch $Vvh
#	lta set v3ah $Vvh
#	lta set v3bh $Vvh
#	lta set tgah $Vth
#	lta set tgbh $Vth
        }


touch $lockfilename
mkdir -p $imgFOLDER

source init/init_skp_lta_microchip.sh

#lta sseq sequencers/microchip/sequencer_microchip_brenda_VA.xml
#lta sseq sequencers/microchip/sequencer_microchip_binned_brenda.xml
#lta sseq sequencers/microchip/sequencer_microchip_noreset_brenda.xml

#source voltage_skp_lta_v1_microchip.sh

source eraseANDepurge.sh
lta set vsub $Vvsub

#doBinned

doClean
#doClean
#doClean
#doClean
sleep 600
lta read

#lta set vdrain_sw 0
#lta set vdrain_sw 1
#doClean

#lta sseq sequencers/microchip/sequencer_microchip_binned_brenda.xml

#source voltage_skp_lta_v3_microchip_horizontal.sh
#source voltage_skp_lta_v2_microchip_freezed.sh
#source voltage_skp_lta_v2_C_safe_brenda_horizontal.sh

#doSettings
#lta name $imgFOLDER/skp_${runname}_EXPOSURE${expo}_NSAMP${nsmpls}_NROW${rows}_NCOL${cols}_img
#lta read

#doSettings
#lta name $imgFOLDER/skp_${runname}_EXPOSURE${expo}_NSAMP${nsmpls}_NROW${rows}_NCOL${cols}_rawch${channel}_
#doRaw

#-----------LOOPS----------

#for string in VA VB HA HB
#do
#	if [ ! -f "$lockfilename" ]; then break; fi
#	lta sseq sequencers/microchip/sequencer_microchip_brenda_${string}.xml
#	doSettings
#	lta name $imgFOLDER/skp_${runname}_seq${string}_NSAMP${nsmpls}_NROW${rows}_NCOL${cols}_EXPOSURE${expo}_img
#	lta read
#done

#for expo in `seq 0 600 3600`
#do
#	if [ ! -f "$lockfilename" ]; then break; fi
#	source eraseANDepurge.sh
#	lta set vsub $Vvsub

#	doClean

#	doSettings
#	lta EXPOSURE $expo
#	lta name $imgFOLDER/skp_${runname}_NSAMP${nsmpls}_NROW${rows}_NCOL${cols}_EXPOSURE${expo}_img
#	lta set vdd_sw 1
#	lta read
#done

#for delayV in 15 150 300 600
#do
#	for Vvl in -2.5 -1.5
#	do
#	if [ ! -f "$lockfilename" ]; then break; fi
#	source voltage_skp_lta_v3_microchip.sh
#	source eraseANDepurge.sh
#	lta set vsub $Vvsub
#
#	lta delay_H_overlap 150
#	lta delay_V_Overlap 150
#	doClean
#
#	doSettings
#	lta delay_V_Overlap $delayV
#	lta set v1al $Vvl
#	lta set v1bl $Vvl
#	lta set v3al $Vvl
#	lta set v3bl $Vvl
#	lta set v2cl $Vvl
#
#	lta name $imgFOLDER/skp_${runname}_EXPOSURE${expo}_NSAMP${nsmpls}_NROW${rows}_NCOL${cols}_delayV${delayV}_vl${Vvl}_img
#	lta read
#	done
#
#	for Vvh in 1 2
#	do
#	if [ ! -f "$lockfilename" ]; then break; fi
#	source voltage_skp_lta_v3_microchip.sh
#	source eraseANDepurge.sh
#	lta set vsub $Vvsub
#
#	lta delay_H_overlap 150
#	lta delay_V_Overlap 150
#	doClean
#
#	doSettings
#	lta delay_V_Overlap $delayV
#	lta set v1ah $Vvh
#	lta set v1bh $Vvh
#	lta set v3ah $Vvh
#	lta set v3bh $Vvh
#	lta set v2ch $Vvh
#
#	lta name $imgFOLDER/skp_${runname}_EXPOSURE${expo}_NSAMP${nsmpls}_NROW${rows}_NCOL${cols}_delayV${delayV}_vh${Vvh}_img
#	lta read
#	done
#done

#for delayH in 15 150 300 600
#do
#	for delayV in 150 600
#	do
#		for Vhl in `seq -5.5 1 -2.5`
#		do
#		if [ ! -f "$lockfilename" ]; then break; fi
#		source voltage_skp_lta_v3_microchip.sh
#		source eraseANDepurge.sh
#		lta set vsub $Vvsub
#
#		lta delay_H_overlap 150
#		lta delay_V_Overlap 150
#		doClean
#
#		doSettings
#		lta delay_H_overlap $delayH
#		lta set h1al $Vhl
#		lta set h1bl $Vhl
#		lta set h2cl $Vhl
#		lta set h3al $Vhl
#		lta set h3bl $Vhl

#		lta name $imgFOLDER/skp_${runname}_EXPOSURE${expo}_NSAMP${nsmpls}_NROW${rows}_NCOL${cols}_delayH${delayH}_hl${Vhl}_img
#		lta read
#		done

#		for Vhl in `seq -3.5 -1 -`
#		do
#		Vtl=$(echo ${Vhl}+0.5 | bc)
#		Vvl=$(echo ${Vhl}+1 | bc)

#		if [ ! -f "$lockfilename" ]; then break; fi
#		source voltage_skp_lta_v3_microchip.sh
#		source eraseANDepurge.sh
#		lta set vsub $Vvsub

#		lta set v1al $Vvl
#		lta set v1bl $Vvl
#		lta set v2cl $Vvl
#		lta set v3al $Vvl
#		lta set v3bl $Vvl

#		lta set h1al $Vhl
#		lta set h1bl $Vhl
#		lta set h2cl $Vhl
#		lta set h3al $Vhl
#		lta set h3bl $Vhl

#		lta set tgal $Vtl
#		lta set tgbl $Vtl

#		lta delay_H_overlap 150
#		lta delay_V_Overlap 150

#		doClean
#		doSettings

#		lta delay_H_overlap $delayH
#		lta delay_V_Overlap $delayV

#		lta name $imgFOLDER/skp_${runname}_EXPOSURE${expo}_NSAMP${nsmpls}_NROW${rows}_NCOL${cols}_delayH${delayH}_img
#		lta read
#		done
#	done
#done

#for nsmpls in 1 4 9 16 25 49 100 225 400 625
#for nsmpls in `seq 200 100 600`
#do
#	if [ ! -f "$lockfilename" ]; then break; fi
#	source eraseANDepurge.sh
#	lta set vsub $Vvsub

#	doClean
#	doSettings

#	lta NSAMP $nsmpls
#	lta name $imgFOLDER/skp_${runname}_loopNSAMP_NSAMP${nsmpls}_NROW${rows}_NCOL${cols}_img
#	lta read
#done

#for smp in `seq 20 20 2500`
#do
#	if [ ! -f "$lockfilename" ]; then break; fi
#	delay=$((smp+100))
#	lta set ssamp $smp
#	lta set psamp $smp
#	lta delay_Integ_ped $delay
#	lta delay_Integ_sig $delay
#	lta name $imgFOLDER/skp_${runname}_loopSSAMP_SSAMP${smp}_PSAMP${smp}_img
#	lta read
#done

#for loop in {1..20}
#do
#	if [ ! -f "$lockfilename" ]; then break; fi
#	echo "Loop $loop"

#	source eraseANDepurge.sh
#	lta set vsub $Vvsub
#	doClean
#
#	doSettings
#	lta name $imgFOLDER/skp_${runname}_EXPOSURE${expo}_NSAMP${nsmpls}_NROW${rows}_NCOL${cols}_img
#	lta read

#	echo "End of loop $loop"
#done

