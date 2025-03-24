# urgent-ambulatory-decisions
Hybrid Agent-based and discrete event simulation model to reproduce and evaluate early remote decisions about in-patient versus out-patient urgent care for internal medical populations. Includes decision-making, and patient care upon arrival. Scheduled events reproduced using a time-step count down method. CC-BY-4.0

# Introduction
This is the Netlogo code for the hybrid agent based and discrete event simulation model created for a PhD project exploring the impact of early decisions to identify patients suitable for avoiding admission when referred to hospital with an urgent internal medical concern. 

The code was finalised for generating model outputs in late 2022 and has not been adapted or changed since then

This code is shared to allow other interested modellers who may wish to know how others have programmed a hybrid in model in NetLogo. It is not perfect and is complicated.
I also share here for peer reviewers of published work resulting from the model's use

## Key points to know if using to compare/explore code used
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
Acute medical units (AMUs) are dedicated facilities for the urgent assessment and treatment of acute internal medical decline in adult patients. They manage most patients via in-patient resources, but many have the capacity for urgent out-patient care delivered on the same day and/or on days following the initial illness event. They are suitable alternatives to EDs for adult care where immediate threat to life, limb, or trauma are absent, and where the decline is cleary not best managed by an alternative specialty (e.g., surgical, ophthalmology). AMUs specialists can also de-escalate urgency by excluding urgent illness and referring patients back into elective and community services. Urgent out-patient and in-patient care frequently share the same resources (staff, hospital space, diagnostics access). Urgent out-patient services are usually extended hours practice but frequently not 24hr services - patients may be deferred to attend when clinics are open (if safe) or default to in-patient care. Urgent out-patients (also called ambulatory emergency care) will also provide planned follow up of patients until the urgent health decline removed and/or another team ar able to take over patient care. 

Patients with a suspected urgent health decline may attend a community clinician (GP) or attend the emergency department (ED) to be referred into an AMU. Patients cannot self-present to AMUs as they do the EDs.
The model begins from the moment a community or ED clinician suspects an urgent internal medical concern requiring immediate AMU attendance for review and decision about hospital admission for ongoing care. 

### Model patient movement overview:
1. Patients enter the model as referrals from an ED or non-ED clinician to a member of AMU staff for discussion: senior doctor (expert), trainee doctor (non-expert) or nurse (expert)
      The model can be reconfigured to determine which member of staff accpets the call, but the code shared is hard coded as follows:
      - 0900-2000hrs the GP team refer to an expert (if not available it goes to a trainee then nurse)
      - 2000-0900 the GP refers to a trainee
      - 24hrs ED refer all patients to the nurse (if not available then order of referral is nurse>trainee>consultant)

2. Staff decide if the patient has a condition suitable to be managed in the urgent clinic or if they need to come to a bed for likely admission.
      Consultants can identify a small number of patients who need not attend at all (false alarm - not an emergency requiring attendance)
      Consultants can also increase the number of patients they send to the clinic area if they think there is or will be too many patients waiting for in-patient beds
   
3. Patients are assigned an area of care according to their condition and the staffs' expertise, they then travel into the department (hide in the model)
      Travel to the department quicker from ED as they are in the same buidling but not immediate
   
4. Once their travel time is over, they appear in the department (unhidden) and seek a safe clinical space to start care
      Will seek space in their allocated area and occupy upon arrival if available (clinic or in-patient bed)
      If no allocated spaces  available, they go to the designated waiting area for their allocated area and compete with other patients for the next space 
      If waiting >1hr for a bed, they will seek the next free space regardless of allocation with patients waiting >4hrs prioritised
      If no space in clinical or waiting areas, they exit the model (diverted to another site)
   
5. Once in a safe space (clinic chair or bed) they begin care
   
6. Once care is complete they are evaluated as for admission or discharge and exit the model accordingly
      Patients disharged from the urgent clinic exit the model immediately
      Patients discharged from in-patient beds exit the model once transport is available
      Patients admitted will exit to another ward accroding to time of day, current and previous 24hrs patient activity

### Disruptions to patient movement
*Scheduled events* : ward rounds from 0800-1100hrs (delayed exit), the closure of the urgent clinic 2300-0800 (default to in-patient resource occupancy), and overnight concerns about disruption and safety (delayed exit 0300-0800hrs).
Scheduled events occur at the same time every day but delays may be over-ridden by reactive organisational behaviours.
Scheduled events represent real-life patterns of activity in the hospital modelled

*Reactive organisational behaviours* : patients will exit the model as default admitted patients (not evaluated for admission avoidance) before care is complete if AMU in-patient occupancy is/anticipated to become too high, patients for admission will be held in the department for longer than necessary if there is low/acceptable in-patient occupancy. 
Reactive organisational behaviours respond to emergent queues in the model: the number of patients expected, the number of unoccupied in-patient beds, the number of patient waiting for an in-patient bed.
Reactive organisational behaviour logic is triggered if: a) in-patient occupancy exceeds the tolerated overcrowding threshold (set by the user) or b) the ratio of expected in-patient allocations to unoccupied beds falls below a threshold
Reactive organisational behaviour logic thresholds are modified when demand in the previous 24hrs has exceeded a high demand threshold (longer delays to exit via admission)
Organisational behaviours represent cultural behaviours exhibited in the hospital modelled to manage scarce resources in both the AMU and the wider hospital





