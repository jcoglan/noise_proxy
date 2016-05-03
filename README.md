# noise-proxy

Runs a TCP proxy with configurable noise in both directions.


## Installation

    git clone git://github.com/jcoglan/noise_proxy.git
    cd noise_proxy
    bundle install


## Usage

    ./bin/noise-proxy [PORT]

This runs a TCP proxy on `PORT` and a configuration web app on `PORT+1`. The
proxy's upstream host and port, and the noise factors for incoming and outgoing
traffic, can be configured via the web app.


## License

Copyright (C) 2016 James Coglan

This program is free software: you can redistribute it and/or modify it under
the terms of the GNU General Public License as published by the Free Software
Foundation, either version 3 of the License, or (at your option) any later
version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY
WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
PARTICULAR PURPOSE.  See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with
this program.  If not, see <http://www.gnu.org/licenses/>.
