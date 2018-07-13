# docker-image-sync
Transfer docker images between two docker hosts.

Usecase - in development VM I pull images from a private docker registry.
All is OK, except that a clean pull takes half hour, for about 10 GB of data.
That is avarage transfer rate of about 5 MB/s. A bit slow.
I wish I could avoid that part of pull step.

For testing a clean deploy on a new VM existing data on old VM can be reused.
Command ```docker save``` and ```docker load``` will do the real work.
Annoying detail about ```docker load``` - it will create a new image with correct sha256 id,
but it will not know its name (e.g. source repository and tag will be blank).
A ```docker pull``` will fix this - image data is already availble, so it only updates
the missing image name.

Usually data would be transfered over SSH, and all commands could be piped into a
single line in bash. But SSH would also encrypt data, and that can be slow.
So netcat is used for data transfer.
The consumed network bandwidth between 2 local VMs was up to 200 - 300 MB/s.
That is a peak value, measured over a 2 secundes interval with ```bwm-ng``` tool.
The 10 GB of image data was synced in about 6 minutes.
