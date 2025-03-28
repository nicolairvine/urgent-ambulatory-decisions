# urgent-ambulatory-decisions
Hybrid Agent-based and discrete event simulation model to reproduce and evaluate early remote decisions about in-patient versus out-patient urgent care for internal medical populations. Includes decision-making, and patient care upon arrival. Scheduled events reproduced using a time-step count down method. CC-BY-4.0

# Introduction
This is the Netlogo code for the hybrid agent based and discrete event simulation model created for a PhD project exploring the impact of early decisions to identify patients suitable for avoiding admission when referred to hospital with an urgent internal medical concern. 

The code was finalised for generating model outputs in late 2022 and has not been adapted or changed since then

This code is shared to allow other interested modellers who may wish to know how others have programmed a hybrid in model in NetLogo. It is not perfect and is complicated.
I also share here for peer reviewers of published work resulting from the model's use.

The code is licensed under Creative Commons Attribution 4.0 International. Please see the CC A 4.1 document uploaded for information about usage and sharing of the information contained

## Key points to know if using to compare/explore code used
The model was built in NetLogo V6.2.0. Verfication, validation, and scenario testing were done via the 'nlrx' package for R and the data collection requirements were too large for NetLogo

The DES is used to reproduced days of week (weekday versus weekend), staff shift changes, peaks/troughs of demand, and regular organisational events that affect patient movement
All other behaviours are part of an agent based model

The methods are integrated - scheduled events as disrupted by emergent outcomes of agents, and scheduled events regulate which agents are active in the system (see below)

The time extenstion is used to produce a clock in the model for collecting data (model state at different times of the day), to support verification, and validation. 
At the time of creating, the discrete event package for NetLogo was not functioning (i'm not sure if this has changed)
All regularly scheduled events were created using a coutndown method based on model time.
1 time-step == 1 minute
All agents use this countdown to move in the model to some degree:
- patients use it to arrive in the hospital, respond to delays, departmental occupancy levels, and to exit the model once care is complete
- staff use it to guage shift time (regularly scheduled events)

## Background and reason for the model
The model was built to answer a simple question: do expert telephone triage decisions about in-patient versus out-patient car for urgent health decline improve hospital efficiency without reducing health nor patient experiences of care compared to decisions by trainee clinicians or nursing staff?

Adult patients with a suspected urgent health decline may attend a community clinician (GP) or attend the emergency department (ED) and be referred into an acute medical unit (AMU) if the referring clinician thinks there is an urgent internal medical concern (e.g., heart attack, stroke, sepsis). Patients cannot self-present to AMUs as they do the EDs. Clinicians contact the AMU team and arrange attendance to the AMU either immediately or within 48hrs depending upon the concern.

AMUs are dedicated facilities for the urgent assessment and treatment of acute internal medical decline in adult patients. They manage most patients via in-patient resources due to the nature of the population referred, but many have the capacity for urgent out-patient care if the condition is afe to be managed this way and the patient is able. They are suitable alternatives to EDs for adult care where immediate threat to life, limb, or trauma are absent, and where the decline is clearly not best managed by an alternative specialty (e.g., surgical, ophthalmology). AMUs specialists can also de-escalate urgency by excluding urgent illness and referring patients back into elective and community services. Urgent out-patient and in-patient care frequently share the same resources (staff, hospital space, diagnostics access). Urgent out-patient services are usually extended hours practice but frequently not 24hr services. Patients may be deferred to attend when clinics are open (if safe) or default to in-patient care. Urgent out-patients (also called ambulatory emergency care) will also provide planned follow up of patients until the urgent health decline is removed and/or another team are able to take over patient care. AMUs are staff by senior doctors (consultants) from 0800-2000hrs all days and have access to urgent diagnostic and specialist services as EDs do. All patients are reviewed by/with consultants between these hours after initial evaluation to determine care plan and suitability for admission avoidance.

Healthcare policymakers would like to see more urgent care delivered without admission to hospital. This is assumed to be patient preference, but there is an explicit goal to decrease the number of hospital admissions, reduce crowding in urgent care (unmanagable occupancy levels), reduce delays to receive treatment in urgent care, and reduce wider hospital occupancy to more efficient levels. Intuitively, having experts in internal medicine make admission avoidance decisions asap will acheive these goals, but the the evidence is absent, and these are high risk decisions to make remotely. Most patients still have to attend an AMU immediately to be evaluated for suitability (clinical assessment and basic investigations). Currently, the heavy presence of senior doctors and rapid diagnostics available means that many suitable patients are rapidly identified as discharged safely. Increasing consultant (very high cost staff) numbers to perform triage and the assessments upon arrival may not create meaningful value above current practice from a healthcare or a societal perspective.

### Model overview:
The model begins from the moment a community or ED clinician suspects an urgent internal medical concern requiring immediate AMU attendance for treatment and a decision about hospital admission for ongoing care. 
1. Patients enter the model as referrals from an ED or non-ED clinician to a member of AMU staff: senior doctor (expert), trainee doctor (non-expert) or nurse (expert)
      The model can be reconfigured to determine which member of staff accpets the call, but the code shared is hard coded as follows:
      - 0900-2000hrs the GP team refer to an expert (if not available it goes to a trainee then nurse)
      - 2000-0900 the GP refers to a trainee
      - 24hrs ED refer all patients to the nurse (if not available then order of referral is nurse>trainee>consultant)

2. Staff decide if the patient has a condition suitable for admission avoidance (allocated to clinic) or not (allocated to in-patient bed)
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

## Allocation decision logic
All staff compare a variable indiciating their level of expertise with a patient-held variable summarising their need (value = 0.0-1.0). Levels of the expertise variable are unique to each consultant and trainee staff agent, but nursing staff hold the same level of expertise. Expertise variables are held througout model run, but staff allocating vary at random according to shift patterns. Levels of expertise are allocated at creation from a distribution unique to each staff group with consultants the highest, and nurses the lowest.
All experts also hold a variable that can adjust the proportion of patients they will allocate to ED. This is hard coded into the model and set at zero for all as verfication and validation revealed no meaningful difference in outcomes when applied.
Consultants hold an additional variable to identify patients via comparing this variable with a patient's condition variable (these patients exit the model upon identification)

Patient condition variable (value 0.0-1.0) represents biopsychosocial needs of patients and their preferences as admission avoidance decisions are not made purely on disease-specific grounds and adding more variable to represent all needs used to inform decisions would be computationally exhausting and unlikely to be of use to decision-makers given the purpose of the model.

The simple logic compare the patient variable with the expertise variable and allocates as able according to opening/closing times of urgent clinic facilities

## Model outputs
A sub-model was included to collect data throughout model runs:
- System Level:
- Occupancy per minute (in-patient and clinic areas)
- System failure events (each patient diverted due to no capacity)
- Proportion of patients referred who were delayed to accessing a clinical space per day
- Proportion of patients discharged who did so within 24hrs per day
- Proportion of patients admitted per day
- Proportion of patient placed in the non-allocated area to start care per day
- Proportion of patients transferred to another ward (admitted) between 0300-0800hrs per day
- Proportion of patients with a positive experience of care per day

Patient Level
- Lengths of delay to starting care for each area per patient delayed >5mins
- Lengths of stay in department
- Health utility change (upon model exit)

Staff level:
- Accuracy of early allocation decisions per week (to validate decision-maker sub-model)

### General User Interface
The GUI user has control to allow adjustment of:
- Staffing configurations - number and work pattern
- Mean daily demand
- Proportion of patients suitable for admission avoidance in the population
- Opening and closing hours of the clinic
- Hours of peak demand

The GUI is a simple reproduction of the department with a color key to identify patient.
The GUI also provides real-time updates of expected patients by area allocated.
It also plots occupancy levels and daily numbers of patient delayed >5mins (after 2 week model warm-up), along with other outputs to check model functioning as it runs
These and all other model outputs are stored in csv. files (folder space left blank)

### Integration of DES and ABM
The Figure below is the conceptual model of the early senior decision-making in the AMU. The diagram shows patient movement through the system, with boxes representing patient states and arrows showing transitions. Dashed arrows indicate integration points between agent-based and discrete event sub-models. Arrow polarity (+/-) indicates whether the source event increases or decreases the target process. Key model elements include patient creation from referrals, decision-making processes, and resource allocation


![Figure 1: Conceptual model of early expert decision-making in an acute medical unit](https://github.com/user-attachments/assets/a34fe6fc-b112-4e94-a576-1067c3a886d9)
![image](https://github.com/user-attachments/assets/c96d4d71-c7db-4cb5-9782-90a9055c4f5a)

The model was created following ethnographic observation of and data collection in a representative AMU in the UK.

###Technical implementation details
The model runs in one minute time steps, simulating four months of AMU activity starting from 18/10/2019 00:00. At any given time, each patients in the system belongs to one of 12 status categories (shown below) that reflect their current state – for example, whether they are waiting for allocation, receiving care in a bed, or awaiting transport home. 

Patient status categories
1.	Waiting to be allocated
2.	In-patient allocated travelling to hospital
3.	AEC-allocated travelling to hospital
4.	In-patient allocated awaiting bed
5.	In-patient allocated receiving care in a bed
6.	In-patient allocated receiving care in the AEC facility
7.	In-patient allocated awaiting transport home
8.	In-patient allocated receiving care but suitable to transfer before care complete
9.	AEC- allocated awaiting AEC facility space
10.	AEC- allocated receiving care in the AEC facility
11.	AEC-assigned receiving care in a bed
12.	AEC-assigned awaiting transport home

These patient categories update dynamically based on based on both individual factors (such as treatment stage and allocated pathway) and environmental system conditions (such as AEC resource availability). As patients progress through their care journey and queues form or dissolve, the categories update accordingly. This categorisation allows us to track key system metrics at each time step, including, occupancy levels, anticipated arrivals, delays, and resource availability. 

### Adjustments
The model initiates with the case study site demand/prevalence patterns, opening closing times of the clinic services, and mean 'expertise' of staff but these can be adjusted following model set up at the GUI
The GUI prompts the user to select staff and adjust parameters as necessary

The resources beyond staff and opening times are hard coded but could be changed to relfect a preferred number of in-patient beds/clinic spaces

