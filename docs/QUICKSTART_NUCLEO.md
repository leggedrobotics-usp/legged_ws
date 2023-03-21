# Quickstart for NUCLEO-F446RE
[ [Back to README.md](../README.md) ]

## Previous steps
Previous steps are available on the [README.md](../README.md) file.

## Step 2 - Prepare the docker image for embedded software development

The following command will prepare all the needed repositories and build the needed docker image with melodic-legged image.
```bash
./scripts/prepare_embedded_ws.sh nucleo-legged
```

## Step 3 - Run the container
**NOTE: Already built if you followed step 2 **
To easily start the container:
```bash
./docker/run_embedded.sh nucleo-legged
```

```If you don't know whether you are inside a container, check if yout current folder and user look something like:``` **user@computer:~/forecast-nucleo$**
