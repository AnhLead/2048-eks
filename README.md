# 2048-eks

Installation: 

1. Run Terraform Apply -target module.VPC
  Current bug in modules
2. Run Terraform Apply

3. kubectl config
  aws eks update-kubeconfig --region region-code --name cluster-name
4. flux bootstrap
flux bootstrap github \
  --owner=anhlead \
  --repository=2048-eks \
  --branch=main \
  --path=./clusters/dev-cluster \
  --private