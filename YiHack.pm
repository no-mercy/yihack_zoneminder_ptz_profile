# ==========================================================================
#
# ZoneMinder YiHack Control Protocol Module
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
#
# ==========================================================================
#
# This module contains the implementation of the YiHack device control protocol
#
package ZoneMinder::Control::YiHack;

use 5.006;
use strict;
use warnings;

require ZoneMinder::Control;

our @ISA = qw(ZoneMinder::Control);

our %CamParams = ();

# ==========================================================================
#
# ONVIF Control Protocol
#
# On ControlAddress use the format :
#   USERNAME:PASSWORD@ADDRESS:PORT
#   eg : admin:@10.1.2.1:80
#        zoneminder:zonepass@192.168.0.10:8080
#	 192.168.0.10:8080
# ==========================================================================

use ZoneMinder::Logger qw(:all);
use ZoneMinder::Config qw(:all);

use Time::HiRes qw( usleep );

sub open {
  my $self = shift;

  $self->loadMonitor();

  use LWP::UserAgent;
  $self->{ua} = LWP::UserAgent->new;
  $self->{ua}->agent('ZoneMinder Control Agent/'.ZoneMinder::Base::ZM_VERSION);

  $self->{state} = 'open';
}

sub sendCmd {
  my $self = shift;
  my $cmd = shift;
  my $result = undef;

  my $req = HTTP::Request->new(GET=>'http://'.$self->{Monitor}->{ControlAddress}.'/cgi-bin/ptz.sh?'.$cmd);
  my $res = $self->{ua}->request($req);

  if ( $res->is_success ) {
    $result = !undef;
  }

  return $result;
}

#Up Arrow
sub moveAbsUp
{
  my $self = shift;
  Debug( "Move Up" );
  my $cmd = "dir=down";
  $self->sendCmd( $cmd );
}

#Down Arrow
sub moveAbsDown
{
  my $self = shift;
  Debug( "Move Down" );
  my $cmd = "dir=up";
  $self->sendCmd( $cmd );
}

#Left Arrow
sub moveAbsLeft
{
  my $self = shift;
  Debug( "Move Left" );
  my $cmd = "dir=right";
  $self->sendCmd( $cmd );
}

#Right Arrow
sub moveAbsRight
{
  my $self = shift;
  Debug( "Move Right" );
  my $cmd = "dir=left";
  $self->sendCmd( $cmd );
}

sub presetHome
{
  Debug( "Home Position" );
}

1;
