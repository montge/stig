## Changelog
---------
- 0.5.5
-- [evan.montgomery-recht@va.gov] - Updated with VA CRISP related settings.

- 0.5.4
-- [isuftin@usgs.gov] - Fix an issue with auth-config being improperly written to for pass reuse limit

- 0.5.3
-- [isuftin@usgs.gov] - Switch sysctl write flags

- 0.5.2
-- [isuftin@usgs.gov] - Ignore errors on unknown sysctl keys

- 0.5.1
-- [isuftin@usgs.gov] - Included third-party sysctl cookbook as a hard-coupled dependency by calling it in proc_hard recipe

- 0.5.0
-- [isuftin@usgs.gov] - Switched sysctl.conf template writing out and brought in the third-party sysctl cookbook to handle writing .d config file
-- [isuftin@usgs.gov] - Updated serverspec testing

- 0.4.3
-- [isuftin@usgs.gov] - Updated to switch out which file in /etc/pam.d/system-auth* gets symlinked

- 0.4.2
-- [isuftin@usgs.gov] - Fix most foodcritic errors and warnings
-- [isuftin@usgs.gov] - CIS 1.6.2 (Configure ExecShield) was removed in 2.0.0 of all CIS STIG. No longer testing for it
-- [isuftin@usgs.gov] - Added updates to SSHD config to allow boolean for password authentication
-- [isuftin@usgs.gov] - Updated system auth recipe to be less destructive to /etc/pam.d/system-auth since that may be updated by authconfig
-- [isuftin@usgs.gov] - Fixed a few tests


- 0.4.1
-- [isuftin@usgs.gov] - Updated sshd config to include approved ciphers (RHEL6 STIG 6.2.11)
-- [isuftin@usgs.gov] - Added the ability to change `ChallengeResponseAuthentication` in sshd config
-- [isuftin@usgs.gov] - Added the ability to change `UsePAM` in sshd config

- 0.4.0
-- [isuftin@usgs.gov] - Users may now add auditd rules directly as a series of attributes

- 0.3.11
-- [isuftin@usgs.gov] - More Auditd fixes

- 0.3.10
-- [isuftin@usgs.gov] - Fix auditd default parameters which break the build
-- [isuftin@usgs.gov] - Add documentation for new attributes

- 0.3.9
-- [isuftin@usgs.gov] - Fully parameterized auditd configuration file
-- [isuftin@usgs.gov] - No longer calling the auditd cookbook directly from auditd.rb
-- [isuftin@usgs.gov] - Auditd cookbook is no longer a direct dependency of the STIG cookbook. Should be part of an overall runlist

- 0.3.8
-- [isuftin@usgs.gov] - Updated STIG and Audit rules to CIS RHEL Stig 1.4.0
-- [isuftin@usgs.gov] - Added CentOS 6 ruleset 3.2 - "Remove the X Window System"
-- [isuftin@usgs.gov] - Fixed and added many Serverspec tests
-- [isuftin@usgs.gov] - Corrected a typo in `check_duplicate_gid.sh` to correct STIG control number
-- [isuftin@usgs.gov] - Removed CIS wording from audit scripts
-- [isuftin@usgs.gov] - Enforced permissions on /boot/grub/grub.conf as per STIG 1.5.2
-- [isuftin@usgs.gov] - Removed grub.conf template
-- [isuftin@usgs.gov] - Updated mounting of /dev/shm to be idempotent
