#!/bin/bash

#set clock voltages
lta set v1ch 5
lta set v1cl -2
lta set v2ch 5
lta set v2cl -2
lta set v3ch 5
lta set v3cl -2
lta set h1ah 7.9
lta set h1al -2.8
lta set h1bh 7.9
lta set h1bl -2.8
lta set h2ah 7.9
lta set h2al -2.8
lta set h2bh 7.9
lta set h2bl -2.8
lta set h3ah 7.9
lta set h3al -2.8
lta set h3bh 7.9
lta set h3bl -2.8
lta set swah 5
lta set swal -3.4
lta set swbh 5
lta set swbl -3.4
lta set rgah 0
lta set rgal -5.2
lta set rgbh 0
lta set rgbl -5.2
lta set ogah 3.8
lta set ogal 0
lta set ogbh 3.8
lta set ogbl 0
lta set dgh 0
lta set dgl 0
lta set tgh 5
lta set tgl -2.5

#set bias voltages
lta set vdrain 0
lta set vdd -22 
lta set vr -13
lta set vsub 40

#enable bias switches
lta set vdrain_sw 0
lta set vdd_sw 1
lta set vsub_sw 1
lta set vr_sw 1
lta set p15v_sw 1
lta set m15v_sw 1

