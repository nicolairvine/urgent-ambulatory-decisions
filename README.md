# urgent-ambulatory-decisions
Hybrid Agent-based and discrete event simulation model to reproduce and evaluate early remote decisions about in-patient versus out-patient urgent care for internal medical populations. Includes decision-making, and patient care upon arrival. Scheduled events reproduced using a time-step count down method. CC-BY-4.0

# Introduction
This is the Netlogo code for the hybrid agent based and discrete event simulation model created for a PhD project exploring the impact of early decisions about advoiding admission in patients referred to hospital with an urgent internal medical concern.
The code was finalised for generating model outputs in late 2022 and has not been adapted or changed since then

This code is shared to allow other interested modellers who may wish to know how others have programmed a hybrid in model in NetLogo. It is not perfect and is complicated.
I also share here for peer reviewers of published work resulting from the model's use

# Key points to know if using to compare codes
The DES is used to reproduced days of week (weekday versus weekend), staff shift changes, peaks/troughs of demand, and regular organisational events that affect patient movement
All other behaviours are part of an agent based model

The methods are integrated - scheduled events as disrupted by emergent outcomes of agents, and scheduled events regulate which agents are active in the system

The time extenstion is used to produce a clock in the model for collecting data (model state at different times of the day), to support verification, and validation. 
At the time of creating, the discrete event package for NetLogo was not functioning (i'm not sure if this has changed)
All regularly scheduled events were created using a coutndown method based on model time.
1 time-step == 1 minute
All agents use this countdown to move in the model to some degree:
- patients use it to arrive in the hospital, respond to delays, departmental occupancy levels, and to exit the model once care is complete
- staff use it to guage shift time (regularly scheduled events)
