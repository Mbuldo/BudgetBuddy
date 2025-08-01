## Live public URL 

http://budgetbuddy-demo.eastus.azurecontainer.io:5000/

## Screenshots of Provisioned resources

![alt text](<Screenshot From 2025-08-01 17-30-30.png>)
![alt text](<Screenshot From 2025-08-01 17-31-59.png>)
![alt text](<Screenshot From 2025-08-01 17-33-13.png>)

## Reflection on IaC and Manual Deployment Challenges

# Infrastructure as Code (Terraform) Challenges:

State Management:
Initially struggled with Terraform state files when collaborating - learned to use remote backends (Azure Storage) to prevent team conflicts.

Dependency Timing:
Container instances failed when trying to pull images before ACR was fully provisioned. Solved by adding explicit depends_on clauses.

Secret Management:
Hardcoded credentials in early versions were replaced with Terraform variables and Azure Key Vault integration for production readiness.

# Manual Deployment Learnings:

Image Tagging:
Forgot to update image tags during iterations, causing the container to run outdated versions. Implemented CI/CD with commit-based tagging.

Persistent Storage:
SQLite file permissions caused write errors until we properly configured Azure Files volume mounts with chmod in the Dockerfile.

Network Debugging:
Spent hours diagnosing 500 errors before realizing the container needed explicit outbound firewall rules to access Azure services.

# Key Takeaways:

IaC provides reproducibility but requires careful planning of resource dependencies

Manual deployments expose configuration gaps that automation later solves

Documentation is crucial - we added runbooks for every deployment scenario

# Improvement Plan:

Migrate to Terraform modules for reusability

Implement GitHub Actions for automated testing

Add health checks to container definitions

