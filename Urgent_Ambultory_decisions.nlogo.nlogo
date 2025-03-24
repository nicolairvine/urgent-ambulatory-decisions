extensions[time csv]
globals [
;;time-related
  dt                              ;; for logotime and anchoring
  tick-datetime                   ;; current date and time
  ticks-per-hour                  ;; converts user interface times into model time for varying parameters
  minutes-per-tick                ;; how many mins a tick equals (for output calcs)
  corridor-wait                   ;; local definition of time waiting for clinical space before recorded as a delay
  expected-to-current-capacity-ratio ;; threshold of expected bedded to available bed for allowing early movement from AMU
  preferred-aec                   ;; preferred los in AEC area before home or admission
  aec-available                   ;; glocabl variable which informs if aec assessment space is available for use
  aec-returns-start               ;; time when appointed/returning AEC patients start
  aec-returns-end                 ;; time when appointed/returning AEC patients end
  aec-clinic                      ;; duration of aec clinic
  peak-start                      ;; ticks from midnight when peak activity starts as inputted by the user set at 1200hrs
  peak-end                        ;; ticks from midnight when peak activity ends as per user input set at 2100hrs
  peak-duration                   ;; length of peak, as peak-end and start are updated every tick this is fixed to maintain consistent frequency
  expert-shift-starts             ;; start of working day for all staff
  expert-shift-ends               ;; when expert changes finishes/new expert takes next shift
  trainee-exp-shift-starts        ;; if not commencing DM role at start of working day (dayshift-starts)
  trainee-exp-shift-ends          ;; when trainee finishes/new trainee takes next shift
  shift-change-am                 ;; standard morning shift change for fulltime roles (e.g charge nurses, trainees, junior staff)
  shift-change-pm                 ;; standard evening shift change for fulltime roles (e.g charge nurses, trainees, junior staff)
  overnight-start                 ;; ticks when overnight and AEC closure begins
  overnight-end                   ;; ticks when overnight finishes and AEC reopens
  overnight-duration              ;; start and end are updated dynamically therefore duration fixed for consistency
  overnight-transfer-duration     ;; duration after AEC close where ward still happy to transfer patients who have completed care
  overnight-transfer-end          ;; stop transferring patients to create capacity
  slow-arrivals                   ;; indicates when the overnight rate of arrivals slows down
  slow-overnight-arrivals         ;; time when the rate of arrival drops overnight
  expert-end                      ;; time at which experts finish duties
  trainee-end                     ;; time at which trainee finishes duties
  ward-round-finished             ;; time at which the morning rounds will complete an allow patients waiting for discharge to go home
  whole-day                       ;; ticks equal to 24hrs to be used in procedures and reporters
  start-of-weekend                ;; identifies sunday as ticks updated
  end-of-weekend                  ;; identified sunday-monday 00:00
  waiting-time                    ;; time until seek to move anywhere and start treatment
  weekend-demand                  ;; % of usual demand seen on weekends
  week                            ;; interval between patient experience feedbacks
  weekend                         ;; logical variable to determine demand

;; spatial
  to-come-in                      ;; visible queue of patients yet to arrive in the department
  non-ed-referrals                ;; area where patients enter urgent care system from community or clinics
  ed-referrals                    ;; area where patients enter urgent care system from emergency department
  referrals-queue                 ;; patients who are waiting for decision-makers assessment
  decision                        ;; list of decision patches
  AEC-care                        ;; area for aec delivery
  AEC-capacity                    ;; capacity in AEC
  AMU-care                        ;; area for amu delivery
  AMU-capacity                    ;; capacity in AMU
  amu-crowding                    ;; trigger to create capacity in the AMU area
  sufficient-beds-to-cope-night   ;; capacity that supports delays to move overnight to reduce downstream pressure
  sufficient-beds-to-cope-day     ;; capacity that supports delays to move daytime and reduce downstream pressure
  waiting-bedded                  ;; waiting area for bed allocations if no resource availabile in preferred area
  waiting-aec                     ;; waiting area for aec/aaa allocations if no resource availabile in preferred area
  max-ip-waits                    ;; trigger for DMs to sense overcrowding
  max-expects-trigger             ;; trigger for patient pending to sense  overcrowding

;; modelled environment
  demand                          ;; volume anticipated to arrive everday (set by reporter from distribution)
  last-24hrs                      ;; measure of demand from previous day to affect ability to easily transfer patients when hospital  occupancy high
  non-eds                         ;; non-ED patients arriving every 24hrs
  community-patients              ;; community patients creation patch
  eds                             ;; patients arriving from ED every 24hra
  st-dev-attendances
  peak
  mean-demand
  peak-demand                     ;; proportion of activity that occurs during peak periods *** assumed the same split for all days ***
  off-peakdemand
  peak-split                      ;; proportion of demand from ED during peak
  off-peak-split                  ;; proportion of demand from ED off-peak
;  slow-arrivals
  non-ed-peak                     ;; % of demand from community or clinics during peak
  non-ed-off-peak                 ;; % of demand from community or clinics off-peak
  non-ed-week                     ;; % of demand from community during the week
  non-ed-weekend                  ;; % of demand from community during weekends
  non-urgent                      ;; proportion of patients recognised by experts as non-urent and refused attendance
  ed-refers                       ;; % of demand coming through ED
  AEC-condition-probability       ;; probability that condition is something that the unit has an agreed/usual AEC pathway (above this require more time to provide care)
  global-aec-risk                 ;; the global minimal aec suitability detected by all (pathways and referrer plans etc)
  min-AEC-push                    ;; % of additional patients that any member of staff would divert to AEC under moderate pressure
  max-AEC-push                    ;; % of additional patients that any member of staff would divert to AEC under extreme pressure
  AEC-los                         ;; probability distribution for length of stay in the AEC area
  AMU-los                         ;; probability distribution for length of stay in the AMU area
  random-adm-aec
  random-discharge-amu



;;output-related
  AMUs                            ;; patients still receiving active care and deemed as not suitable for AEC
  AECs                            ;; patients still receiving active care and deemed as suitable for AEC even in overcrowing
  AEC-daily                       ;; list of daily AEC allocations
  AMU-daily                       ;; list of daily AMU IP allocations
  AMU-waiting                     ;; list of patients waiting to get into an AMU resource
  new-patients                    ;; determines the arrival process of new patients entering the system
  discharge                       ;; patients sent home after treatment
  admission                       ;; patients admitted after treatment
  patients_discharged             ;; variable which allows patches to record if a patient hase been sent home
  amu-discharges                  ;; patients sent home from AMU after treatment
  aec-discharges                  ;; patients sent home from AEC after treatment
  AEC-disch
  AMU-disch
  patients_discharged_24          ;; variable which allows patches to record if a patient hase been sent home within 12hrs
  patients_admitted               ;; variable which allows patches to record if a patient hase been admitted
  daily-discharge                 ;; tally of daily discharges for validation
  daily-admit                     ;; tally of daily admissions for validation
  daily-discharge-24              ;; tally of daily discharges within 12hrs
;  random-disposal-plan-change     ;; stochatic change to disposal outcome after treatment finished
  capacity-moves                  ;; identifies moves made to create capacity in OOH period
  capacity-moves-daily
  exp-daily-aec                   ;; cummulative record of experience
  exp-daily-amu                   ;; cummulative record of amu experience
  good-exp-amu                    ;; proportion with good experience in amu
  good-exp-aec                    ;; proportion with good experience in aec
  exp-true-amu                    ;; true amu identified by experts
  nonexp-true-amu                 ;; true amu identified by nonexperts
  exp-true-aec                    ;; true aec identified by experts
  nonexp-true-aec                 ;; true aec identified by nonexperts
  exp-false-amu                   ;; false amu identified by experts
  nonexp-false-amu                ;; false amu identified by nonexperts
  exp-false-aec                   ;; false aec identified by experts
  nonexp-false-aec                ;; false aec identified by nonexperts
  waits-today                     ;; cummulative tally of patients waiting that day
  waits-24                        ;; final output to store
  wrong-place                     ;; AMU-care patients who had to start treatment in AEC
  daily-wrong-place               ;; daily tally of patients cared for in the wrong place
  hrqol-aec                       ;; ouput tally of HRQoL AEC
  hrqol-amu                       ;; ouput tally of HRQoL AMU
  disch-hrqol-aec                 ;; daily change in health for aec discharges
  disch-hrqol-amu                 ;; daily change in health for amu discharges
  expert-true-aec                 ;; population with AEC-ok? and los <10hrs & discharge true
  expert-false-aec                ;; population with AEC_ok? true who were not true aec
  expert-true-amu                 ;; population with AEC_ok? false and discharge false
  expert-false-amu                ;; population with AEC-ok? false who were not true amu
  nonexpert-true-aec              ;; population with AEC-ok? and los <10hrs & discharge true
  nonexpert-false-aec             ;; population with AEC_ok? true who were not true aec
  nonexpert-true-amu              ;; population with AEC_ok? false and discharge false
  nonexpert-false-amu             ;; population with AEC-ok? false who were not true amu
  so-far                          ;; daily tally of referrals coming in
  daily-total                     ;; output monitoring daily referrals
  ed-total                        ;; final tally of ed versus non-ed to evaluate the PPV
  noned-total                    ;; final tally of ed versus non-ed to evaluate the PPV
  total-system-time               ;; total time in system once patients leave to be stored for analysis later (los and referral time)
  time-variables                  ;; list of lists with patiennt time variables for analysis if needed (behaviour space creates central summaries)
;  arrival-times                   ;; list of arrival times collected for validation but not needed for model running
;  departure-times                 ;; list of departure times collected for validation but not needed for model running
  aec_complete_today
  amu_complete_today
  amu-complete
  aec-complete
  prev_ed_model
  prev_noned_model
;  alloc-distributions             ;; collected for validation but not needed for model running
  refused
]

breed [patients patient]                       ;; all patients attending the facility
breed [experts expert]                         ;; acute medicine consultats
breed [experts-fulltime expert-fulltime]      ;; acute medicine consultants on shift
breed [senior-nurses senior-nurse]             ;; charge and senior charge nurses
breed [trainees-shift trainee-shift]           ;; Advanced nurse practitioner, physician associates or senior trainee doctors >= ST3
breed [trainees-fulltime trainee-fulltime]     ;; Advanced nurse practitioner, physician associates or senior trainee doctors >= ST3
breed [admins admin]                           ;; clerical administrative staff non-clinical
breed [key1s key1 ]                              ;; allows better visual engagement with process
breed [key2s key2 ]                             ;; allows better visual engagement with process
breed [key3s key3 ]                             ;; allows better visual engagement with p
breed [key4s key4 ]                             ;; allows better visual engagement with p
breed [calls call]                             ;; visual engagement with patients referred

patches-own
[
  high-risk-adjust                ;; variable which allows the patch to assume the max-AEC-risk profile of the DM working on that patch
  expert-adjust-local             ;; the adjustment made by the decision-maker on the patch at that time according to their expertise
  system-failure                  ;; occurs when there is no capacity in clinical areas or the waiting/general ward area
  positive-exp-aec                ;; total number patients with preferred positive experience of AEC
  positive-exp-amu                ;; total number patients with preferred positive experience of AEC


]

patients-own
[
  AEC-ok?                         ;; logical variable based on condition and DM risk threshold indictaing suitable for AEC even if not preferred
  final-area                      ;; variable which indicates where the patient ended care
  condition                       ;; potential for AEC
  for-discharge                   ;; logical variable indicating final outcome
  ed                              ;; logical variable indicating ed or non-ed source
  time_referred                   ;; tick time when referred into the system
  time_arrived                    ;; tick time when a patient should enter the unit after being referred (urgent care system care began)
  aec-possible                    ;; logical variable that indicates if the patient arrived during AEC opening hours
  complete?                       ;; logical variable indicating when ready to leave the area
  time_in_system                  ;; total time patient spends in the urgent care path from referrals to outcome
  time_complete                   ;; time at which care is complete and patient ready to exit the system
  treatment_started               ;; time of arrival into clinical resource for care
  treatment_time                  ;; time required for care completion - also acts as a count-down to determine when patients are ready for discharge/disposal
  los                             ;; total time in urgent care area since arrival
  delayed                         ;; any time spent in the general waiting area
  experience                      ;; binary variable indicating positive or negative experience
  hrqol                           ;; HRQoL index score according to area
  expert-dm                       ;; logical variable indicating if patient allocted by expert for PPV/NPV validation
  early-move                      ;; logical variable to indicate early move and ensure admission
  aec-move                        ;; logical variable to indicate if patient moved to aec awaiting discharge but recieved all care on AMU
]

;; DECISION MAKER TURTLES:
experts-own
[
max-AEC-risk
expert-adjust
]

experts-fulltime-own
[
max-AEC-risk
expert-adjust
]

senior-nurses-own
[
max-AEC-risk
expert-adjust
]

trainees-shift-own
[
max-AEC-risk
expert-adjust
]

trainees-fulltime-own
[
max-AEC-risk
expert-adjust
]

admins-own
[
max-AEC-risk
expert-adjust
]


to setup
  ca
  set tick-datetime time:anchor-to-ticks (time:create "2019-09-30 00:00") 0.01666667 "hour"
  set minutes-per-tick 1

  ;; THE MODEL TAKES EACH TICK TO REPRESENT  ONE MINUTES OF TIME - ALL HARD VALUES ARE CALCULATED TO REFLECT THIS...
  set ticks-per-hour 60 / minutes-per-tick
  set whole-day 1440 / minutes-per-tick
  set week whole-day * 7
  set weekend false
  set end-of-weekend week                                            ;; assumes Monday 00:00 start
  set start-of-weekend (whole-day * 5)                               ;; assumes Monday 00:00 start
  set slow-overnight-arrivals (ticks-per-hour * 27)

  setup-urgent-care
  user-message "Set demand parameters, prevalence of out-patient (AEC) suitability according to local population, choose staffing configuration"
  user-message "'INITIATE MODEL SET-UP' button will reset choices in case of error"
  user-message "Once selections complete click 'SET PARAMETERS' and 'START/STOP' to run the model"

  set peak-split 0.2                                                 ;; proportion of ED patients at peak
  set off-peak-split 0.5                                             ;; proportion of ED patients off-peak
  set slow-arrivals false
  set peak-demand 0.6
  set non-urgent 0.96
  set aec-available false
  set aec-returns-start Open_AEC * ticks-per-hour                    ;; assumes 0800hrs start
  set aec-returns-end 16 * ticks-per-hour                            ;; assumes 1600hrs end
  set aec-clinic Open_AEC * ticks-per-hour
  set expected-to-current-capacity-ratio capacity-threshold-low
  set amu-crowding 110
  set max-ip-waits 3
  set max-expects-trigger 8
  set waiting-time ticks-per-hour * 1
  set sufficient-beds-to-cope-night 6
  set sufficient-beds-to-cope-day 6
  set peak-start Peak_begins * ticks-per-hour                        ;; according to local data collection this referrals massively increase
  set peak-end Peak_ends * ticks-per-hour                            ;;
  set peak-duration duration-peak                                    ;;
  set overnight-start Close_AEC * ticks-per-hour                     ;; 23:00 hours
  set overnight-end Open_AEC * ticks-per-hour                        ;; 08:00 hours day after model starts
  set overnight-duration whole-day - (AEC-duration)                  ;; sets overnight duration without AEC available as determined by the user
  set overnight-transfer-duration (ticks-per-hour * 4)               ;; ward transfers still happen for 4hrs after AEC closes unless sufficient capacity to limit this
  set expert-shift-starts (ExpertStart * ticks-per-hour)             ;; converts hour of day user input to model time
  set expert-shift-ends (ExpertEnd * ticks-per-hour)                 ;;    "            "
  set trainee-exp-shift-starts (TraineeExpStart * ticks-per-hour)    ;;    "
  set trainee-exp-shift-ends (TraineeExpEnd * ticks-per-hour)        ;;    "
  set shift-change-am 8 *  ticks-per-hour                            ;; 08:00hrs
  set shift-change-pm 20 * ticks-per-hour                            ;; 20:00hrs
  set time-variables []
;  set arrival-times []                                              ;; collected for validation but not needed for model running
;  set departure-times []                                            ;; collected for validation but not needed for model running
;  set alloc-distributions []                                        ;; collected for validation but not needed for model running

;  allocate-expert
;  allocate-trainee-shift
 ; allocate-senior-nurse

  reset-ticks

  end


to go

  if ticks = 181440 [
;  [collect-patient-data
;   export-plot "Occupancy" (word "C:/....".csv")                    ;; to collect occupancy data assign folder - note this is very large
;  ]
   stop]
  output-print time:show tick-datetime "EEEE dd-MM-yyy HH:mm"

  set-demand
 ask decision
  [start-work
   shift-work
  ]
  resource-shifts
  patients-referred
  present
 ask decision
  [decide
  ]
 ask patients
  [get-treatment
  ]
  readjust-location
  leave
  update
  redirect

  tick

end


;;-----------------------------------------------------------------------------------------------------
;;------------------------- environment set-up---------------------------------------------------------

to setup-urgent-care

  ask patches with [pxcor >= -11 and pxcor <= 11 and pycor >= -11] [set pcolor 8]
  ask patches with [pxcor >= -11 and pxcor <= 11 and pycor <= 11] [set pcolor 8]

; create the urgent outpatient clinic (Ambulatory Assessment Area)
  ask patches with [pxcor >= -11 and pxcor <= -1 and pycor >= 3 and pycor <= 9][set pcolor 58]   ;; Green assessment area with spaces for patient assessment
  ask patch -7 7 [set plabel "AMBULATORY" set plabel-color 0]
  ask patch -7 6 [set plabel "ASSESSMENT AREA" set plabel-color 0]
  set AEC-care patches at-points [
    [-10 8] [-10 4] [-8 8] [-8 4]
    [-5 8] [-4 8] [-3 8] [-2 8]
    [-5 6] [-4 6] [-3 6] [-2 6]
    [-5 4] [-4 4] [-3 4] [-2 4]
  ]
  ask AEC-care [set pcolor 58.5]

;create discharge home patch
 set discharge patch -10 10.5                                                                     ;; patch to represent patients leaving hospital for OP care

;create AMU in-patient bedded area
  ask patches with [pxcor >= -11 and pxcor <= 5 and pycor <= -4] [set pcolor 98.5]
  ask patches with [pxcor >= 2 and pxcor <= 11 and pycor >= 3 and pycor <= 7] [set pcolor 98.5]
  ask patch 9 7 [set plabel "BEDDED AREA" set plabel-color 0]
  ask patch 9 6 [set plabel "SIDE ROOMS" set plabel-color 0]
  ask patch -2 -4 [set plabel "BEDDED AREA BAYS" set plabel-color 0]
  set AMU-care patches at-points[
    [2 4] [4 4] [4 6]        ;; side rooms
    [6 4] [8 4] [10 4]       ;; side room
    [4 -6] [2 -6] [0 -6] [-2 -6] [-4 -6] [-6 -6] [-8 -6] [-10 -6]         ;; bays
    [4 -8] [2 -8] [0 -8] [-2 -8] [-4 -8] [-6 -8] [-8 -8] [-10 -8]         ;; bays
    [4 -10] [2 -10] [0 -10] [-2 -10] [-4 -10] [-6 -10] [-8 -10] [-10 -10] ;; bays
  ]
   ask AMU-care [set pcolor 98.8]

  ask patch 2 6 [set plabel "SR 4"]
  ask patch 6 5 [set plabel "SR 3"]
  ask patch 8 5 [set plabel "SR 2"]
  ask patch 10 5 [set plabel "SR 1"]
  ask patch 2 -5 [set plabel "Bay 1"]
  ask patch -2 -5 [set plabel "Bay 2"]
  ask patch -6 -5 [set plabel "Bay 3"]
  ask patch -10 -5 [set plabel "Bay 4"]

;Create admission patch
  set admission patch 10 10                                                                       ;; patch to represent patients being admitted to hospital IP bed after treatment
  ask patches with [pxcor >= 2 and pycor >= 10][set pcolor 5]
  ask patch 2 11 [set plabel "KEY" set plabel-color 0]
  ask patch 10 11 [sprout-key1s 1 [set shape "person" set color 103]]
  ask patch 10 10 [set plabel "IP CARE" set plabel-color 9.9]
  ask patch 4 11 [sprout-key2s 1 [set shape "person" set color 75]]
  ask patch 4 10 [set plabel "AEC" set plabel-color 9.9]
  ask patch 6 11 [sprout-key3s 1 [set shape "person" set color 27]]
  ask patch 6 10 [set plabel "RETURN" set plabel-color 9.9]
  ask patch 8 11 [sprout-key4s 1 [set shape "person" set color 15]]
  ask patch 8 10 [set plabel "WAITING" set plabel-color 9.9]


;create the waiting area & toilet/sluice block
  ask patches with [pxcor >= -10 and pxcor <= 5 and pycor = 1] [set pcolor 2]
  ask patches with [pxcor >= -10 and pxcor <= 5 and pycor = 0] [set pcolor 2]                     ;; red area representing the main ward space/corridor in the case study facility
  ask patches with [pxcor >= -10 and pxcor <= 5 and pycor = -1] [set pcolor 2]
  set waiting-bedded patches at-points[
    [-10 -2][-9 -2][-8 -2][-7 -2][-6 -2][-5 -2]                                                   ;; bedded area waiting places
    [-4 -2][-3 -2][-2 -2][-1 -2][0 -2][1 -2]
    [2 -2][3 -2][4 -2][5 -2]]

  set waiting-aec patches at-points[
    [-4 2] [-3 2] [-2 2] [-1 2]]
  ask patch 0 0 [set plabel "BATHROOM & KITCHEN BLOCK" set plabel-color 9]


;create staff station
  ask patches with [pxcor >= 8 and pxcor <= 11 and pycor = 1] [set pcolor 9.5]
  ask patches with [pxcor >= 8 and pxcor <= 11 and pycor = 0][set pcolor 9.5]
  ask patches with [pxcor >= 8 and pxcor <= 11 and pycor = -1][set pcolor 9.5]
  ask patches with [pxcor >= 8 and pxcor <= 11 and pycor = -2][set pcolor 9.5]
  ask patches with [pxcor >= 8 and pxcor <= 11 and pycor = -3][set pcolor 9.5]
  ask patch 10 1[set plabel  "STAFF BASE" set plabel-color 0]

  set decision patches at-points [                                                               ;; area where patients are assessed by available DM in urgent care system model
    [10 -1] [10 -2] [10 -3]]


;Create the patient arrival and waiting patches
  set community-patients patches at-points [[9 -2][9 -3]]
  ask community-patients [sprout-calls 1
    [set shape "telephone" set color 15]]

  set ed-referrals patches at-points [[9 -1]]
  ask ed-referrals [sprout-calls 1
    [set shape "telephone" set color 15]]

  set non-ed-referrals patches at-points [[9 -3]]
  set to-come-in patches at-points [[10 -5]]
      ask patch 10 -5[set plabel "TO COME IN" set plabel-color 0]

end

;;-------------------------------- to create decision-makers -------------------------------------------------------------
;;------------------------------------------------------------------------------------------------------------------------



to allocate-expert                                                                              ;; different expert every day
  ask patch 10 -11 [sprout-experts expert-rota-staffing]
  ask experts[
  set max-AEC-risk 0.0
  set expert-adjust random-gamma 8 6.9
    while [expert-adjust < 0.5]
    [set expert-adjust random-gamma 8 6.9]
    set shape "cons"]
;  set alloc-distributions lput (list shape expert-adjust) alloc-distributions]                 ;; used for model verification
  user-message "Shift-work experts created. Will allocate non-ED between start & end shift times only. Remember to select trainees to cover non-working shifts & nurses for ED referrals"
  ask patch 10 -10 [set plabel "STAFF POOL" set plabel-color 0]

end

to allocate-trainee-shift                                                                       ;; trainees in acute medicine/AMU/AEC or non-acute med consultant
  ask patch 9 -11 [sprout-trainees-shift trainee-rota-staffing]
  ask trainees-shift[
  set max-AEC-risk 0.0
  set expert-adjust random-normal expert-adj-trainee 0.1
    while [expert-adjust < 0.2 or expert-adjust > 0.5]
          [set expert-adjust random-normal expert-adj-trainee 0.1]
    set shape "anp_st3"]
  user-message "Shift-work trainee-experts. Will allocate non-ED between start and end shift times only. Remember to select nurses for ED referrals and experts for non-ED"
;    set alloc-distributions lput (list shape expert-adjust) alloc-distributions]               ;; used for model verification
  ask patch 10 -10 [set plabel "STAFF POOL" set plabel-color 0]

end

to allocate-trainee-fulltime                                                                    ;; trainees in acute medicine/AMU/AEC or non-acute med consultant
 ask patch 8 -11 [sprout-trainees-fulltime trainee-rota-staffing]
 ask trainees-fulltime[
 set max-AEC-risk 0.0
 set expert-adjust random-normal expert-adj-trainee 0.1
    while [expert-adjust < 0.2 or expert-adjust > 0.5]
          [set expert-adjust random-normal expert-adj-trainee 0.1]
    set shape "anp_st3"]
;    set alloc-distributions lput (list shape expert-adjust) alloc-distributions]               ;; used for model verification
 ask one-of trainees-fulltime[move-to one-of decision with [not any? turtles-here]]
 user-message "24hr trainee-expert staff selected - can work alone. If combined with shift experts, trainees will take all ED referrals. Select nursing staff if required for ED referrals"
 ask patch 10 -10 [set plabel "STAFF POOL" set plabel-color 0]

end

to allocate-expert-fulltime                                                                    ;; trainees in acute medicine/AMU/AEC or non-acute med consultant
 ask patch 10 -11 [sprout-experts-fulltime expert-rota-staffing]
  ask experts-fulltime[
  set max-AEC-risk 0.0
  set expert-adjust random-gamma 8 6.9
    while [expert-adjust < 0.5]
    [set expert-adjust random-gamma 8 6.9]
    set shape "cons"]
 ask one-of experts-fulltime [move-to one-of decision with [not any? turtles-here]]
 user-message "24hr expert staff selected. Remember to select full time nursing or full time trainee staff if required for ED referrals"
 ask patch 10 -10 [set plabel "STAFF POOL" set plabel-color 0]

end

to allocate-senior-nurse                                                                         ;; charge nurse or senior charge nurse specialised in urgent care
  ask patch 10 -9 [sprout-senior-nurses 1]
  ask senior-nurses [
  set max-AEC-risk 0
  set expert-adjust random-float expert-adj-sn
    set shape "charge nurse"]
;    set alloc-distributions lput (list shape expert-adjust) alloc-distributions]                ;; used for model verification
  ask one-of senior-nurses[move-to one-of decision with [not any? turtles-here]]                 ;; 24hr presence so there at the start of the model
  user-message "24hr nursing staff selected. Remember to select medical staff if required for non-ED referrals"

end


;;-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
;;-------------------------------- to set-demand -------------------------------------------------------------------------------------------------------------------------
;;-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

to set-demand             ;; global preocedure to set the arrivals over the next 24hrs according to day of the week

set AMU-daily 0                                                                     ;; reset the daily tallies to zero until end of the day then recorded in output/BS
set AEC-daily 0
set waits-24 0
set daily-wrong-place 0
set good-exp-aec 0
set good-exp-amu 0
set disch-hrqol-aec 0
set disch-hrqol-amu 0
set amu-complete 0
set aec-complete 0
set AEC-disch 0
set AMU-disch 0
set daily-discharge 0
set daily-discharge-24 0
set daily-admit 0
set exp-true-amu 0
set nonexp-true-amu 0
set exp-true-aec 0
set nonexp-true-aec 0
set exp-false-amu 0
set nonexp-false-amu 0
set exp-false-aec 0
set nonexp-false-aec 0

if ticks = 0 [set mean-demand (Mean_weekday_attendances * 0.75)]                            ;; ensures model starts on first day

;set end-of-weekend week                                                           ;; assumes Monday 00:00 start
if ticks < whole-day * 5 [set start-of-weekend (whole-day * 5)]                    ;; assumes Monday 00:00 start

ifelse weekend = true                                                              ;; ensures demand set daily at 00:00
      [set mean-demand (Mean_weekend_attendances * 0.75)]
      [set mean-demand (Mean_weekday_attendances * 0.75)]

if ticks = start-of-weekend
     [set weekend true
      set start-of-weekend start-of-weekend + 1
      set mean-demand (Mean_weekend_attendances * 0.75)]
if ticks = end-of-weekend or ticks mod end-of-weekend = 0
     [set weekend false
      set start-of-weekend (start-of-weekend + (whole-day * 5))
      set mean-demand (Mean_weekday_attendances * 0.75)]


if any? patients with [label = "die"] [ask patients with [label = "die"] [die]]    ;; make sure no patients scheduled to leave are still in the area


;; if high demand the day before limit proactive capacity creation as hospital occupancy high
  ifelse last-24hrs < 65
    [set expected-to-current-capacity-ratio 10]
    [set expected-to-current-capacity-ratio 15]

end

;;-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
;;-------------------------------- to start-work ------------------------------------------------------------------------------------------------------------------------------
;;-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

to start-work                                                                           ;; decision-maker procedure to identify themselves as ready to assess patients

let DMs turtles with [
    shape != "telephone" and
    shape != "person"]

ask DMs
  [ask decision in-radius 1
     [
      set high-risk-adjust [max-AEC-risk] of myself
      set expert-adjust-local [expert-adjust] of myself
      ask turtles-here [
        if shape = "charge nurse" [set pcolor 9]
        if shape = "cons" [set pcolor 9.9]
        if shape = "anp_st3" [set pcolor 8]
      ]]

  ]
  if not any? turtles-here [
    set pcolor 9.5]

end

;;-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
;;-------------------------------- to shift-work ------------------------------------------------------------------------------------------------------------------------------
;;-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

to shift-work                                                                          ;; DM procedure which asks DMs to work shifts according to the user settings

if any? experts
  [
    if ticks = expert-shift-ends or ticks mod whole-day = expert-shift-ends                          ;; expert leaves at end of shift - no overnight expert
    [ask experts-on decision [set pcolor 9.5 move-to patch 10 -11
     ]]
    if ticks = expert-shift-starts or ticks mod whole-day = expert-shift-starts                      ;; different expert starts the next day
    [ask one-of experts [if not any? experts-on decision[
     move-to one-of decision with [not any? turtles-here]]
    ]]
  ]

if any? trainees-shift
  [
    if ticks = trainee-exp-shift-ends or ticks mod whole-day = trainee-exp-shift-ends                        ;; trainee leaves at end of shift - no overnight trainee with shift work
    [ask trainees-shift-on decision [set pcolor 9.5 move-to patch 9 -11
     ]]
    if ticks = trainee-exp-shift-starts or ticks mod whole-day = trainee-exp-shift-starts                  ;; different trainee starts the next day
    [ask one-of trainees-shift [if not any? trainees-shift-on decision[
      move-to one-of decision with [not any? turtles-here]]
     ]]
  ]


 if any? trainees-fulltime
 [
   if ticks = shift-change-am [
     set shift-change-am shift-change-am + whole-day
     ask trainees-fulltime-on decision [set pcolor 9.5 move-to patch 8 -11]
     ask one-of trainees-fulltime [if not any? trainees-fulltime-on decision [
     move-to one-of decision with [not any? turtles-here]
    ]]
    ]

   if ticks = shift-change-pm [
    set shift-change-pm shift-change-pm + whole-day
    ask trainees-fulltime-on decision [set pcolor 9.5 move-to patch 8 -11]
    ask one-of trainees-fulltime [if not any? trainees-fulltime-on decision [
     move-to one-of decision with [not any? turtles-here]
    ]]
    ]
  ]

end

;;-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
;;--------------------------------- to resource-shifts ------------------------------------------------------------------------------------------------------------------------
;;-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

to resource-shifts                       ;patch procedure to manage resources according to time of day and demand fluctuations

let first-run (Close_AEC * ticks-per-hour)
let expected count patients with [label = "QAMU"]
let free-beds count AMU-care with [not any? patients-here]


ifelse ticks = overnight-end
; ******* when daytime is identified run daytime resource management and limit transfers to preserve downstream activity ********
[set aec-available true
 set overnight-end overnight-end + 1
 if overnight-end = overnight-start
    [ set overnight-transfer-end ticks + (overnight-transfer-duration)
      set overnight-end overnight-end + overnight-duration]

  if sufficient-amu-beds = true [avoid-downstream-pressure]                         ;; ensure no transfers if AMU deemed to have sufficient capacity
 ]

;; ******** once overnight period identified run overnight resource management to balance downstream activity and amu occupancy *********
 [set aec-available false
 ifelse ticks < first-run
    [overnight-move]
    [set overnight-start overnight-start + 1
     overnight-move
     set expected-to-current-capacity-ratio 2
     if overnight-start = overnight-end
      [ ask patients-on AMU-care [
        if any? patients with [label = "Rx" and (time_complete - ticks) < 60][
        ask patients with [label = "Rx" and (time_complete - ticks) < 60]            ;; patients scheduled to fininsh within 2hrs of ward round delay leaving
                      [set time_complete  time_complete + ward-round-delay myself]]]     ;; delay moves during the ward round unless overcrowiding which logic will detecte


        set overnight-start overnight-start + (whole-day - overnight-duration)]
    ]
    if sufficient-amu-beds = true [avoid-overnight-moves]                             ;; procedure to reproduce policy of avoiding patient transfers overnight unless no capacity

;; if expected demand during overnight has reduced, limit early-moves already identified
      if expected < 3 and free-beds > 0 [
      ask patients-on AMU-care [
       if any? patients with [early-move = true][
        ask patients with [early-move = true][set early-move false
            set time_complete overnight-end + ward-round-delay myself]
        ]
        ]]
      if expected < 3 and overcrowding = false [
      ask patients-on AMU-care [
       if any? patients with [early-move = true][
        ask patients with [early-move = true][set early-move false
            set time_complete overnight-end + ward-round-delay myself]
        ]
    ]]

  ]
end

;;--------------------------------- to overnight-move ------------------------------------------------------
;;----------------------------------------------------------------------------------------------------------

to overnight-move                                                                      ;; procedure to move patients from AEC to AMU overnight if not able to discharge or transfer

ask patients-on AEC-care                                                               ;; patients still on AEC at night calculate need to move to AMU resource
 [
  if (time_complete - ticks) > ticks-per-hour * 2                                      ;; if not due for discharge within 2 hrs moves to AMU-care
     [if any? AMU-care with [not any? patients-here]
       [move-to one-of AMU-care with [not any? patients-here]
        set color 103 set shape "AMU-bed"]                                             ;; set as AMU-preferred patient to reflect move
;        set time_complete time_complete + (ticks-per-hour * 4)]                        ;; increase time to complete care as will not discharge overnight after 0100hrs
     ]
 ]
end

;;-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
;;-------------------------------- to patients-referred -------------------------------------------------------------------------------------------------------------------------
;;-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

to patients-referred                    ;; patch procedure - new patients created according to daily activity - peak/off-peak and weekend variation

let off-peak (whole-day - peak-duration)

ifelse peak = false                                                                    ;; creates the mean for poisson distribution according to the random daily demand
   [set non-eds (1 - off-peak-split)
    set eds off-peak-split
    if ticks = slow-overnight-arrivals[
          set slow-arrivals true
          set slow-overnight-arrivals slow-overnight-arrivals + whole-day]
   ]
   [set slow-arrivals false
    set non-eds (1 - peak-split)
    set eds peak-split

    ]

ask community-patients [

ifelse peak = false
       [
       ifelse slow-arrivals = false[                                                      ;; if off-peak but pre-0300hrs
       sprout-patients random-poisson (((mean-demand * (1 - peak-demand)) * non-eds) / off-peak )
        [set shape "person"
         set so-far so-far + 1
         set label "call waiting"
         set ed false
         set condition precision random-float 1.0 3                                 ;; suspected clinical condition established
         set los 0                                                                  ;; start calculating los
         set time_in_system 0
         set complete? false                                                        ;; identify treatment not complete yet
         move-to one-of non-ed-referrals                                            ;; form short virtual queue in front of DM
         ht]]
       [                                                                                 ;; ;;reduce the rate 0300-0900hrs
         sprout-patients random-poisson (((mean-demand * (1 - peak-demand)) * non-eds) / (off-peak * 2))
        [set shape "person"
         set so-far so-far + 1
         set label "call waiting"
         set ed false
         set condition precision random-float 1.0 3                                 ;; suspected clinical condition established
         set los 0                                                                  ;; start calculating los
         set time_in_system 0
         set complete? false                                                        ;; identify treatment not complete yet
         move-to one-of non-ed-referrals                                            ;; form short virtual queue in front of DM
         ht]]
         ]
       [                                                                                  ;;peak hour arrival rates
        sprout-patients random-poisson ((mean-demand * peak-demand * non-eds) / peak-duration)
         [set shape "person"
          set so-far so-far + 1
          set label "call waiting"
          set ed false
          set condition precision random-float 1.0 3                                ;; suspected clinical condition established
          set los 0                                                                 ;; start calculating los
          set time_in_system 0
          set complete? false                                                       ;; identify treatment not complete yet
          move-to one-of non-ed-referrals                                           ;; form short virtual queue in front of DM
        ht]]
    ]


 ;;--------New patients created as constant stream from ED


  ask ed-referrals [

  ifelse peak = false
       [
        ifelse slow-arrivals = false[
        sprout-patients random-poisson ((mean-demand * (1 - peak-demand) * eds) / off-peak)
         [set shape "person"
          set so-far so-far + 1
          set condition precision random-float 1.0 3                      ;; Different probability of an AEC patient
          set los 0                                                                 ;; start calculating los
          set ed true
          set time_in_system 0
          set complete? false                                                       ;; identify treatment not complete yet
          set label "call waiting"
          ht]]                                                                      ;; remain in the ED pending transfer
         [sprout-patients random-poisson ((mean-demand * (1 - peak-demand) * eds) /( off-peak * 2))
         [set shape "person"
          set so-far so-far + 1
          set condition precision random-float 1.0 3                      ;; Different probability of an AEC patient
          set los 0                                                                 ;; start calculating los
          set ed true
          set time_in_system 0
          set complete? false                                                       ;; identify treatment not complete yet
          set label "call waiting"
          ht]]
        ]
        [
        sprout-patients random-poisson ((mean-demand * peak-demand * eds) / peak-duration)
         [set shape "person"
          set so-far so-far + 1
          set condition precision random-float 1.0 3
          set los 0                                                                 ;; start calculating los
          set ed true
          set time_in_system 0
          set complete? false                                                       ;; identify treatment not complete yet
          set label "call waiting"
          ht]]                                                                      ;; remain in the ED pending transfer
  ]


;;------Returning/Follow-up AEC patients created daily ------                      ;; identified as green

 if ticks = aec-returns-start [                                                    ;; when the clinic opens patients
    ask patch -10 -10 [
      set aec-returns-start aec-returns-start + 1
      sprout-patients random-poisson (returns / aec-clinic)                       ;; reporter for random returns
      [ht
       set color 27                                                               ;; set color to identify returning patient
       set label "RETURN"
       set AEC-ok? true
       set for-discharge true
       set ed false
       set los 0
       set time_arrived ticks
       set complete? false
       set treatment_time AEC_dis_treatment_time myself                           ;; current treatment time assumed to reflect standard AEC time as return for ongoin care
       if treatment_time > aec-clinic [set treatment_time aec-clinic]             ;; limit return los to length of clinic time or under
       relocate                                                                   ;; follow the procedure to find a resource in competition with other patients
  ]]]
  if aec-returns-start = aec-returns-end [
    set aec-returns-start (aec-returns-start + whole-day - aec-clinic)            ;; reset the time for next aec clinic to start in 24hrs
    set aec-returns-end aec-returns-end + whole-day                               ;; reset the time for next aec clinic to end in 24hrs
  ]

end

;;------------- to start-peak --------------------------------------------------------------------------------
;;------------------------------------------------------------------------------------------------------------

to start-peak

let next-peak-onset (peak-start + (whole-day - peak-duration))

ifelse ticks != peak-end
  [set peak true
   set peak-start peak-start + 1]
  [set peak false
   set peak-start next-peak-onset
   set peak-end (peak-end + whole-day)]

end

;;-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
;;-------------------------------- to present ---------------------------------------------------------------------------------------------------------------------------------
;;-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

to present                                                                             ;; patch procedure instructing patients to present to DMs (ie calls answered)

  if any? patients-on ed-referrals [                                                   ;; ed referrals always go to the charge nurse
    ask patients-on ed-referrals[
      if any? decision with [pcolor = 9 and not any? patients-here]                    ;; charge nurse changes decision patch to a unique color
      [move-to one-of decision with [pcolor = 9 and not any? patients-here]
       set expert-dm false]
    ]]



  if any? patients-on non-ed-referrals and any? decision with [pcolor = 9.9] [
    ask patients-on non-ed-referrals[
    if any? decision with [pcolor = 9.9 and not any? patients-here]                    ;; non-ed referrals have preference for expert dm if available
          [move-to one-of decision with [pcolor = 9.9 and not any? patients-here]
           set expert-dm true]
  ]]

 if any? patients-on non-ed-referrals and any? decision with [pcolor = 8] [
    ask patients-on non-ed-referrals[
    if any? decision with [pcolor = 8 and not any? patients-here]                      ;; non-ed referrals will take trainee-expert if no experts available
          [move-to one-of decision with [pcolor = 8 and not any? patients-here]
           set expert-dm false]
  ]]


  if any? patients-on non-ed-referrals and not any? decision with [pcolor = 9.9 or pcolor = 8][
    ask patients-on non-ed-referrals[
    if any? decision with [pcolor = 9 and not any? patients-here]                      ;; allocation by charge nurse when no other clinicians present
          [move-to one-of decision with [pcolor = 9 and not any? patients-here]
           set expert-dm false]
  ]]


   if any? patients-on ed-referrals [                                                   ;; ed referrals DEFAULT TO TRAINEES IF NO NURSES
    ask patients-on ed-referrals[
      if any? decision with [pcolor = 8 and not any? patients-here]                    ;; charge nurse changes decision patch to a unique color
      [move-to one-of decision with [pcolor = 8 and not any? patients-here]
       set expert-dm false]
    ]]

  if any? patients-on ed-referrals [                                                   ;; ed referrals default cons if no nurses or trainees
    ask patients-on ed-referrals[
      if any? decision with [pcolor = 9.9 and not any? patients-here]
      [move-to one-of decision with [pcolor = 9.9 and not any? patients-here]
       set expert-dm true]
    ]]

end

;;-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
;;--------------------------------- to decide ---------------------------------------------------------------------------------------------------------------------------------
;;-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

to decide                                                                              ;; patch procedure that instructs DM to create more AEC pathways if overcrowding present or anticipated

 ask patients-on decision[
    if expert-dm = true and condition >= non-urgent
    [set refused refused + 1
     die]]

 ifelse overcrowding = true                                                            ;; adjusts allocation decision to mitigate overcrowding
   [adjust]
   [allocate]

end

;;--------------------------------- to allocate -----------------------------------------------------------
;;---------------------------------------------------------------------------------------------------------

to allocate                                                                            ;; patch procedure to determine allocation when no overcrowding

ask patients-on decision [

ifelse AEC myself [                                                                    ;; DM determines if for AEC based on a their expertise/risk threshhold

      set AEC-ok? true set color 75 set label "QAEC"                                   ;; identify as AEC
      set AECs AECs + 1
      ifelse ed = true                                                                 ;; set arrival according to source (ed or non-ed)
       [set time_referred ticks                                                        ;; indicate when referred into the system
        set time_arrived arrival_time_ed myself
        ifelse condition <= ed-aec-prev                                                ;; set discharge according to prevalence of AEC suitable patients
             [set for-discharge true
              set treatment_time AEC_dis_treatment_time myself]                        ;; treatment_time (count-down) variable set according to AEC-discharge reporter
             [set for-discharge false
              set treatment_time AEC_adm_treatment_time myself]                        ;; treatment_time (count-down) variable set according to AEC-admission reporter

       ]
      [set time_referred ticks                                                         ;; indicate when referred into the system
       set time_arrived arrival_time_comm myself                                       ;; as above for non-ED patients
       ifelse condition <= noned-aec-prev                                              ;; set discharge according to prevalence of AEC suitable patients
             [set for-discharge true
              set treatment_time AEC_dis_treatment_time myself]                        ;; treatment_time (count-down) variable set according to AEC-discharge reporter
             [set for-discharge false
              set treatment_time AEC_adm_treatment_time myself]                        ;; treatment_time (count-down) variable set according to AEC-admission reporter

      ]
    move-to one-of to-come-in                                                          ;; move to queue of anticipated patients
    set shape "person"
    stop
    ]
  [
    set AEC-ok? false set color 103 set label "QAMU"                                   ;; identify as AMU
    set AMUs AMUs + 1
    ifelse ed = true                                                                   ;; set arrival time according to source for non-AEC patients
        [
         set time_referred ticks                                                       ;; indicate when referred into the system
         set time_arrived arrival_time_ed myself
         ifelse condition <= ed-aec-prev                                   ;; set discharge according to prevalence of AEC suitable patients according to condition
             [set for-discharge true
              set treatment_time AMU_dis_treatment_time myself]                        ;; treatment_time set according to AEC-discharge reporter as will be picked up as AEC by staff in AMU-care
             [set for-discharge false
              set treatment_time AMU_adm_treatment_time myself]                        ;; treatment_time set according to AEC-admission reporter as will be picked up as AEC by staff in AMU-care

        ]
       [set time_referred ticks                                                         ;; indicate when referred into the system
        set time_arrived arrival_time_comm myself
        ifelse condition <= noned-aec-prev                                     ;; set discharge according to prevalence of AEC suitable patients according to condition
             [set for-discharge true
              set treatment_time AMU_dis_treatment_time myself]                        ;; treatment_time set according to AEC-discharge reporter as will be picked up as AEC by staff in AMU-care
             [set for-discharge false
              set treatment_time AMU_adm_treatment_time myself]                        ;; treatment_time set according to AEC-admission reporter as will be picked up as AEC by staff in AMU-care

       ]


    set shape "person"
    move-to one-of to-come-in                                                         ;; move to queue of anticipated patients
    stop
    ]
  ]

end

;;--------------------------------- to adjust ------------------------------------------------------------
;;--------------------------------------------------------------------------------------------------------

to adjust                                                                              ;; patch procedure to determine allocation when some overcrowding

ask patients-on decision [

    ifelse modified-AEC myself [                                                       ;; DM determines if for AEC based on a their expertise/risk threshhold

      set AEC-ok? true set color 75 set label "QAEC"                                   ;; identify as AEC
      set AECs AECs + 1
      ifelse ed = true                                                                 ;; set arrival according to source (ed or non-ed)
       [
        set time_referred ticks                                                        ;; indicate when referred into the system
        set time_arrived arrival_time_ed myself
        ifelse condition <= ed-aec-prev                                                ;; set discharge according to prevalence of AEC suitable patients
             [set for-discharge true
              set treatment_time AEC_dis_treatment_time myself]                        ;; treatment_time (count-down) variable set according to AEC-discharge reporter
             [set for-discharge false
              set treatment_time AEC_adm_treatment_time myself]                        ;; treatment_time (count-down) variable set according to AEC-admission reporter
       ]
       [set time_referred ticks                                                        ;; indicate when referred into the system
        set time_arrived arrival_time_comm myself                                      ;; as above for non-ED patients
        ifelse condition <= noned-aec-prev                                             ;; set discharge according to prevalence of AEC suitable patients
             [set for-discharge true
              set treatment_time AEC_dis_treatment_time myself]                        ;; treatment_time (count-down) variable set according to AEC-discharge reporter
             [set for-discharge false
              set treatment_time AEC_adm_treatment_time myself]                        ;; treatment_time (count-down) variable set according to AEC-admission reporter
       ]
    move-to one-of to-come-in                                                          ;; move to queue of anticipated patients
    set shape "person"
    stop
  ]
  [
    set AEC-ok? false set color 103 set label "QAMU"                                   ;; identify as AMU
    set AMUs AMUs + 1
    ifelse ed = true                                                                   ;; set arrival time according to source for non-AEC patients
        [
         set time_referred ticks                                                       ;; indicate when referred into the system
         set time_arrived arrival_time_ed myself
         ifelse condition <= ed-aec-prev                                    ;; set discharge according to prevalence of AEC suitable patients according to condition
             [set for-discharge true
              set treatment_time AMU_dis_treatment_time myself]                        ;; treatment_time (count-down) variable set according to AMU-discharge reporter as takes longer here
             [set for-discharge false
              set treatment_time AMU_adm_treatment_time myself]                        ;; treatment_time (count-down) variable set according to AEC-admission reporter as takes longer here
       ]
       [set time_referred ticks                                                        ;; indicate when referred into the system
        set time_arrived arrival_time_comm myself
        ifelse condition <= noned-aec-prev                                     ;; set discharge according to prevalence of AEC suitable patients according to condition
             [set for-discharge true
              set treatment_time AMU_dis_treatment_time myself]                        ;; treatment_time (count-down) variable set according to AMU-discharge reporter as takes longer here
             [set for-discharge false
              set treatment_time AMU_adm_treatment_time myself]                        ;; treatment_time (count-down) variable set according to AEC-admission reporter as takes longer here
        ]
    set shape "person"
    move-to one-of to-come-in                                                         ;; move to queue of anticipated patients
    stop
    ]
  ]


end

;;-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
;;----------------------------- to get-treatment ------------------------------------------------------------------------------------------------------------------------------
;;-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

to get-treatment                                                                      ;; this procedure progresses patients in the system to receive care and then move on when able
  if label = "T" [stop]
  if label = "H" [stop]


  let corridors count patients-on waiting-bedded
  set los (ticks - time_arrived)                                                      ;; all arrived patients count time in the system regardless of whether treatment has started
  ask patients-on to-come-in [set los 0]                                              ;; correct los for non-arrived patients

;PATIENTS STILL TO COME IN
  ask patients with [label = "QAMU" or label = "QAEC"] [                              ;; queuing patients will check to see if arrival time has been met
    if time_arrived = ticks
     [relocate
   ;  set arrival-times lput (list ed time:show tick-datetime "EEEE dd-MM-yyy HH:mm") arrival-times               ;; will relocate & record arrival time if verification require
     ]
        if time_arrived < ticks
     [relocate
  ;   set arrival-times lput (list ed time:show tick-datetime "EEEE dd-MM-yyy HH:mm") arrival-times               ;; safety net to ensure all suitable patients have moved
     ]]

; PATIENTS IN THE WAITING AREA
  ask patients-on waiting-bedded [
    ifelse los < waiting-time [wait-for-resource][skip-queue]]                      ;; if wait to move to bedded (not aec) identify high priority according to time waiting
  ask patients-on waiting-aec [
    ifelse los < waiting-time [wait-for-resource][skip-queue]]                      ;; those placedin AEC because of overcrowding wait for same periods as AMU patients

  ask patients-on AEC-care [set final-area 1]                                       ;; ask patients to identify where they are receiving care
  ask patients-on AMU-care [set final-area 0]


;****** WHEN AEC IS AVAILABLE *******
  ifelse aec-available = true
[ ;; during urgent care hours patients are discharged when completed

  if occupancy-AMU > amu-crowding or overcrowding-expected = true [                  ;; during daytime if there is crowding, ask those waiting for transport home to move to AEC-care
      if any? patients with [shape = "car" and label != " "][                        ;; move patients waiting for transport to AEC if overcrowding to prevent waits
      ask n-of 1 patients with [shape = "car" and label != " "] [
        if any? AEC-care with [not any? patients-here] [
            move-to one-of AEC-care with [not any? patients-here]
            set aec-move true
            set label " "]                                                           ;; identify as a AMU discharge moved to AEC to await transport home
    ]]
    ]

;*********** INSTRUCTIONS AT THE END OF TREATMENT **************
;PATIENTS MOVED TO AEC AWAITING TRASNPORT
 if any? patients with [aec-move = true and label = " " and time_complete <= ticks][
    ask patients with [aec-move = true and label = " " and time_complete <= ticks]   ;; patients moved to aec awaiting discharge but actually an AMU-discharge
            [set final-area 0                                                        ;; identify as an AMU-discharge
             set complete? true
             set label "C"
    ]]

;PATIENTS FOR DISCHARGE IDENTIFIED AS EARLY MOVE TO CREATE CAPACITY                  ;; if still required to move to create capacity will be admitted during day
 if any? patients with [label = "EMD" and time_complete <= ticks][
    ask patients with [label = "EMD" and time_complete <= ticks]
            [set complete? true
             set label "C"                                                    ;; indicate treatment is finished
    ]]
 if any? patients with [early-move = true and shape = "AEC-chair" and time_complete <= ticks][
      ask patients with [early-move = true and shape = "AEC-chair" and time_complete <= ticks]
            [set final-area 0
             set complete? true
             set label "C"
    ]]

;PATIENTS WITH DELAYED DISCHARGE OVRNIGHT IDENTIFIED TO LEAVE
  if any? patients with [label = "DD" and time_complete <= ticks][
    ask patients with [label = "DD" and time_complete <= ticks]
            [set complete? true
             set label "C"                                                     ;; indicate treatment is finished
    ]]


;PATIENTS STILL UNDERGOING CARE REACHING TO END OF TREATMENT IN ANY AREA
 if any? patients with [label = "Rx" and time_complete <= ticks][
    ask patients with [label = "Rx" and time_complete <= ticks]
                                                                                     ;; undecided patients will identify when treatment (Rx) is completed
     [
      if early-move != true or shape != "car" [                                      ;; all early move patients are admission by default
        ifelse AEC-ok? = true[
        if final-decision myself <= random-adm-aec
            [if for-discharge = true [set for-discharge false]                            ;;unexpected outcome meaning admission
          ]]
        [if final-decision myself <= random-discharge-amu
            [if for-discharge = false [set for-discharge true]                           ;;unexpected outcomes meaning discharge
          ]]
       set complete? true                                                             ;; indicate treatment is finished
       set label "C"
        ]                                                                      ;; once care completed move to be discharged or admitted                                                                     ;; once care completed move to be discharged or admitted
      ]
  ]]

  ;****** WHEN AEC IS NOT AVAILABLE/OVERNIGHT *******
[if any? patients with [label = "Rx" and time_complete <= ticks][
    ask patients with [label = "Rx" and time_complete <= ticks]                                   ;; undecided patients will identify when treatment (Rx) is completed
    [
    if early-move != true or shape != "car"[
    ifelse AEC-ok? = true[
        if final-decision myself <= random-adm-aec                                ;; AEC-ok patients are discharged OOH hours assumes transport an knowledge of discharge
          [if for-discharge = true [set for-discharge false]                      ;; if review means they are for admission identify and leave
        ]
      set complete? true
      set label "C"]
      [ifelse for-discharge = true[                                                   ;; OOH AMU patients for discharge not expecting to get home and possible frailer
         set label "DD"                                                               ;; identify as delayed discharge
         set color 125
         set shape "car"
         set time_complete overnight-end + (60 + floor random-float 300)]             ;; set new time for completion for sometimes after the ward round
        [set complete? true                                                           ;; if for admission may exit if the avoid ovrenight moves procedure hasn't been triggered
         set label "C"]
      ]
     ]
    ]]

;PATIENTS FOR DISCHARGE IDENTIFIED AS EARLY MOVE TO CREATE CAPACITY
 if any? patients with [label = "EMD" and time_complete <= ticks][
    ask patients with [label = "EMD" and time_complete <= ticks]
            [set complete? true                                                       ;; indicate treatment is finished
             set label "C"
    ]]                                                                 ;; once care completed move to be admitted

  ]

if any? patients with [complete? = true and label = "C"][
    ask patients with [complete? = true ] [dispose]                                   ;; all patients identified as complete can exit the model
  ]
end

;;----------------------------------------------------------------------------------------------------------
;;---------------------------------to relocate--------------------------------------------------------------

to relocate                                                                            ;; patient procedure to move to a clinical area when space is available

st
;; AEC OPEN
if aec-available = true [
    set aec-possible true
    ifelse AEC-ok?                                                                     ;; AEC ALLOCATED PATIENTS
        [ifelse any? AEC-care with [not any? patients-here]                            ;; if allocated to aec move to aec where there is capacity
        [
         move-to one-of AEC-care with [not any? patients-here]
         set treatment_started ticks
         set label "Rx"                                                                ;; start care
         set time_complete time_completed myself                                       ;; identify time when care will finish
         set shape "AEC-chair"
        ]
        [
         ifelse any? waiting-aec with [not any? patients-here]                         ;; if no capacity in AEC goes to aec waiting area
        [move-to one-of waiting-aec with [not any? patients-here]
            ]
        [ifelse any? waiting-bedded with [not any? patients-here]                      ;; if not waiting capacity outside aec but capacity to wait outside bedded go there
          [
            move-to one-of waiting-bedded with [not any? patients-here]                ;; move to bedded waiting area
            set waits-today waits-today + 1
          ]
          [
            print "URGENT CARE SYSTEM FAILURE"                                         ;; if both waiting areas full then the system has failed.
            ask patch-here [set system-failure system-failure + 1]                     ;; system failure is recorded
            die]                                                                       ;; patient redirected to another area for care e.g. emergency department & leave the model
         ]
    ]
    ]
    ;if AEC-ok? false                                                                  ;; BEDDED (NON-AEC) ALLOCATED PATIENTS
    [ifelse any? AMU-care with [not any? patients-here]                                ;; go to any available AMU space/bed
        [
         move-to one-of AMU-care with [not any? patients-here]
         set treatment_started ticks
         set label "Rx"                                                                ;; indicate that care has started
         set time_complete time_completed myself                                       ;; indicate when care will be complete
         set shape "AMU-bed"
        ]
        [
         ifelse any? waiting-bedded with [not any? patients-here]                      ;; if no AMU bed but space in bedded waiting area then move there
          [
           move-to one-of waiting-bedded with [not any? patients-here]
           set waits-today waits-today + 1
          ]
          [
            print "URGENT CARE SYSTEM FAILURE"                                         ;; if whole area is full sindicate system failure
            ask patch-here [set system-failure system-failure + 1]
            die]                                                                       ;; patient redirected to another area for care e.g. emergency department & exits model
        ]
    ]
  ]

;; AEC CLOSED
if aec-available = false [                                                             ;; instructions for aec patients who have to go to AMU due to overnight processes
    set aec-possible false
    ifelse any? AMU-care with [not any? patients-here]                                 ;; all patients seek space in bedded area where available
        [
         move-to one-of AMU-care with [not any? patients-here]                         ;; instructions for aec patients who have to go to AMU due to overnight processes
         ifelse for-discharge = true
                [set treatment_time AEC_dis_treatment_time myself]                     ;; AEC patients re-adjust treatment time to be AMU patients according to discharge or not
                [set treatment_time AMU_adm_treatment_time myself]                     ;; reflects time taken to process care in bedded area
         set treatment_started ticks
         set label "Rx"                                                                ;; indicate that care has started
         set time_complete time_completed myself                                       ;; indicate when care will be complete
         set color 103
         set shape "AMU-bed"

        ]
        [
         ifelse any? waiting-bedded with [not any? patients-here]                      ;; if no AMU bed then go to bedded waiting area
          [
            move-to one-of waiting-bedded with [not any? patients-here]
            set waits-today waits-today + 1]
          [
            print "URGENT CARE SYSTEM FAILURE"                                         ;; if whole area is full indicate the system has failed
            ask patch-here [set system-failure system-failure + 1]
            die]                                                                       ;; patient redirected to another area for care e.g. emergency department & exits model
        ]
  ]

;--------- All patients who are remaining in waiting areas after these moves
  ask patients-on waiting-bedded
  [set treatment_started 0 set label "D"                                               ;; patients who have not been able to move to a clinical space identify themselves
   set time_complete 0                                                                 ;; ensure time to complete care is reset to be re-calculated on next round
   set shape "person"
   if color != 15 [set color 15]]                                                      ;; if patient should be in a bed identified as red to alert staff

  ask patients-on waiting-aec
  [set treatment_started 0 set label "D"                                               ;; patients who have not been able to move to a clinical space identify themselves
   set time_complete 0                                                                 ;; ensure time to complete care is reset to be re-calculated on next round
   set shape "person"
   if color != 15 [set color 15]]                                                      ;; if patient should be in a bed identified as red to alert staff


end

;;----------------------------- to wait-for-resource ---------------------------------------------------
;;------------------------------------------------------------------------------------------------------

to wait-for-resource                                                                ;; patient procedure to process patients who have been waiting for < maximum wait

let long-wait-aec 0
let long-wait-bedded 0

ask patients-on waiting-aec[
    if los >= (ticks-per-hour * 4)[set long-wait-aec 1]]                            ;; patients waiting >= 4hrs get priority when large queues arise
ask patients-on waiting-bedded[
    if los >= (ticks-per-hour * 4)[set long-wait-bedded 1]]


;; PATIENTS IN AEC WAITING AREA

if any? patients-on waiting-aec
[
  ifelse aec-available = true                                                        ;; if aec is open patients for aec wait for resource
      [ask patients-on waiting-aec [
         if AEC-ok? = true and long-wait-aec = 0 [                                   ;; when aec is open true aecs move when they can as long as no very long waits before them
            if any? AEC-care with [not any? patients-here][
              move-to one-of AEC-care with [not any? patients-here]
              set treatment_started ticks
              set label "Rx"                                                         ;; start care
              set time_complete time_completed myself                                ;; identify time when care will finish
              set shape "AEC-chair"
              set color 75                                                           ;; become an aec patient
              set delayed [los] of self
              if delayed < 5 [set delayed 0]
          ]]
          ]
       ]
      [
      if long-wait-aec = 0 and long-wait-bedded = 0
      [ask patients-on waiting-aec [                                                 ;; if aec not open use AMU resource
          ifelse any? AMU-care with [not any? patients-here] [
            move-to one-of AMU-care with [not any? patients-here]                    ;; if gets allocated bed in AMU change to AMU color/assimilate
            ifelse for-discharge = true
                [set treatment_time AEC_dis_treatment_time myself]                   ;; AEC patients re-adjust treatment time to be AMU patients according to discharge or not
                [set treatment_time AMU_adm_treatment_time myself]                   ;; reflects time taken to process care in bedded area
            set treatment_started ticks

            set label "Rx"                                                           ;; care not managed through AEC as reduced capapcity overnight indepdendent of the DM grade
            set color 103                                                            ;; becomes as AMU patient not AEC
            set AEC-ok? false
            set shape "AMU-bed"
            set time_complete time_completed myself                                  ;; identify when care will be complete
            set delayed [los] of self
            if delayed < 5 [set delayed 0]
        ]
        [ifelse any? waiting-bedded with [not any? patients-here]
        [move-to one-of waiting-bedded with [not any? patients-here]                 ;; when aec is closed those left waiting seek to move to waiting-bedded for AMU care
         set waits-today waits-today + 1
          ]
        [print "URGENT CARE SYSTEM FAILURE"                                          ;; if whole area is full sindicate system failure
            ask patch-here [set system-failure system-failure + 1]
            die]]
        ]
      ]
      ]
  ]

;; PATIENTS IN BEDDED WAITING AREA


if any? patients-on waiting-bedded
[
  ifelse aec-available = true                                                        ;; if aec is open patients for aec wait for resource
      [
       if long-wait-bedded = 0                                                       ;; patients on waited-bedded get priority over waiting-aec (who are more stable)
      [ask patients-on waiting-bedded [

        if AEC-ok? = false[                                                          ;; if for amu but they have not waited beyond the agreed max wait...
        if any? AMU-care with [not any? patients-here]                               ;; check for free AMU resource and move if available
        [   move-to one-of AMU-care with [not any? patients-here]                    ;; if gets allocated bed in AMU change to AMU color/assimilate
            set treatment_started ticks
            set label "Rx" set color 103                                             ;; start treatment
            set time_complete time_completed myself                                  ;; identify when care will be complete
            set delayed [los] of self
            if delayed < 5 [set delayed 0]
            set shape "AMU-bed"]
        ]

        if AEC-ok? = true [                                                          ;; aec patients moved to waiting-bedded when aec closed who are there when it opens
        if long-wait-aec = 0
           [                                                                         ;; if placed in bedded waiting when AEC closed but it opens while they wait go there first
            if any? AEC-care with [not any? patients-here][
            move-to one-of AEC-care with [not any? patients-here]
            set treatment_started ticks
            set label "Rx"                                                           ;; start care
            set time_complete time_completed myself                                  ;; identify time when care will finish
            set shape "AEC-chair"
            set color 75
            set delayed [los] of self
            if delayed < 5 [set delayed 0]
           ]

            if any? AMU-care with [not any? patients-here] [                         ;; if no AEC space available default to AMU
            move-to one-of AMU-care with [not any? patients-here]                    ;; if gets allocated bed in AMU change to AMU color/assimilate
            set treatment_started ticks
            set label "Rx"                                                           ;; care not managed through AEC as reduced capapcity overnight indepdendent of the DM grade
            set color 103                                                            ;; becomes as AMU patient not AEC
            set shape "AMU-bed"
            set time_complete time_completed myself                                  ;; identify when care will be complete
            set delayed [los] of self]
            if delayed < 5 [set delayed 0]
           ]
    ]]]]
    [
        if long-wait-aec = 0 and long-wait-bedded = 0[                               ;; AEC patient wait for AMU bed when AEC closed
            if any? AMU-care with [not any? patients-here] [                         ;; if no AEC space available default to AMU
            move-to one-of AMU-care with [not any? patients-here]                    ;; if gets allocated bed in AMU change to AMU color/assimilate
            if AEC-ok? = true [
               ifelse for-discharge = true
                [set treatment_time AEC_dis_treatment_time myself]                   ;; AEC patients re-adjust treatment time to be AMU patients according to discharge or not
                [set treatment_time AMU_adm_treatment_time myself]]                  ;; reflects time taken to process care in bedded area
            set treatment_started ticks
            set label "Rx"                                                           ;; care not managed through AEC as reduced capapcity overnight indepdendent of the DM grade
            set color 103                                                            ;; becomes as AMU patient not AEC
            set shape "AMU-bed"
            set time_complete time_completed myself                                  ;; identify when care will be complete
            set delayed [los] of self]]
            if delayed < 5 [set delayed 0]
            ]
  ]

;---------All patients who are remaining in waiting areas after these moves
ask patients-on waiting-aec                                                          ;; any patients unable to move from the waiting areas reset to remain as waiting
  [set treatment_started 0
   set shape "person" set label "D" set time_complete 0]                             ;; ensures if 2 patients try to move to one space, the unsuccessful one will readjust variable to baseline
ask patients-on waiting-bedded                                                       ;; any patients unable to move from the waiting areas reset to remain as waiting
  [set treatment_started 0
   set shape "person" set label "D" set time_complete 0]                             ;; ensures if 2 patients try to move to one space, the unsuccessful one will readjust variable to baseline

end

;;----------------------------- to skip-queue ----------------------------------------------------------
;;------------------------------------------------------------------------------------------------------

to skip-queue                                                                        ;; model for patients who have been waiting > than their maximum wait
                                                                                     ;; once waiting > 1hr all patient compete regrardless of length of wait

if label = "RETURN" and los >= ticks-per-hour * 4 [die]                                ;; return patients will be removed from the area in the event of severe overcrowding


ifelse aec-available = true[                                                         ;; AEC OPEN: use aec for all delayed patients when it is open
   if AEC-ok? = false [                                                              ;; patients waiting for a bed look first
     if any? AMU-care with [not any? patients-here]
        [
         move-to one-of AMU-care with [not any? patients-here]                       ;; if gets allocated bed in AMU change to AMU color/assimilate
         set treatment_started ticks
         set label "Rx"                                                              ;; start treatment
         set color 103
         set time_complete time_completed myself                                     ;; identify when care will be complete
         set delayed [los] of self
         if delayed < 5 [set delayed 0]
         set shape "AMU-bed"
        ]
     if any? AEC-care with [not any? patients-here]
        [
         move-to one-of AEC-care with [not any? patients-here]                       ;; patient awaiting AEC care can move when AEC available
         set treatment_started ticks

         set label "Rx"                                                              ;; start treatment
         set color 15
         set shape "AEC-chair"                                                       ;; appear as red patient in a chair
         set time_complete time_completed myself                                     ;; identify when care will be complete
         set delayed [los] of self
         set wrong-place wrong-place + 1
         if delayed < 5 [set delayed 0]
        ]
    ]

 if AEC-ok? = true [
     if any? AEC-care with [not any? patients-here]
        [
         move-to one-of AEC-care with [not any? patients-here]                       ;; go to AEC if suitable
         set treatment_started ticks
         set label "Rx"                                                              ;; start treatment
         set shape "AEC-chair"
         set color 75
         set time_complete time_completed myself                                     ;; identify when care will be complete
         set delayed [los] of self
         if delayed < 5 [set delayed 0]
        ]
   if any? AMU-care with [not any? patients-here]                                    ;; if no AEC capacity and waiting >4hrs change to a bed
        [
         move-to one-of AMU-care with [not any? patients-here]                       ;; if gets allocated bed in AMU change to AMU color/assimilate
         set treatment_started ticks
         set label "Rx"                                                              ;; start treatment
         set time_complete time_completed myself                                     ;; identify when care will be complete
         set delayed [los] of self
         if delayed < 5 [set delayed 0]
         set color 103                                                               ;; become an AMU bedded patient
         set shape "AMU-bed"                                                         ;; merge into AMU patient group (i.e., delayed/lost in the system when capacity is pushed)
        ]
    ]
 ]
 [
  if any? AMU-care with [not any? patients-here]                                     ;; AEC CLOSED: use AMU for all patients until aec open again
        [
         move-to one-of AMU-care with [not any? patients-here]                       ;; if gets allocated bed in AMU change to AMU color/assimilate
         if AEC-ok? = true [
               ifelse for-discharge = true
                [set treatment_time AEC_dis_treatment_time myself]                   ;; AEC patients re-adjust treatment time to be AMU patients according to discharge or not
                [set treatment_time AMU_adm_treatment_time myself]]                  ;; reflects time taken to process care in bedded area
         set treatment_started ticks
         set label "Rx"                                                              ;; start treatment
         set color 103
         set time_complete time_completed myself                                     ;; identify when care will be complete
         set delayed [los] of self
         if delayed < 5 [set delayed 0]
         set shape "AMU-bed"
    ]
  ]


ask patients-on waiting-aec                                                          ;; any patients unable to move from the waiting areas reset to remain as waiting
  [set treatment_started 0
   set shape "person" set label "D" set time_complete 0]                             ;; ensures if 2 patients try to move to one space, the unsuccessful one will readjust variable to baseline
ask patients-on waiting-bedded                                                       ;; any patients unable to move from the waiting areas reset to remain as waiting
  [set treatment_started 0
   set shape "person" set label "D" set time_complete 0]                             ;; ensures if 2 patients try to move to one space, the unsuccessful one will readjust variable to baseline


end

;;--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
;;----------------------------- to readjust-location -----------------------------------------------------------------------------------------------------------------------------
;;--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


to readjust-location                                                                 ;; AMU patients on AEC get priority for beds but are randomly competing with other waiting patients


  ask patients-on AEC-care [
    if color = 15[
    if any? AMU-care with [not any? patients-here][
        move-to one-of AMU-care with [not any? patients-here]
        set shape "AMU-bed"
        set label "Rx"
        set color 103
        set delayed [los] of self]                                                   ;; indicated delay as recorded in real life as time when placed in a bed
        if delayed < 5 [set delayed 0]]                                              ;; ensures only delays of 5mins or more are captured in final outputs
    ]

end

;;-------------------------------------------------------------------------------------------------------
;;------------------------------ to dispose -------------------------------------------------------------


to dispose                                                                           ;; procedure to identify where patients should move to once care complete

 if label = "RETURN" [die]                                                           ;; remove from calculations


 ifelse for-discharge = true
        [set shape "home-car"                                                             ;; visually identify on the model for home
         set label "H"
         set patients_discharged (patients_discharged + 1)                           ;; update the global tally
         if los <= ticks-per-hour * 24 [
              set patients_discharged_24 (patients_discharged_24 + 1)]               ;; update the global tally of 24hr discharges
         ifelse final-area = 1                                                       ;; set daily tallies for AMU-bedded and AEC discharges for model end
           [set aec-discharges aec-discharges + 1
            set aec_complete_today aec_complete_today + 1                            ;; update tally for complete that day
            set exp-daily-aec exp-daily-aec + record-experience myself]              ;; record experience according to area of care
           [set amu-discharges amu-discharges + 1
        ;      set shape "star"
            set amu_complete_today amu_complete_today + 1
            set exp-daily-amu exp-daily-amu + record-experience myself]
           ]

        [set label "T"
         set shape "patient"
         set patients_admitted patients_admitted + 1                                 ;; update the global tally
         ifelse final-area = 1                                                       ;; set daily tallies for AMU-bedded and AEC discharges for model end
           [set aec_complete_today aec_complete_today + 1                            ;; update tally for complete that day
            set exp-daily-aec exp-daily-aec + record-experience myself]              ;; record experience according to area of care
           [set amu_complete_today amu_complete_today + 1
            set exp-daily-amu exp-daily-amu + record-experience myself]
         ]


  ifelse [time_referred] of self <= week * 2 [stop]                                                     ;; dont collect data for the first two weeks to allow model to warm up
  [
  ifelse for-discharge = true [                                                           ;; only collect hrqol for discharged patients
    ifelse final-area = 1                                                             ;; if finished care in aec assume all in aec and aec health change (moved for discharge identify as amu)
      [set hrqol hrqol-me myself
       set hrqol-aec hrqol-aec + hrqol]
      [set hrqol hrqol-me myself                                                      ;; if finished care in amu assume care in amu (even if originally aec) and amu health change
       set hrqol-amu hrqol-amu + hrqol]
    ]
    [stop]
  ]

end


;;-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
;;------------------------------ to leave -------------------------------------------------------------------------------------------------------------------------------------
;;-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

to leave                               ;; patient procedure

  if any? patients with [label = "T" or label = "H"][
  ask patients with [label = "T" or label = "H"][
      exit-model]]

end



;;------------------------------ to exit-model ---------------------------------------------------------
;;-----------------------------------------------------------------------------------------------------------

to exit-model                    ;; patient procedure

if [time_referred] of self <= week * 2 [die]                                          ;;prevents the first two weeks of patients from entering variables for post-run analysis (warm up period)


if label = "T" and AEC-ok? = true[
    set label "AECT"
    ifelse expert-dm = true
                      [set expert-false-aec expert-false-aec + 1]                    ;; identify outcome for PPV NPV calculation if expert dm or nonexpert
                      [set nonexpert-false-aec nonexpert-false-aec + 1]
    ifelse ed = true[
                       set ed-total ed-total + 1]                                    ;; model totals for patients in each area
                      [set noned-total noned-total + 1]

    set los ([los] of self * minutes-per-tick)                                       ;; los in amu area as mins

    set delayed ([delayed] of self * minutes-per-tick)
;    set time_in_system([time_in_system] of self * minutes-per-tick)                   ;; time spent in urgent care system (from time of referral) in mins
    set time-variables lput
    (list label los delayed hrqol ) time-variables                     ;; separate csv file for analysis as needed
 ;   set departure-times lput
 ;   (list label time:show tick-datetime "EEEE dd-MM-yyy HH:mm") departure-times                     ;; departure-times collected for verification as needed
    die
  ]

if label = "T" and AEC-ok? = false[
    set label "AMUT"
    ifelse expert-dm = true
                      [set expert-true-amu expert-true-amu + 1]                      ;; identify outcome for PPV NPV calculation if expert dm or nonexpert
                      [set nonexpert-true-amu nonexpert-true-amu + 1]
    ifelse ed = true[
                       set ed-total ed-total + 1]                                    ;; model totals for patients in each area
                      [set noned-total noned-total + 1]

    set los ([los] of self * minutes-per-tick)                                       ;; los in amu area as mins
    set delayed ([delayed] of self * minutes-per-tick)
;    set time_in_system([time_in_system] of self * minutes-per-tick)                  ;; time spent in urgent care system (from time of referral) in mins
    set time-variables lput
    (list label los delayed hrqol) time-variables                     ;; departure-times collected for verification as needed
;    set departure-times lput
;    (list label time:show tick-datetime "EEEE dd-MM-yyy HH:mm") departure-times
    if aec-available = false [set capacity-moves capacity-moves + 1]                 ;; identify an overnight transfer
    die
  ]


if label = "H" and AEC-ok? = true[
    set label "AECH"
    ifelse expert-dm = true
    [
    ifelse los <= ticks-per-hour * 10 and aec-possible = true                        ;; meet LoS (10 hrs0 criteria and AEC availability on arrival
                      [set expert-true-aec expert-true-aec + 1]                      ;; correct aec placement by expert
                      [set expert-false-aec expert-false-aec + 1]                    ;; incorrect aec placement by expert
    ifelse ed = true  [set prev_ed_model prev_ed_model + 1
                       set ed-total ed-total + 1]                                    ;; identify model prevalence for PPV NPV calculation
                      [set prev_noned_model prev_noned_model + 1
                       set noned-total noned-total + 1]                              ;; model totals for patients in each area

    ]
    [
    ifelse los <= ticks-per-hour * 10 and aec-possible = true                        ;; meet LoS criteria and AEC availability on arrival
                      [set nonexpert-true-aec nonexpert-true-aec + 1]                ;; correct aec placement by non-expert
                      [set nonexpert-false-aec nonexpert-false-aec + 1]              ;; incorrect aec placement by non-expert
    ifelse ed = true  [set prev_ed_model prev_ed_model + 1
                       set ed-total ed-total + 1]                                    ;; identify model prevalence for PPV NPV calculation
                      [set prev_noned_model prev_noned_model + 1
                       set noned-total noned-total + 1]                              ;; model totals for patients in each area
    ]

    set los ([los] of self * minutes-per-tick)                                       ;; los in amu area as mins
    set delayed ([delayed] of self * minutes-per-tick)
;    set time_in_system([time_in_system] of self * minutes-per-tick)                  ;; time spent in urgent care system (from time of referral) in mins
    set time-variables lput
    (list label los delayed hrqol) time-variables                     ;; separate csv file for analysis as needed
;    set departure-times lput
;    (list label time:show tick-datetime "EEEE dd-MM-yyy HH:mm") departure-times     ;; departure-times collected for verification as needed
    die
  ]

if label = "H" and AEC-ok? = false[
    set label "AMUH"
    ifelse expert-dm = true
    [
    ifelse los <= ticks-per-hour * 10 and aec-possible = true                        ;; meet LoS (10 hrs0 criteria and AEC availability on arrival
                      [set expert-false-amu expert-false-amu + 1]                    ;; incorrect amu placement by expert
                      [set expert-true-amu expert-true-amu + 1]                      ;; correct amu placement by expert
    ]
    [
    ifelse los <= ticks-per-hour * 10 and aec-possible = true                        ;; meet LoS (10 hrs0 criteria and AEC availability on arrival
                      [set nonexpert-false-amu nonexpert-false-amu + 1]              ;; incorrect amu placement by non-expert
                      [set nonexpert-true-amu nonexpert-true-amu + 1]                ;; correct amu placement by non-expert
    ]

    set los ([los] of self * minutes-per-tick)                                        ;; los in amu area as mins
    set delayed ([delayed] of self * minutes-per-tick)
;    set time_in_system([time_in_system] of self * minutes-per-tick)                   ;; time spent in urgent care system (from time of referral) in mins
    set time-variables lput
    (list label los delayed hrqol) time-variables                      ;; separate csv file for analysis as needed
;    set departure-times lput
;    (list label time:show tick-datetime "EEEE dd-MM-yyy HH:mm") departure-times      ;; departure-times collected for verification as needed
    die
  ]

end




;;-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
;;------------------------------ to update -------------------------------------------------------------------------------------------------------------------------------------
;;-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------


to update                             ;; updates historical agent-sets, timing of aec extra-time for discharge, and relevant reporters


if ticks = 0 [stop]

if ticks = peak-start [
                       start-peak]

ifelse ticks <= week * 2 [                                                       ;; don't store data for the first two weeks of model run but make sure values are set at 0
    if ticks mod whole-day = 0 [
      set AECs 0                                                                  ;; reset to calcuate for this day
      set AMUs 0
      set amu-discharges 0
      set aec-discharges 0
      set aec_complete_today 0
      set amu_complete_today 0
      set patients_discharged 0
      set patients_discharged_24 0
      set patients_admitted 0
      set exp-daily-aec 0                                                       ;; daily experience for comparison with activity
      set exp-daily-amu 0
      set last-24hrs so-far
      set so-far 0
      set waits-today 0
      set wrong-place 0
      set hrqol-aec 0
      set hrqol-amu 0
      set expert-true-amu 0
      set nonexpert-true-amu 0
      set expert-true-aec 0
      set nonexpert-true-aec 0
      set expert-false-amu 0
      set nonexpert-false-amu 0
      set expert-false-aec 0
      set nonexpert-false-aec 0
      set capacity-moves 0

      ifelse last-24hrs > 65 [set amu-crowding 120][set amu-crowding 110]
      set random-adm-aec 0.1 + random-float 0.301
      set random-discharge-amu 0.075 + random-float 0.126
    ]]

    [
    if ticks mod whole-day = 0 [
    set exp-true-amu expert-true-amu                                            ;; daily taillies for predictive values
    set expert-true-amu 0
    set nonexp-true-amu nonexpert-true-amu
    set nonexpert-true-amu 0
    set exp-true-aec expert-true-aec
    set expert-true-aec 0
    set nonexp-true-aec nonexpert-true-aec
    set nonexpert-true-aec 0
    set exp-false-amu expert-false-amu
    set expert-false-amu 0
    set nonexp-false-amu nonexpert-false-amu
    set nonexpert-false-amu 0
    set exp-false-aec expert-false-aec
    set expert-false-aec 0
    set nonexp-false-aec nonexpert-false-aec
    set nonexpert-false-aec 0
    set capacity-moves-daily capacity-moves
    set capacity-moves 0
if aec_complete_today > 0[                                                      ;; prevent 0 division error if no patients left
        set good-exp-aec precision (exp-daily-aec / aec_complete_today) 3]          ;; collect daily experience in all aec group to correlate with other activity in analysis
if amu_complete_today > 0[                                                      ;; prevent 0 division error if no patients left
        set good-exp-amu precision (exp-daily-amu / amu_complete_today) 3]
    set disch-hrqol-aec hrqol-aec
    set hrqol-aec 0
    set disch-hrqol-amu hrqol-amu
    set hrqol-amu 0
    set exp-daily-aec 0
    set exp-daily-amu 0
    set last-24hrs so-far                                                       ;; measure of yesterdays take to determine how easily patients may transfer early when overcorwding threatened/present
    set so-far 0                                                                ;; reset waits per day
    set waits-24 waits-today                                                    ;; update waits per day for output/behaviour space
    set waits-today 0
    set daily-wrong-place wrong-place                                           ;; tally of patients in the AEC who should be be in AMU
    set wrong-place 0
    set AEC-daily AECs                                                          ;; daily patients for end of day/model calcs in each area
    set AMU-daily AMUs
    set AECs 0                                                                  ;; reset to calcuate for this day
    set AMUs 0
    set amu-complete amu_complete_today
    set aec-complete aec_complete_today
    set AMU-disch amu-discharges
    set AEC-disch aec-discharges
    set amu-discharges 0
    set aec-discharges 0
    set aec_complete_today 0
    set amu_complete_today 0
    set daily-discharge patients_discharged
    set patients_discharged 0
    set daily-discharge-24 patients_discharged_24
    set patients_discharged_24 0
    set daily-admit patients_admitted
    set patients_admitted 0

     set random-adm-aec 0.1 + random-float 0.301
      set random-discharge-amu 0.075 + random-float 0.126
      ifelse last-24hrs > 65 [set amu-crowding 120][set amu-crowding 110]
    ]
    ]





end

;;-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
;;-------------------- HOSPITAL/EXTERNAL SYSTEM INFLUENCES/BEHAVIOURS ---------------------------------------------------------------------------------------------------------
;;-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------


;;------------------------------ to avoid-downstream-pressure --------------------------------------------------------------------------------------------------------------------
;;-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

to avoid-downstream-pressure

if any? patients-on AMU-care[
    ask patients-on AMU-care[
      if for-discharge = false
      [set time_complete time_complete + 2]
    ]
  ]

end
;;------------------------------ to avoid-overnight-moves ---------------------------------------------------------------------------------------------------------------------
;;-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

to avoid-overnight-moves                                                      ;; proceudure to permit transfers and bedded discharges up to certain time then only as overcrowding dictates

let empty-beds-evening count AMU-care with [not any? patients-here]

if (ticks < overnight-transfer-end) and (empty-beds-evening >= sufficient-beds-to-cope-day)[
    if any? patients-on AMU-care[
    ask patients-on AMU-care[
         if any? patients with [for-discharge = false and early-move != true][
        ask patients with [for-discharge = false and early-move != true][
        if time_complete < overnight-end
        [set time_complete overnight-end + ward-round-delay myself]
      ]
  ]]]
  ]

if ticks > overnight-transfer-end[

    if any? patients-on AMU-care[
    ask patients-on AMU-care [
        if any? patients with [for-discharge = false and early-move != true][
          ask patients with [for-discharge = false and early-move != true] [set time_complete overnight-end + ward-round-delay myself]]

        if any? patients with [for-discharge = true and early-move != true and label = "Rx"][
        ask patients with  [for-discharge = true and early-move != true and label = "Rx"][
          if time_complete < overnight-end[
            set shape "car"                                                    ;; identify as for discharge
            set label "DD"
            set time_complete overnight-end + (60 + random-float 300)]]        ;; add delay to leaving once the ward round/daytime starts
    ]
  ]
  ]
  ]
end


;;------------------------------ to redirect ----------------------------------------------------------------------------------------------------------------------------------
;;-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

to redirect                                                                      ;; in extremes of persistent overcrowding this procedure stops the model crashing

  if not any? AMU-care with [not any? patients-here][
    if not any? AEC-care with [not any? patients-here] [
      if not any? waiting-bedded with [not any? patients-here] [
        if not any? waiting-aec with [not any? patients-here][                   ;; if all possible space in the unit is filled
          ask patients-on to-come-in [die]                                       ;; all patients currently expected to-come-in are directed elsehwere in the system

    ]]]]

ifelse occupancy-AMU > amu-crowding or overcrowding-expected = true              ;; local recognition of the need to create capacity and limit/prevent overcrowding
  [system-crowding-reaction]
  [if any? patients with [early-move = true][
   ask patients with [early-move = true] [set early-move false]]                ;; previous overcrowding has been addressed stop further early transfers
   ask patients with [label = "EMD"][
      set label "DD"
      set shape "car"
      set time_complete overnight-end + (60 + random-float 360)]           ;; re-establish status as delayed discharge and set time to leave as before
  ]

end


;;----------------------------------------------------------------------------------------------------------
;;---------------------------------to system-crowding-reaction ---------------------------------------------

to system-crowding-reaction                                                             ;; procedure to replicate automatic system behaviour in extremes of overcrowding

  let waiting-to-move count patients with [early-move = true]

  if any? patients with [shape = "AMU-bed" and label = "Rx"
      and for-discharge = true and (time_complete - ticks) <= (ticks-per-hour * 2)]    ;; those with 4hrs left before discharge are moved to AEC area regardless of time to await home
     [ask n-of 1 patients with
          [shape = "AMU-bed" and label = "Rx" and for-discharge = true and (time_complete - ticks) <= (ticks-per-hour * 2)]
     [if any? AEC-care with [not any? patients-here]
     [move-to one-of AEC-care with [not any? patients-here]
     set shape "AEC-chair"
     set aec-move true ]]]                                                             ;; identify as an AMU-bedded patient transferred to AEC for final discharges tallies

; LIMIT THE NUMBER OF EARLY TRANSFERS
  ifelse waiting-to-move >= 2
  [stop]
  [
  if any? patients with [for-discharge = false and early-move != true
                          and los > (ticks-per-hour * 6)]                              ;; any patients who have been in the area for >=6hrs and for admission longest are transferred downstream
    [ask n-of 1 patients with
      [for-discharge = false and early-move != true and los > (ticks-per-hour * 6)]
      [set time_complete ticks + early-transfer-delay                                   ;; natural delay to creating capacity when early move
       set early-move true
    ] ]                                                          ;; identify as early move to ensure admission not random discharge

  if any? patients with [for-discharge = false and early-move != true
                          and los > (ticks-per-hour * 6)]                              ;; any patients who have been in the area for >=6hrs and for admission longest are transferred downstream
    [ask n-of 1 patients with
      [for-discharge = false and early-move != true and los > (ticks-per-hour * 6)]
      [set time_complete ticks + early-transfer-delay                                   ;; natural delay to creating capacity when early move
       set early-move true
    ] ]                                                          ;; identify as early move to ensure admission not random discharge
  ]

; IF INSUFFICIENT EARLY MOVES IDENTIFIED TO CREATE CAPACITY MOVE PATIENTS FOR DISCHARGE
  ifelse waiting-to-move >= 2
  [stop][move-discharges]

end

;----------------- increase patients to move early as needed

to move-discharges                                                                      ;; procedure to admit patients assumed for discharge but still receieving care to create capacity

 let not-enough-waiting-to-move count patients with [early-move = true]

  if any? patients with
  [for-discharge = true and early-move != true and label = "Rx"
                        and los > (ticks-per-hour * 12)] ;and AEC-ok? = false]           ;; patients who have been in the dept for >12hrs and for discharge are transferred downstream
    [ask n-of 1 patients with                                                            ;; to create capacity
  [for-discharge = true and early-move != true and label = "Rx"
                        and los > (ticks-per-hour * 12)]; and AEC-ok? = false ]
      [ set for-discharge false
        set time_complete ticks + early-transfer-delay                                   ;; natural delay to creating capacity when early move
        set early-move true
]]

; CHECK IF SUFFICIENT EARLY MOVES IDENTIFIED
ifelse not-enough-waiting-to-move >= 2 [stop][move-delayed-discharges]

end

;----------------- increase patients to move early as needed

to move-delayed-discharges                                                              ;; procedure to admit patients for discharge who have completed care to create capacity

  if any? patients with [label = "DD" and early-move != true and aec-move != true]      ;; ensure no patients who have already been ear-marked for admission
  [ask n-of 1 patients with [label = "DD" and early-move != true and aec-move != true]
    [set shape "AMU-bed"
     set for-discharge false
     set time_complete ticks + early-transfer-delay                                     ;; natural delay to creating capacity when early move
     set early-move true
      set label "EMD"]                                                                   ;; identify as discharge admitted incase this is changed back when overcrowding cleared
  ]


end

;;------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
;;------------------------ to collect-patient-data for end of run list outputs -------------------------------------------------------------------------------------------------

to collect-patient-data


   csv:to-file (word "time-variables" random-float 100 ".csv") time-variables  ;; collect patient variables in csv file for each run
;   csv:to-file (word "arrival-times" random-float 100 ".csv") arrival-times
;   csv:to-file (word "departure-times" random-float 100 ".csv") departure-times
;   csv:to-file (word "alloc-distributions" random-float 100 ".csv") alloc-distributions

end

;;------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
;;------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
;;------------------------------- REPORTERS ------------------------------------------------------------------------------------------------------------------------------------
;;------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

to-report AEC-duration

  let duration Close_AEC - Open_AEC

  if duration <= 0 [report ((24 - Open_AEC + Close_AEC) * ticks-per-hour)]
  if duration > 0 [report ((Close_AEC - Open_AEC) * ticks-per-hour)]

end


to-report duration-peak

  let duration-p Peak_ends - Peak_begins

  if duration-p <= 0 [report ((24 - Peak_begins + Peak_ends) * ticks-per-hour)]
  if duration-p > 0 [report ((Peak_ends - Peak_begins) * ticks-per-hour)]

end

;;---------------------------------------------------

to-report offpeak-eds

report (1 - (peak-demand * 0.5)) * off-peak-split

end

;to-report offpeak-noneds

;report (1 - (peak-demand * 0.5)) * (1 - off-peak-split)

;end

to-report peak-eds

report peak-demand * peak-split

end

to-report peak-noneds

report peak-demand * (1 - peak-split)

end

;; --------------------------------------------------

to-report returns                                                                    ;; random return AEC attendances

 report 3 + precision random-float 5 1

end

;;---------------------------------------------------

to-report overcrowding

 let cr count patients-on waiting-bedded
 let vacant count AMU-care with [not any? patients-here] + 0.00000001  ;avoid division by zero
 let expect count patients with [label = "QAMU"]


 ifelse cr >= max-ip-waits or
         expect > max-expects-trigger or
  expect / vacant > 3 [report true][report false]



;  ifelse cr >= max-ip-waits [report true]
;  [ifelse expect >= max-expects-trigger [report true]
;    [if expect < max-expects-trigger [report false]
;     if expect / vacant >= 2 [report true]]
;  ]

end

;;---------------------------------------------------

to-report capacity-threshold-low                                                       ;; reports the ratio of expected to empty bedded resources that triggers early move to create capacity

 report  10 ;8 + precision random-float 3.1 1

end

;----------------------------------------------------

to-report capacity-threshold-high                                                       ;; reports the ratio of expected to empty bedded resources that triggers early move to create capacity

 report  10 ;8 + precision random-float 3.1 1

end

;----------------------------------------------------

to-report early-transfer-delay                                                     ;; report a random model exit time for patients transferred early to prevent all moves at once

 if last-24hrs >= 65 or so-far >= 65
    [report floor 60 + random-float 60]

 if last-24hrs < 65 or so-far < 65
    [report floor 10 + random-float 60]

end
;----------------------------------------------------

to-report sufficient-amu-beds                                                       ;; report the acceptable free-capacity overnight to prevent unnecessary patient moves out of hours

let available count AMU-care with [not any? patients-here]
ifelse  aec-available = false [
    ifelse available >= sufficient-beds-to-cope-night [report true][report false]]
[
    ifelse available >= sufficient-beds-to-cope-day [report true][report false]]

end
;;---------------------------------------------------

to-report overcrowding-expected

 let empty count AMU-care with [not any? patients-here]
 if empty = 0 [set empty 1] ; prevent division by 0
 let expect count patients with [label = "QAMU"]

  ifelse expect / empty >= expected-to-current-capacity-ratio [report true][report false]

end


;;---------------------------------------------------
to-report AEC     [a-patient]                                                        ;; reports suitability for AEC in this location according to DM

  let patient-condition (condition)                                                  ;; uses patient condition probability determined on arrival
  let pop-prev noned-aec-prev                                                        ;; assume pop-prev is for non-ed unless patient is from ed
  if ed = true [set pop-prev ed-aec-prev]

  let AEC-yes (patient-condition <= expert-adjust-local * pop-prev)                  ;; if the patient condition meets their threshold for AEC then they allocate
  report AEC-yes

end


;;----------------------------------------------------

to-report modified-AEC     [a-patient]                                               ;; reports suitability for AEC when department is crowded according to DM authority/expertise

  let patient-condition (condition)                                                  ;; uses patient condition probability determined on arrival
  let pop-prev noned-aec-prev                                                        ;; assume pop-prev is for non-ed unless patient is from ed
  if ed = true [set pop-prev ed-aec-prev]

  let AEC-yes (patient-condition <=
    ((expert-adjust-local + high-risk-adjust) * pop-prev))                           ;; if the patient condition meets their threshold + overcrowding adjust then they allocate

  report AEC-yes
end


;;----------------------------------------------------

to-report arrival_time_comm     [a-patient]                                          ;; delays to arrival when coming to the unit from home


  ifelse AEC-ok? = true
 [let transport-in floor random-gamma 2 0.045
  while [transport-in < 0] [set transport-in floor random-gamma 2 0.045]
    report (transport-in + time_referred)]
 [
  ifelse ticks = overnight-start
  [let transport-in floor random-gamma 11 0.08
  while [transport-in < 5] [set transport-in floor floor random-gamma 11 0.08]
      report (transport-in + time_referred)]
  [let transport-in floor random-gamma 6 0.06
  while [transport-in < 5] [set transport-in floor floor random-gamma 6 0.06]
      report (transport-in + time_referred)]
  ]

end

;;----------------------------------------------------

to-report arrival_time_ed     [a-patient]                                               ;; delays to arrival when coming to the unit from ed (quicker)

ifelse peak = true[                                                         ;; arrive faster from ED overnight to rlect reduction in arrivals after mid-overnight period
 let ed-delay floor random-normal 90 45
  while [ed-delay < 0][set ed-delay floor random-normal 90 45]
    report (ed-delay + time_referred)]
  [
 let ed-delay floor random-normal 60 30
   while [ed-delay < 0][set ed-delay floor random-normal 60 30]
    report (ed-delay + time_referred)
  ]

end


;;----------------------------------------------------

to-report aec-prevalence    [a-patient]                                                  ;; reports prevalence for population to determine probability of discharge

 ifelse ed = true [report ed-aec-prev][report noned-aec-prev]

end

;;--------------- AEC-dis Treatment time ---------------------

to-report AEC_dis_treatment_time [a-patient];; gamma dist                                ;; reports treatment time for patients in AEC

  let los-AEC-dis ceiling (random-gamma 4.5 0.02)
;  while [los-AEC-dis < ticks-per-hour * 1]
;  [set los-AEC-dis ceiling (random-gamma 4.5 0.02)]

  report los-AEC-dis

end

;;--------------- AEC-adm Treatment time ---------------------

to-report AEC_adm_treatment_time [a-patient];; gamma dist                                ;; reports treatment time for patients in AEC

  let los-AEC-adm ceiling (random-gamma 24 0.04)                                        ;;
;  while [los-AEC-adm < ticks-per-hour * 0.5]
;  [set los-AEC-adm ceiling (random-gamma 3.0 0.008)]

  report los-AEC-adm

end

;;--------------- AMU-dis Treatment time ---------------------

to-report AMU_dis_treatment_time [a-patient]; gamma dist                                 ;; reports treatment time for patients in AMU

  let los-AMU-dis ceiling (random-gamma 24 0.04)                                        ;;
;  while [los-AEC-adm < ticks-per-hour * 0.5]
;  [set los-AEC-adm ceiling (random-gamma 3.0 0.008)]

  report los-AMU-dis
end


;;-------------  AMU-adm Treatment time  --------------------

to-report AMU_adm_treatment_time [a-patient]; gamma dist                                 ;; reports treatment time for patients in AMU

  let los-AMU-adm ceiling (random-gamma 3 0.008)                                      ;; values based on snapshot data to estimate mean & variance
;  while [los-AMU-adm < ticks-per-hour * 3]
;    [set los-AMU-adm ceiling (random-gamma 15  0.03)]

  report los-AMU-adm

end

;;---------------------------------------------------

to-report ward-round-delay [a-patient]

let delay-wr floor random-normal 300 180
  while [delay-wr < 60][set delay-wr floor random-normal 300 180]

  report delay-wr

end

;;---------------------------------------------------

to-report time_completed [a-patient]                                                     ;; reports time/ticks when patient will be ready to move

  if delayed < 0 [set delayed 0]

report (floor treatment_time + treatment_started - delayed)                              ;; rounded down for ease of model. Delay time removed as treatment time estimated from dataset
                                                                                         ;; length of stay which includes the delay. For output comparison los includes modelled delay
end


;;---------------------------------------------------

to-report final-decision [a-patient]                                                     ;; identify 10% of patients whose disposal plan will unexpectedly change

report random-float 1

end


;;------------------------------ to report patient outcomes ---------------------------------------------
;;-----------------------------------------------------------------------------------------------------------

to-report record-experience [a-patient]

let x 1

if AEC-ok? = false and delayed >= ticks-per-hour [set x 0]
if AEC-ok? = true and los >= (ticks-per-hour * 8) [set x 0]
if delayed >= (ticks-per-hour * 4) [set x 0]

report x

end

to-report hrqol-me        [a-patient]

  if AEC-ok? = true [report precision random-normal 0.068 0.117 3]
  if AEC-ok? = false [report precision random-normal 0.111 0.131 3]

end





;;--------------------------------------------------------------------------------------------------------------------------------------------------------------------------
;;------------------------------- output & behaviour space reporters -------------------------------------------------------------------------------------------------------
;;--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


to-report occupancy-AMU
  let capacity-amu count(AMU-care)
  let a (count patients-on AMU-care)
  let x (count patients-on waiting-bedded)
  report ((a + x)/ capacity-amu) * 100

end

to-report occupancy-total
  let cap-total (count(AMU-care) + count(AEC-care))
  let b (count patients-on AMU-care)
  let y (count patients-on waiting-bedded)
  let w (count patients-on AEC-care)
  let z (count patients-on waiting-aec)
  report ((b + y + w + z) / cap-total) * 100

end

to-report occupancy-AEC
  let capacity-aec count(AEC-care)
  let c (count patients-on AEC-care)
  let d (count patients-on waiting-aec)
  report ((c + d) / capacity-aec) * 100

end



to-report total-admissions

  report (sum[patients_admitted] of patches)

end

to-report system-failure-events

  report (sum [system-failure] of patches)

end


to-report p-waiting

report (count patients with [label = "D"])

end

to-report delayed-care-waiting    ;report delayed care for bedded area waiting only as this reflects porr experience but aec will wait

;  let d-aec median [los] of patients-on waiting-aec
  let d-bedded median [los] of patients-on waiting-bedded

 report (d-bedded * minutes-per-tick)

end
@#$#@#$#@
GRAPHICS-WINDOW
419
50
937
569
-1
-1
22.2
1
10
1
1
1
0
0
0
1
-11
11
-11
11
0
0
1
5 minutes
1.0

BUTTON
74
48
405
81
INITIATE MODEL SET-UP
setup
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

BUTTON
943
49
1337
83
START/STOP MODEL
go
T
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

PLOT
943
321
1343
450
Daily waits >5mins 
Model time (5 minute intervals)
No. waiting
0.0
10.0
0.0
10.0
true
false
"" ""
PENS
"default" 1.0 0 -16777216 true "" "plot waits-24"

OUTPUT
423
44
647
89
13

BUTTON
76
544
220
588
Shift Experts 
allocate-expert  
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

BUTTON
77
643
221
689
Shift Trainee Experts 
allocate-trainee-shift
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

MONITOR
1269
451
1345
496
Syst. failures
system-failure-events
17
1
11

PLOT
941
107
1339
290
Occupancy
NIL
NIL
0.0
10.0
0.0
10.0
true
true
"" ""
PENS
"AMU" 1.0 0 -13345367 true "" "plot occupancy-AMU"
"AEC" 1.0 0 -7858858 true "" "plot occupancy-AEC"
"Departmental occupancy" 1.0 0 -16777216 true "" "plot occupancy-total"
"100% occupancy" 1.0 0 -14439633 true "" "plot 100 "

MONITOR
826
434
876
479
BED
count patients with [label = \"QAMU\"]
17
1
11

MONITOR
881
434
931
479
AAA
count patients with [label = \"QAEC\"]
17
1
11

INPUTBOX
76
434
151
494
ExpertStart
9.0
1
0
Number

INPUTBOX
154
435
228
495
ExpertEnd
20.0
1
0
Number

INPUTBOX
229
435
321
495
TraineeExpStart
20.0
1
0
Number

INPUTBOX
323
435
414
495
TraineeExpEnd
9.0
1
0
Number

BUTTON
77
599
221
643
Fulltime Trainee
allocate-trainee-fulltime 
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

BUTTON
75
323
220
368
Fulltime Charge Nurse
allocate-senior-nurse
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

MONITOR
1188
452
1269
497
Calls queueing
count patients with [label = \"call waiting\"]
17
1
11

MONITOR
825
478
931
523
Referrals so far
so-far
17
1
11

SLIDER
75
171
407
204
Mean_weekday_attendances
Mean_weekday_attendances
0
100
45.0
1
1
Patients
HORIZONTAL

SLIDER
75
101
237
134
Open_AEC
Open_AEC
0
12
8.0
1
1
:00hrs
HORIZONTAL

SLIDER
240
100
406
133
Close_AEC
Close_AEC
1
24
23.0
1
1
:00hrs
HORIZONTAL

SLIDER
74
136
237
169
Peak_begins
Peak_begins
0
24
10.0
1
1
:00hrs
HORIZONTAL

SLIDER
240
136
406
169
Peak_ends
Peak_ends
0
24
18.0
1
1
:00hrs
HORIZONTAL

BUTTON
511
611
846
658
SET PARAMETERS
 set aec-returns-start Open_AEC * ticks-per-hour   \n set aec-clinic Open_AEC * ticks-per-hour\n set peak-start Peak_begins * ticks-per-hour  \n set peak-end Peak_ends * ticks-per-hour      \n set peak-duration duration-peak  \n set overnight-start Close_AEC * ticks-per-hour  \n set overnight-end Open_AEC * ticks-per-hour  \n set overnight-duration whole-day - (AEC-duration) \n set expert-shift-starts (ExpertStart * ticks-per-hour)   \n set expert-shift-ends (ExpertEnd * ticks-per-hour) \n set trainee-exp-shift-starts (TraineeExpStart * ticks-per-hour)    \n set trainee-exp-shift-ends (TraineeExpEnd * ticks-per-hour)        \n; user-message \"Time & system parameters set\"\n ;user-message \"If you wish to change parameters please re-initiate model set-up\"\n 
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

SLIDER
75
208
408
241
Mean_weekend_attendances
Mean_weekend_attendances
0
100
35.0
1
1
Patients
HORIZONTAL

MONITOR
1006
453
1099
498
Moved overnight
capacity-moves-daily
17
1
11

MONITOR
941
453
1008
498
IPs in AAA
wrong-place
17
1
11

SLIDER
77
398
231
431
expert-rota-staffing
expert-rota-staffing
5
50
15.0
1
1
NIL
HORIZONTAL

SLIDER
232
399
413
432
trainee-rota-staffing
trainee-rota-staffing
0
100
31.0
1
1
NIL
HORIZONTAL

SLIDER
75
267
241
300
noned-aec-prev
noned-aec-prev
0.1
0.5
0.223
0.001
1
NIL
HORIZONTAL

SLIDER
242
267
406
300
ed-aec-prev
ed-aec-prev
0
0.3
0.067
0.001
1
NIL
HORIZONTAL

SLIDER
945
614
1087
647
expert-adj-con
expert-adj-con
0.7
2.0
1.2
0.001
1
NIL
HORIZONTAL

SLIDER
1088
614
1232
647
expert-adj-trainee
expert-adj-trainee
0.2
2.0
0.0
0.001
1
NIL
HORIZONTAL

SLIDER
1233
613
1364
646
expert-adj-sn
expert-adj-sn
0.0
1.0
0.101
0.001
1
NIL
HORIZONTAL

MONITOR
1099
452
1188
497
Non-attendance
refused
17
1
11

BUTTON
76
497
219
545
 Full-time Experts 
allocate-expert-fulltime
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

TEXTBOX
90
382
422
400
Medical staff number and shift change times if including in model
11
0.0
1

TEXTBOX
84
84
452
114
Set demand activity and urgent clinic (AEC) opening/closing times
11
0.0
1

TEXTBOX
222
501
412
543
24hr expert model - shifts as above. Allocates all non-ED referrals. Will allocate all ED if no other staff present
11
0.0
1

TEXTBOX
163
305
473
323
Choose staffing configurations
12
0.0
1

TEXTBOX
222
552
408
594
Expert allocations between start & end shift times only
11
0.0
1

TEXTBOX
225
608
456
664
24hr trainee model- allocate non-ED referrals. Will allocate all ED patients if no nursing working
11
0.0
1

TEXTBOX
225
326
517
344
Nursing staff take all ED referrals 
11
0.0
1

TEXTBOX
225
339
410
373
Will also allocate all non-ED referrals if no other staff group created
11
0.0
1

TEXTBOX
977
88
1311
118
Real-time modelled outputs(only stored to csv. file if coded)
12
0.0
1

TEXTBOX
83
249
412
267
Prevalence of out-patient suitability in non-ED and ED populations
11
0.0
1

TEXTBOX
950
571
1380
613
Mean expertise in out-patient suitability recognition. This adjusts the mean of distr. parameters for expertise. When multiplied by aec-prevalence it provides the mean proportion of patients allocated to out-patient care (advise do not adjust)
11
0.0
1

TEXTBOX
224
647
423
703
Trainees allocating between start & end shifts only validated for use with experts/nurses combination
11
0.0
1

TEXTBOX
940
304
1354
346
Note: Daily waits >5mins is not set to store data until after a 2-week warm-up period 
11
14.0
1

@#$#@#$#@


































 
@#$#@#$#@
default
true
0
Polygon -7500403 true true 150 5 40 250 150 205 260 250

admin
false
0
Rectangle -1 true false 120 90 180 180
Polygon -16777216 true false 120 90 105 90 60 195 90 210 116 154 120 195 90 285 105 300 135 300 150 225 165 300 195 300 210 285 180 195 183 153 210 210 240 195 195 90 180 90 150 165
Circle -7500403 true true 110 5 80
Rectangle -7500403 true true 127 76 172 91
Polygon -14835848 true false 165 180 195 226 270 210 240 150
Line -16777216 false 180 90 150 165
Line -16777216 false 120 90 150 165
Line -16777216 false 210 180 225 210
Line -16777216 false 195 180 210 210
Line -16777216 false 225 180 240 210

aec-chair
false
10
Rectangle -11221820 true false 30 75 90 255
Rectangle -11221820 true false 90 165 210 225
Rectangle -11221820 true false 165 165 210 255
Circle -13345367 true true 90 15 60
Rectangle -13345367 true true 90 75 150 165
Rectangle -13345367 true true 150 135 240 165
Rectangle -13345367 true true 210 165 240 255
Rectangle -13345367 true true 240 240 255 255

airplane
true
0
Polygon -7500403 true true 150 0 135 15 120 60 120 105 15 165 15 195 120 180 135 240 105 270 120 285 150 270 180 285 210 270 165 240 180 180 285 195 285 165 180 105 180 60 165 15

amu-bed
false
9
Rectangle -1 true false 0 135 285 240
Polygon -1 true false 15 30 15 30 75 135 0 135 0 30 15 30
Circle -13791810 true true 30 0 90
Rectangle -13791810 true true 75 75 195 135
Rectangle -13791810 true true 255 90 285 135
Rectangle -13791810 true true 195 105 255 135
Rectangle -1 true false 270 255 285 285
Rectangle -1 true false 0 240 15 285
Rectangle -11221820 true false 150 135 285 255
Line -16777216 false 75 135 0 135

anp_st3
false
0
Polygon -7500403 true true 105 90 120 195 90 285 105 300 135 300 150 225 165 300 195 300 210 285 180 195 195 90
Polygon -7500403 true true 105 90 60 195 90 210 135 105
Polygon -7500403 true true 195 90 240 195 210 210 165 105
Circle -7500403 true true 110 5 80
Rectangle -7500403 true true 127 79 172 94
Polygon -13345367 true false 105 90 60 195 90 210 114 156 120 195 90 270 210 270 180 195 186 155 210 210 240 195 195 90 165 90 150 150 135 90
Line -16777216 false 150 148 150 270
Line -16777216 false 150 195 165 195
Line -16777216 false 150 240 165 240
Line -16777216 false 150 150 165 150
Line -2674135 false 120 90 135 135
Line -2674135 false 180 90 135 135
Line -2674135 false 135 135 135 165
Circle -1 true false 120 165 30

arrow
true
0
Polygon -7500403 true true 150 0 0 150 105 150 105 293 195 293 195 150 300 150

box
false
0
Polygon -7500403 true true 150 285 285 225 285 75 150 135
Polygon -7500403 true true 150 135 15 75 150 15 285 75
Polygon -7500403 true true 15 75 15 225 150 285 150 135
Line -16777216 false 150 285 150 135
Line -16777216 false 150 135 15 75
Line -16777216 false 150 135 285 75

bug
true
0
Circle -7500403 true true 96 182 108
Circle -7500403 true true 110 127 80
Circle -7500403 true true 110 75 80
Line -7500403 true 150 100 80 30
Line -7500403 true 150 100 220 30

butterfly
true
0
Polygon -7500403 true true 150 165 209 199 225 225 225 255 195 270 165 255 150 240
Polygon -7500403 true true 150 165 89 198 75 225 75 255 105 270 135 255 150 240
Polygon -7500403 true true 139 148 100 105 55 90 25 90 10 105 10 135 25 180 40 195 85 194 139 163
Polygon -7500403 true true 162 150 200 105 245 90 275 90 290 105 290 135 275 180 260 195 215 195 162 165
Polygon -16777216 true false 150 255 135 225 120 150 135 120 150 105 165 120 180 150 165 225
Circle -16777216 true false 135 90 30
Line -16777216 false 150 105 195 60
Line -16777216 false 150 105 105 60

car
false
0
Polygon -2674135 true false 300 180 279 164 261 144 240 135 226 132 213 106 203 84 185 63 159 50 135 50 75 60 0 150 0 165 0 225 300 225 300 180
Circle -16777216 true false 180 180 90
Circle -16777216 true false 30 180 90
Polygon -16777216 true false 162 80 132 78 134 135 209 135 194 105 189 96 180 89
Circle -7500403 true true 47 195 58
Circle -7500403 true true 195 195 58

charge nurse
false
9
Polygon -7500403 true false 105 90 120 195 90 285 105 300 135 300 150 225 165 300 195 300 210 285 180 195 195 90
Polygon -7500403 true false 105 90 60 195 90 210 135 105
Polygon -7500403 true false 195 90 240 195 210 210 165 105
Circle -7500403 true false 110 5 80
Rectangle -7500403 true false 127 79 172 94
Polygon -13345367 true false 105 90 60 195 90 210 114 156 120 195 90 270 210 270 180 195 186 155 210 210 240 195 195 90 165 90 150 150 135 90
Line -16777216 false 150 148 150 270
Line -16777216 false 150 195 165 195
Line -16777216 false 150 240 165 240
Line -16777216 false 150 150 165 150
Polygon -13345367 true false 120 90 135 150 120 90
Polygon -2674135 true false 120 90 120 90 135 150 150 150 135 90
Polygon -2674135 true false 180 90 165 90 150 150 165 150 180 90

circle
false
0
Circle -7500403 true true 0 0 300

circle 2
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240

cons
false
0
Polygon -7500403 true true 105 90 120 195 90 285 105 300 135 300 150 225 165 300 195 300 210 285 180 195 195 90
Polygon -7500403 true true 105 90 60 195 90 210 135 105
Polygon -7500403 true true 195 90 240 195 210 210 165 105
Circle -7500403 true true 110 5 80
Rectangle -7500403 true true 127 79 172 94
Polygon -1 true false 105 90 60 195 90 210 114 156 120 195 90 270 210 270 180 195 186 155 210 210 240 195 195 90 165 90 150 150 135 90
Line -16777216 false 150 148 150 270
Line -16777216 false 150 195 165 195
Line -16777216 false 150 240 165 240
Line -16777216 false 150 150 165 150
Line -2674135 false 150 135 135 165
Circle -7500403 true true 120 165 30
Line -2674135 false 150 135 120 90
Line -2674135 false 150 135 180 90

cow
false
0
Polygon -7500403 true true 200 193 197 249 179 249 177 196 166 187 140 189 93 191 78 179 72 211 49 209 48 181 37 149 25 120 25 89 45 72 103 84 179 75 198 76 252 64 272 81 293 103 285 121 255 121 242 118 224 167
Polygon -7500403 true true 73 210 86 251 62 249 48 208
Polygon -7500403 true true 25 114 16 195 9 204 23 213 25 200 39 123

cylinder
false
0
Circle -7500403 true true 0 0 300

dot
false
0
Circle -7500403 true true 90 90 120

face happy
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 255 90 239 62 213 47 191 67 179 90 203 109 218 150 225 192 218 210 203 227 181 251 194 236 217 212 240

face neutral
false
0
Circle -7500403 true true 8 7 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Rectangle -16777216 true false 60 195 240 225

face sad
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 168 90 184 62 210 47 232 67 244 90 220 109 205 150 198 192 205 210 220 227 242 251 229 236 206 212 183

fish
false
0
Polygon -1 true false 44 131 21 87 15 86 0 120 15 150 0 180 13 214 20 212 45 166
Polygon -1 true false 135 195 119 235 95 218 76 210 46 204 60 165
Polygon -1 true false 75 45 83 77 71 103 86 114 166 78 135 60
Polygon -7500403 true true 30 136 151 77 226 81 280 119 292 146 292 160 287 170 270 195 195 210 151 212 30 166
Circle -16777216 true false 215 106 30

flag
false
0
Rectangle -7500403 true true 60 15 75 300
Polygon -7500403 true true 90 150 270 90 90 30
Line -7500403 true 75 135 90 135
Line -7500403 true 75 45 90 45

flower
false
0
Polygon -10899396 true false 135 120 165 165 180 210 180 240 150 300 165 300 195 240 195 195 165 135
Circle -7500403 true true 85 132 38
Circle -7500403 true true 130 147 38
Circle -7500403 true true 192 85 38
Circle -7500403 true true 85 40 38
Circle -7500403 true true 177 40 38
Circle -7500403 true true 177 132 38
Circle -7500403 true true 70 85 38
Circle -7500403 true true 130 25 38
Circle -7500403 true true 96 51 108
Circle -16777216 true false 113 68 74
Polygon -10899396 true false 189 233 219 188 249 173 279 188 234 218
Polygon -10899396 true false 180 255 150 210 105 210 75 240 135 240

home-car
false
0
Polygon -2674135 true false 300 180 279 164 261 144 240 135 226 132 213 106 203 84 185 63 159 50 135 50 75 60 0 150 0 165 0 225 300 225 300 180
Circle -16777216 true false 180 180 90
Circle -16777216 true false 30 180 90
Polygon -16777216 true false 162 80 132 78 134 135 209 135 194 105 189 96 180 89
Circle -7500403 true true 47 195 58
Circle -7500403 true true 195 195 58
Circle -6459832 true false 135 90 30
Polygon -13791810 true false 135 135 150 120 180 135

hospital
false
0
Rectangle -13791810 true false 30 120 255 285
Rectangle -6459832 true false 105 210 180 285
Line -16777216 false 30 120 270 120
Rectangle -13791810 true false 30 0 255 120
Rectangle -16777216 true false 60 15 75 45
Rectangle -1 true false 45 15 90 45
Rectangle -1 true false 195 240 240 270
Rectangle -1 true false 45 240 90 270
Rectangle -1 true false 45 60 90 90
Rectangle -1 true false 105 60 180 90
Rectangle -1 true false 45 150 90 180
Rectangle -1 true false 105 105 180 135
Rectangle -1 true false 45 105 90 135
Rectangle -1 true false 45 195 90 225
Rectangle -1 true false 195 60 240 90
Rectangle -1 true false 195 105 240 135
Rectangle -1 true false 105 150 180 180
Rectangle -1 true false 195 150 240 180
Rectangle -1 true false 195 15 240 45
Rectangle -1 true false 195 195 240 225
Rectangle -2674135 true false 135 15 150 60
Rectangle -2674135 true false 120 30 165 45

house two story
false
0
Polygon -16777216 true false 2 180 227 180 152 150 32 150
Rectangle -6459832 true false 270 75 285 255
Rectangle -6459832 true false 75 135 270 255
Rectangle -2674135 true false 124 195 187 256
Rectangle -1 true false 210 195 255 240
Rectangle -1 true false 90 150 135 180
Rectangle -1 true false 210 150 255 180
Line -16777216 false 270 135 270 255
Rectangle -6459832 true false 15 180 75 255
Polygon -16777216 true false 60 135 285 135 240 90 105 90
Line -16777216 false 75 135 75 180
Rectangle -1 true false 30 195 93 240
Line -16777216 false 60 135 285 135
Line -16777216 false 255 105 285 135
Line -16777216 false 0 180 75 180
Line -16777216 false 60 195 60 240
Line -16777216 false 154 195 154 255

leaf
false
0
Polygon -7500403 true true 150 210 135 195 120 210 60 210 30 195 60 180 60 165 15 135 30 120 15 105 40 104 45 90 60 90 90 105 105 120 120 120 105 60 120 60 135 30 150 15 165 30 180 60 195 60 180 120 195 120 210 105 240 90 255 90 263 104 285 105 270 120 285 135 240 165 240 180 270 195 240 210 180 210 165 195
Polygon -7500403 true true 135 195 135 240 120 255 105 255 105 285 135 285 165 240 165 195

line
true
0
Line -7500403 true 150 0 150 300

line half
true
0
Line -7500403 true 150 0 150 150

nurse-doctor
false
0
Polygon -7500403 true true 105 90 120 195 90 285 105 300 135 300 150 225 165 300 195 300 210 285 180 195 195 90
Polygon -7500403 true true 105 90 60 195 90 210 135 105
Polygon -7500403 true true 195 90 240 195 210 210 165 105
Circle -7500403 true true 110 5 80
Rectangle -7500403 true true 127 79 172 94
Polygon -13791810 true false 105 90 60 195 90 210 114 156 120 195 90 270 210 270 180 195 186 155 210 210 240 195 195 90 165 90 150 150 135 90
Line -16777216 false 150 148 150 270
Line -16777216 false 196 90 151 149
Line -16777216 false 104 90 149 149
Line -16777216 false 150 195 165 195
Line -16777216 false 150 240 165 240
Line -16777216 false 150 150 165 150

patient
false
0
Rectangle -7500403 true true 90 135 285 180
Polygon -7500403 true true 105 90 105 90 135 135 90 135 90 90 105 90
Circle -13791810 true false 99 69 42
Rectangle -13791810 true false 135 105 210 135
Rectangle -13791810 true false 255 90 270 135
Rectangle -13791810 true false 210 120 255 135
Circle -16777216 true false 219 174 42
Circle -16777216 true false 114 174 42
Circle -6459832 true false 39 39 42
Rectangle -11221820 true false 45 75 75 150
Rectangle -11221820 true false 75 105 105 120
Rectangle -11221820 true false 60 150 75 195
Rectangle -11221820 true false 45 150 60 195
Line -16777216 false 60 195 60 150
Rectangle -16777216 true false 60 195 90 210
Rectangle -16777216 true false 45 195 60 210

pentagon
false
0
Polygon -7500403 true true 150 15 15 120 60 285 240 285 285 120

person
false
0
Circle -7500403 true true 110 5 80
Polygon -7500403 true true 105 90 120 195 90 285 105 300 135 300 150 225 165 300 195 300 210 285 180 195 195 90
Rectangle -7500403 true true 127 79 172 94
Polygon -7500403 true true 195 90 240 150 225 180 165 105
Polygon -7500403 true true 105 90 60 150 75 180 135 105

plant
false
0
Rectangle -7500403 true true 135 90 165 300
Polygon -7500403 true true 135 255 90 210 45 195 75 255 135 285
Polygon -7500403 true true 165 255 210 210 255 195 225 255 165 285
Polygon -7500403 true true 135 180 90 135 45 120 75 180 135 210
Polygon -7500403 true true 165 180 165 210 225 180 255 120 210 135
Polygon -7500403 true true 135 105 90 60 45 45 75 105 135 135
Polygon -7500403 true true 165 105 165 135 225 105 255 45 210 60
Polygon -7500403 true true 135 90 120 45 150 15 180 45 165 90

sheep
false
15
Circle -1 true true 203 65 88
Circle -1 true true 70 65 162
Circle -1 true true 150 105 120
Polygon -7500403 true false 218 120 240 165 255 165 278 120
Circle -7500403 true false 214 72 67
Rectangle -1 true true 164 223 179 298
Polygon -1 true true 45 285 30 285 30 240 15 195 45 210
Circle -1 true true 3 83 150
Rectangle -1 true true 65 221 80 296
Polygon -1 true true 195 285 210 285 210 240 240 210 195 210
Polygon -7500403 true false 276 85 285 105 302 99 294 83
Polygon -7500403 true false 219 85 210 105 193 99 201 83

square
false
0
Rectangle -7500403 true true 30 30 270 270

square 2
false
0
Rectangle -7500403 true true 30 30 270 270
Rectangle -16777216 true false 60 60 240 240

star
false
0
Polygon -7500403 true true 151 1 185 108 298 108 207 175 242 282 151 216 59 282 94 175 3 108 116 108

target
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240
Circle -7500403 true true 60 60 180
Circle -16777216 true false 90 90 120
Circle -7500403 true true 120 120 60

telephone
false
0
Polygon -7500403 true true 75 273 60 255 60 195 84 165 75 165 45 150 45 120 60 90 105 75 195 75 240 90 255 120 255 150 223 165 215 165 240 195 240 255 226 274
Polygon -16777216 false false 75 273 60 255 60 195 105 135 105 120 105 105 120 105 120 120 180 120 180 105 195 105 195 135 240 195 240 255 225 273
Polygon -16777216 false false 81 165 74 165 44 150 44 120 59 90 104 75 194 75 239 90 254 120 254 150 218 167 194 135 194 105 179 105 179 120 119 120 119 105 104 105 104 135 81 166 78 165
Rectangle -16777216 false false 120 165 135 180
Rectangle -16777216 false false 165 165 180 180
Rectangle -16777216 false false 142 165 157 180
Rectangle -16777216 false false 165 188 180 203
Rectangle -16777216 false false 142 188 157 203
Rectangle -16777216 false false 120 188 135 203
Rectangle -16777216 false false 120 210 135 225
Rectangle -16777216 false false 142 210 157 225
Rectangle -16777216 false false 165 210 180 225
Rectangle -16777216 false false 120 233 135 248
Rectangle -16777216 false false 142 233 157 248
Rectangle -16777216 false false 165 233 180 248

tree
false
0
Circle -7500403 true true 118 3 94
Rectangle -6459832 true false 120 195 180 300
Circle -7500403 true true 65 21 108
Circle -7500403 true true 116 41 127
Circle -7500403 true true 45 90 120
Circle -7500403 true true 104 74 152

triangle
false
0
Polygon -7500403 true true 150 30 15 255 285 255

triangle 2
false
0
Polygon -7500403 true true 150 30 15 255 285 255
Polygon -16777216 true false 151 99 225 223 75 224

truck
false
0
Rectangle -7500403 true true 4 45 195 187
Polygon -7500403 true true 296 193 296 150 259 134 244 104 208 104 207 194
Rectangle -1 true false 195 60 195 105
Polygon -16777216 true false 238 112 252 141 219 141 218 112
Circle -16777216 true false 234 174 42
Rectangle -7500403 true true 181 185 214 194
Circle -16777216 true false 144 174 42
Circle -16777216 true false 24 174 42
Circle -7500403 false true 24 174 42
Circle -7500403 false true 144 174 42
Circle -7500403 false true 234 174 42

turtle
true
0
Polygon -10899396 true false 215 204 240 233 246 254 228 266 215 252 193 210
Polygon -10899396 true false 195 90 225 75 245 75 260 89 269 108 261 124 240 105 225 105 210 105
Polygon -10899396 true false 105 90 75 75 55 75 40 89 31 108 39 124 60 105 75 105 90 105
Polygon -10899396 true false 132 85 134 64 107 51 108 17 150 2 192 18 192 52 169 65 172 87
Polygon -10899396 true false 85 204 60 233 54 254 72 266 85 252 107 210
Polygon -7500403 true true 119 75 179 75 209 101 224 135 220 225 175 261 128 261 81 224 74 135 88 99

warning
true
0
Polygon -2674135 true false 45 225 150 30 255 225
Polygon -1 true false 150 60 75 210 225 210 150 60
Polygon -16777216 true false 135 105 165 105 150 165 135 105
Circle -16777216 true false 135 165 30

wheel
false
0
Circle -7500403 true true 3 3 294
Circle -16777216 true false 30 30 240
Line -7500403 true 150 285 150 15
Line -7500403 true 15 150 285 150
Circle -7500403 true true 120 120 60
Line -7500403 true 216 40 79 269
Line -7500403 true 40 84 269 221
Line -7500403 true 40 216 269 79
Line -7500403 true 84 40 221 269

wolf
false
0
Polygon -16777216 true false 253 133 245 131 245 133
Polygon -7500403 true true 2 194 13 197 30 191 38 193 38 205 20 226 20 257 27 265 38 266 40 260 31 253 31 230 60 206 68 198 75 209 66 228 65 243 82 261 84 268 100 267 103 261 77 239 79 231 100 207 98 196 119 201 143 202 160 195 166 210 172 213 173 238 167 251 160 248 154 265 169 264 178 247 186 240 198 260 200 271 217 271 219 262 207 258 195 230 192 198 210 184 227 164 242 144 259 145 284 151 277 141 293 140 299 134 297 127 273 119 270 105
Polygon -7500403 true true -1 195 14 180 36 166 40 153 53 140 82 131 134 133 159 126 188 115 227 108 236 102 238 98 268 86 269 92 281 87 269 103 269 113

x
false
0
Polygon -7500403 true true 270 75 225 30 30 225 75 270
Polygon -7500403 true true 30 75 75 30 270 225 225 270
@#$#@#$#@
NetLogo 6.1.0
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
<experiments>
  <experiment name="Baseline_DM_work" repetitions="10" runMetricsEveryStep="true">
    <setup>setup
allocate-expert
allocate-trainee-shift
allocate-senior-nurse</setup>
    <go>go</go>
    <timeLimit steps="56001"/>
    <metric>time:show tick-datetime "EEEE dd-MM-yyy HH:mm"</metric>
    <metric>AEC-daily</metric>
    <metric>AMU-daily</metric>
    <metric>waits-24</metric>
    <metric>total-discharges</metric>
    <metric>total-admissions</metric>
    <metric>system-failure-events</metric>
    <metric>exp-tally-aec</metric>
    <metric>exp-tally-amu</metric>
    <metric>occupancy-AMU</metric>
    <metric>occupancy-AEC</metric>
    <metric>occupancy-total</metric>
    <metric>mean-hrqol-aec</metric>
    <metric>mean-hrqol-amu</metric>
    <metric>sd-hrqol-aec</metric>
    <metric>sd-hrqol-amu</metric>
    <metric>median-los-aec-dis</metric>
    <metric>median-los-aec-adm</metric>
    <metric>median-los-amu-dis</metric>
    <metric>median-los-amu-adm</metric>
    <metric>quartile1-aec-los</metric>
    <metric>quartile1-amu-los</metric>
    <metric>quartile3-aec-los</metric>
    <metric>quartile3-amu-los</metric>
    <metric>quartile1-aec-adm-los</metric>
    <metric>quartile1-amu-adm-los</metric>
    <metric>quartile3-aec-adm-los</metric>
    <metric>quartile3-amu-adm-los</metric>
    <metric>ed-total</metric>
    <metric>non-ed-total</metric>
    <metric>final-total</metric>
    <metric>false-aec</metric>
    <metric>true-aec</metric>
    <metric>false-amu</metric>
    <metric>true-amu</metric>
    <enumeratedValueSet variable="TraineeExpStart">
      <value value="20"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="TraineeExpEnd">
      <value value="8"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="ExpertStart">
      <value value="8"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="ExpertEnd">
      <value value="20"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Open_AEC">
      <value value="8"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Close_AEC">
      <value value="23"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Peak_begins">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Peak_ends">
      <value value="20"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Mean_weekday_attendances">
      <value value="45"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Mean_weekend_attendances">
      <value value="25"/>
    </enumeratedValueSet>
  </experiment>
  <experiment name="Baseline_DM_timeseries" repetitions="1" runMetricsEveryStep="true">
    <setup>setup
allocate-expert
allocate-trainee-shift
allocate-senior-nurse</setup>
    <go>go</go>
    <timeLimit steps="56001"/>
    <metric>time:show tick-datetime "EEEE dd-MM-yyy HH:mm"</metric>
    <metric>AEC-daily</metric>
    <metric>AMU-daily</metric>
    <metric>waits-24</metric>
    <metric>total-discharges</metric>
    <metric>total-admissions</metric>
    <metric>system-failure-events</metric>
    <metric>occupancy-AMU</metric>
    <metric>occupancy-AEC</metric>
    <metric>occupancy-total</metric>
    <metric>ed-total</metric>
    <metric>non-ed-total</metric>
    <enumeratedValueSet variable="TraineeExpStart">
      <value value="20"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="TraineeExpEnd">
      <value value="8"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="ExpertStart">
      <value value="8"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="ExpertEnd">
      <value value="20"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Open_AEC">
      <value value="8"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Close_AEC">
      <value value="20"/>
      <value value="23"/>
      <value value="2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Peak_begins">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Peak_ends">
      <value value="20"/>
    </enumeratedValueSet>
    <steppedValueSet variable="Mean_weekday_attendances" first="45" step="5" last="55"/>
    <steppedValueSet variable="Mean_weekend_attendances" first="25" step="5" last="35"/>
  </experiment>
  <experiment name="Baseline_DM_work_outcomes" repetitions="1" runMetricsEveryStep="true">
    <setup>setup
allocate-expert
allocate-trainee-shift
allocate-senior-nurse</setup>
    <go>go</go>
    <timeLimit steps="56001"/>
    <metric>total-discharges</metric>
    <metric>total-admissions</metric>
    <metric>system-failure-events</metric>
    <metric>exp-tally-aec</metric>
    <metric>exp-tally-amu</metric>
    <metric>mean-hrqol-aec</metric>
    <metric>mean-hrqol-amu</metric>
    <metric>sd-hrqol-aec</metric>
    <metric>sd-hrqol-amu</metric>
    <metric>median-los-aec-dis</metric>
    <metric>median-los-aec-adm</metric>
    <metric>median-los-amu-dis</metric>
    <metric>median-los-amu-adm</metric>
    <metric>quartile1-aec-los</metric>
    <metric>quartile1-amu-los</metric>
    <metric>quartile3-aec-los</metric>
    <metric>quartile3-amu-los</metric>
    <metric>quartile1-aec-adm-los</metric>
    <metric>quartile1-amu-adm-los</metric>
    <metric>quartile3-aec-adm-los</metric>
    <metric>quartile3-amu-adm-los</metric>
    <metric>ed-total</metric>
    <metric>non-ed-total</metric>
    <metric>final-total</metric>
    <metric>false-aec</metric>
    <metric>true-aec</metric>
    <metric>false-amu</metric>
    <metric>true-amu</metric>
    <enumeratedValueSet variable="TraineeExpStart">
      <value value="20"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="TraineeExpEnd">
      <value value="8"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="ExpertStart">
      <value value="8"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="ExpertEnd">
      <value value="20"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Open_AEC">
      <value value="8"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Close_AEC">
      <value value="23"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Peak_begins">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Peak_ends">
      <value value="20"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Mean_weekday_attendances">
      <value value="45"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Mean_weekend_attendances">
      <value value="25"/>
    </enumeratedValueSet>
  </experiment>
  <experiment name="Baseline_DM_outcomes" repetitions="1" runMetricsEveryStep="true">
    <setup>setup
allocate-expert
allocate-trainee-shift
allocate-senior-nurse</setup>
    <go>go</go>
    <timeLimit steps="56001"/>
    <metric>total-discharges</metric>
    <metric>total-admissions</metric>
    <metric>system-failure-events</metric>
    <metric>exp-tally-aec</metric>
    <metric>exp-tally-amu</metric>
    <metric>mean-hrqol-aec</metric>
    <metric>mean-hrqol-amu</metric>
    <metric>sd-hrqol-aec</metric>
    <metric>sd-hrqol-amu</metric>
    <metric>median-los-aec-dis</metric>
    <metric>median-los-aec-adm</metric>
    <metric>median-los-amu-dis</metric>
    <metric>median-los-amu-adm</metric>
    <metric>quartile1-aec-los</metric>
    <metric>quartile1-amu-los</metric>
    <metric>quartile3-aec-los</metric>
    <metric>quartile3-amu-los</metric>
    <metric>quartile1-aec-adm-los</metric>
    <metric>quartile1-amu-adm-los</metric>
    <metric>quartile3-aec-adm-los</metric>
    <metric>quartile3-amu-adm-los</metric>
    <metric>ed-total</metric>
    <metric>non-ed-total</metric>
    <metric>final-total</metric>
    <metric>false-aec</metric>
    <metric>true-aec</metric>
    <metric>false-amu</metric>
    <metric>true-amu</metric>
    <enumeratedValueSet variable="TraineeExpStart">
      <value value="20"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="TraineeExpEnd">
      <value value="8"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="ExpertStart">
      <value value="8"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="ExpertEnd">
      <value value="20"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Open_AEC">
      <value value="8"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Close_AEC">
      <value value="20"/>
      <value value="23"/>
      <value value="2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Peak_begins">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Peak_ends">
      <value value="20"/>
    </enumeratedValueSet>
    <steppedValueSet variable="Mean_weekday_attendances" first="45" step="5" last="55"/>
    <steppedValueSet variable="Mean_weekend_attendances" first="25" step="5" last="35"/>
  </experiment>
  <experiment name="Baseline_DM_work_exp_data" repetitions="10" runMetricsEveryStep="true">
    <setup>setup
allocate-expert
allocate-trainee-shift
allocate-senior-nurse</setup>
    <go>go</go>
    <timeLimit steps="56001"/>
    <metric>exp-tally-aec</metric>
    <metric>exp-tally-amu</metric>
    <metric>AMU-complete</metric>
    <metric>AEC-complete</metric>
    <enumeratedValueSet variable="TraineeExpStart">
      <value value="20"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="TraineeExpEnd">
      <value value="8"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="ExpertStart">
      <value value="8"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="ExpertEnd">
      <value value="20"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Open_AEC">
      <value value="8"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Close_AEC">
      <value value="23"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Peak_begins">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Peak_ends">
      <value value="20"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Mean_weekday_attendances">
      <value value="45"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Mean_weekend_attendances">
      <value value="25"/>
    </enumeratedValueSet>
  </experiment>
  <experiment name="Validation_runs" repetitions="20" runMetricsEveryStep="true">
    <setup>setup
allocate-expert
allocate-trainee-shift
allocate-senior-nurse</setup>
    <go>go</go>
    <timeLimit steps="56001"/>
    <metric>time:show tick-datetime "EEEE dd-MM-yyy HH:mm"</metric>
    <metric>AEC-daily</metric>
    <metric>AMU-daily</metric>
    <metric>waits-24</metric>
    <metric>daily-discharge</metric>
    <metric>daily-admit</metric>
    <metric>system-failure-events</metric>
    <metric>ed-total</metric>
    <metric>non-ed-total</metric>
    <metric>expert-false-aec</metric>
    <metric>expert-true-aec</metric>
    <metric>expert-false-amu</metric>
    <metric>expert-true-amu</metric>
    <metric>nonexpert-false-aec</metric>
    <metric>nonexpert-true-aec</metric>
    <metric>nonexpert-false-amu</metric>
    <metric>nonexpert-true-amu</metric>
    <enumeratedValueSet variable="TraineeExpStart">
      <value value="20"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="TraineeExpEnd">
      <value value="8"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="ExpertStart">
      <value value="8"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="ExpertEnd">
      <value value="20"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Open_AEC">
      <value value="8"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Close_AEC">
      <value value="23"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Peak_begins">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Peak_ends">
      <value value="20"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Mean_weekday_attendances">
      <value value="45"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Mean_weekend_attendances">
      <value value="25"/>
    </enumeratedValueSet>
  </experiment>
  <experiment name="SA_NO_EXPERT_Validation_runs" repetitions="20" runMetricsEveryStep="true">
    <setup>setup
allocate-trainee-fulltime 
allocate-senior-nurse</setup>
    <go>go</go>
    <timeLimit steps="56001"/>
    <metric>time:show tick-datetime "EEEE dd-MM-yyy HH:mm"</metric>
    <metric>AEC-daily</metric>
    <metric>AMU-daily</metric>
    <metric>daily-discharge</metric>
    <metric>daily-admit</metric>
    <metric>system-failure-events</metric>
    <enumeratedValueSet variable="TraineeExpStart">
      <value value="20"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="TraineeExpEnd">
      <value value="8"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="ExpertStart">
      <value value="8"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="ExpertEnd">
      <value value="20"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Open_AEC">
      <value value="8"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Close_AEC">
      <value value="23"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Peak_begins">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Peak_ends">
      <value value="20"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Mean_weekday_attendances">
      <value value="45"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Mean_weekend_attendances">
      <value value="25"/>
    </enumeratedValueSet>
  </experiment>
  <experiment name="SA_EXPERT_Validation_runs" repetitions="20" runMetricsEveryStep="true">
    <setup>setup
allocate-expert
allocate-trainee-shift 
allocate-senior-nurse</setup>
    <go>go</go>
    <timeLimit steps="56001"/>
    <metric>time:show tick-datetime "EEEE dd-MM-yyy HH:mm"</metric>
    <metric>AEC-daily</metric>
    <metric>AMU-daily</metric>
    <metric>daily-discharge</metric>
    <metric>daily-admit</metric>
    <metric>system-failure-events</metric>
    <enumeratedValueSet variable="TraineeExpStart">
      <value value="20"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="TraineeExpEnd">
      <value value="8"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="ExpertStart">
      <value value="8"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="ExpertEnd">
      <value value="20"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Open_AEC">
      <value value="8"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Close_AEC">
      <value value="23"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Peak_begins">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Peak_ends">
      <value value="20"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Mean_weekday_attendances">
      <value value="45"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Mean_weekend_attendances">
      <value value="25"/>
    </enumeratedValueSet>
  </experiment>
  <experiment name="HIGH_DEMAND_Validation_runs" repetitions="20" runMetricsEveryStep="true">
    <setup>setup
allocate-expert
allocate-trainee-shift 
allocate-senior-nurse</setup>
    <go>go</go>
    <timeLimit steps="56001"/>
    <metric>time:show tick-datetime "EEEE dd-MM-yyy HH:mm"</metric>
    <metric>AEC-daily</metric>
    <metric>AMU-daily</metric>
    <metric>daily-discharge</metric>
    <metric>daily-admit</metric>
    <metric>system-failure-events</metric>
    <enumeratedValueSet variable="TraineeExpStart">
      <value value="20"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="TraineeExpEnd">
      <value value="8"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="ExpertStart">
      <value value="8"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="ExpertEnd">
      <value value="20"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Open_AEC">
      <value value="8"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Close_AEC">
      <value value="23"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Peak_begins">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Peak_ends">
      <value value="20"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Mean_weekday_attendances">
      <value value="75"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Mean_weekend_attendances">
      <value value="35"/>
    </enumeratedValueSet>
  </experiment>
  <experiment name="Validation_2" repetitions="20" runMetricsEveryStep="true">
    <setup>setup
allocate-expert
allocate-trainee-shift
allocate-senior-nurse</setup>
    <go>go</go>
    <timeLimit steps="56001"/>
    <metric>time:show tick-datetime "EEEE dd-MM-yyy HH:mm"</metric>
    <metric>AEC-daily</metric>
    <metric>AMU-daily</metric>
    <metric>waits-24</metric>
    <metric>daily-discharge</metric>
    <metric>daily-admit</metric>
    <metric>system-failure-events</metric>
    <metric>ed-total</metric>
    <metric>non-ed-total</metric>
    <metric>expert-false-aec</metric>
    <metric>expert-true-aec</metric>
    <metric>expert-false-amu</metric>
    <metric>expert-true-amu</metric>
    <metric>nonexpert-false-aec</metric>
    <metric>nonexpert-true-aec</metric>
    <metric>nonexpert-false-amu</metric>
    <metric>nonexpert-true-amu</metric>
    <enumeratedValueSet variable="TraineeExpStart">
      <value value="20"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="TraineeExpEnd">
      <value value="8"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="ExpertStart">
      <value value="8"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="ExpertEnd">
      <value value="20"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Open_AEC">
      <value value="8"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Close_AEC">
      <value value="23"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Peak_begins">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Peak_ends">
      <value value="20"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Mean_weekday_attendances">
      <value value="48"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Mean_weekend_attendances">
      <value value="28"/>
    </enumeratedValueSet>
  </experiment>
  <experiment name="Validation_3" repetitions="20" runMetricsEveryStep="true">
    <setup>setup
allocate-expert
allocate-trainee-shift
allocate-senior-nurse</setup>
    <go>go</go>
    <timeLimit steps="56001"/>
    <metric>time:show tick-datetime "EEEE dd-MM-yyy HH:mm"</metric>
    <metric>AEC-daily</metric>
    <metric>AMU-daily</metric>
    <metric>waits-24</metric>
    <metric>daily-discharge</metric>
    <metric>daily-admit</metric>
    <metric>system-failure-events</metric>
    <metric>ed-total</metric>
    <metric>non-ed-total</metric>
    <metric>expert-false-aec</metric>
    <metric>expert-true-aec</metric>
    <metric>expert-false-amu</metric>
    <metric>expert-true-amu</metric>
    <metric>nonexpert-false-aec</metric>
    <metric>nonexpert-true-aec</metric>
    <metric>nonexpert-false-amu</metric>
    <metric>nonexpert-true-amu</metric>
    <enumeratedValueSet variable="TraineeExpStart">
      <value value="20"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="TraineeExpEnd">
      <value value="8"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="ExpertStart">
      <value value="8"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="ExpertEnd">
      <value value="20"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Open_AEC">
      <value value="8"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Close_AEC">
      <value value="23"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Peak_begins">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Peak_ends">
      <value value="20"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Mean_weekday_attendances">
      <value value="48"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Mean_weekend_attendances">
      <value value="28"/>
    </enumeratedValueSet>
  </experiment>
  <experiment name="Minutes_Validation_3" repetitions="5" runMetricsEveryStep="true">
    <setup>setup
allocate-expert
allocate-trainee-shift
allocate-senior-nurse</setup>
    <go>go</go>
    <timeLimit steps="181440"/>
    <metric>time:show tick-datetime "EEEE dd-MM-yyy HH:mm"</metric>
    <metric>AEC-daily</metric>
    <metric>AMU-daily</metric>
    <metric>waits-24</metric>
    <metric>daily-discharge</metric>
    <metric>daily-admit</metric>
    <metric>system-failure-events</metric>
    <metric>ed-total</metric>
    <metric>non-ed-total</metric>
    <metric>expert-false-aec</metric>
    <metric>expert-true-aec</metric>
    <metric>expert-false-amu</metric>
    <metric>expert-true-amu</metric>
    <metric>nonexpert-false-aec</metric>
    <metric>nonexpert-true-aec</metric>
    <metric>nonexpert-false-amu</metric>
    <metric>nonexpert-true-amu</metric>
    <enumeratedValueSet variable="TraineeExpStart">
      <value value="20"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="TraineeExpEnd">
      <value value="8"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="ExpertStart">
      <value value="8"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="ExpertEnd">
      <value value="20"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Open_AEC">
      <value value="8"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Close_AEC">
      <value value="23"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Peak_begins">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Peak_ends">
      <value value="20"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Mean_weekday_attendances">
      <value value="50"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Mean_weekend_attendances">
      <value value="30"/>
    </enumeratedValueSet>
  </experiment>
</experiments>
@#$#@#$#@
@#$#@#$#@
default
0.0
-0.2 0 0.0 1.0
0.0 1 1.0 0.0
0.2 0 0.0 1.0
link direction
true
0
Line -7500403 true 150 150 90 180
Line -7500403 true 150 150 210 180
@#$#@#$#@
0
@#$#@#$#@
