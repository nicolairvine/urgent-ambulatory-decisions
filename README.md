# urgent-ambulatory-decisions
Hybrid Agent-based and discrete event simulation model to reproduce and evaluate early remote decisions about in-patient versus out-patient urgent care for internal medical populations. Includes decision-making, and patient care upon arrival. Scheduled events reproduced using a time-step count down method. CC-BY-4.0

# Introduction
This is the Netlogo code for the hybrid agent based and discrete event simulation model created for a PhD project exploring the impact of early decisions about advoiding admission in patients referred to hospital with an urgent internal medical concern.
The code was finalised for generating model outputs in late 2022 and has not been adapted or changed since then

This code is shared to allow other interested modellers who may wish to know how others have programmed a hybrid in model in NetLogo. It is not perfect and is complicated.
I also share here for peer reviewers of published work resulting from the model's use

## Key points to know if using to compare codes
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

## Overview
Patients with an urgent internal medical health concern seek help via their community team (e.g., general practitioner) or attend the emergency department (ED). The model assumes the clinician reviewing agrees there is an urgent concern, and wishes to refer them to the acute medical unit (AMU) for urgent review and likely admission into hospital.
1. Patients are referred to a member of staff for discussion - senior doctor (expert), trainee doctor (non-expert) or nurse (expert)
   The model can be reconfigured to determine which member of staff accpets the call, but the code shared is hard coded as follows:
   - 0900-2000hrs the GP team refer to an expert (if not available it goes to a trainee then nurse)
   - 2000-0900 the GP refers to a trainee
   - 24hrs ED refer all patients to the nurse (if not available then order of referral is nurse>trainee>consultant)

2. Staff  decide if the patient has a condition suitable to be managed in the urgent clinic or if they need to come to a bed.
   Consultants can identify a small number of patients who need not attend at all (false alarm - not an emergency requiring attendance)
   Consultants can also increase the number of patients they send to the clinic area if they think there is or will be too many patients waiting for in-patient beds
4. Patients are assigned an area of care according to their condition and the staffs' expertise, they then travel into the department (hide in the model)
   Travel to the department quicker from ED as they are in the same buidling but not immediate
5. Once their travel time is over, they appear in the department (unhidden) and seek a safe clinical space to start care
   If no spaces are available, they go to a designated waiting area for their allocated area of care and are in competition with other patients for the next space 
   If they have waited for >1hr for a bed, they will seek any clinical space but patients waiting >4hrs are prioritised.
6. Once in a safe space (clinic chair or bed) then begin care.
7. Once care is complete they exit the model as discharged or admitted patients

Scheduled events disrupt the movement of patients in the department: ward rounds from 0800-1100hrs (delayed exit), the closure of the urgent clinic 2300-0800 (default to in-patient care), and overnight concerns about disruption and safety (delayed exit 0300-0800hrs)
Organisational behaviours to prevent excessive occupancy also disrupt patient movement: patients will be moved into the hospital before care is complete (admitted) if occupancy is too high, patients for admission will be held in the department if there is low/acceptable occupancy

