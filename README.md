# New Vision CI/CD Pipeline

This is the Github repo for my project at Insight datascience. I was a DevOps fellow and the project was a pro bono consulting project for a NY-based education company.

The existing infrastructure of the company is presented below. There are two AWS EC2 instances that host staging and production environments. I was presented with two challenges. One, the developers push their codes directly to staging environment. How can we create an infrastructure that performs integration testing first before allowing them to merge their codes with the master branch? Two, the data pipelines use static schemas and the schema is embedded to the existing source code, so any change to the database schemas break the existing code, how can we solve this problem?

<!-- ![alt text](images/current_infra.png "Existing Infrastructure") <img src="image" width="40%"> -->
<p align="center"> <img src="images/current_infra.png" width="250" height="250"> </p>










### Project infrastructure

Below, you can see the overall architecture. 

![alt text](images/Architecturediagram.png "Project Infrastructure")
