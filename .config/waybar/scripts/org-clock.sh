#!/usr/bin/env bash

# Fetch org-clock info from emacsclient
# It returns a string like "Task Name (time_clocked/effort)" or "Task Name (time_clocked)"

ELISP="(if (and (featurep 'org-clock) (org-clocking-p))
    (let ((task (substring-no-properties org-clock-heading))
          (effort (if (and (boundp 'org-clock-effort) org-clock-effort) org-clock-effort \"\"))
          (clocked (org-duration-from-minutes (org-clock-get-clocked-time))))
      (if (string= effort \"\")
          (format \"%s (%s)\" task clocked)
        (format \"%s (%s/%s)\" task clocked effort)))
  \"\")"

OUTPUT=$(emacsclient -e "$ELISP" 2>/dev/null)

if [ $? -ne 0 ]; then
    # Emacsclient failed (e.g., daemon not running)
    echo ""
    exit 0
fi

# Remove leading and trailing quotes from emacsclient output
OUTPUT="${OUTPUT%\"}"
OUTPUT="${OUTPUT#\"}"

if [ -n "$OUTPUT" ]; then
    echo "$OUTPUT"
else
    echo ""
fi
