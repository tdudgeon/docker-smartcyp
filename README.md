Really simple example Docker file illustrating how the SmartCyp program can be packaged up as  docker image and run as a command-line app.
SmartCyp is a program that can do metabolism predictions on molecules.

For more info on SmartCyp see here: http://www.farma.ku.dk/smartcyp/

For more info on Docker see here: http://www.docker.com/


## Build Docker image

``` sh
docker build .
```

output:
```
docker build --no-cache .
Sending build context to Docker daemon 34.82 kB
Step 1 : FROM java:openjdk-8-jre
 ---> 45a4bb374fcb
Step 2 : MAINTAINER Tim Dudgeon <tdudgeon@informaticsmatters.com>
 ---> Running in 0fc317e7c871
 ---> a966b1a843c6
Removing intermediate container 0fc317e7c871
Step 3 : RUN curl -L 'http://www.farma.ku.dk/smartcyp/smartcyp.jar' -o smartcyp.jar
 ---> Running in d5a544891459
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100 18.0M  100 18.0M    0     0  2717k      0  0:00:06  0:00:06 --:--:-- 2384k
 ---> 45d6749e1f31
Removing intermediate container d5a544891459
Successfully built 6a4549a24a9e
```

Tag the image you built (note the image ID on the last line of the output):

``` sh
docker tag 6a4549a24a9e smartcyp
```

You now have a docker image named smartcyp which has everything you need to run smartcyp (essentially a Linux machine with Java and the SmartCyp executable.

## Run SmartCyp

Here we specify a smiles string as a commandline argument. For more info on the command-line args see here:
http://www.farma.ku.dk/smartcyp/download.php

first make a directory for the results

``` sh
mkdir results
```

and now run smartcyp

``` sh
docker run --rm -v $PWD/results:/results smartcyp java -jar smartcyp.jar -smiles 'CN1C=NC2=C1C(=O)N(C(=O)N2C)C' -outputdir /results -outputfile caffeine

 ************** Processing SMARTS and Energies **************

 ************** Reading molecule structures **************
1 molecules were read from the file smartcypxyz.smiles

 ************** Molecule 1 **************

 ************** Writing Results as CSV **************

 ************** Writing Results as ChemDoodle HTML **************
The temporary file smartcypxyz.smiles has been deleted!
```

Some explaination:

*docker run* fires up the container from the specified image

*--rm* deletes the container when finished so you have no rubbish hanging around

*-v $PWD/results:/results* mount the results subdirectory inside the container as /results so that when the results are put there you can find them.

*java ...* (the rest) is the command to run smart cyp. Likely you will want to adjust these. 
 
Results will be found in the results dir of your host machine. You can see the output in a browser:

``` sh
firefox results/caffeine.html
```


## Use prebuilt image

If building the image is too much effort you can use a pre-prepared image from Docker Hub.

``` sh
docker run --rm -v $PWD/results:/results tdudgeon/smartcyp java -jar smartcyp.jar -smiles 'CN1C=NC2=C1C(=O)N(C(=O)N2C)C' -outputdir /results -outputfile caffeine
```

This does the same thing as above, but the Docker image is pulled from Docker Hub, so this command is the only thing you need other than docker.
The docker image on Docker Hub is built automatically from the Docker file on Git Hub, so that whenever the Git Hub project is updated the Docker Hub image is autmatically rebuilt.







