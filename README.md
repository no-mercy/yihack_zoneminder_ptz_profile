# This is ZoneMinder controls profile for cameras with ptz (moving) abilities that are running YiHack compatible firmware

How to use:

* Copy YiHack.pm to /usr/share/perl5/ZoneMinder/Control (or related path on your system)

* Go to control settings of your camera Monitor -> Control, and check *Controllable* checkbox

* Create profile with in Monitor -> Control -> Control type, Check

* In protocol field add YiHack protocol name

* In Move section check "Can Move" and "Can move absolute"

* In Pan section check "Can Pan"

* In Tilt section check "Can Tilt"

* Save profile

* Assign Control Address to your camera, i.e. 192.168.0.10:8080

* Kill all related zmcontrol processes (this is safe, they will be restarted automatically)

On my camera all controls are reverted, and this is fixed in this module.
