## How to use

./buils.sh

## Current issues

* hugepages
* nic binding

The above requires containers to be privileged. It may be possible to mount hugepages via kubernetes yaml deployment definition without privileged but nice binding most likely requires it anyway.
The current version of Dockerfile does not do those two things. You can try to do them manually using commented out commands (binding should work, hugepages were not tested on priviliged container)