```mermaid
%%{init: {'theme': 'nuetral' } }%%
gantt
    dateFormat YYWW
    axisFormat %yW%W
    title CX1e ADAS Test Plan

    section VP1 <br> (General Preparation)
	PA	: crit, active, milestone, 2023-07-01,1d
	Define Test Objectives	: active, des1, 2023-07-02,4d
	Develop Test Plan	: active, des2, 2023-07-03,29d
	Obtain Necessary Equipment	: active, des3, 2023-08-01,85d
	Establish Test Environment	: active, des4, 2023-10-25,29d
	Determine Data Collection Method	: active, des5, 2023-11-23,15d
	Sensor Calibration	: active, des6, 2023-12-08,29d
	Define Test Metrics	: crit, active, des7, 2024-01-08,15d
	Ensure Safety Measures	: crit, active, des8, 2024-01-23,15d
	Obtain Permissions and Permits	: crit, active, des9, 2024-02-07,15d
	Documentation	: crit, active, des10, 2024-02-22,15d
	Staff Training	: crit, active, des11, 2024-03-08,15d

    section TEST subject
	Secure GAS EVO SW	: crit, active, milestone, 2024-02-01,1d
	Secure Test Vehicles	: crit, active, milestone, 2024-02-02,4d

    section VP1(or maybe 2)<br> (Winter Test)
	Sensor Calibration	: active, des2, 2024-02-05,15d
	Functional Testing	: active, des3, 2024-02-20,29d
	Object Detection and Tracking	: active, des4, 2024-03-20,29d
	Environmental Conditions	: active, des5, 2024-04-18,29d
	Real-World Scenarios	: active, des6, 2024-05-17,29d
	Functional Safety	: active, des7, 2024-06-17,29d
    Test Results and Data	: active, des8, 2024-08-01,1d

    section VP2 <br> Collision Avoidance(CMSF,AEB)
	Sensor Calibration	: active, des2, 2024-02-05,15d
	Functional Testing	: active, des3, 2024-02-20,29d
	Object Detection and Tracking	: active, des4, 2024-03-20,29d
	Environmental Conditions	: active, des5, 2024-04-18,29d
	Real-World Scenarios	: active, des6, 2024-05-17,29d
	Functional Safety	: active, des7, 2024-06-17,29d
    Test Results and Data	: active, des8, 2024-08-01,1d
    
    section VP2 <br> Adaptive Cruise Control (ACC)
	Sensor Calibration	: active, des2, 2024-02-05,15d
	Functional Testing	: active, des3, 2024-02-20,29d
	Object Detection and Tracking	: active, des4, 2024-03-20,29d
	Environmental Conditions	: active, des5, 2024-04-18,29d
	Real-World Scenarios	: active, des6, 2024-05-17,29d
	Functional Safety	: active, des7, 2024-06-17,29d
    Test Results and Data	: active, des8, 2024-08-01,1d
    
    section VP2 <br> Lane Departure Warning (LDW)
	Sensor Calibration	: active, des2, 2024-02-05,15d
	Functional Testing	: active, des3, 2024-02-20,29d
	Object Detection and Tracking	: active, des4, 2024-03-20,29d
	Environmental Conditions	: active, des5, 2024-04-18,29d
	Real-World Scenarios	: active, des6, 2024-05-17,29d
	Functional Safety	: active, des7, 2024-06-17,29d
    Test Results and Data	: active, des8, 2024-08-01,1d
    
    section VP2 <br> Traffic Sign Recognition (TSR)
	Sensor Calibration	: active, des2, 2024-02-05,15d
	Functional Testing	: active, des3, 2024-02-20,29d
	Object Detection and Tracking	: active, des4, 2024-03-20,29d
	Environmental Conditions	: active, des5, 2024-04-18,29d
	Real-World Scenarios	: active, des6, 2024-05-17,29d
	Functional Safety	: active, des7, 2024-06-17,29d
    Test Results and Data	: active, des8, 2024-08-01,1d

    section 5 TT and 2PP VP2 <br> Homologation handover testing for Q-test
	Compliance Documentation	: crit, active, milestone, 2024-08-01,1d
	Sensor Calibration Reports	: crit, active, milestone, 2024-08-02,4d
	Safety Assessments	: active, des2, 2024-08-05,15d
	Test Equipment Documentation	: active, des3, 2024-08-20,29d
	System Descriptions	: active, des4, 2024-09-18,29d
	Software and Firmware Information	: active, des5, 2024-10-17,29d
	Manuals and User Guides	: active, des6, 2024-11-15,29d
	Certifications and Approvals	: active, des7, 2024-12-16,29d
```