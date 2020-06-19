This is the folder that contains files that I used to demo how to use CircleCI as a CI tool. These are just the files, the repo itself is located [here](github.com/Quantanalyst/r_project)

In order to integrate the CircleCI to your Github, you must create an account on CircleCI website with your Github account. Then, you connect your desired repo to your CircleCI projects. 

In the Github repo, you must change the repo setting and protect your master branch. So, in the setting, you tell Github that after each pull request, you want CircleCI to perform the unit tests and when the results ready, then under some conditions, you allow the pull request to merge with your master branch. 

As you can see, on this directory, I have a folder named ```.circleci```, this folder has a YAML file that gives the CircleCI instructions about what to do and where to look for unit testing. 

Below, you can see my CircleCI account and the integration testing result of my pushes to my Github. 

<p align="center"> <img src="images/circleci.png"> </p>









References: 
Continuous integration for your private R projects with CircleCI (link = https://appsilon.com/continuous-integration-for-your-private-r-projects-with-circleci/)
