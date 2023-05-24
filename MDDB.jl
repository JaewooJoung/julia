using DuckDB
#using DataFrames
# create a new in-memory database
con = DBInterface.connect(DuckDB.DB, "myddb.duckdb") #:memory:   #"myddb.duckdb"

# create a table
DBInterface.execute(con, "CREATE TABLE IF NOT EXISTS integers(i INTEGER)")

# insert data using a prepared statement
stmt = DBInterface.prepare(con, "INSERT INTO integers VALUES(?)")
DBInterface.execute(stmt, [42])

# query the database
results = DBInterface.execute(con, "SELECT 42 a")
print(results)

#=
Safety and Confidence:

Lane departure warning
Forward collision warning
Adaptive cruise control
Emergency braking
Blind spot detection
Pedestrian detection
Ease of Use:

Intuitive user interface
Clear and accessible controls
Simple and understandable settings
Minimal driver distraction
Accuracy and Reliability:

Reliable detection and sensing capabilities
Low false alarm rates
Precise distance and speed measurements
Consistent performance across different driving conditions
Customization and Personalization:

Adjustable sensitivity levels
Personalized warning thresholds
Tailored system behavior based on driver preferences
Customizable alert preferences (visual, auditory, haptic)
Integration and Consistency:

Seamless integration with other vehicle systems
Consistent user experience across different ADAS features
Integration with infotainment systems and smartphone connectivity
Unified control interface
Education and Training:

Clear instructions and user manuals
In-vehicle tutorials or training modules
Educational materials on ADAS capabilities and limitations
Guidance on proper usage and best practices
Feedback and Communication:

Clear and timely visual alerts (icons, symbols, warnings)
Auditory cues (beeps, tones, spoken messages)
Haptic feedback (vibrations, steering wheel resistance)
Voice prompts and instructions
Ethical Considerations:

Prioritizing human safety over convenience
Avoiding situations that may lead to unnecessary risks
Mitigating unintended consequences of ADAS actions
Compliance with ethical guidelines and regulations
=#