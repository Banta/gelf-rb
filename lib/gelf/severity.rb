module GELF
  # There are two things you should know about log levels/severity:
  #  - syslog defines levels from 0 (Emergency) to 7 (Debug).
  #    0 (Emergency) and 1 (Alert) levels are reserved for OS kernel.
  #  - Ruby default Logger defines levels from 0 (DEBUG) to 4 (FATAL) and 5 (UNKNOWN).
  #    Note that order is inverted.
  # For compatibility we define our constants as Ruby Logger, and convert values before
  # generating GELF message, using defined mapping.

  module Levels
    DEBUG   = 0
    INFO    = 1
    WARN    = 2
    ERROR   = 3
    FATAL   = 4
    UNKNOWN = 5
    # Additional native syslog severities. These will work in direct mapping mode
    # only, for compatibility with syslog sources unrelated to Logger.
    EMERGENCY     = 10
    ALERT         = 11
    CRITICAL      = 12
    WARNING       = 14
    NOTICE        = 15
    INFORMATIONAL = 16
  end

  include Levels

  # Maps Ruby Logger levels to syslog levels as SyslogLogger and syslogger gems. This one is default.
  LOGGER_MAPPING = {DEBUG   => 'debug', # Debug
                    INFO    => 'info', # Informational
                    WARN    => 'warn', # Notice
                    ERROR   => 'error', # Warning
                    FATAL   => 'fatal', # Error
                    UNKNOWN => 'unknown'} # Alert – shouldn't be used

  # Maps Syslog or Ruby Logger levels directly to standard syslog numerical severities.
  DIRECT_MAPPING = {DEBUG         => 'debug', # Debug
                    INFORMATIONAL => 'info', # Informational (syslog source)
                    INFO          => 'info', # Informational (Logger source)
                    NOTICE        => 'notice', # Notice
                    WARNING       => 'warn', # Warning (syslog source)
                    WARN          => 'warn', # Warning (Logger source)
                    ERROR         => 'error', # Error
                    CRITICAL      => 'critical', # Critical (syslog source)
                    FATAL         => 'critical', # Critical (Logger source)
                    ALERT         => 'alert', # Alert (syslog source)
                    UNKNOWN       => 'alert', # Alert - shouldn't be used (Logger source)
                    EMERGENCY     => 'emergency'} # Emergency (syslog source)
end
