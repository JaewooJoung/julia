```mermaid
%%{init: {'theme': 'nuetral' } }%%

graph TB
    s12([12*USS])
    WAM([4*CAM])
    CAM([7*CAM])
    FLR([FLR3])
    RML
    IRRM
    SRS

    PAS3(PAS3)
    GAS(GAS52EVO)

    subgraph PAS
        PAS3-->|Hardwire|s12
        PAS3-->|FPD<br/>LINK3*4|WAM
    end

    subgraph ADCU
        FLR-->|CANFD<br/>Private|GAS
        CAM-->|FPD<br/>LINK3*7|GAS
    end
    GAS---|Passive<br/>Safety CAN|RML
    GAS---|Passive<br/>Safety CAN|IRRM
    GAS---|Passive<br/>Safety CAN|SRS
    GAS---|Flexray|BCM2
    GAS---|AD redundant<br/>CAN|BCM2
    GAS---|Flexray|PCMU
    GAS---|Ethernet<br/>1G|PCMU
    GAS---|CANFD4<br/>Safety|PAS3
    GAS---|FPD<br/>LINK4|PAS3
```
Smart Charging 
Calendar
Driving Coach
virtual guide
customer voice
----
Coding-buddy (Find errors in codes / propose improvements)
Generating code based on requirements
Education (learning new skills, reminder of information or procedures)
Benchmark (Find trends and competition)
Brainstorming-buddy (Generating content based on your initial ideas/Combine old ideas into new ones)
Brainstorming user scenarios (E.g. come up with dangerous driving situations to use in AD simulations)
Translation
Creating or improving requirements based on high level input or testing results
Making wise material and construction choices (giving details on the effectiveness, longevity, and environmental impact)
Analyze signals and faulty codes during testing
Summarize supplier/purchasing contracts assist in evaluating the required changes, risks and facilitate comparisons
Quality follow-up (Analyze faulty codes or user complains from the market)
Find and summarize laws and standards
Social companion, coach or mental health advisor
Automating the development of technical documentation and 3D models.
Work while driving assistant (read out loud summaries of your emails, compose emails, create presentations)
Translate between formal and natural languages that describe traffic scenarios for example