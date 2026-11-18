BigWigs spoken warnings - recording notes
==========================================

VoiceLines.csv lists every line: the file name to save, the exact text to speak, a group, and the
warnings it will be used for. Open it in Excel or any spreadsheet.

Voice
-----
- One soft-spoken female voice for every line, so they sound like one speaker.
- Calm, clear and unhurried. These play mid-fight, so clarity matters more than emotion.
- ElevenLabs: a stability setting of about 60% keeps lines consistent from one file to the next.
- Chosen voice is Siren

Files
-----
- Save each line with the exact name in the File column (MP3, same capitals), into this folder:
  Interface\AddOns\BigWigs\Sounds\Voice\
- MP3, 44.1 kHz, mono or stereo. WoW 1.12 plays MP3, WAV and OGG; BigWigs already uses MP3.
- Trim the silence at the start of each file so the warning plays the moment it fires.
- Aim for under 2 seconds per line (the Wyrmguard lines may run a little longer).

Batch generation with elevenbatch (PowerShell)
----------------------------------------------
elevenbatch (https://github.com/grossstadtmann/elevenbatch) names each MP3 after its spoken text,
so generate first, then rename:

1. In PowerShell, set your key, the Siren voice ID and a model:
     $env:ELEVENLABS_API_KEY = "your_api_key"
     $env:ELEVENLABS_API_VOICE = "siren_voice_id"      (helper\windows\get_voices_ids.ps1 lists IDs)
     $env:ELEVENLABS_API_MODEL_ID = "eleven_multilingual_v2"
2. Change to this folder and run the batch on column 1 (the Text column; columns count from 0):
     cd "C:\Gaming\World of Warcraft - Turtle\Interface\AddOns\BigWigs\Sounds\Voice"
     & "C:\path\to\elevenbatch\elevenbatch.ps1" -CsvFile .\VoiceLines-elevenbatch.csv -Columns "1"
   Files are saved in the current folder, e.g. Skull_is_vulnerable_to_fire.mp3.
3. Rename them to the names BigWigs uses (add -WhatIf first to preview):
     .\Rename-VoiceLines.ps1

Notes:
- elevenbatch fixes the voice settings in its script (stability 0.5, similarity 0.75). To use 60%
  stability, change "stability = 0.5" to "stability = 0.6" in elevenbatch.ps1 before running.
- A rerun sends every line again and uses credits again. To redo a few lines, copy the header and
  just those rows into a smaller CSV and run that.
- If a generated file already exists, elevenbatch adds _1, _2... to the new one; delete the old
  file and rename the new one by hand.

Pronunciation
-------------
- "Trank now" is spelled that way on purpose, so it sounds like the player shorthand for
  Tranquilizing Shot. Re-generate any line that comes out sounding wrong; "Decurse" should be
  "dee-curse".

Already in BigWigs
------------------
Numbers One to Ten, MarkOne to MarkTwelve, Shackle and Healer rotation lines already exist in
Sounds\ and are not in this list.
